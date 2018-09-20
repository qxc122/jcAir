//
//  modififyInfoBaseFillCell.m
//  portal
//
//  Created by Store on 2017/12/19.
//  Copyright © 2017年 qxc122@126.com. All rights reserved.
//

#import "modififyInfoBaseFillCell.h"


@interface modififyInfoBaseFillCell ()


@end

@implementation modififyInfoBaseFillCell
+ (instancetype)returnCellWith:(UITableView *)tableView
{
    modififyInfoBaseFillCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([self class])];
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
        self.backgroundColor = [UIColor clearColor];
        UILabel *titleN = [UILabel new];
        self.titleN = titleN;
        [self.contentView addSubview:titleN];
    
        [self.titleN mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.back).offset(20);
            make.bottom.equalTo(self.back);
            make.top.equalTo(self.back);
        }];
        if ([[[PortalHelper sharedInstance]get_AppSetPlist].internation isEqualToString:@"0"]) {
            [self.input mas_remakeConstraints:^(MASConstraintMaker *make) {
                make.left.equalTo(self.back).offset(116-20);
                make.right.equalTo(self.back).offset(-20);
                make.bottom.equalTo(self.back);
                make.top.equalTo(self.back);
            }];
        } else if ([[[PortalHelper sharedInstance]get_AppSetPlist].internation isEqualToString:@"1"]) {
            [self.input mas_remakeConstraints:^(MASConstraintMaker *make) {
                make.left.equalTo(self.titleN.mas_right).offset(15);
                make.right.equalTo(self.back).offset(-20);
                make.bottom.equalTo(self.back);
                make.top.equalTo(self.back);
            }];
        }
        [titleN setWithColor:0xACABAB Alpha:1.0 Font:14 ROrM:@"r"];
    }
    return self;
}

- (void)setInputInfo:(setUpData *)inputInfo{
    [super setInputInfo:inputInfo];
    self.input.text = nil;
    self.titleN.text = inputInfo.title;
}
@end
