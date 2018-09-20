//
//  modififyInfo.m
//  portal
//
//  Created by Store on 2017/12/19.
//  Copyright © 2017年 qxc122@126.com. All rights reserved.
//

#import "modififyInfo.h"
#import "modififyInfoBaseFillCell.h"
#import "modififyinfoSexCell.h"
#import "phoneCell.h"
#import "selecetCountyVc.h"
#import "datePiker.h"
#import "selecetAreaVc.h"
@interface modififyInfo ()
@property (nonatomic,strong) NSMutableArray *dataArry;
@property (nonatomic,weak) UIButton *next;

@property (nonatomic,strong) NSString *sex;
@property (nonatomic,strong) NSString *name;
@property (nonatomic,strong) NSString *xing;
@property (nonatomic,strong) NSString *birthdaty;
@property (nonatomic,strong) countryOne *countryone;

@property (nonatomic,strong) countryOne *AreaJsonone;
@property (nonatomic,strong) NSString *phone;

@end
@implementation modififyInfo
- (void)viewDidLoad {
    [super viewDidLoad];
    self.title =NSLocalizedString(@"modififyInfotitle", nil);
    UserInfo *tmp = [[[PortalHelper sharedInstance]get_userInfo] copy];
    self.sex = tmp.sex;
    self.name = tmp.enName;
    self.xing = tmp.surname;
    self.birthdaty = tmp.birthday;
    self.countryone = [countryOne new];
    self.countryone.countryCode = tmp.nationality;
    self.AreaJsonone = [countryOne new];
    self.AreaJsonone.areaCode = tmp.zone;
    self.phone = tmp.mobile;
    
    self.header.hidden = YES;
    self.view.backgroundColor = ColorWithHex(0xF3F3F3, 1.0);
    self.registerClasss = @[[modififyInfoBaseFillCell class],[phoneCell class],[modififyinfoSexCell class]];
    self.empty_type = succes_empty_num;
    self.tableView.contentInset = UIEdgeInsetsMake(20, 0, 50, 0);

    UIButton *next = [UIButton new];
    [self.view addSubview:next];
    self.next = next;
    [self.next mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view);
        make.right.equalTo(self.view);
        make.bottom.equalTo(self.view);
        make.height.equalTo(@50);
    }];
    [self.next setWithNormalColor:0xFFFFFF NormalAlpha:1.0 NormalTitle:NSLocalizedString(@"modififyInfotitlesave", nil) NormalImage:nil NormalBackImage:nil SelectedColor:0x0 SelectedAlpha:0 SelectedTitle:nil SelectedImage:nil SelectedBackImage:nil Font:17 NormalROrM:@"m" backColor:0xED1C24 backAlpha:1.0];
    self.next.enabled = NO;
    [self.next addTarget:self action:@selector(nextClick) forControlEvents:UIControlEventTouchUpInside];
}
- (void)nextClick{
    [self.tableView endEditing:YES];
    if ([self.AreaJsonone.areaCode containsString:@"86"]) {
        if ([self.phone IsTelNumber]) {
            [self saveZiliao];
        } else {
            [MBProgressHUD showPrompt:NSLocalizedString(@"shoujihaocuowu", nil) toView:self.view];
        }
    } else {
        [self saveZiliao];
    }
}
- (void)saveZiliao{
    kWeakSelf(self);
    [MBProgressHUD showLoadingMessage:NSLocalizedString(@"baocunzhogn", nil) toView:self.view];
    
    [[ToolRequest sharedInstance]URLBASIC_jcModifyMyInfoWithmobile:self.phone zone:self.AreaJsonone.areaCode surname:self.xing enName:self.name sex:self.sex birthday:self.birthdaty nationality:self.countryone.countryCode success:^(id dataDict, NSString *msg, NSInteger code) {
        UserInfo *tmp = [[PortalHelper sharedInstance]get_userInfo];
        tmp.sex = weakself.sex;
        tmp.surname = weakself.xing;
        tmp.enName = weakself.name;
        tmp.birthday = weakself.birthdaty;
        tmp.nationality = weakself.countryone.countryCode;
        tmp.zone = weakself.AreaJsonone.areaCode;
        tmp.mobile = weakself.phone;
        [[PortalHelper sharedInstance]set_userInfo:tmp];
        [MBProgressHUD hideHUDForView:weakself.view];
        [MBProgressHUD showPrompt:NSLocalizedString(@"baocunzhognOK", nil)];
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
#pragma --mark< 创建cell >
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    setUpData *one = self.dataArry[indexPath.row];
    if ([one.title isEqualToString:NSLocalizedString(@"modififyInfoCellTitle1", @"")]) {
        modififyinfoSexCell *cell = [modififyinfoSexCell returnCellWith:tableView];
        [self configuremodififyinfoSexCell:cell atIndexPath:indexPath];
        return  cell;
    } else if ([one.title isEqualToString:NSLocalizedString(@"modififyInfoCellTitle2", @"")] || [one.title isEqualToString:NSLocalizedString(@"modififyInfoCellTitle3", @"")] || [one.title isEqualToString:NSLocalizedString(@"modififyInfoCellTitle4", @"")] || [one.title isEqualToString:NSLocalizedString(@"modififyInfoCellTitle5", @"")]) {
        modififyInfoBaseFillCell *cell = [modififyInfoBaseFillCell returnCellWith:tableView];
        [self configuremodififyInfoBaseFillCell:cell atIndexPath:indexPath];
        return  cell;
    } else if ([one.title isEqualToString:NSLocalizedString(@"modififyInfoCellTitle6", @"")]) {
        phoneCell *cell = [phoneCell returnCellWith:tableView];
        [self configurephoneCell:cell atIndexPath:indexPath];
        return  cell;
    }else{
        return nil;
    }
}
#pragma --mark< 配置modififyinfoSexCell 的数据>
- (void)configuremodififyinfoSexCell:(modififyinfoSexCell *)cell atIndexPath:(NSIndexPath *)indexPath {
    setUpData *one = self.dataArry[indexPath.row];
    cell.titleN.text = one.title;
    if ([self.sex isEqualToString:@"M"]) {
        cell.man.selected = YES;
        cell.Woman.selected = NO;
    } else if ([self.sex isEqualToString:@"F"]) {
        cell.man.selected = NO;
        cell.Woman.selected = YES;
    }else{
        cell.man.selected = NO;
        cell.Woman.selected = NO;
    }
    kWeakSelf(self);
    cell.btnClickSex = ^(NSString *identifer) {
        if (![identifer isEqualToString:weakself.sex]) {
            weakself.sex = identifer;
            [weakself Isitpossibletojudgewhetheritispossibl];
        }
    };
}
#pragma --mark< 配置modififyInfoBaseFillCell 的数据>
- (void)configuremodififyInfoBaseFillCell:(modififyInfoBaseFillCell *)cell atIndexPath:(NSIndexPath *)indexPath {
    setUpData *one = self.dataArry[indexPath.row];
    cell.inputInfo = one;
    kWeakSelf(self);
    cell.Fill_in_the_text = ^(NSString *identifer, NSString *inText, UITextField *intput) {
        if ([identifer isEqualToString:NSLocalizedString(@"modififyInfoCell2", @"")]) {
            weakself.name = inText;
        } else if ([identifer isEqualToString:NSLocalizedString(@"modififyInfoCell3", @"")]) {
            weakself.xing = inText;
        }
        [weakself Isitpossibletojudgewhetheritispossibl];
    };
    if ([one.title isEqualToString:NSLocalizedString(@"modififyInfoCellTitle2", @"")]) {
        cell.input.text = self.name;
    } else if ([one.title isEqualToString:NSLocalizedString(@"modififyInfoCellTitle3", @"")]) {
        cell.input.text = self.xing;
    }
    if ([one.title isEqualToString:NSLocalizedString(@"modififyInfoCellTitle4", @"")]) {
        cell.input.text = self.birthdaty;
    } else if ([one.title isEqualToString:NSLocalizedString(@"modififyInfoCellTitle5", @"")]) {
        if (self.countryone.countryName.length) {
            cell.input.text = self.countryone.countryName;
        } else {
            [self getCoutryNameWithCode:self.countryone.countryCode];
        }
    }
}
- (void)getCoutryNameWithCode:(NSString *)code{
    if (code.length) {
        kWeakSelf(self);
        dispatch_async(dispatch_get_global_queue(0, 0), ^{
            NSDictionary *tmp;
            if ([[[PortalHelper sharedInstance]get_AppSetPlist].internation isEqualToString:@"0"]) {
                tmp = [[PortalHelper sharedInstance]getCountyZh];
            } else {
                tmp = [[PortalHelper sharedInstance]getCountyEn];
            }
            NSArray *indexArry = @[@"Hot",@"A",@"B",@"C",@"D",@"E",@"F",@"G",@"H",@"I",@"J",@"K",@"L",@"M",@"N",@"O",@"P",@"Q",@"R",@"S",@"T",@"U",@"V",@"W",@"Y",@"Z"];
            for (NSString *key in indexArry) {
                NSArray *arry = tmp[key];
                if (arry && [arry isKindOfClass:[NSArray class]] && arry.count) {
                    for (NSDictionary *dic in arry) {
                        countryOne *one = [countryOne mj_objectWithKeyValues:dic];
                        if ([one.countryCode isEqualToString:code]) {
                            weakself.countryone.countryName = one.countryName;
                            break;
                        }
                    }
                }
            }
            dispatch_async(dispatch_get_main_queue(), ^{
                [weakself.tableView reloadData];
            });
        });
    }
}
#pragma --mark< 配置phoneCell 的数据>
- (void)configurephoneCell:(phoneCell *)cell atIndexPath:(NSIndexPath *)indexPath {
    setUpData *one = self.dataArry[indexPath.row];
    cell.titleN.text = one.title;
    cell.zone.text = [NSString stringWithFormat:@"+%@",self.AreaJsonone.areaCode];
    cell.input.placeholder = one.describe;
    cell.input.text = self.phone;
    kWeakSelf(self);
    cell.selezone = ^{
        [weakself OpenZone];
    };
    cell.Fill_in_the_text = ^(NSString *identifer, NSString *inText, UITextField *intput) {
        weakself.phone = inText;
        [weakself Isitpossibletojudgewhetheritispossibl];
    };
    
}
- (void)OpenZone{
    selecetAreaVc *vc = [selecetAreaVc new];
    kWeakSelf(self);
    vc.selecetData = ^(countryOne *data) {
        weakself.AreaJsonone = data;
        [weakself.tableView reloadData];
        [weakself Isitpossibletojudgewhetheritispossibl];
    };
    [self OPenVc:vc];
}
#pragma --mark< 点击了 cell >
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:NO];// 取消选中
    setUpData *one = self.dataArry[indexPath.row];
    if ([one.title isEqualToString:NSLocalizedString(@"modififyInfoCellTitle4", @"")]) {
        //选出生日期
        [self OpendatePikerIsbirthday:indexPath];
    } else if ([one.title isEqualToString:NSLocalizedString(@"modififyInfoCellTitle5", @"")]) {
        //选国籍
        [self OpenselecetCountyVc:indexPath];
    }
}
#pragma -mark<选国籍选择>
- (void)OpenselecetCountyVc:(NSIndexPath *)indexPath{
    //选国籍
    selecetCountyVc *vc = [selecetCountyVc new];
    kWeakSelf(self);
    vc.selecetData = ^(countryOne *data) {
        weakself.countryone = data;
        [weakself.tableView reloadData];
        [weakself Isitpossibletojudgewhetheritispossibl];
    };
    [self OPenVc:vc];
}
#pragma -mark<打开日期选择>
- (void)OpendatePikerIsbirthday:(NSIndexPath *)indexPath{
    [self.tableView endEditing:YES];
    datePiker *piker = [datePiker new];
    piker.minDateStr = @"19000101";
    piker.maxDate = [NSDate date];
    kWeakSelf(self);
    piker.SelecetDateStr = ^(NSString *Date) {
        weakself.birthdaty = Date;
        [weakself.tableView reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationNone];
        [weakself Isitpossibletojudgewhetheritispossibl];
    };
    [piker windosViewshow];
}
- (NSMutableArray *)dataArry{
    if (!_dataArry) {
        _dataArry = [NSMutableArray new];
        for (NSInteger tmp = 0; tmp<6; tmp++) {
            setUpData *data = [setUpData new];
            NSString *placeholder = nil;
            NSString *title = nil;
            UITextFieldViewMode clearButtonMode = UITextFieldViewModeWhileEditing;
            UIKeyboardType keyboardType = UIKeyboardTypeASCIICapable;
            NSInteger contentType = 0;
            NSUInteger  existedLength = 0;
            if (tmp == 0) {
                title =NSLocalizedString(@"modififyInfoCellTitle1", @"");
                placeholder =NSLocalizedString(@"modififyInfoCell1", @"");
                clearButtonMode = UITextFieldViewModeWhileEditing;
                keyboardType = UIKeyboardTypeASCIICapable;
            } else if(tmp == 1){
                title =NSLocalizedString(@"modififyInfoCellTitle2", @"");
                placeholder =NSLocalizedString(@"modififyInfoCell2", @"");
                clearButtonMode = UITextFieldViewModeWhileEditing;
                keyboardType = UIKeyboardTypeASCIICapable;
                contentType = baseFillCellType_LetterCharacterSet;
                existedLength = 50;
            } else if(tmp == 2){
                title =NSLocalizedString(@"modififyInfoCellTitle3", @"");
                placeholder =NSLocalizedString(@"modififyInfoCell3", @"");
                clearButtonMode = UITextFieldViewModeWhileEditing;
                keyboardType = UIKeyboardTypeASCIICapable;
                contentType = baseFillCellType_LetterCharacterSet;
                existedLength = 50;
            } else if(tmp == 3){
                title =NSLocalizedString(@"modififyInfoCellTitle4", @"");
                placeholder =NSLocalizedString(@"modififyInfoCell4", @"");
                clearButtonMode = UITextFieldViewModeWhileEditing;
                keyboardType = UIKeyboardTypeASCIICapable;
            } else if(tmp == 4){
                title =NSLocalizedString(@"modififyInfoCellTitle5", @"");
                placeholder =NSLocalizedString(@"modififyInfoCell5", @"");
                clearButtonMode = UITextFieldViewModeWhileEditing;
                keyboardType = UIKeyboardTypeASCIICapable;
            } else if(tmp == 5){
                title =NSLocalizedString(@"modififyInfoCellTitle6", @"");
                placeholder =NSLocalizedString(@"modififyInfoCell6", @"");
                clearButtonMode = UITextFieldViewModeWhileEditing;
                keyboardType = UIKeyboardTypeASCIICapable;
            }
            data.title = title;
            data.describe = placeholder;
            data.clearButtonMode = clearButtonMode;
            data.keyboardType = keyboardType;
            data.contentType = contentType;
            data.existedLength  =existedLength;
            [_dataArry addObject:data];
        }
    }
    return _dataArry;
}

- (void)Isitpossibletojudgewhetheritispossibl{
    if (self.sex.length && self.name.length && self.xing.length && self.birthdaty.length && self.countryone.countryName.length && self.AreaJsonone.areaCode.length && self.phone.length) {
        self.next.enabled = YES;
    }else{
        self.next.enabled = NO;
    }
}
@end
