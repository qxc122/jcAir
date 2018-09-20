//
//  loginVc.m
//  portal
//
//  Created by Store on 2017/12/14.
//  Copyright © 2017年 qxc122@126.com. All rights reserved.
//

#import "loginVc.h"
#import "registVc.h"
#import "baseFillCell.h"
#import "loginVcFoot.h"
@interface loginVc ()
@property (nonatomic,strong) NSMutableArray *dataArry;
@property (nonatomic,weak) loginVcFoot *head;
@end

@implementation loginVc

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title =NSLocalizedString(@"loginVctitle", @"");
    [self setMyaccountVcUI];
    
    // Do any additional setup after loading the view.
}
- (void)setMyaccountVcUI{
    self.view.backgroundColor = ColorWithHex(0xF3F3F3, 1.0);
    loginVcFoot *head = [[loginVcFoot alloc]initWithFrame:CGRectMake(0, 0, SCREENWIDTH,144)];
    self.head = head;
    self.head.login.enabled = NO;
    self.tableView.tableFooterView = head;
    kWeakSelf(self);
    head.btnClick = ^(NSString *identifer) {
        [weakself handleFoot:identifer];
    };
    self.tableView.contentInset =UIEdgeInsetsMake(20, 0, 0, 0);
    self.header.hidden = YES;
    self.registerClasss = @[[baseFillCell class]];
    self.empty_type = succes_empty_num;
}
- (void)handleFoot:(NSString *)identifer{
    NSLog(@"identifer=%@",identifer);
    if ([identifer isEqualToString:@"login"]) {
        [self loginVclogin];
    } else if ([identifer isEqualToString:@"rerest"]) {
        [self OPenVc:[registVc new]];
    } else if ([identifer isEqualToString:@"guest"]) {
        [self.navigationController popToRootViewControllerAnimated:YES];
    }
}
- (void)loginVclogin{
    if ([self.email isValidateEmail]) {
        [self.tableView endEditing:YES];
        kWeakSelf(self);
        [MBProgressHUD showLoadingMessage:NSLocalizedString(@"dengluzhong", nil) toView:self.view];
        [[ToolRequest sharedInstance]URLBASIC_jcLoginWithemail:self.email password:self.passWord success:^(id dataDict, NSString *msg, NSInteger code) {
            UserInfo *tmp = [UserInfo mj_objectWithKeyValues:dataDict];
            [[PortalHelper sharedInstance]set_userInfo:tmp];
            if (tmp.authenTicket.length && tmp.authenUserId.length && tmp.surname.length && tmp.enName.length) {
                [MBProgressHUD hideHUDForView:weakself.view];
                [MBProgressHUD showPrompt:NSLocalizedString(@"dengluzhongOK", nil)];
                [weakself popSelf];
            }else{
                [weakself loginVcgetMyinfo];
            }
            NSNotification *notification =[NSNotification notificationWithName:@"resetCokie" object:nil userInfo:nil];
            [[NSNotificationCenter defaultCenter] postNotification:notification];
        } failure:^(NSInteger errorCode, NSString *msg) {
            [MBProgressHUD hideHUDForView:weakself.view];
            [MBProgressHUD showPrompt:msg toView:weakself.view];
        }];
    }else{
        [MBProgressHUD showPrompt:NSLocalizedString(@"qignshuruzhengEmai", nil) toView:self.view];
    }
}
- (void)loginVcgetMyinfo{
    kWeakSelf(self);
    [[ToolRequest sharedInstance]URLBASIC_jcMyInfosuccess:^(id dataDict, NSString *msg, NSInteger code) {
        UserInfo *tmp = [UserInfo mj_objectWithKeyValues:dataDict];
        [[PortalHelper sharedInstance]set_userInfo:tmp];
        [MBProgressHUD hideHUDForView:weakself.view];
        [MBProgressHUD showPrompt:NSLocalizedString(@"dengluzhongOK", nil)];
        [weakself popSelf];
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
    
}
#pragma --mark< 创建cell >
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    baseFillCell *cell = [baseFillCell returnCellWith:tableView];
    [self configurebaseFillCell:cell atIndexPath:indexPath];
    return  cell;
}

#pragma --mark< 配置HomeVcCell 的数据>
- (void)configurebaseFillCell:(baseFillCell *)cell atIndexPath:(NSIndexPath *)indexPath {
    setUpData *one = self.dataArry[indexPath.row];
    cell.inputInfo = one;
    kWeakSelf(self);
    cell.Fill_in_the_text = ^(NSString *identifer, NSString *inText, UITextField *intput) {
        if ([identifer isEqualToString:NSLocalizedString(@"loginVccell1", @"")]) {
            weakself.email = inText;
            setUpData *data = weakself.dataArry[0];
            data.title = inText;
        } else if ([identifer isEqualToString:NSLocalizedString(@"loginVccell2", @"")]) {
            weakself.passWord = inText;
            setUpData *data = weakself.dataArry[1];
            data.title = inText;
        }
        if (weakself.email.length && weakself.passWord.length) {
            weakself.head.login.enabled = YES;
        } else {
            weakself.head.login.enabled = NO;
        }
    };
}
- (NSMutableArray *)dataArry{
    if (!_dataArry) {
        _dataArry = [NSMutableArray new];
        for (NSInteger tmp = 0; tmp<2; tmp++) {
            setUpData *data = [setUpData new];
            NSString *placeholder;
            UITextFieldViewMode clearButtonMode;
            UIKeyboardType keyboardType;
            NSInteger contentType = 0;
            NSInteger existedLength = 0;
            if (tmp == 0) {
                placeholder =NSLocalizedString(@"loginVccell1", @"");
                clearButtonMode = UITextFieldViewModeWhileEditing;
                keyboardType = UIKeyboardTypeEmailAddress;
                existedLength = 50;
            } else {
                placeholder =NSLocalizedString(@"loginVccell2", @"");
                clearButtonMode = UITextFieldViewModeWhileEditing;
                keyboardType = UIKeyboardTypeASCIICapable;
                contentType = baseFillCellType_NumbersAndletters;
                existedLength = 20;
            }
            data.existedLength = existedLength;
            data.describe = placeholder;
            data.clearButtonMode = clearButtonMode;
            data.keyboardType = keyboardType;
            data.contentType = contentType;
            [_dataArry addObject:data];
        }
    }
    return _dataArry;
}
- (void)setEmail:(NSString *)email{
    _email = email;
    if (self.zhijielongin && self.dataArry.count>0) {
        setUpData *data = self.dataArry[0];
        data.title = email;
        [self.tableView reloadData];
    }
}
- (void)setPassWord:(NSString *)passWord{
    _passWord = passWord;
    if (self.zhijielongin && self.dataArry.count>1) {
        self.zhijielongin = nil;
        setUpData *data = self.dataArry[1];
        data.title = passWord;
        [self.tableView reloadData];
    }
}



@end
