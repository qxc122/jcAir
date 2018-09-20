//
//  appidVc.m
//  portal
//
//  Created by Store on 2017/12/16.
//  Copyright © 2017年 qxc122@126.com. All rights reserved.
//

#import "appidVc.h"

@interface appidVc ()
@property (nonatomic,weak) UIImageView *back;
@property (nonatomic,strong) CheckApp *CheckAppData;

@end

@implementation appidVc

- (void)viewDidLoad {
    [super viewDidLoad];
    self.fd_prefersNavigationBarHidden = YES;
    self.fd_interactivePopDisabled = YES;
    UIImageView *back = [UIImageView new];
    self.back = back;
    back.contentMode = UIViewContentModeScaleAspectFit;
    back.clipsToBounds = YES;
    back.image = [UIImage imageNamed:@"启动页2"];
    
    [self.view addSubview:back];
    [back mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view);
        make.right.equalTo(self.view);
        make.top.equalTo(self.view);
        make.bottom.equalTo(self.view);
    }];
    if (![[PortalHelper sharedInstance] get_appIdAndSecret]) {
        [self appidGet];
    } else {
        if (![[PortalHelper sharedInstance] get_accessToken]) {
            [self apptokenGet:nil];
        } else {
            if ([[NSDate date]isLaterThanOrEqualTo:[[PortalHelper sharedInstance]get_accessToken].expireTime]) { //过期了
                [self apptokenRefresh];
            } else {
                [self checkAppVer];
            }
        }
    }
}
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    if (self.CheckAppData) {
        [self shoAlertWith:self.CheckAppData];
    }
}
#pragma --mark< 检查更新 >
- (void)checkAppVer{
    kWeakSelf(self);
    [[ToolRequest sharedInstance]URLBASIC_appappUpdatesuccess:^(id dataDict, NSString *msg, NSInteger code) {
        weakself.CheckAppData = [CheckApp mj_objectWithKeyValues:dataDict];
        [weakself shoAlertWith:weakself.CheckAppData];
    } failure:^(NSInteger errorCode, NSString *msg) {
        [weakself.navigationController popViewControllerAnimated:NO];
        NSLog(@"检查更新失败：%@",msg);
    }];
}
- (void)shoAlertWith:(CheckApp *)data{
//    data.updateType = @"1";
    if ([data.updateType isEqualToString:@"1"] || [data.updateType isEqualToString:@"2"]) {
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:NSLocalizedString(@"fanewversong", nil) message:data.updateInfoUrl preferredStyle:UIAlertControllerStyleAlert];
        [alert addAction:[UIAlertAction actionWithTitle:NSLocalizedString(@"gotoAppStore", nil) style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            NSURL *url = [NSURL URLWithString:PORTALAPPID];
            if ([[UIApplication sharedApplication] canOpenURL:url]){
                [[UIApplication sharedApplication] openURL:url];
            }
        }]];
        if ([data.updateType isEqualToString:@"1"]) { //1 建议
            kWeakSelf(self);
            [alert addAction:[UIAlertAction actionWithTitle:NSLocalizedString(@"quxiaoAppstore", nil) style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
                [weakself.navigationController popViewControllerAnimated:NO];
            }]];
        }
        [self presentViewController:alert animated:YES completion:nil];
    }else{
        [self.navigationController popViewControllerAnimated:NO];
    }
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
        NSNotification *notification =[NSNotification notificationWithName:@"geyToken" object:nil userInfo:nil];
        [[NSNotificationCenter defaultCenter] postNotification:notification];
        [[PortalHelper sharedInstance]set_userInfo:tmp];
        [weakself.navigationController popViewControllerAnimated:NO];
    } failure:^(NSInteger errorCode, NSString *msg) {
        [weakself performSelector:@selector(ticketRefresh) withObject:nil afterDelay:0.5];
    }];
    
}
- (void)appidGet{
    kWeakSelf(self);
    [[ToolRequest sharedInstance]tpurseappappIdApplysuccess:^(id dataDict, NSString *msg, NSInteger code) {
        appIdAndSecret *appid =[appIdAndSecret mj_objectWithKeyValues:dataDict];
        [[PortalHelper sharedInstance] set_appIdAndSecret:appid];
        [weakself apptokenGet:nil];
    } failure:^(NSInteger errorCode, NSString *msg) {
        [weakself performSelector:@selector(appidGet) withObject:nil afterDelay:0.5];
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
            [weakself.navigationController popViewControllerAnimated:NO];
            NSNotification *notification =[NSNotification notificationWithName:@"geyToken" object:nil userInfo:nil];
            [[NSNotificationCenter defaultCenter] postNotification:notification];
        }
    } failure:^(NSInteger errorCode, NSString *msg) {
        [weakself performSelector:@selector(apptokenGet:) withObject:bloc afterDelay:1.0];
    }];
}
@end
