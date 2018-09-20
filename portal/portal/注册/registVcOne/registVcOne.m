//
//  registVcOne.m
//  portal
//
//  Created by Store on 2017/12/14.
//  Copyright © 2017年 qxc122@126.com. All rights reserved.
//

#import "registVcOne.h"

#import "baseFillCell.h"
@interface registVcOne ()
@property (nonatomic,strong) NSMutableArray *dataArry;
@end

@implementation registVcOne

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = ColorWithHex(0xF3F3F3, 1.0);
    self.registerClasss = @[[baseFillCell class]];
    self.empty_type = succes_empty_num;
    self.header.hidden = YES;
    // Do any additional setup after loading the view.
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
        if ([identifer isEqualToString:NSLocalizedString(@"registVcOnecell1", @"")]) {
            weakself.email = inText;
            setUpData *data = weakself.dataArry[0];
            data.title = inText;
        } else if ([identifer isEqualToString:NSLocalizedString(@"registVcOnecell2", @"")]) {
            setUpData *data = weakself.dataArry[1];
            weakself.passWordpre = inText;
            data.title = inText;
        } else if ([identifer isEqualToString:NSLocalizedString(@"registVcOnecell3", @"")]) {
            setUpData *data = weakself.dataArry[2];
            if ([inText isEqualToString:weakself.passWordpre]) {
                data.title = inText;
                weakself.passWord = inText;
            }else{
                weakself.passWord = nil;
                if (inText.length) {
                    [MBProgressHUD showPrompt:NSLocalizedString(@"registVcOnePassNO", @"") toView:weakself.view];
                }
                data.title = nil;
            }
            [weakself.tableView reloadData];
        }
        if (weakself.Fill_in_the_text) {
            weakself.Fill_in_the_text(weakself.email, weakself.passWord);
        }
    };
}
- (NSMutableArray *)dataArry{
    if (!_dataArry) {
        _dataArry = [NSMutableArray new];
        for (NSInteger tmp = 0; tmp<3; tmp++) {
            setUpData *data = [setUpData new];
            NSString *placeholder = nil;
            UITextFieldViewMode clearButtonMode = UITextFieldViewModeWhileEditing;
            UIKeyboardType keyboardType = UIKeyboardTypeASCIICapable;
            NSInteger contentType = 0;
            NSInteger existedLength = 0;
            if (tmp == 0) {
                placeholder =NSLocalizedString(@"registVcOnecell1", @"");
                clearButtonMode = UITextFieldViewModeWhileEditing;
                keyboardType = UIKeyboardTypeEmailAddress;
                existedLength = 50;
            } else if(tmp == 1){
                placeholder =NSLocalizedString(@"registVcOnecell2", @"");
                clearButtonMode = UITextFieldViewModeWhileEditing;
                keyboardType = UIKeyboardTypeASCIICapable;
                contentType = baseFillCellType_NumbersAndletters;
                existedLength = 20;
            } else {
                placeholder =NSLocalizedString(@"registVcOnecell3", @"");
                clearButtonMode = UITextFieldViewModeWhileEditing;
                keyboardType = UIKeyboardTypeASCIICapable;
                contentType = baseFillCellType_NumbersAndletters;
                existedLength = 20;
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
