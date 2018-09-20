//
//  MyaccountVcHead.m
//  portal
//
//  Created by Store on 2017/12/14.
//  Copyright © 2017年 qxc122@126.com. All rights reserved.
//

#import "MyaccountVcHead.h"

@interface MyaccountVcHead ()
@property (nonatomic,weak) UIImageView *icon;
@property (nonatomic,weak) UILabel *name;
@end

@implementation MyaccountVcHead

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        UIImageView *icon = [UIImageView new];
        [self addSubview:icon];
        self.icon = icon;
        
        UILabel *name = [UILabel new];
        [self addSubview:name];
        self.name = name;
        
        [self.icon mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(self).offset(14.5);
            make.width.equalTo(@36);
            make.height.equalTo(@36);
            make.left.equalTo(self).offset(20);
        }];
        [self.name mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(self.icon);
            make.left.equalTo(self.icon.mas_right).offset(20);
            make.right.equalTo(self).offset(-20);
        }];
        [self.icon SetContentModeScaleAspectFill];
        self.icon.image = [UIImage imageNamed:@"系统头像"];
        [self.name setWithColor:0x0 Alpha:1.0 Font:14 ROrM:@"r"];
    }
    return self;
}
-(void)setUserInfo:(UserInfo *)userInfo{
    _userInfo = userInfo;
    if ([[[PortalHelper sharedInstance]get_AppSetPlist].internation isEqualToString:@"0"]) {
        self.name.text = [NSString stringWithFormat:@"%@%@ %@",NSLocalizedString(@"hi",nil),self.userInfo.surname,self.userInfo.enName];
    } else if ([[[PortalHelper sharedInstance]get_AppSetPlist].internation isEqualToString:@"1"]) {
        self.name.text = [NSString stringWithFormat:@"%@%@ %@",NSLocalizedString(@"hi",nil),self.userInfo.enName,self.userInfo.surname];
    }
}
@end
