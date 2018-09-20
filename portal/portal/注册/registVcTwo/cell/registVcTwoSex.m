//
//  registVcTwoSex.m
//  portal
//
//  Created by Store on 2017/12/14.
//  Copyright © 2017年 qxc122@126.com. All rights reserved.
//

#import "registVcTwoSex.h"

@interface registVcTwoSex ()

@end

@implementation registVcTwoSex
+ (instancetype)returnCellWith:(UITableView *)tableView
{
    registVcTwoSex *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([self class])];
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
        UIButton *man = [UIButton new];
        self.man = man;
        [self.contentView addSubview:man];
        
        UIButton *Woman = [UIButton new];
        self.Woman = Woman;
        [self.contentView addSubview:Woman];

        [self.man mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.input);
            make.top.equalTo(self.back);
            make.bottom.equalTo(self.back);
        }];
        [self.Woman mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.man.mas_right).offset(30);
            make.top.equalTo(self.back);
            make.bottom.equalTo(self.back);
        }];

        [self.man setWithNormalColor:0xACABAB NormalAlpha:1.0 NormalTitle:NSLocalizedString(@"registVcTwoSexMan", @"") NormalImage:@"男未选" NormalBackImage:nil SelectedColor:0xED1C24 SelectedAlpha:1.0 SelectedTitle:nil SelectedImage:@"男选中" SelectedBackImage:nil Font:15 NormalROrM:@"r" backColor:0x0 backAlpha:0];
        
        [self.Woman setWithNormalColor:0xACABAB NormalAlpha:1.0 NormalTitle:NSLocalizedString(@"registVcTwoSexWoMan", @"") NormalImage:@"女未选" NormalBackImage:nil SelectedColor:0xED1C24 SelectedAlpha:1.0 SelectedTitle:nil SelectedImage:@"女" SelectedBackImage:nil Font:15 NormalROrM:@"r" backColor:0x0 backAlpha:0];
        [self.man addTarget:self action:@selector(BtnClick:) forControlEvents:UIControlEventTouchUpInside];
        [self.Woman addTarget:self action:@selector(BtnClick:) forControlEvents:UIControlEventTouchUpInside];
        self.input.hidden = YES;
        self.man.restorationIdentifier = @"M";
        self.Woman.restorationIdentifier = @"F";
    }
    return self;
}
- (void)BtnClick:(UIButton *)btn{
    if (![btn.restorationIdentifier isEqualToString:self.restorationIdentifier]) {
        if ([btn.restorationIdentifier isEqualToString:@"M"]) {
            self.Woman.selected = NO;
        } else {
            self.man.selected = NO;
        }
        btn.selected = YES;
        self.restorationIdentifier = btn.restorationIdentifier;
        if (self.btnClickSex) {
            self.btnClickSex(btn.restorationIdentifier);
        }
    }
}
@end
