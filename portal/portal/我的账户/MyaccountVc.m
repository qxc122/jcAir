//
//  MyaccountVc.m
//  portal
//
//  Created by Store on 2017/12/14.
//  Copyright © 2017年 qxc122@126.com. All rights reserved.
//

#import "MyaccountVc.h"
#import "baseCell.h"
#import "MyaccountVcHead.h"
#import "modififyInfo.h"
@interface MyaccountVc ()
@property (nonatomic,strong) NSMutableArray *dataArry;
@property (nonatomic,weak) MyaccountVcHead *head;
@end

@implementation MyaccountVc

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title =NSLocalizedString(@"MyaccountVctitle", @"");
    [self setMyaccountVcUI];

    // Do any additional setup after loading the view.
}
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.head.userInfo = [[PortalHelper sharedInstance]get_userInfo];
}
- (void)setMyaccountVcUI{
    self.view.backgroundColor = ColorWithHex(0xF3F3F3, 1.0);
    MyaccountVcHead *head = [[MyaccountVcHead alloc]initWithFrame:CGRectMake(0, 0, SCREENWIDTH,137)];
    self.head = head;
    self.head.hidden = YES;
    self.tableView.tableHeaderView = head;
    
    UIButton *exit = [UIButton new];
    [self.view addSubview:exit];
    [exit mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.equalTo(@50);
        make.bottom.equalTo(self.view);
        make.right.equalTo(self.view);
        make.left.equalTo(self.view);
    }];
    [self.tableView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(exit.mas_top);
        make.top.equalTo(self.view);
        make.right.equalTo(self.view);
        make.left.equalTo(self.view);
    }];
    self.registerClasss = @[[baseCell class]];
    [self.tableView setSeparatorStyle:UITableViewCellSeparatorStyleSingleLineEtched];
    [exit setWithNormalColor:0xFFFFFF NormalAlpha:1.0 NormalTitle:NSLocalizedString(@"MyaccountVcout", @"") NormalImage:nil NormalBackImage:nil SelectedColor:0x0 SelectedAlpha:0 SelectedTitle:nil SelectedImage:nil SelectedBackImage:nil Font:17 NormalROrM:@"r" backColor:0xED1C24  backAlpha:1.0];
    [exit addTarget:self action:@selector(exitClick) forControlEvents:UIControlEventTouchUpInside];
    
//    UserInfo *tmp = [[PortalHelper sharedInstance]get_userInfo];
//    if (tmp.surname.length && tmp.enName.length) {
//        self.header.hidden = YES;
//        self.empty_type = succes_empty_num;
//        self.head.userInfo = tmp;
//    self.head.hidden = NO;
//    } else {
//        [self.header beginRefreshing];
//    }
    [self.header beginRefreshing];
}
- (void)loadNewData{
    kWeakSelf(self);
    [[ToolRequest sharedInstance]URLBASIC_jcMyInfosuccess:^(id dataDict, NSString *msg, NSInteger code) {
        UserInfo *tmp = [UserInfo mj_objectWithKeyValues:dataDict];
        [[PortalHelper sharedInstance]set_userInfo:tmp];
        weakself.head.userInfo = tmp;
        weakself.head.hidden = NO;
        [weakself loadNewDataEndHeadsuccessSet:nil code:code footerIsShow:NO hasMore:nil];
    } failure:^(NSInteger errorCode, NSString *msg) {
        [weakself loadNewDataEndHeadfailureSet:nil errorCode:errorCode];
    }];
}
- (void)exitClick{
    kWeakSelf(self);
    [MBProgressHUD showLoadingMessage:NSLocalizedString(@"tuichuzhogn", nil) toView:self.view];
    [[ToolRequest sharedInstance]URLBASIC_tpurseuserlogoutsssuccess:^(id dataDict, NSString *msg, NSInteger code) {
        [[PortalHelper sharedInstance]set_userInfo:nil];
        [MBProgressHUD hideHUDForView:weakself.view];
        [MBProgressHUD showPrompt:NSLocalizedString(@"tuichuzhognOK", nil)];
        [weakself.navigationController popToRootViewControllerAnimated:YES];
    } failure:^(NSInteger errorCode, NSString *msg) {
        [MBProgressHUD hideHUDForView:weakself.view];
        [MBProgressHUD showPrompt:msg toView:weakself.view];
    }];
}
#pragma --mark< UITableViewDelegate 高>
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 60;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataArry.count;
}
#pragma --mark< 点击了 cell >
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    setUpData *one = self.dataArry[indexPath.row];
    if ([one.title isEqualToString:NSLocalizedString(@"MyaccountVccell1", @"")]) {
        [self OPenVc:[modififyInfo new]];
    } else if ([one.title isEqualToString:NSLocalizedString(@"MyaccountVccell2", @"")]) {
        
    } else if ([one.title isEqualToString:NSLocalizedString(@"MyaccountVccell3", @"")]) {
        [self openEachWkVcWithId:[[PortalHelper sharedInstance]get_Globaldata].jcPassengerUrl];
    }
}

#pragma --mark< 创建cell >
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    baseCell *cell = [baseCell returnCellWith:tableView];
    [self configurebaseCell:cell atIndexPath:indexPath];
    return  cell;
}

#pragma --mark< 配置HomeVcCell 的数据>
- (void)configurebaseCell:(baseCell *)cell atIndexPath:(NSIndexPath *)indexPath {
    setUpData *one = self.dataArry[indexPath.row];
    cell.imageView.image = [UIImage imageNamed:one.icon];
    cell.textLabel.text = one.title;
    cell.backgroundColor = [UIColor whiteColor];
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    cell.separatorInset = UIEdgeInsetsMake(0, 20, 0, 20);
}
- (NSMutableArray *)dataArry{
    if (!_dataArry) {
        _dataArry = [NSMutableArray new];
        for (NSInteger tmp = 0; tmp<2; tmp++) {
            setUpData *data = [setUpData new];
            NSString *title;
            NSString *icon;
            if (tmp == 0) {
                title =NSLocalizedString(@"MyaccountVccell1", @"");
                icon =@"我的资料";
            } else if (tmp == 1) {
                title =NSLocalizedString(@"MyaccountVccell3", @"");
                icon =@"常用旅客";
            } else if (tmp == 2) {
                title =NSLocalizedString(@"MyaccountVccell2", @"");
                icon =@"我的旅行证件";
            }
            data.title = title;
            data.icon = icon;
            [_dataArry addObject:data];
        }
    }
    return _dataArry;
}

@end
