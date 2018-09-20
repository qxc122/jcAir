//
//  modififyinfoSexCell.m
//  portal
//
//  Created by Store on 2017/12/19.
//  Copyright © 2017年 qxc122@126.com. All rights reserved.
//

#import "modififyinfoSexCell.h"



@implementation modififyinfoSexCell
+ (instancetype)returnCellWith:(UITableView *)tableView
{
    modififyinfoSexCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([self class])];
    if (cell == nil) {
        cell = [[self alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:NSStringFromClass([self class])];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}
- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        UILabel *titleN = [UILabel new];
        self.titleN = titleN;
        [self.contentView addSubview:titleN];
        
        [self.titleN mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.back).offset(20);
            make.bottom.equalTo(self.back);
            make.top.equalTo(self.back);
        }];
        [self.man mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.back).offset(116-20);
            make.top.equalTo(self.back);
            make.bottom.equalTo(self.back);
        }];
        [titleN setWithColor:0xACABAB Alpha:1.0 Font:14 ROrM:@"r"];
    }
    return self;
}

@end
