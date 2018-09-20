//
//  selecetCountyVc.m
//  portal
//
//  Created by Store on 2017/12/18.
//  Copyright © 2017年 qxc122@126.com. All rights reserved.
//

#import "selecetCountyVc.h"

#import "selecetHead.h"
@interface selecetCountyVc ()

@property (nonatomic,strong) NSArray *AreaJsonOneAllKey;
@end

@implementation selecetCountyVc

- (void)viewDidLoad {
    [super viewDidLoad];
    self.AreaJsonOneAllKey = @[@"Hot",@"A",@"B",@"C",@"D",@"E",@"F",@"G",@"H",@"I",@"J",@"K",@"L",@"M",@"N",@"O",@"P",@"Q",@"R",@"S",@"T",@"U",@"V",@"W",@"Y",@"Z"];
    self.title =NSLocalizedString(@"selecetCountyVctitle", nil);
    self.view.backgroundColor = ColorWithHex(0xFFFFFF, 1.0);
    self.registerClasss = @[[sekecetAreaCell class]];
    [self.header beginRefreshing];
    [self.tableView setSeparatorStyle:UITableViewCellSeparatorStyleSingleLine];
}


#pragma --mark< UITableViewDelegate 高>
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 45;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    NSArray *tmp = self.AreaJsonOneAll[section];
    if ([tmp isKindOfClass:[NSArray class]]) {
        return tmp.count;
    } else {
        return 0;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 30;
}

- (nullable UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    selecetHead *tmp  = [selecetHead new];
    tmp.titlee.text = self.AreaJsonOneAllKey[section];
    return tmp;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return self.AreaJsonOneAll.count;
}
#pragma --mark< 创建cell >
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    sekecetAreaCell *cell = [sekecetAreaCell returnCellWith:tableView];
    [self configuresekecetAreaCell:cell atIndexPath:indexPath];
    return  cell;
}
#pragma --mark< 点击了 cell >
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:NO];// 取消选中
    if (self.selecetData) {
        NSArray *tmp = self.AreaJsonOneAll[indexPath.section];
        self.selecetData(tmp[indexPath.row]);
    }
    [self popSelf];
}
#pragma --mark< 配置HomeVcCell 的数据>
- (void)configuresekecetAreaCell:(sekecetAreaCell *)cell atIndexPath:(NSIndexPath *)indexPath {
    NSArray *tmp = self.AreaJsonOneAll[indexPath.section];
    if ([tmp isKindOfClass:[NSArray class]]) {
        countryOne *one = tmp[indexPath.row];
        cell.textLabel.text = one.countryName;
    }
    cell.separatorInset = UIEdgeInsetsMake(0, 22, 0, 20);
    cell.accessoryType = UITableViewCellAccessoryNone;
}

//右边索引 字节数(如果不实现 就不显示右侧索引)
- (NSArray *)sectionIndexTitlesForTableView:(UITableView *)tableView {
    return self.AreaJsonOneAllKey;
}
//section （标签）标题显示
- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    return self.AreaJsonOneAllKey[section];
}

//点击右侧索引表项时调用
- (NSInteger)tableView:(UITableView *)tableView sectionForSectionIndexTitle:(NSString *)title atIndex:(NSInteger)index {
    [tableView scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:index] atScrollPosition:UITableViewScrollPositionTop animated:YES];
    return index;
}



- (void)loadNewData{
    kWeakSelf(self);
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        NSDictionary *tmp;
        if ([[[PortalHelper sharedInstance]get_AppSetPlist].internation isEqualToString:@"0"]) {
            tmp = [[PortalHelper sharedInstance]getCountyZh];
        } else {
            tmp = [[PortalHelper sharedInstance]getCountyEn];
        }
        if (tmp) {
            weakself.AreaJsonOneAll = [NSMutableArray new];
//            NSArray *indexArry = @[@"hot",@"A",@"B",@"C",@"D",@"E",@"F",@"G",@"H",@"I",@"J",@"K",@"L",@"M",@"N",@"O",@"P",@"Q",@"R",@"S",@"T",@"U",@"V",@"W",@"X",@"Y",@"Z"];
            for (NSString *key in weakself.AreaJsonOneAllKey) {
                NSArray *arry = tmp[key];
                NSMutableArray *tmpSmall = [NSMutableArray new];
                if (arry && [arry isKindOfClass:[NSArray class]] && arry.count) {
                    for (NSDictionary *dic in arry) {
                        countryOne *one = [countryOne mj_objectWithKeyValues:dic];
                        [tmpSmall addObject:one];
                    }
                    [weakself.AreaJsonOneAll addObject:tmpSmall];
                }
            }
        }
        dispatch_async(dispatch_get_main_queue(), ^{
            //回调或者说是通知主线程刷新，
            if (weakself.AreaJsonOneAll) {
                [weakself loadNewDataEndHeadsuccessSet:nil code:succes_empty_num footerIsShow:NO hasMore:nil];
            }else{
                [MBProgressHUD showPrompt:NSLocalizedString(@"NONEcountyArry", nil)];
                [weakself popSelf];
            }
        });
    });
}

@end
