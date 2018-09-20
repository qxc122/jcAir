//
//  AppDelegate.m
//  portal
//
//  Created by Store on 2017/8/30.
//  Copyright © 2017年 qxc122@126.com. All rights reserved.
//

#import "AppDelegate.h"
#import "HeaderAll.h"
#import "MACRO_PIC.h"
#import "MACRO_PORTAL.h"
#import "UIColor+Add.h"
#import "AppDelegate+Umeng.h"
#import "mainVc.h"
#import "NSBundle+Language.h"
#import "WXApi.h"
#import "THIRD_PARTY.h"
#import "AppTools.h"
#import "LaunchIntroductionView.h"

#define IS_PAD (UI_USER_INTERFACE_IDIOM()== UIUserInterfaceIdiomPad)
#define IS_IPHONE (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone)

typedef void (^AppDelegateLoadSuccess)(NSInteger type);


@interface AppDelegate ()<WXApiDelegate>

@end

@implementation AppDelegate
- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    if ([[NSUserDefaults standardUserDefaults] objectForKey:@"myLanguage"] && ![[[NSUserDefaults standardUserDefaults] objectForKey:@"myLanguage"] isEqualToString:@""]) {
        [NSBundle setLanguage:[[NSUserDefaults standardUserDefaults] objectForKey:@"myLanguage"]];
    }
    
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    self.window.backgroundColor = [UIColor whiteColor];   //设置通用背景颜色
    
    UINavigationController *nnvc = [[UINavigationController alloc]initWithRootViewController:[[mainVc alloc] init]];
    self.window.rootViewController = nnvc;
    [self.window makeKeyAndVisible];
    [WXApi registerApp:WechatAppID];
    [self setupUMeng];
    if ([PHONEVERSION floatValue] >= 7.0) {
        [[UINavigationBar appearance] setBackgroundImage:[ColorWithHex(0xED1C24, 1.0) imageWithColor] forBarMetrics:UIBarMetricsDefault];
        [[UINavigationBar appearance] setShadowImage:[ColorWithHex(0xED1C24, 1.0) imageWithColor]];
    }
    
    NSString *deviceType = [UIDevice currentDevice].model;
    if([deviceType isEqualToString:@"iPhone"]) {
        NSArray *pngs;
        if ([[[PortalHelper sharedInstance]get_AppSetPlist].internation isEqualToString:@"0"]) {
            pngs = @[@"launch00",@"launch10",@"launch20",@"launch30"];
        } else if ([[[PortalHelper sharedInstance]get_AppSetPlist].internation isEqualToString:@"1"]) {
            pngs = @[@"launch01",@"launch11",@"launch21",@"launch31"];
        }
        
        [AppTools onFirstStartForCurrentVersion:^(BOOL isFirstStartForCurrentVersion) {
            if (isFirstStartForCurrentVersion) {
                LaunchIntroductionView *launch = [LaunchIntroductionView sharedWithImages:pngs buttonImage:IMMEDIATE_EXPERIENCE_BTN buttonFrame:CGRectMake(SCREENWIDTH/2 - 80/2,134, 80, 35) skipbuttonImage:nil skipbuttonFrame:CGRectZero];
                launch.currentColor = ColorWithHex(0xFFFFFF, 1.0);
                launch.nomalColor = ColorWithHex(0xFFFFFF, 0.5);
            }
        }];
    }
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}
- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.

}
- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

// 支持所有iOS系统
- (BOOL)application:(UIApplication *)application openURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication annotation:(id)annotation
{
    BOOL result = [WXApi handleOpenURL:url delegate:self];
    return result;
}

#pragma mark---微信登录
- (void)onResp:(BaseResp *)resp
{
    if ([resp isKindOfClass:[PayResp class]]) {
        PayResp *response = (PayResp *)resp;
        switch(response.errCode) {
            case WXSuccess:
                [MBProgressHUD showError:NSLocalizedString(@"wechatPaySuccess", nil)];
                [[NSNotificationCenter defaultCenter] postNotificationName:@"wechatPaySuccess" object:nil];
                break;
            case WXErrCodeUserCancel:
                [MBProgressHUD showError:NSLocalizedString(@"wechatPayUserCancel", nil)];
                [[NSNotificationCenter defaultCenter] postNotificationName:@"wechatPayUserCancel" object:nil];
                break;
            default:
                [MBProgressHUD showError:NSLocalizedString(@"wechatPayFaild", nil)];
                [[NSNotificationCenter defaultCenter] postNotificationName:@"wechatPayFaild" object:nil];
                break;
        }
    }
}
@end
