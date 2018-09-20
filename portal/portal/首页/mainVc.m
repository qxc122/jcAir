//
//  mainVc.m
//  portal
//
//  Created by Store on 2017/12/13.
//  Copyright © 2017年 qxc122@126.com. All rights reserved.
//

#import "mainVc.h"
#import "MyaccountVc.h"
#import "loginVc.h"
#import "appidVc.h"
#import "rightVc.h"
#import <WebKit/WKFoundation.h>
#import <WebKit/WebKit.h>
@interface mainVc ()
@property (nonatomic,weak) UIImageView *back;
@property (nonatomic,weak) UIButton *left;
@property (nonatomic,weak) UIButton *right;

@property (nonatomic,weak) UILabel *welCome;
@property (nonatomic,weak) UILabel *name;
@property (nonatomic,weak) UIImageView *more;
@property (nonatomic,weak) UIButton *mildle;
@property (nonatomic,weak) UIView *mildleLine;
@property (nonatomic,strong) GlobalParameter *Globaldata;

@property (nonatomic,strong) NSString *yaoshuxingtaoken;
//@property (nonatomic,strong) NSString *yaoshuxingtaoken;

@property (nonatomic,assign) BOOL Wkwebclear;
@end

@implementation mainVc

- (void)viewDidLoad {
    [super viewDidLoad];
    self.Wkwebclear = NO;
    [self setmainVcUI];
    if (!self.isRestatr.length && !self.isRestatr) {
        [self.navigationController pushViewController:[appidVc new] animated:NO];
        if ([[PortalHelper sharedInstance] get_accessToken]) {
            [self gettGlobalParams];
        }
    }
    if ([[PortalHelper sharedInstance]get_userInfo]) {
        [self tpurseusermyInfo];
    }
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(geyTokenFunc:)
                                                 name:@"geyToken"
                                               object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(yaoshuxingtaokenFunc:)
                                                 name:@"yaoshuxingtaoken"
                                               object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(yonghubucunzaiFunc:)
                                                 name:@"yonghubucunzai"
                                               object:nil];
}
- (void)yaoshuxingtaokenFunc:(NSNotification *)user{
    if (![self.yaoshuxingtaoken isEqualToString:@"1"]) {
        self.yaoshuxingtaoken = @"1";
        [self apptokenRefresh];
    }
}
- (void)yonghubucunzaiFunc:(NSNotification *)user{
    [[PortalHelper sharedInstance]set_userInfo:nil];
    [self.navigationController popToRootViewControllerAnimated:YES];
    [MBProgressHUD showPrompt:NSLocalizedString(@"ningdezhnghuyjbuzaile", nil) toView:self.view];
}

- (void)apptokenRefresh{
    kWeakSelf(self);
    [self apptokenGet:^{
        if ([[PortalHelper sharedInstance] get_userInfo]) {
            [weakself ticketRefresh];
        }
    }];
}
- (void)ticketRefresh{
    kWeakSelf(self);
    [[ToolRequest sharedInstance]URLBASIC_userrefreshLoginWithnisssuccess:^(id dataDict, NSString *msg, NSInteger code) {
        UserInfo *tmp = [[[PortalHelper sharedInstance]get_userInfo] copy];
        UserInfo *now = [UserInfo mj_objectWithKeyValues:dataDict];
        if (now.authenTicket.length) {
            tmp.authenTicket = now.authenTicket;
        }
        if (now.authenUserId.length) {
            tmp.authenUserId = now.authenUserId;
        }
        if (now.userId.length) {
            tmp.userId = now.userId;
        }
//        weakself.yaoshuxingtaoken = nil;
        [[PortalHelper sharedInstance]set_userInfo:tmp];
        NSNotification *notification =[NSNotification notificationWithName:@"geyToken" object:nil userInfo:nil];
        [[NSNotificationCenter defaultCenter] postNotification:notification];
    } failure:^(NSInteger errorCode, NSString *msg) {
        [weakself performSelector:@selector(ticketRefresh) withObject:nil afterDelay:0.3];
    }];
}
- (void)apptokenGet:(successDoBlock)bloc{
    kWeakSelf(self);
    [[ToolRequest sharedInstance]apptokenApplysuccess:^(id dataDict, NSString *msg, NSInteger code) {
        accessToken *token =[accessToken mj_objectWithKeyValues:dataDict];
        [[PortalHelper sharedInstance] set_accessToken:token];
        if ([[PortalHelper sharedInstance]get_userInfo]) {
            if (bloc) {
                bloc();
            }
        } else {
//            weakself.yaoshuxingtaoken = nil;
            [weakself.navigationController popViewControllerAnimated:NO];
            NSNotification *notification =[NSNotification notificationWithName:@"geyToken" object:nil userInfo:nil];
            [[NSNotificationCenter defaultCenter] postNotification:notification];
        }
    } failure:^(NSInteger errorCode, NSString *msg) {
        [weakself performSelector:@selector(apptokenGet:) withObject:bloc afterDelay:1.0];
    }];
}

- (void)geyTokenFunc:(NSNotification *)user{
//    if (!self.Globaldata) {
//    }
    [self gettGlobalParams];
    if ([[PortalHelper sharedInstance]get_userInfo]) {
        [self tpurseusermyInfo];
    }
}
- (void)dealloc{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)tpurseusermyInfo{
    kWeakSelf(self);
    [[ToolRequest sharedInstance]URLBASIC_jcMyInfosuccess:^(id dataDict, NSString *msg, NSInteger code) {
        UserInfo *tmp = [UserInfo mj_objectWithKeyValues:dataDict];
        [[PortalHelper sharedInstance]set_userInfo:tmp];
        [weakself setNameLabel:tmp];
    } failure:^(NSInteger errorCode, NSString *msg) {
        NSLog(@"首页获取我的信息失败");
    }];
}
- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    if (!self.Wkwebclear) {
        WKWebsiteDataStore *dateStore = [WKWebsiteDataStore defaultDataStore];
        kWeakSelf(self);
        [dateStore fetchDataRecordsOfTypes:[WKWebsiteDataStore allWebsiteDataTypes]
                         completionHandler:^(NSArray<WKWebsiteDataRecord *> * __nonnull records) {
                             NSInteger index = 0;
                             for (WKWebsiteDataRecord *record  in records){
                                 [[WKWebsiteDataStore defaultDataStore] removeDataOfTypes:record.dataTypes
                                                                           forDataRecords:@[record]
                                                                        completionHandler:^{
                                                                            weakself.Wkwebclear = YES;
                                                                        }];
                                 index++;
                             }
                         }];
    }
}
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self setNameLabel:[[PortalHelper sharedInstance]get_userInfo]];
}
- (void)setNameLabel:(UserInfo *)tmp{
    if (tmp) {
        if ([[[PortalHelper sharedInstance]get_AppSetPlist].internation isEqualToString:@"0"]) {
            self.name.text = [NSString stringWithFormat:@"%@ %@",tmp.surname,tmp.enName];
        } else if ([[[PortalHelper sharedInstance]get_AppSetPlist].internation isEqualToString:@"1"]) {
            self.name.text = [NSString stringWithFormat:@"%@ %@",tmp.enName,tmp.surname];
        }
    } else {
        self.name.text = NSLocalizedString(@"dengluzhuce", @"");
    }
}
- (void)gettGlobalParams{
    kWeakSelf(self);
    [[ToolRequest sharedInstance]appgetGlobalParamssuccess:^(id dataDict, NSString *msg, NSInteger code) {
        GlobalParameter *Globaldata = [GlobalParameter mj_objectWithKeyValues:dataDict];
        weakself.Globaldata = Globaldata;
        [[PortalHelper sharedInstance] set_Globaldata:Globaldata];
        if (weakself.restorationIdentifier.length) {
            [MBProgressHUD hideHUD];
            if ([weakself.restorationIdentifier isEqualToString:@"left"]) {
//                [weakself openEachWkVcWithId:self.Globaldata.jcFilghtUrl];
                [weakself OpendingpiaoVc];
            } else if ([weakself.restorationIdentifier isEqualToString:@"right"]) {
                [weakself Openwodelist];
//                [weakself openEachWkVcWithId:self.Globaldata.jcMyTripUrl];
            }
            weakself.restorationIdentifier = nil;
        }
    } failure:^(NSInteger errorCode, NSString *msg) {
        NSLog(@"全局参数加载失败了msg=%@",msg);
    }];
}
- (void)setmainVcUI{
    self.view.backgroundColor = ColorWithHex(0xED1C24, 1.0);
    UIImageView *back = [UIImageView new];
    [self.view addSubview:back];
    self.back  =back;
    
    UIButton *left = [UIButton new];
    [self.view addSubview:left];
    self.left  =left;
    
    UIButton *right = [UIButton new];
    [self.view addSubview:right];
    self.right  =right;
    
    UILabel *welCome = [UILabel new];
    [self.view addSubview:welCome];
    self.welCome  =welCome;
    
    UILabel *name = [UILabel new];
    [self.view addSubview:name];
    self.name  =name;
    
    UIImageView *more = [UIImageView new];
    [self.view addSubview:more];
    self.more  =more;
    
    UIButton *mildle = [UIButton new];
    [self.view addSubview:mildle];
    self.mildle  =mildle;
    
    UIView *mildleLine = [UIView new];
    [self.view addSubview:mildleLine];
    self.mildleLine  =mildleLine;
    
    [self.back mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view);
        make.right.equalTo(self.view);
        make.top.equalTo(self.view);
    }];
    [self.left mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view);
        make.width.equalTo(@[self.right]);
        make.height.equalTo(@60);
        make.bottom.equalTo(self.view);
        make.top.equalTo(self.back.mas_bottom).offset(2);
    }];
    [self.right mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.left.mas_right);
        make.right.equalTo(self.view);
        make.bottom.equalTo(self.left);
        make.top.equalTo(self.left);
    }];
    
    [self.welCome mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view).offset(23);
        make.bottom.equalTo(self.view.mas_centerY).offset(-6);
    }];
    [self.name mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.welCome);
        make.top.equalTo(self.view.mas_centerY).offset(6);
        make.width.mas_lessThanOrEqualTo(@(SCREENWIDTH - 23 - 15 - 10 - 10));
    }];
    [self.more mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.name.mas_right).offset(10);
        make.centerY.equalTo(self.name);
        make.width.equalTo(@15);
        make.height.equalTo(@15);
    }];
    [self.mildle mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.name);
        make.right.equalTo(self.more);
        make.centerY.equalTo(self.name);
        make.height.equalTo(@44);
    }];
    
    [self.mildleLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.equalTo(@0.5);
        make.centerX.equalTo(self.right.mas_left);
        make.bottom.equalTo(self.left);
        make.top.equalTo(self.left);
    }];
    [self.welCome setWithColor:0xED1C24 Alpha:1.0 Font:15 ROrM:@"r"];
    [self.name setWithColor:0xED1C24 Alpha:1.0 Font:15 ROrM:@"r"];
    self.mildleLine.backgroundColor = ColorWithHex(0xDFDFDF, 1.0);
    self.back.image = [UIImage imageNamed:@"首页图"];
    [self.back SetContentModeScaleAspectFill];
    self.welCome.text = NSLocalizedString(@"huanying", @"");
    self.name.text = NSLocalizedString(@"dengluzhuce", @"");
    self.more.image = [UIImage imageNamed:@"下一步"];
    [self.left setWithNormalColor:0x5D5D5D NormalAlpha:1.0 NormalTitle:NSLocalizedString(@"hangbang", @"") NormalImage:@"首页预订航班" NormalBackImage:nil SelectedColor:0x0 SelectedAlpha:0 SelectedTitle:nil SelectedImage:nil SelectedBackImage:nil Font:14 NormalROrM:@"r" backColor:0xFFFFFF backAlpha:1.0];
    [self.right setWithNormalColor:0x5D5D5D NormalAlpha:1.0 NormalTitle:NSLocalizedString(@"hangcheng", @"") NormalImage:@"首页我的行程" NormalBackImage:nil SelectedColor:0x0 SelectedAlpha:0 SelectedTitle:nil SelectedImage:nil SelectedBackImage:nil Font:14 NormalROrM:@"r" backColor:0xFFFFFF backAlpha:1.0];
    
    UIImageView *titlePngf = [UIImageView new];
    titlePngf.image = [UIImage imageNamed:@"title"];
    [titlePngf SetContentModeScaleAspectFill];
    titlePngf.frame = CGRectMake(0, 0, 139, 27);
    self.navigationItem.titleView = titlePngf;
    UIBarButtonItem *tmpItem = [[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"汉堡菜单"] style:UIBarButtonItemStyleDone target:self action:@selector(btnClick:)];
    tmpItem.tintColor=[UIColor whiteColor];
    self.navigationItem.rightBarButtonItem = tmpItem;
    [self.left addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.right addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.mildle addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
    self.left.restorationIdentifier = @"left";
    self.right.restorationIdentifier = @"right";
    self.mildle.restorationIdentifier = @"mildle";

}
- (void)customBackButton
{

}
- (void)btnClick:(UIButton *)btn{
    if ([btn isKindOfClass:[UIButton class]]) {
        if ([btn.restorationIdentifier isEqualToString:@"left"]) {
            if (self.Globaldata) {
                [self OpendingpiaoVc];
//                [self openEachWkVcWithId:self.Globaldata.jcFilghtUrl];
            } else {
                self.restorationIdentifier = @"left";
                [MBProgressHUD showLoadingMessage:NSLocalizedString(@"mainVcDengdai", @"")];
                [self gettGlobalParams];
            }
        } else if ([btn.restorationIdentifier isEqualToString:@"right"]) {
            if (self.Globaldata) {
                [self Openwodelist];
            } else {
                self.restorationIdentifier = @"right";
                [MBProgressHUD showLoadingMessage:NSLocalizedString(@"mainVcDengdai", @"")];
                [self gettGlobalParams];
            }
        } else if ([btn.restorationIdentifier isEqualToString:@"mildle"]) {
            [self OpenMyaccountVc];
        }
    } else {
        self.backimage = nil;
        [self openrightWindosView:YES];
    }
}
- (void)openrightWindosView:(BOOL)Animated{
    if (!self.backimage) {
        if ([[UIScreen mainScreen] respondsToSelector:@selector(scale)]){
            UIGraphicsBeginImageContextWithOptions(self.view.window.bounds.size, NO, [UIScreen mainScreen].scale);
        } else {
            UIGraphicsBeginImageContext(self.view.window.bounds.size);
        }
        [self.view.window.layer renderInContext:UIGraphicsGetCurrentContext()];
        self.backimage = UIGraphicsGetImageFromCurrentImageContext();
        UIGraphicsEndImageContext();
    }
    kWeakSelf(self);
    rightVc *vc = [rightVc new];
    vc.didselecetCell = ^(id url) {
        if (url) {
            if ([url isKindOfClass:[NSString class]]) {
                if ([url isEqualToString:NSLocalizedString(@"righht1", @"")]) {
                    [weakself OpenMyaccountVc];
                }
            }
//            else if ([url isKindOfClass:[NSURL class]]) {
//                [weakself openEachWkVcWithId:url];
//            }
        }
    };
    vc.backimage = self.backimage;
    [self OPenVc:vc Animated:Animated];
    
    
    
    
//    kWeakSelf(self);
//    rightVc *vc = [rightVc new];
//    vc.didselecetCell = ^(id url) {
//        if (url) {
//            if ([url isKindOfClass:[NSString class]]) {
//                if ([url isEqualToString:NSLocalizedString(@"righht1", @"")]) {
//                    [weakself OpenMyaccountVc];
//                }
//            }
//        }
//    };
//    [self OPenVc:vc Animated:Animated];
//
//    if (self.backimage) {
//        vc.backimage = self.backimage;
//    }else{
//        kWeakSelf(self);
//        dispatch_async(dispatch_get_global_queue(0, 0), ^{
//            if ([[UIScreen mainScreen] respondsToSelector:@selector(scale)]){
//                UIGraphicsBeginImageContextWithOptions(self.view.window.bounds.size, NO, [UIScreen mainScreen].scale);
//            } else {
//                UIGraphicsBeginImageContext(self.view.window.bounds.size);
//            }
//            [weakself.view.window.layer renderInContext:UIGraphicsGetCurrentContext()];
//            weakself.backimage = UIGraphicsGetImageFromCurrentImageContext();
//            UIGraphicsEndImageContext();
//            dispatch_async(dispatch_get_main_queue(), ^{
//                vc.backimage = weakself.backimage;
//            });
//        });
//    }
}
- (void)OpenMyaccountVc{
    if ([[PortalHelper sharedInstance]get_userInfo]) {
        [self OPenVc:[MyaccountVc new]];
    } else {
        [self OPenVc:[loginVc new]];
    }
}
- (GlobalParameter *)Globaldata{
    if (!_Globaldata) {
        _Globaldata = [[PortalHelper sharedInstance]get_Globaldata];
    }
    return _Globaldata;
}
@end
