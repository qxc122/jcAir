//
//  selecetAreaVc.m
//  portal
//
//  Created by Store on 2017/12/18.
//  Copyright © 2017年 qxc122@126.com. All rights reserved.
//

#import "selecetAreaVc.h"

@interface selecetAreaVc ()

@end

@implementation selecetAreaVc

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title =NSLocalizedString(@"selecetAreaVctitle", nil);
}

#pragma --mark< 配置HomeVcCell 的数据>
- (void)configuresekecetAreaCell:(sekecetAreaCell *)cell atIndexPath:(NSIndexPath *)indexPath {
    NSArray *tmp = self.AreaJsonOneAll[indexPath.section];
    if ([tmp isKindOfClass:[NSArray class]]) {
        countryOne *one = tmp[indexPath.row];
        cell.textLabel.text = [NSString stringWithFormat:@"%@(+%@)",one.countryName,one.areaCode];
    }
    cell.separatorInset = UIEdgeInsetsMake(0, 22, 0, 20);
    cell.accessoryType = UITableViewCellAccessoryNone;
}

@end
