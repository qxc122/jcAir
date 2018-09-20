//
//  rightVc.m
//  portal
//
//  Created by Store on 2017/12/18.
//  Copyright © 2017年 qxc122@126.com. All rights reserved.
//

#import "rightVc.h"
#import "rightVcCell.h"
#import "NSBundle+Language.h"
#import "mainVc.h"
#ifdef DEBUG
#import <WebKit/WKFoundation.h>
#import <WebKit/WebKit.h>
#endif
@interface rightVc ()
@property (nonatomic,strong) NSMutableArray *dataArry;
@property (nonatomic,weak) UIImageView *backPng;
@end

@implementation rightVc

- (void)viewDidLoad {
    [super viewDidLoad];
    self.fd_interactivePopDisabled = YES;
    self.fd_prefersNavigationBarHidden = YES;

    self.tableView.backgroundColor = ColorWithHex(0x000000, 0.9);
//    self.tableView.backgroundView = [[UIImageView alloc]initWithImage:self.backimage];
    self.tableView.contentInset =UIEdgeInsetsMake((SCREENHEIGHT-(55*self.dataArry.count))*0.5-10, 0, 0, 0);
    self.tableView.scrollEnabled= NO;
    UIButton *closeBtn = [UIButton new];
    [self.view addSubview:closeBtn];
    [closeBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        if (IPoneX) {
            make.top.equalTo(self.view).offset(42);
        } else {
            make.top.equalTo(self.view).offset(22);
        }
        make.left.equalTo(self.view).offset(8);
        make.width.equalTo(@44);
        make.height.equalTo(@44);
    }];
    [closeBtn setImage:[UIImage imageNamed:@"汉堡菜单"] forState:UIControlStateNormal];
    [closeBtn addTarget:self action:@selector(popSelfpopSelfAnimatedMy) forControlEvents:UIControlEventTouchUpInside];

    UIImageView *backPng = [UIImageView new];
    self.backPng = backPng;
    [self.view addSubview:backPng];
    [backPng mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view);
        make.right.equalTo(self.view);
        make.top.equalTo(self.view);
        make.bottom.equalTo(self.view);
    }];
    backPng.image = self.backimage;
    [self.view sendSubviewToBack:backPng];
    
    self.header.hidden = YES;
    self.registerClasss = @[[rightVcCell class]];
    self.empty_type = succes_empty_num;
}
- (void)setBackimage:(UIImage *)backimage{
    _backimage = backimage;
    self.backPng.image = backimage;
}
- (void)popSelfpopSelfAnimatedMy{
    [self popSelfAnimated:NO];
}
#pragma --mark< UITableViewDelegate 高>
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 15+40;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataArry.count;
}
#pragma --mark< 点击了 cell >
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:NO];// 取消选中
    setUpData *one = self.dataArry[indexPath.row];
#ifdef DEBUG
    if (indexPath.row == 7) {
        [self changeHuangJing];
    }else
#endif
    if ([one.title isEqualToString:NSLocalizedString(@"righht7", @"")]) {
        [self changeLuange];
    } else {
        id url = nil;
        if ([one.title isEqualToString:NSLocalizedString(@"righht1", @"")]) {
            url = NSLocalizedString(@"righht1", @"");
        } else if ([one.title isEqualToString:NSLocalizedString(@"righht2", @"")]) {
//            url = NSLocalizedString(@"righht2", @"");
            [self popSelf];
        } else if ([one.title isEqualToString:NSLocalizedString(@"righht3", @"")]) {
//            url = [[PortalHelper sharedInstance] get_Globaldata].jcFilghtUrl;
            [self OpendingpiaoVc];
            return;
        } else if ([one.title isEqualToString:NSLocalizedString(@"righht4", @"")]) {
//            url = [[PortalHelper sharedInstance] get_Globaldata].jcMyTripUrl;
            [self Openwodelist];
            return;
        } else if ([one.title isEqualToString:NSLocalizedString(@"righht5", @"")]) {
            url = [[PortalHelper sharedInstance] get_Globaldata].jcContactUrl;
        } else if ([one.title isEqualToString:NSLocalizedString(@"righht6", @"")]) {
            url = [[PortalHelper sharedInstance] get_Globaldata].jcAboutUrl;
        }
        if (self.didselecetCell) {
            self.didselecetCell(url);
        }
        if ([url isKindOfClass:[NSURL class]]) {
            [self openEachWkVcWithId:url];
        }
    }
}
#ifdef DEBUG
- (void)changeHuangJing{
    
    [[PortalHelper sharedInstance]set_userInfo:nil];
    [[PortalHelper sharedInstance]set_Globaldata:nil];
    [[PortalHelper sharedInstance]set_appIdAndSecret:nil];
    [[PortalHelper sharedInstance]set_accessToken:nil];
    
    NSString *strles = [NSUserDefaults getObjectWithKey:URLAddress];
    if ([strles isEqualToString:tesetURLAddress]) {
        [NSUserDefaults setObject:productURLAddress withKey:URLAddress];
        [MBProgressHUD showLoadingMessage:@"现在是正式环境，请重启APP"];
    } else if ([strles isEqualToString:productURLAddress]) {
        [NSUserDefaults setObject:tesetURLAddress withKey:URLAddress];
         [MBProgressHUD showLoadingMessage:@"现在是测试环境，请重启APP"];
    }
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
                                                                           
                                                                        }
                                                                        NSLog(@"Cookies for %@ deleted successfully",record.displayName);
                                                                    }];
                             index++;
                         }
                     }];
}
#endif
- (void)changeLuange{
    AppSetPlist *tmp = [[PortalHelper sharedInstance]get_AppSetPlist];
    NSString *title1 = nil;
    NSString *title2 = nil;
    if ([tmp.internation isEqualToString:@"0"]) { //中文
        title1 = NSLocalizedString(@"rightVcchagevctitle1Zh", nil);
        title2 = NSLocalizedString(@"rightVcchagevctitle2Zh", nil);
    } else if ([tmp.internation isEqualToString:@"1"]) { //英文
        title1 = NSLocalizedString(@"rightVcchagevctitle1En", nil);
        title2 = NSLocalizedString(@"rightVcchagevctitle2En", nil);
    }
    
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:NSLocalizedString(@"rightVcchagevc", nil) message:nil preferredStyle:UIAlertControllerStyleActionSheet];
    kWeakSelf(self);
    [alert addAction:[UIAlertAction actionWithTitle:title1 style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [weakself setStore];
    }]];
    [alert addAction:[UIAlertAction actionWithTitle:title2 style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
    }]];
    [alert addAction:[UIAlertAction actionWithTitle:NSLocalizedString(@"rightVcquxiao", nil) style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        
    }]];
    [self presentViewController:alert animated:YES completion:nil];
    
    
}
- (void)setStore{
    AppSetPlist *tmp = [[PortalHelper sharedInstance]get_AppSetPlist];
    if ([tmp.internation isEqualToString:@"0"]) { //中文
        tmp.internation = @"1";
        [self changeLanguageTo:@"en"];
    } else if ([tmp.internation isEqualToString:@"1"]) { //英文
        tmp.internation = @"0";
        [self changeLanguageTo:@"zh-Hans"];
    }
    [[PortalHelper sharedInstance]set_AppSetPlist:tmp];
}
- (void)changeLanguageTo:(NSString *)language {
    // 设置语言
    [NSBundle setLanguage:language];
    
    // 然后将设置好的语言存储好，下次进来直接加载
    [[NSUserDefaults standardUserDefaults] setObject:language forKey:@"myLanguage"];
    [[NSUserDefaults standardUserDefaults] synchronize];
    mainVc *tmp = [mainVc new];
    tmp.backimage = [self.backimage copy];
    tmp.isRestatr = @"NO";
    [UIApplication sharedApplication].keyWindow.rootViewController = [[UINavigationController alloc]initWithRootViewController:tmp];
    [tmp openrightWindosView:NO];
    
}
#pragma --mark< 创建cell >
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    rightVcCell *cell = [rightVcCell returnCellWith:tableView];
    [self configurerightVcCell:cell atIndexPath:indexPath];
    return  cell;
}

#pragma --mark< 配置HomeVcCell 的数据>
- (void)configurerightVcCell:(rightVcCell *)cell atIndexPath:(NSIndexPath *)indexPath {
    setUpData *one = self.dataArry[indexPath.row];
    cell.data = one;
}


- (NSMutableArray *)dataArry{
    if (!_dataArry) {
        _dataArry = [NSMutableArray new];
        for (NSInteger tmp = 0; tmp<7; tmp++) {
            setUpData *data = [setUpData new];
            NSString *title;
            NSString *icon;
            if (tmp == 0) {
                title =NSLocalizedString(@"righht1", nil);
                icon =@"我的账户";
            } else if (tmp == 1) {
                title =NSLocalizedString(@"righht2", nil);
                icon =@"首页";
            } else if (tmp == 2) {
                title =NSLocalizedString(@"righht3", nil);
                icon =@"预订航班";
            } else if (tmp == 3) {
                title =NSLocalizedString(@"righht4", nil);
                icon =@"我的行程";
            } else if (tmp == 4) {
                title =NSLocalizedString(@"righht5", nil);
                icon =@"联系我们";
            } else if (tmp == 5) {
                title =NSLocalizedString(@"righht6", nil);
                icon =@"关于我们";
            } else if (tmp == 6) {
                title =NSLocalizedString(@"righht7", nil);
                icon =@"中文";
            }
            NSLog(@"%@", data.title);
            data.title = title;
            data.icon = icon;
            [_dataArry addObject:data];
        }
#ifdef DEBUG
            setUpData *data = [setUpData new];
        NSString *title2;
        NSString *strles = [NSUserDefaults getObjectWithKey:URLAddress];
        if ([strles isEqualToString:tesetURLAddress]) {
            title2 = @"（现在是测试环境）";
        } else if ([strles isEqualToString:productURLAddress]) {
            title2 = @"（现在是正式环境）";
        }
        
            data.title =[NSString stringWithFormat:@"%@%@",NSLocalizedString(@"切换环境", @""),title2];
            data.icon =@"中文";
            [_dataArry addObject:data];
#endif
    }
    return _dataArry;
}
- (void)dealloc{
    NSLog(@"%s",__FUNCTION__);
}
@end
