//
//  AppDelegate+Umeng.m
//  Tourism
//
//  Created by Store on 16/11/9.
//  Copyright © 2016年 qxc122@126.com. All rights reserved.
//

#import "AppDelegate+Umeng.h"
#import <UMCommon/UMCommon.h>           // 公共组件是所有友盟产品的基础组件，必选
#import <UMAnalytics/MobClick.h>        // 统计组件
#import "THIRD_PARTY.h"


@implementation AppDelegate (Umeng)
-(void)setupUMeng{
#ifdef DEBUG
    [UMConfigure initWithAppkey:UmengAppKey channel:@"App Test"];
#else
    [UMConfigure initWithAppkey:UmengAppKey channel:@"App Store"];
#endif
}
@end
