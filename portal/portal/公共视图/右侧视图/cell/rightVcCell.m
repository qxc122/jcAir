//
//  rightVcCell.m
//  portal
//
//  Created by Store on 2017/12/13.
//  Copyright © 2017年 qxc122@126.com. All rights reserved.
//

#import "rightVcCell.h"

@interface rightVcCell ()
@property (nonatomic,weak) UIImageView *iicon;
@property (nonatomic,weak) UILabel *ttile;
@end

@implementation rightVcCell

+ (instancetype)returnCellWith:(UITableView *)tableView
{
    rightVcCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([self class])];
    if (cell == nil) {
        cell = [[rightVcCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:NSStringFromClass([self class])];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    return cell;
}

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        UIImageView *iicon = [UIImageView new];
        [self.contentView addSubview:iicon];
        self.iicon = iicon;
        
        UILabel *ttile = [UILabel new];
        [self.contentView addSubview:ttile];
        self.ttile = ttile;
        
        [self.iicon mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(self.contentView).offset(-38);
            make.centerY.equalTo(self.contentView);
            make.width.equalTo(@18);
            make.height.equalTo(@18);
        }];
        [self.ttile mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(self.iicon.mas_left).offset(-34);
            make.centerY.equalTo(self.iicon);
        }];
        [self.ttile setWithColor:0xFFFFFF Alpha:1.0 Font:15 ROrM:@"r"];
    }
    return self;
}
- (void)setData:(id)data{
    [super setData:data];
    if ([data isKindOfClass:[setUpData class]]) {
        setUpData *tmp = data;
        self.ttile.text = tmp.title;
        self.iicon.image  =[UIImage imageNamed:tmp.icon];
    }
}
@end
