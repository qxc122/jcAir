//
//  ToolRequest.m
//  Tourism
//
//  Created by Store on 16/11/8.
//  Copyright © 2016年 qxc122@126.com. All rights reserved.
//

#import "ToolRequest.h"
#import "HeaderAll.h"



#define  RETSTATUSSUCCESS   @"0"
#define  RETSTATUFAILURE   @"-1"
#define  RETSTATUFAILUREYICHANG   @"1"


#define REAUESRTIMEOUT      10.f    //网络请求超时时间


#define PROMPT_FAIL         NSLocalizedString(@"Load failed", @"Load failed")
#define PROMPT_NOTJSON      NSLocalizedString(@"The server returned the wrong data format", @"The server returned the wrong data format")
#define PROMPT_NOTCONNECT   NSLocalizedString(@"Please check your network settings", @"Please check your network settings")


@interface ToolRequest ()
@property (strong, nonatomic) NSString *baseURLStr;
@end


AFNetworkReachabilityStatus Netstatus;
@implementation ToolRequest
+ (ToolRequest *)sharedInstance
{
    static ToolRequest *instance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[self alloc] init];
//        1.创建网络状态监测管理者
        AFNetworkReachabilityManager *manger = [AFNetworkReachabilityManager sharedManager];
//        开启监听，记得开启，不然不走block
        [manger startMonitoring];
//        2.监听改变
        [manger setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
            Netstatus = status;
        }];
    });
#ifdef DEBUG
    NSString *strles = [NSUserDefaults getObjectWithKey:URLAddress];
    if (!strles) {
        [NSUserDefaults setObject:tesetURLAddress withKey:URLAddress];
        strles = tesetURLAddress;
    }else{
        strles = strles;
    }
    instance.baseURLStr = strles;
#else
    instance.baseURLStr = URLBASIC;
#endif
    return instance;
}
- (BOOL)getNetStaue{
    if (Netstatus == AFNetworkReachabilityStatusReachableViaWWAN || Netstatus == AFNetworkReachabilityStatusReachableViaWiFi) {
        return YES;
    } else {
        return NO;
    }
}

- (void)postJsonWithPath:(NSString *)path
              parameters:(NSMutableDictionary *)parameters
                 success:(RequestSuccess)successBlock
                 failure:(RequestFailure)failureBlock
{
    NSLog(@"%@ %@ ",[NSDate date],[[PortalHelper sharedInstance]get_accessToken].expireTime);
    if (([path containsString:@"appIdApply"] || [path containsString:@"tokenApply"]) || ![[NSDate date]isLaterThanOrEqualTo:[[PortalHelper sharedInstance]get_accessToken].expireTime]) { //过期了
        NSMutableDictionary *sessionContext = [NSMutableDictionary new];
        
        [sessionContext setObject:PORTALCHANNEL forKey:@"channel"];
        [sessionContext setObject:[[NSDate date]formattedDateWithFormat:@"yyyyMMddHHmmss"] forKey:@"localDateTime"];
        NSString *userId = [[PortalHelper sharedInstance]get_userInfo].userId;
        if (userId && userId.length) {
            [sessionContext setObject:userId forKey:@"userId"];
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
            //TODO 去申请token 过期等判断
            if ([path isEqualToString:URLBASIC_tpurseappappIdApply] || [path isEqualToString:URLBASIC_apptokenApply]) {
                
            }else{
                
            }
        }
        [parameters setObject:sessionContext forKey:@"sessionContext"];
        NSString *urlStr = [NSString stringWithFormat:@"%@%@", self.baseURLStr, path];
        urlStr = [urlStr stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
        AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
        manager.requestSerializer = [AFJSONRequestSerializer serializer];
        //    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"text/json", @"application/json",@"text/html", nil];
        manager.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"application/x-zip-compressed"];
        manager.responseSerializer = [AFHTTPResponseSerializer serializer]; // AFN不会解析,数据是data，需要自己解析
        manager.requestSerializer.timeoutInterval = 10.f;
#ifdef DEBUG
        NSLog(@"path=%@  parameters=%@",urlStr,[parameters DicToJsonstr]);
#endif
        kWeakSelf(self);
        [manager POST:urlStr parameters:parameters progress:^(NSProgress * _Nonnull uploadProgress) {
            
        } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            if (responseObject) {
                id result = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:NULL];
                [weakself parseResponseData:result
                                    success:^(id dataDict, NSString *msg, NSInteger code) {
                                        successBlock(dataDict, msg, code);
                                    }
                                    failure:^(NSInteger errorCode, NSString *msg) {
                                        failureBlock(errorCode, msg);
                                    }
                     ifRespondDataEncrypted:NO];
            }else{
                failureBlock(KRespondCodeNone, NSLocalizedString(@"fuwuqifanghuishujuweinil", nil));
            }
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            if (Netstatus == AFNetworkReachabilityStatusNotReachable || Netstatus == AFNetworkReachabilityStatusUnknown) {
                failureBlock(KRespondCodeNotConnect, PROMPT_NOTCONNECT);
            }else{
                NSDictionary *tmp = error.userInfo;
                NSString *tmpStr = tmp[@"NSLocalizedDescription"];
                failureBlock(KRespondCodeFail, tmpStr);
            }
        }];
    }else{
        failureBlock(KRespondCodeFail, NSLocalizedString(@"token NOne", nil));
    }
}

//验证返回数据是否正确
- (void)parseResponseData:(id)responseData
                  success:(RequestSuccess)successBlock
                  failure:(RequestFailure)failureBlock
   ifRespondDataEncrypted:(BOOL)encryptedReponse
{
    NSDictionary *jsonRootObject = (NSDictionary *)responseData;
    if (jsonRootObject == nil) {
        failureBlock(kRespondCodeNotJson, PROMPT_NOTJSON);
    }else {
        transactionStatus *resStaue = [transactionStatus mj_objectWithKeyValues:responseData];
        if ([resStaue.errorCode isEqualToString:RETSTATUSSUCCESS]) {
#ifdef DEBUG
            NSLog(@"responseData=%@",responseData);
#endif
            successBlock(jsonRootObject, resStaue.replyText, [RETSTATUSSUCCESS integerValue]);
        } else {
            if ([resStaue.replyCode integerValue] == 100008) {    /** Token无效 */

                
                if (![[NSDate date]isLaterThanOrEqualTo:[[PortalHelper sharedInstance]get_accessToken].expireTime]) { //过期了
                    NSNotification *notification =[NSNotification notificationWithName:@"yaoshuxingtaoken" object:nil userInfo:nil];
                    [[NSNotificationCenter defaultCenter] postNotification:notification];
                }
            }else if ([resStaue.replyCode integerValue] == 100003) {  //用户不存在
                NSNotification *notification =[NSNotification notificationWithName:@"yonghubucunzai" object:nil userInfo:nil];
                [[NSNotificationCenter defaultCenter] postNotification:notification];
            }
            failureBlock([resStaue.errorCode integerValue], resStaue.replyText);
        }
    }
}

- (void)LoadToekn{
    kWeakSelf(self);
    [[ToolRequest sharedInstance]apptokenApplysuccess:^(id dataDict, NSString *msg, NSInteger code) {
        accessToken *token =[accessToken mj_objectWithKeyValues:dataDict];
        [[PortalHelper sharedInstance] set_accessToken:token];
    } failure:^(NSInteger errorCode, NSString *msg) {
        [weakself performSelector:@selector(LoadToekn) withObject:nil afterDelay:0.3];
    }];
}

//更新个人资料
- (void)appuserupdateWithAvtor:(UIImage *)avtor
                      progress:(RequestProgress)progressBlock
                       success:(RequestSuccess)successBlock
                       failure:(RequestFailure)failureBlock{
    
    NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
    
    NSString *accessToken = [[PortalHelper sharedInstance] get_accessToken].accessToken;
    [parameters setObject:PORTALCHANNEL forKey:@"channel"];
    [parameters setObject:PORTALACCESSSOURCE forKey:@"accessSource"];
    [parameters setObject:PHONEVERSION forKey:@"accessSourceType"];
    [parameters setObject:PORTALVERSION forKey:@"version"];
    
    NSString *userId = [[PortalHelper sharedInstance]get_userInfo].authenUserId;
    if (userId && userId.length) {
        [parameters setObject:userId forKey:@"userId"];
    }
    if (accessToken) {
        [parameters setObject:accessToken forKey:@"accessToken"];
    }
    NSDictionary *appRequest = @{
                                 @"sessionContext":[parameters dictionaryToJsonStr],
                                 };
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    [manager.requestSerializer willChangeValueForKey:@"timeoutInterval"];
    manager.requestSerializer.timeoutInterval = REAUESRTIMEOUT;
    [manager.requestSerializer didChangeValueForKey:@"timeoutInterval"];
    manager.requestSerializer = [AFJSONRequestSerializer serializer];
    //    manager.responseSerializer = [AFJSONResponseSerializer serializer];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer]; // AFN不会解析,数据是data，需要自己解析
#ifdef DEBUG
    NSLog(@"strTmp=%@  path=%@",[parameters DicToJsonstr],[NSString stringWithFormat:@"%@%@", self.baseURLStr, URLBASIC_userheadUpload]);
#endif
    //2.上传文件
    [manager POST:[NSString stringWithFormat:@"%@%@", self.baseURLStr, URLBASIC_userheadUpload] parameters:appRequest constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
        UIImage *tmp = avtor;
        //            UIImage *tmp = [UIImage imageNamed:@"1"];
        NSData *imageData = UIImageJPEGRepresentation(tmp,1.0);//进行图片压缩
        CGFloat yasou=0.99;
        while (imageData.length > 1024*1024) {
            tmp = avtor;
            NSLog(@"太大了 评价  imageData.leng=%ld   yasou=%f",imageData.length/(1024*1024),yasou);
            imageData = UIImageJPEGRepresentation(tmp, yasou);
            if (imageData.length > 10*1024*1024) {
                yasou *=0.1;
            } else if (imageData.length > 5*1024*1024){
                yasou *=0.2;
            } else if (imageData.length > 4*1024*1024){
                yasou *=0.6;
            } else if (imageData.length > 3*1024*1024){
                yasou *=0.7;
            } else if (imageData.length > 2*1024*1024){
                yasou *=0.8;
            } else if (imageData.length > 1*1024*1024){
                yasou *=0.9;
            }
            NSLog(@"压小后 评价  imageData.leng=%ld   yasou=%f",imageData.length/(1024*1024),yasou);
        }
        NSLog(@"imageData.leng=%ld k",imageData.length/1024);
        
        if (imageData.length) {
            [formData appendPartWithFileData:imageData name:@"file" fileName:@"files.png" mimeType:@"image/png"];
        }else{
            failureBlock(-1,NSLocalizedString(@"The picture is empty", @"The picture is empty"));
        }
    } progress:^(NSProgress * _Nonnull uploadProgress) {
        //打印上传进度
        progressBlock(uploadProgress);
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        if (responseObject) {
            id result = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:NULL];
            [self parseResponseData:result
                            success:^(id dataDict, NSString *msg, NSInteger code) {
                                
                                successBlock(dataDict, msg, code);
                            }
                            failure:^(NSInteger errorCode, NSString *msg) {
                                failureBlock(errorCode, msg);
                            }
             ifRespondDataEncrypted:NO];
        }else{
            failureBlock(KRespondCodeNone, NSLocalizedString(@"The server returns the data blank", @"The server returns the data blank"));
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if (Netstatus == AFNetworkReachabilityStatusNotReachable || Netstatus == AFNetworkReachabilityStatusUnknown) {
            failureBlock(KRespondCodeNotConnect, PROMPT_NOTCONNECT);
        }else{
            NSDictionary *tmp = error.userInfo;
            NSString *tmpStr = tmp[@"NSLocalizedDescription"];
            failureBlock(KRespondCodeFail, tmpStr);
        }
    }];
}


//更新个人资料
- (void)appuserupdateWithImages:(NSArray *)Images
                        content:(NSString *)content
                  contactMethod:(NSString *)contactMethod
                      progress:(RequestProgress)progressBlock
                       success:(RequestSuccess)successBlock
                       failure:(RequestFailure)failureBlock{
    
    NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
    
    NSString *accessToken = [[PortalHelper sharedInstance] get_accessToken].accessToken;
    [parameters setObject:PORTALCHANNEL forKey:@"channel"];
    [parameters setObject:PORTALACCESSSOURCE forKey:@"accessSource"];
    [parameters setObject:PHONEVERSION forKey:@"accessSourceType"];
    [parameters setObject:PORTALVERSION forKey:@"version"];
    
    NSString *userId = [[PortalHelper sharedInstance]get_userInfo].userId;
    if (userId && userId.length) {
        [parameters setObject:userId forKey:@"userId"];
    }
    if (accessToken) {
        [parameters setObject:accessToken forKey:@"accessToken"];
    }
    NSDictionary *appRequest = @{
                                 @"sessionContext":[parameters dictionaryToJsonStr],
                                 @"content":content,
                                 @"contactMethod":contactMethod?contactMethod:@"",
                                 };
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    [manager.requestSerializer willChangeValueForKey:@"timeoutInterval"];
    manager.requestSerializer.timeoutInterval = REAUESRTIMEOUT;
    [manager.requestSerializer didChangeValueForKey:@"timeoutInterval"];
    manager.requestSerializer = [AFJSONRequestSerializer serializer];
    //    manager.responseSerializer = [AFJSONResponseSerializer serializer];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer]; // AFN不会解析,数据是data，需要自己解析
#ifdef DEBUG
    NSLog(@"strTmp=%@  path=%@",[appRequest DicToJsonstr],[NSString stringWithFormat:@"%@%@", self.baseURLStr, URLBASIC_tpurseusersubmitFeedback]);
#endif
    //2.上传文件
    [manager POST:[NSString stringWithFormat:@"%@%@", self.baseURLStr, URLBASIC_tpurseusersubmitFeedback] parameters:appRequest constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
        for (UIImage *tmp in Images) {
            NSData *imageData = UIImageJPEGRepresentation(tmp,1.0);//进行图片压缩
            CGFloat yasou=0.99;
            while (imageData.length > 1024*1024) {
                NSLog(@"太大了 评价  imageData.leng=%ld   yasou=%f",imageData.length/(1024*1024),yasou);
                imageData = UIImageJPEGRepresentation(tmp, yasou);
                if (imageData.length > 10*1024*1024) {
                    yasou *=0.1;
                } else if (imageData.length > 5*1024*1024){
                    yasou *=0.2;
                } else if (imageData.length > 4*1024*1024){
                    yasou *=0.6;
                } else if (imageData.length > 3*1024*1024){
                    yasou *=0.7;
                } else if (imageData.length > 2*1024*1024){
                    yasou *=0.8;
                } else if (imageData.length > 1*1024*1024){
                    yasou *=0.9;
                }
                NSLog(@"压小后 评价  imageData.leng=%ld   yasou=%f",imageData.length/(1024*1024),yasou);
            }
            NSLog(@"imageData.leng=%ld k",imageData.length/1024);
            
            if (imageData.length) {
                [formData appendPartWithFileData:imageData name:@"files" fileName:@"files.png" mimeType:@"image/png"];
            }else{
                failureBlock(-1,NSLocalizedString(@"The picture is empty", @"The picture is empty"));
            }
        }
    } progress:^(NSProgress * _Nonnull uploadProgress) {
        //打印上传进度
        progressBlock(uploadProgress);
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        if (responseObject) {
            id result = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:NULL];
            [self parseResponseData:result
                            success:^(id dataDict, NSString *msg, NSInteger code) {
                                
                                successBlock(dataDict, msg, code);
                            }
                            failure:^(NSInteger errorCode, NSString *msg) {
                                failureBlock(errorCode, msg);
                            }
             ifRespondDataEncrypted:NO];
        }else{
            failureBlock(KRespondCodeNone, NSLocalizedString(@"The server returns the data blank", @"The server returns the data blank"));
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if (Netstatus == AFNetworkReachabilityStatusNotReachable || Netstatus == AFNetworkReachabilityStatusUnknown) {
            failureBlock(KRespondCodeNotConnect, PROMPT_NOTCONNECT);
        }else{
            NSDictionary *tmp = error.userInfo;
            NSString *tmpStr = tmp[@"NSLocalizedDescription"];
            failureBlock(KRespondCodeFail, tmpStr);
        }
    }];
}
@end
