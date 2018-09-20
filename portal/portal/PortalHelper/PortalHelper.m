//
//  PortalHelper.m
//  portal
//
//  Created by Store on 2017/8/31.
//  Copyright © 2017年 qxc122@126.com. All rights reserved.
//

#import "PortalHelper.h"
#import "MACRO_PORTAL.h"

#import "HeaderAll.h"
@interface PortalHelper ()
@property (nonatomic,strong) appIdAndSecret *appid;
@property (nonatomic,strong) accessToken *token;
@property (nonatomic,strong) UserInfo *userInfo;
@property (nonatomic,strong) UserInfoDeatil *userInfoDeatil;
@property (nonatomic,strong) GlobalParameter *Globaldata;
@property (nonatomic,strong) setUpAll *setUpAlldata;
@property (nonatomic,strong) bankList *bankListdata;
@property (nonatomic,strong) UMdeviceToken *deviceToken;
@property (nonatomic,strong) setUpdatePre *setupdatePre;
@property (nonatomic,strong) AppSetPlist *appSetPlist;
@end


@implementation PortalHelper
+ (PortalHelper *)sharedInstance
{
    static PortalHelper *instance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[self alloc] init];
    });
    return instance;
}
- (instancetype)init
{
    self = [super init];
    if (self) {
        self.appid = [NSKeyedUnarchiver unarchiveObjectWithFile:PATH_APPIDANDSECRET];
        self.token = [NSKeyedUnarchiver unarchiveObjectWithFile:PATH_TOKEN];
        self.Globaldata = [NSKeyedUnarchiver unarchiveObjectWithFile:PATH_APPCOMMONGLOBAL];
        self.userInfoDeatil = [NSKeyedUnarchiver unarchiveObjectWithFile:PATH_HOMEDATA];
        self.userInfo = [NSKeyedUnarchiver unarchiveObjectWithFile:PATH_USERINFO];
        self.setUpAlldata = [NSKeyedUnarchiver unarchiveObjectWithFile:PATH_SET_UP];
        self.bankListdata = [NSKeyedUnarchiver unarchiveObjectWithFile:PATH_BANK_PATH];
        self.deviceToken = [NSKeyedUnarchiver unarchiveObjectWithFile:PATH_deviceToken];
        self.setupdatePre = [NSKeyedUnarchiver unarchiveObjectWithFile:PATH_timePre];
        self.appSetPlist = [NSKeyedUnarchiver unarchiveObjectWithFile:PATH_appplist];
        if (!self.appSetPlist.internation || !self.appSetPlist.internation.length) {
            self.appSetPlist = [AppSetPlist new];

            NSString *tmp = [[NSUserDefaults standardUserDefaults] objectForKey:@"myLanguage"];
            if ([tmp isEqualToString:@"zh-Hans"]) {
                self.appSetPlist.internation = @"0";
            } else if ([tmp isEqualToString:@"en"]) {
                self.appSetPlist.internation = @"1";
            }else{
NSUserDefaults* defs = [NSUserDefaults standardUserDefaults];
                NSArray* languages = [defs objectForKey:@"AppleLanguages"];
                NSString* preferredLang = [languages objectAtIndex:0];
                if ([preferredLang containsString:@"zh-Hans"]) {
                    self.appSetPlist.internation = @"0";
                } else {
                    self.appSetPlist.internation = @"1";
                }
            }
        }
    }
    return self;
}

- (setUpdatePre *)get_setupdatePre{
    return self.setupdatePre;
}
- (void)set_setupdatePre:(setUpdatePre *)setupdatePre{
    if (setupdatePre) {
        [NSKeyedArchiver archiveRootObject:setupdatePre toFile:PATH_timePre];
    }else{
        NSFileManager *manager = [NSFileManager defaultManager];
        [manager removeItemAtPath:PATH_timePre error:nil];
    }
    self.setupdatePre = setupdatePre;
}


- (accessToken *)get_accessToken{
    return self.token;
}
- (AppSetPlist *)get_AppSetPlist{
    return self.appSetPlist;
}
- (void)set_AppSetPlist:(AppSetPlist *)data{
    if (data) {
        [NSKeyedArchiver archiveRootObject:data toFile:PATH_appplist];
    }else{
        NSFileManager *manager = [NSFileManager defaultManager];
        [manager removeItemAtPath:PATH_appplist error:nil];
    }
    self.appSetPlist = data;
}


- (void)set_accessToken:(accessToken *)data{
    if (data) {
        [NSKeyedArchiver archiveRootObject:data toFile:PATH_TOKEN];
    }else{
        NSFileManager *manager = [NSFileManager defaultManager];
        [manager removeItemAtPath:PATH_TOKEN error:nil];
    }
    self.token = data;
}

- (appIdAndSecret *)get_appIdAndSecret{
    return self.appid;
//    appIdAndSecret *data =  [NSKeyedUnarchiver unarchiveObjectWithFile:PATH_APPIDANDSECRET];
//    return data;
}
- (void)set_appIdAndSecret:(appIdAndSecret *)data{
    if (data) {
        [NSKeyedArchiver archiveRootObject:data toFile:PATH_APPIDANDSECRET];
    }else{
        NSFileManager *manager = [NSFileManager defaultManager];
        [manager removeItemAtPath:PATH_APPIDANDSECRET error:nil];
    }
    self.appid = data;
}

- (UserInfo *)get_userInfo{
    return self.userInfo;
//    UserInfo *data =  [NSKeyedUnarchiver unarchiveObjectWithFile:PATH_USERINFO];
//    return data;
}
- (void)set_userInfo:(UserInfo *)data{
    if (data) {
        if (!data.userId.length && self.userInfo.userId.length) {
            data.userId = self.userInfo.userId;
        }
        if (!data.surname.length && self.userInfo.surname.length) {
            data.surname = self.userInfo.surname;
        }
        if (!data.enName.length && self.userInfo.enName.length) {
            data.enName = self.userInfo.enName;
        }
        if (!data.mobile.length && self.userInfo.mobile.length) {
            data.mobile = self.userInfo.mobile;
        }
        if (!data.certType.length && self.userInfo.certType.length) {
            data.certType = self.userInfo.certType;
        }
        if (!data.certNo.length && self.userInfo.certNo.length) {
            data.certNo = self.userInfo.certNo;
        }
        if (!data.avatar && self.userInfo.avatar) {
            data.avatar = self.userInfo.avatar;
        }
        if (!data.authenTicket.length && self.userInfo.authenTicket.length) {
            data.authenTicket = self.userInfo.authenTicket;
        }
        if (!data.authenUserId.length && self.userInfo.authenUserId.length) {
            data.authenUserId = self.userInfo.authenUserId;
        }
        if (!data.zone.length && self.userInfo.zone.length) {
            data.zone = self.userInfo.zone;
        }
        if (!data.sex.length && self.userInfo.sex.length) {
            data.sex = self.userInfo.sex;
        }
        if (!data.birthday.length && self.userInfo.birthday.length) {
            data.birthday = self.userInfo.birthday;
        }
        if (!data.nationality.length && self.userInfo.nationality.length) {
            data.nationality = self.userInfo.nationality;
        }
        [NSKeyedArchiver archiveRootObject:data toFile:PATH_USERINFO];
    }else{
        NSFileManager *manager = [NSFileManager defaultManager];
        [manager removeItemAtPath:PATH_USERINFO error:nil];
    }
    self.userInfo = data;
}

- (setUpAll *)get_setUpAlldata{
   return self.setUpAlldata;
}
- (void)set_setUpAlldata:(setUpAll *)setUpAlldata{
    if (setUpAlldata) {
        [NSKeyedArchiver archiveRootObject:setUpAlldata toFile:PATH_SET_UP];
    }else{
        NSFileManager *manager = [NSFileManager defaultManager];
        [manager removeItemAtPath:PATH_SET_UP error:nil];
    }
    self.setUpAlldata = setUpAlldata;
}


- (UserInfoDeatil *)get_userInfoDeatil{
    return self.userInfoDeatil;
//    UserInfoDeatil *data =  [NSKeyedUnarchiver unarchiveObjectWithFile:PATH_HOMEDATA];
//    return data;
}

- (void)set_userInfoDeatil:(UserInfoDeatil *)dataDeatil{
    if (dataDeatil) {
        if (self.userInfoDeatil.Arry_list.count) {
            dataDeatil.Arry_list = self.userInfoDeatil.Arry_list;
        }
        [NSKeyedArchiver archiveRootObject:dataDeatil toFile:PATH_HOMEDATA];
    }else{
        NSFileManager *manager = [NSFileManager defaultManager];
        [manager removeItemAtPath:PATH_HOMEDATA error:nil];
    }
    self.userInfoDeatil = dataDeatil;
}

- (setUp *)get_setUpWith:(NSString *)phone{
    for (setUp *one in self.setUpAlldata.Arry_all) {
        if ([one.phone isEqualToString:phone]) {
            return one;
            break;
        }
    }
    setUp *tmp = [setUp new];
    tmp.phone = phone;
    tmp.staue = @"1";
    return tmp;
}
- (void)delete_setUpWith:(NSString *)phone{
    for (setUp *one in self.setUpAlldata.Arry_all) {
        if ([one.phone isEqualToString:phone]) {
            [self.setUpAlldata.Arry_all removeObject:one];
            if (self.setUpAlldata.Arry_all.count) {
                [NSKeyedArchiver archiveRootObject:self.setUpAlldata toFile:PATH_SET_UP];
            } else {
                NSFileManager *manager = [NSFileManager defaultManager];
                [manager removeItemAtPath:PATH_SET_UP error:nil];
            }
            NSLog(@"%@",self.setUpAlldata);
            break;
        }
    }
}
- (void)set_setUp:(setUp *)setUpData{
    if (setUpData) {
        [self.setUpAlldata.Arry_all addObject:setUpData];
        [NSKeyedArchiver archiveRootObject:self.setUpAlldata toFile:PATH_SET_UP];
    }
}

- (GlobalParameter *)get_Globaldata{
    return self.Globaldata;
//    GlobalParameter *data =  [NSKeyedUnarchiver unarchiveObjectWithFile:PATH_APPCOMMONGLOBAL];
//    return data;
}
- (void)set_Globaldata:(GlobalParameter *)Globaldata{
    if (Globaldata) {
        [NSKeyedArchiver archiveRootObject:Globaldata toFile:PATH_APPCOMMONGLOBAL];
    }else{
        NSFileManager *manager = [NSFileManager defaultManager];
        [manager removeItemAtPath:PATH_APPCOMMONGLOBAL error:nil];
    }
    self.Globaldata = Globaldata;
}

- (bankList *)get_bankListdata{
    return self.bankListdata;
}
- (void)set_bankListdata:(bankList *)bankListdata{
    if (bankListdata) {
        [NSKeyedArchiver archiveRootObject:bankListdata toFile:PATH_BANK_PATH];
    }else{
        NSFileManager *manager = [NSFileManager defaultManager];
        [manager removeItemAtPath:PATH_BANK_PATH error:nil];
    }
    self.bankListdata = bankListdata;
}

- (UMdeviceToken *)get_deviceToken{
    return self.deviceToken;
}
- (void)set_deviceToken:(UMdeviceToken *)deviceToken{
    if (deviceToken) {
        [NSKeyedArchiver archiveRootObject:deviceToken toFile:PATH_deviceToken];
    }else{
        NSFileManager *manager = [NSFileManager defaultManager];
        [manager removeItemAtPath:PATH_deviceToken error:nil];
    }
    self.deviceToken = deviceToken;
}

//- (void)setAppid:(appIdAndSecret *)appid{
//    _appid = appid;
//    [NSKeyedArchiver archiveRootObject:appid toFile:PATH_APPIDANDSECRET];
//}
//- (void)setToken:(accessToken *)token{
//    _token = token;
//    [NSKeyedArchiver archiveRootObject:token toFile:PATH_TOKEN];
//}
//- (void)setGlobalParameter:(GlobalParameter *)globalParameter{
//    _globalParameter = globalParameter;
//    [NSKeyedArchiver archiveRootObject:globalParameter toFile:PATH_APPCOMMONGLOBAL];
//}
//
//- (void)setHomeData:(HomeData *)homeData{
//    _homeData = homeData;
//    [NSKeyedArchiver archiveRootObject:homeData toFile:PATH_HOMEDATA];
//}

//
//- (void)photoSHouquanOKsuccess:(photoSHouquanSuccess)successBlock failure:(photoSHouquanFailure)failureBlock{
//    PHAuthorizationStatus authoriation = [PHPhotoLibrary authorizationStatus];
//    if (authoriation == PHAuthorizationStatusNotDetermined) {
//        kWeakSelf(self);
//        [PHPhotoLibrary requestAuthorization:^(PHAuthorizationStatus status) {
//            //这里非主线程，选择完成后会出发相册变化代理方法
//            if (status == PHAuthorizationStatusAuthorized) {
//                successBlock();
//            } else {
//                [weakself SetWithfailure:failureBlock];
//            }
//        }];
//    }else if (authoriation == PHAuthorizationStatusAuthorized) {
//        successBlock();
//    }else {
//        [self SetWithfailure:failureBlock];
//    }
//}
//
//- (void)SetWithfailure:(photoSHouquanFailure)failureBlock{
//    XAlertView *tmp = [[XAlertView alloc]initWithTitle:NSLocalizedString(@"Cannot preview pictures", @"Cannot preview pictures") message:NSLocalizedString(@"The application has no access to photo permissions", @"The application has no access to photo permissions") clickedBlock:^(XAlertView *alertView, BOOL canceled, NSInteger clickedIndex) {
//        if (canceled) {
//            failureBlock();
//        } else {
//            // 去设置权限
//            NSURL *url = [NSURL URLWithString:UIApplicationOpenSettingsURLString];
//            if ([[UIApplication sharedApplication] canOpenURL:url]) {
//                [[UIApplication sharedApplication] openURL:url];
//            }
//        }
//    } cancelButtonTitle:NSLocalizedString(@"cancel", @"cancel") otherButtonTitles:NSLocalizedString(@"Go setup", @"Go setup"), nil];
//    [tmp show];
//}
//
//- (void)photoSHouquan{
//    PHAuthorizationStatus authoriation = [PHPhotoLibrary authorizationStatus];
//    if (authoriation == PHAuthorizationStatusNotDetermined) {
//        [PHPhotoLibrary requestAuthorization:^(PHAuthorizationStatus status) {
//            //这里非主线程，选择完成后会出发相册变化代理方法
//        }];
//    }
//}

//- (setUp *)getsetUp{
//    setUp *data =  [NSKeyedUnarchiver unarchiveObjectWithFile:PATH_SET_UP];
//    if (!data) {
//        data = [setUp new];
//        data.ReceiveNotification = YES;
//        data.ReceiveNotification = YES;
//        [NSKeyedArchiver archiveRootObject:data toFile:PATH_SET_UP];
//    }
//    return data;
//}
//- (void)setsetUp:(setUp *)data{
//    if (data) {
//        [NSKeyedArchiver archiveRootObject:data toFile:PATH_SET_UP];
//    }else{
//        NSFileManager *manager = [NSFileManager defaultManager];
//        [manager removeItemAtPath:PATH_SET_UP error:nil];
//    }
//}
- (setUpAll *)setUpAlldata{
    if (!_setUpAlldata) {
        _setUpAlldata = [setUpAll new];
        _setUpAlldata.Arry_all = [NSMutableArray array];
        _setUpAlldata.Arry_allPhone = [NSMutableArray array];
    }
    return _setUpAlldata;
}
- (NSDictionary *)getCountyEn{
    return [self readLocalFileWithName:@"JCen"];
}
- (NSDictionary *)getCountyZh{
    return [self readLocalFileWithName:@"JCzh"];
}
- (NSDictionary *)getArea{
   return  [self readLocalFileWithName:@"area"];
}
// 读取本地JSON文件
- (NSDictionary *)readLocalFileWithName:(NSString *)name {
    // 获取文件路径
    NSString *path = [[NSBundle mainBundle] pathForResource:name ofType:@"json"];
    // 将文件数据化
    NSData *data = [[NSData alloc] initWithContentsOfFile:path];
    // 对数据进行JSON格式化并返回字典形式
    return [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:nil];
}
@end
