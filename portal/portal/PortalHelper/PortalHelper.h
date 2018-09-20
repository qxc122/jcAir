//
//  PortalHelper.h
//  portal
//
//  Created by Store on 2017/8/31.
//  Copyright © 2017年 qxc122@126.com. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ToolModeldata.h"


typedef void (^photoSHouquanSuccess)();
typedef void (^photoSHouquanFailure)();

@interface PortalHelper : NSObject
+ (PortalHelper *)sharedInstance;

- (appIdAndSecret *)get_appIdAndSecret;
- (void)set_appIdAndSecret:(appIdAndSecret *)data;

- (AppSetPlist *)get_AppSetPlist;
- (void)set_AppSetPlist:(AppSetPlist *)data;

- (accessToken *)get_accessToken;
- (void)set_accessToken:(accessToken *)data;

- (UserInfo *)get_userInfo;
- (void)set_userInfo:(UserInfo *)data;

- (UserInfoDeatil *)get_userInfoDeatil;
- (void)set_userInfoDeatil:(UserInfoDeatil *)dataDeatil;

- (setUp *)get_setUpWith:(NSString *)phone;
- (void)delete_setUpWith:(NSString *)phone;
- (void)set_setUp:(setUp *)setUpData;

- (GlobalParameter *)get_Globaldata;
- (void)set_Globaldata:(GlobalParameter *)Globaldata;

- (setUpAll *)get_setUpAlldata;
- (void)set_setUpAlldata:(setUpAll *)setUpAlldata;

- (setUpdatePre *)get_setupdatePre;
- (void)set_setupdatePre:(setUpdatePre *)setupdatePre;

-(id )getCountyEn;
-(id )getCountyZh;
-(id )getArea;
@end


