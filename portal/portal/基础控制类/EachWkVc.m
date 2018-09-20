//
//  EachWkVc.m
//  portal
//
//  Created by Store on 2017/8/31.
//  Copyright © 2017年 qxc122@126.com. All rights reserved.
//

#import "EachWkVc.h"
#import "PortalHelper.h"
#import "HeaderAll.h"
#import "NSDictionary+Add.h"
#import "WXApi.h"
#import "loginVc.h"
#import "payRequsestHandler.h"
#import "THIRD_PARTY.h"
@interface EachWkVc ()<WKScriptMessageHandler>
@property (strong,nonatomic) NSString *pathh; //当前路径
@end


@implementation EachWkVc
- (void)setCokie{
    WKUserContentController *userContentController = [[WKUserContentController alloc] init];
    [userContentController addScriptMessageHandler:[[WeakScriptMessageDelegate alloc] initWithDelegate:self] name:@"paySuccess"];
    [userContentController addScriptMessageHandler:[[WeakScriptMessageDelegate alloc] initWithDelegate:self] name:@"JcSignIn"];
    [userContentController addScriptMessageHandler:[[WeakScriptMessageDelegate alloc] initWithDelegate:self] name:@"login"];
    [userContentController addScriptMessageHandler:[[WeakScriptMessageDelegate alloc] initWithDelegate:self] name:@"callPhone"];
    [userContentController addScriptMessageHandler:[[WeakScriptMessageDelegate alloc] initWithDelegate:self] name:@"weixinPay"];
    
    NSMutableDictionary *sessionContext = [NSMutableDictionary new];
    [sessionContext setObject:PORTALCHANNEL forKey:@"channel"];
    [sessionContext setObject:@"1" forKey:@"stepCode"];
    [sessionContext setObject:[[NSDate date]formattedDateWithFormat:@"yyyyMMddHHmmss"] forKey:@"localDateTime"];
    NSString *userId = [[PortalHelper sharedInstance]get_userInfo].authenUserId;
    if (userId && userId.length) {
        [sessionContext setObject:userId forKey:@"userId"];
    }else{
        [sessionContext setObject:@"" forKey:@"userId"];
    }
    NSString *authenUserId = [[PortalHelper sharedInstance]get_userInfo].authenUserId;
    if (authenUserId && authenUserId.length) {
        [sessionContext setObject:authenUserId forKey:@"authenUserId"];
    }else{
        [sessionContext setObject:@"" forKey:@"authenUserId"];
    }
    
    [sessionContext setObject:@"1" forKey:@"stepCode"];
    [sessionContext setObject:PORTALACCESSSOURCE forKey:@"accessSource"];
    [sessionContext setObject:PHONEVERSION forKey:@"accessSourceType"];
    [sessionContext setObject:PORTALVERSION forKey:@"version"];
    
    NSString *internation = [[PortalHelper sharedInstance]get_AppSetPlist].internation;
    [sessionContext setObject:internation forKey:@"internation"];
    
    NSString *accessToken = [[PortalHelper sharedInstance] get_accessToken].accessToken;
    if (accessToken) {
        [sessionContext setObject:accessToken forKey:@"accessToken"];
    }else{
        [sessionContext setObject:@"" forKey:@"accessToken"];
    }

    
    NSString *sessionContextStr = [sessionContext dictionaryToJsonForH5];;
    NSString *cookieStr = [NSString stringWithFormat:@"document.cookie = 'sessionContext=%@'",sessionContextStr];
    WKUserScript * cookieScript = [[WKUserScript alloc]
                                   initWithSource:cookieStr
                                   injectionTime:WKUserScriptInjectionTimeAtDocumentStart forMainFrameOnly:YES];
    [userContentController addUserScript:cookieScript];
    
    WKWebViewConfiguration *config = [[WKWebViewConfiguration alloc] init];
    config.userContentController = userContentController;
    
    self.config = config;
}
- (void)popSelf{
    if ([self.webView canGoBack]) {
        [self.webView goBack];
    }else{
        [self.navigationController popViewControllerAnimated:YES];
    }
}
- (void)viewDidLoad{
    [self setCokie];
    [super viewDidLoad];
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(LOGIN_EXIT_NOTIFICATIONFunC:)
                                                 name:@"resetCokie"
                                               object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(wechatPaySuccessFunC:)
                                                 name:@"wechatPaySuccess"
                                               object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(wechatPayUserCancelFunC:)
                                                 name:@"wechatPayUserCancel"
                                               object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(wechatPayFaildFunC:)
                                                 name:@"wechatPayFaild"
                                               object:nil];
}
- (void)wechatPaySuccessFunC:(NSNotification *)user{
    [self WXpay];
}
- (void)wechatPayUserCancelFunC:(NSNotification *)user{
    [self WXpay];
}
- (void)wechatPayFaildFunC:(NSNotification *)user{
    [self WXpay];
}
- (void)WXpay{
    if ([self isEqual:self.navigationController.topViewController]) {
        if (self.Myjourney) {
            NSArray *arry = self.webView.backForwardList.backList;
            WKBackForwardListItem *first = [arry firstObject];
            [self.webView goToBackForwardListItem:first];
//            [self.webView reloadFromOrigin];
        }else{
            [self.navigationController popViewControllerAnimated:NO];
            [self Openwodelist];
        }
    }
}
#ifdef DEBUG
- (void)saveFUNc{
    //执行js
    [self.webView evaluateJavaScript:@"window.webkit.messageHandlers.finishWeb.postMessage('1')" completionHandler:^(id data, NSError * _Nullable error) {
        if (error) {
            NSLog(@"失败:%@",error.description);
        } else {
            NSLog(@"成功");
        }
    }];
}
#endif

- (void)userContentController:(WKUserContentController *)userContentController didReceiveScriptMessage:(WKScriptMessage *)message{
    //接受传过来的消息从而决定app调用的方法
    NSString *method = message.name;
    NSLog(@"method=%@",method);
    if ([method isEqualToString:@"paySuccess"] || [method isEqualToString:@"weixinPay"]){
        [self Wxpay:message.body];
    }else if ([method isEqualToString:@"JcSignIn"] || [method isEqualToString:@"login"]){
        [self JcSignIn];
    }else if ([method isEqualToString:@"callPhone"]){
        [self callPhone:message.body];
    }
}
- (void)callPhone:(id)phoneNumber{
    if ([phoneNumber isKindOfClass:[NSString class]]) {
        NSString *tmp = phoneNumber;
        tmp = [tmp stringByReplacingOccurrencesOfString:@"" withString:@" "];
        NSMutableString* str=[[NSMutableString alloc] initWithFormat:@"telprompt://%@",tmp];
        if ([[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:str]]) {
            [[UIApplication sharedApplication] openURL:[NSURL URLWithString:str]];
        }
    }else{
        [MBProgressHUD showPrompt:NSLocalizedString(@"dianhaobushizhifuc", nil) toView:self.view];
    }
}
- (void)JcSignIn{
    if ([[PortalHelper sharedInstance]get_userInfo]) {
        [MBProgressHUD showPrompt:NSLocalizedString(@"ningyedenglu", nil) toView:self.view];
    } else {
        [self OPenVc:[loginVc new]];
    }
}
- (void)Wxpay:(NSDictionary *)dic{
//    if ([WXApi isWXAppInstalled]) {
        NSDictionary *tmp = nil;
        if ([dic isKindOfClass:[NSString class]]) {
            NSString *str = (NSString *)dic;
            tmp =[str dictionaryWithJsonString];
        } else if ([dic isKindOfClass:[NSDictionary class]]) {
            tmp = dic;
        }
        if (tmp) {
            if (tmp[@"prepayId"]) {
                NSString *package, *time_stamp, *nonce_str;
                //设置支付参数
                time_t now;
                time(&now);
                time_stamp = [NSString stringWithFormat:@"%ld", now];
                nonce_str = [WXUtil md5:time_stamp];
                package = @"Sign=WXPay";
                payRequsestHandler *handler = [[payRequsestHandler alloc] init];
                
                NSString  *appid = tmp[@"appId"];
                NSString  *MCH_IDStr = MCH_IDOther;
                [handler init:WechatAppID  mch_id:MCH_IDOther ];
                //设置密钥
                [handler setKey:PARTNER_IDOther];
                
                NSMutableDictionary *signParams = [NSMutableDictionary dictionary];
                [signParams setObject:appid forKey:@"appid"];
                [signParams setObject:nonce_str forKey:@"noncestr"];
                [signParams setObject:package forKey:@"package"];
                [signParams setObject:MCH_IDStr forKey:@"partnerid"];
                [signParams setObject:time_stamp forKey:@"timestamp"];
                [signParams setObject:tmp[@"prepayId"] forKey:@"prepayid"];
                
                NSString *localSign = [handler createMd5Sign:signParams];
                //调起微信支付
                PayReq *req = [[PayReq alloc] init];
                req.openID =appid;
                req.partnerId = MCH_IDOther;
                req.prepayId = tmp[@"prepayId"];
                req.nonceStr = nonce_str;
                req.timeStamp = time_stamp.intValue;
                req.package = package;
                req.sign = localSign;
                [WXApi sendReq:req];
            }else{
                [MBProgressHUD showPrompt:NSLocalizedString(@"WxPayqueshsose", nil)];
            }
        } else {
            [MBProgressHUD showPrompt:NSLocalizedString(@"WxcansuFail", nil)];
        }
//    } else {
//        [MBProgressHUD showPrompt:NSLocalizedString(@"NOneWx", nil) toView:self.view];
//    }
}
- (void)Execute_the_JS_statementWith:(NSString *)str{
    [self.webView evaluateJavaScript:str completionHandler:^(id data, NSError * _Nullable error) {
        if (error) {
            NSLog(@"失败:%@",error.description);
        }else{
            NSLog(@"成功");
        }
    }];
}

- (void)dealloc{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)setsessionContext{
    NSString *JSFuncString = @"function setCookieIOS(name,value,expires,urlpath)\
    {\
    var oDate=new Date();\
    oDate.setDate(oDate.getDate()+expires);\
    document.cookie=name+'='+value+';expires='+oDate+';path=/'\
    }";
    
    NSMutableDictionary *parameters = [[NSMutableDictionary alloc] init];
    [parameters setObject:PORTALCHANNEL forKey:@"channel"];
    [parameters setObject:PORTALACCESSSOURCE forKey:@"accessSource"];
    [parameters setObject:PHONEVERSION forKey:@"accessSourceType"];
    [parameters setObject:PORTALVERSION forKey:@"version"];
    
    NSString *userId = [[PortalHelper sharedInstance]get_userInfo].authenUserId;
    if (userId && userId.length) {
        [parameters setObject:userId forKey:@"userId"];
    }else{
        [parameters setObject:@"" forKey:@"userId"];
    }
    NSString *authenUserId = [[PortalHelper sharedInstance]get_userInfo].authenUserId;
    if (authenUserId && authenUserId.length) {
        [parameters setObject:authenUserId forKey:@"authenUserId"];
    }else{
        [parameters setObject:@"" forKey:@"authenUserId"];
    }
    [parameters setObject:@"1" forKey:@"stepCode"];
    NSString *accessToken = [[PortalHelper sharedInstance] get_accessToken].accessToken;
    if (accessToken && accessToken.length) {
        [parameters setObject:accessToken forKey:@"accessToken"];
    }else{
        [parameters setObject:@"" forKey:@"accessToken"];
    }
    
    NSString *sessionContext = [parameters dictionaryToJsonForH5];
    
    //    NSString *cookieStr = [NSString stringWithFormat:@"document.cookie = 'sessionContext=%@'",sessionContext];
    
    
    //拼凑js字符串
    NSMutableString *JSCookieString = JSFuncString.mutableCopy;
//    NSString *excuteJSStringDE1 = [NSString stringWithFormat:@"delCookieIOS('sessionContext');"];
    
    
    NSString *excuteJSString1 = [NSString stringWithFormat:@"setCookieIOS('%@', '%@', 1,self.pathh);", @"sessionContext",sessionContext];
    
//    [JSCookieString appendString:excuteJSStringDE1];
    [JSCookieString appendString:excuteJSString1];
    
    //执行js
    [self.webView evaluateJavaScript:JSCookieString completionHandler:^(id data, NSError * _Nullable error) {
        if (error) {
            NSLog(@"失败:%@",error.description);
        } else {
            //            [self.webView reload];
            NSLog(@"成功");
        }
    }];
}
- (void)resentCokie{
    WKWebsiteDataStore *dateStore = [WKWebsiteDataStore defaultDataStore];
    kWeakSelf(self);
    [dateStore fetchDataRecordsOfTypes:[WKWebsiteDataStore allWebsiteDataTypes]
                     completionHandler:^(NSArray<WKWebsiteDataRecord *> * __nonnull records) {
                         NSInteger index = 0;
                         for (WKWebsiteDataRecord *record  in records){
                             [[WKWebsiteDataStore defaultDataStore] removeDataOfTypes:record.dataTypes
                                                                       forDataRecords:@[record]
                                                                    completionHandler:^{
                                                                        if ((records.count - 1) == index) {
                                                                            [weakself setsessionContext];
                                                                        }
                                                                        NSLog(@"Cookies for %@ deleted successfully",record.displayName);
                                                                    }];
                             index++;
                         }
                     }];
}

#pragma --mark<登录退出的通知>
- (void)LOGIN_EXIT_NOTIFICATIONFunC:(NSNotification *)user{
    [self resentCokie];
}

//- (void)webView:(WKWebView *)webView decidePolicyForNavigationAction:(WKNavigationAction *)navigationAction decisionHandler:(void (^)(WKNavigationActionPolicy))decisionHandler{
//    self.pathh = navigationAction.request.URL.path;
//    MJExtensionLog(@"navigationAction.request.URL.absoluteString=%@ \n",navigationAction.request.URL.path);
//    decisionHandler(WKNavigationActionPolicyAllow);
//}
@end

@implementation WeakScriptMessageDelegate

- (instancetype)initWithDelegate:(id<WKScriptMessageHandler>)scriptDelegate
{
    self = [super init];
    if (self) {
        _scriptDelegate = scriptDelegate;
    }
    return self;
}

- (void)userContentController:(WKUserContentController *)userContentController didReceiveScriptMessage:(WKScriptMessage *)message
{
    [self.scriptDelegate userContentController:userContentController didReceiveScriptMessage:message];
}
@end
