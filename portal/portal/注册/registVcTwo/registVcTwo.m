//
//  registVcTwo.m
//  portal
//
//  Created by Store on 2017/12/14.
//  Copyright © 2017年 qxc122@126.com. All rights reserved.
//

#import "registVcTwo.h"
#import "baseFillCell.h"
#import "selecetCountyVc.h"
#import "registVcTwoSex.h"
#import "datePiker.h"
@interface registVcTwo ()
@property (nonatomic,strong) NSMutableArray *dataArry;
@end

@implementation registVcTwo

- (void)viewDidLoad {
    [super viewDidLoad];
    self.header.hidden = YES;
    self.view.backgroundColor = ColorWithHex(0xF3F3F3, 1.0);
    self.registerClasss = @[[baseFillCell class],[registVcTwoSex class]];
    self.empty_type = succes_empty_num;
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
    [tableView deselectRowAtIndexPath:indexPath animated:NO];// 取消选中
    setUpData *one = self.dataArry[indexPath.row];
    if ([one.describe isEqualToString:NSLocalizedString(@"registVcTwocell4", @"")]) {
        //选出生日期
        [self OpendatePikerIsbirthday:indexPath :one];
    } else  if ([one.describe isEqualToString:NSLocalizedString(@"registVcTwocell5", @"")]) {
        //选国籍
        selecetCountyVc *vc = [selecetCountyVc new];
        kWeakSelf(self);
        vc.selecetData = ^(countryOne *data) {
            weakself.countryone = data;
            one.title = data.countryName;
            [weakself.tableView reloadData];
            if (weakself.Fill_in_the_text) {
                weakself.Fill_in_the_text(weakself.sex, weakself.name, weakself.xing, weakself.birthdaty, weakself.countryone);
            }
        };
        [self OPenVc:vc];
    }
}
#pragma -mark<打开日期选择>
- (void)OpendatePikerIsbirthday:(NSIndexPath *)indexPath :(setUpData *)one{
    [self.tableView endEditing:YES];
    datePiker *piker = [datePiker new];
    piker.minDateStr = @"19000101";
    piker.maxDate = [NSDate date];
    kWeakSelf(self);
    piker.SelecetDateStr = ^(NSString *Date) {
        weakself.birthdaty = Date;
        one.title = Date;
        [weakself.tableView reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationNone];
        if (weakself.Fill_in_the_text) {
            weakself.Fill_in_the_text(weakself.sex, weakself.name, weakself.xing, weakself.birthdaty, weakself.countryone);
        }
    };
    [piker windosViewshow];
}


#pragma --mark< 创建cell >
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row == 0) {
        registVcTwoSex *cell = [registVcTwoSex returnCellWith:tableView];
        [self configureregistVcTwoSex:cell atIndexPath:indexPath];
        return  cell;
    } else {
        baseFillCell *cell = [baseFillCell returnCellWith:tableView];
        [self configurebaseFillCell:cell atIndexPath:indexPath];
        return  cell;
    }
}
#pragma --mark< 配置registVcTwoSex 的数据>
- (void)configureregistVcTwoSex:(registVcTwoSex *)cell atIndexPath:(NSIndexPath *)indexPath {
    setUpData *one = self.dataArry[indexPath.row];
    cell.inputInfo = one;
    kWeakSelf(self);
    cell.btnClickSex = ^(NSString *identifer) {
        weakself.sex = identifer;
        if (weakself.Fill_in_the_text) {
            weakself.Fill_in_the_text(weakself.sex, weakself.name, weakself.xing, weakself.birthdaty, weakself.countryone);
        }
    };
}
#pragma --mark< 配置baseFillCell 的数据>
- (void)configurebaseFillCell:(baseFillCell *)cell atIndexPath:(NSIndexPath *)indexPath {
    setUpData *one = self.dataArry[indexPath.row];
    cell.inputInfo = one;
    kWeakSelf(self);
    cell.Fill_in_the_text = ^(NSString *identifer, NSString *inText, UITextField *intput) {
        if ([identifer isEqualToString:NSLocalizedString(@"registVcTwocell2", @"")]) {
            weakself.name = inText;
            setUpData *data = weakself.dataArry[1];
            data.title = inText;
        } else if ([identifer isEqualToString:NSLocalizedString(@"registVcTwocell3", @"")]) {
            weakself.xing = inText;
            setUpData *data = weakself.dataArry[2];
            data.title = inText;
        }
        if (weakself.Fill_in_the_text) {
            weakself.Fill_in_the_text(weakself.sex, weakself.name, weakself.xing, weakself.birthdaty, weakself.countryone);
        }
    };
}
- (NSMutableArray *)dataArry{
    if (!_dataArry) {
        _dataArry = [NSMutableArray new];
        for (NSInteger tmp = 0; tmp<5; tmp++) {
            setUpData *data = [setUpData new];
            NSString *placeholder = nil;
            UITextFieldViewMode clearButtonMode = UITextFieldViewModeWhileEditing;
            UIKeyboardType keyboardType = UIKeyboardTypeASCIICapable;
            NSInteger contentType = 0;
            NSInteger existedLength = 0;
            if (tmp == 0) {
                placeholder =NSLocalizedString(@"registVcTwocell1SEX", @"");
            } else if(tmp == 1){
                placeholder =NSLocalizedString(@"registVcTwocell2", @"");
                clearButtonMode = UITextFieldViewModeWhileEditing;
                keyboardType = UIKeyboardTypeASCIICapable;
                contentType = baseFillCellType_LetterCharacterSet;
                existedLength = 50;
            } else if(tmp == 2){
                placeholder =NSLocalizedString(@"registVcTwocell3", @"");
                clearButtonMode = UITextFieldViewModeWhileEditing;
                keyboardType = UIKeyboardTypeASCIICapable;
                contentType = baseFillCellType_LetterCharacterSet;
                existedLength = 50;
            } else if(tmp == 3){
                placeholder =NSLocalizedString(@"registVcTwocell4", @"");
                clearButtonMode = UITextFieldViewModeWhileEditing;
                keyboardType = UIKeyboardTypeASCIICapable;
            } else {
                placeholder =NSLocalizedString(@"registVcTwocell5", @"");
                clearButtonMode = UITextFieldViewModeWhileEditing;
                keyboardType = UIKeyboardTypeASCIICapable;
            }
            data.describe = placeholder;
            data.clearButtonMode = clearButtonMode;
            data.keyboardType = keyboardType;
            data.contentType = contentType;
            data.existedLength = existedLength;
            [_dataArry addObject:data];
        }
    }
    return _dataArry;
}
@end
