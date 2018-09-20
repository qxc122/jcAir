//
//  loginVcFoot.m
//  portal
//
//  Created by Store on 2017/12/14.
//  Copyright © 2017年 qxc122@126.com. All rights reserved.
//

#import "loginVcFoot.h"
#import "HeaderAll.h"

@interface loginVcFoot ()

@property (nonatomic,weak) UIButton *rerest;
@property (nonatomic,weak) UIButton *guest;
@property (nonatomic,weak) UIView *lineSu;
@end


@implementation loginVcFoot

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        UIButton *login = [UIButton new];
        [self addSubview:login];
        self.login = login;
        
        UIButton *rerest = [UIButton new];
        [self addSubview:rerest];
        self.rerest = rerest;
        
        UIButton *guest = [UIButton new];
        [self addSubview:guest];
        self.guest = guest;
        
        UIView *lineSu = [UIView new];
        [self addSubview:lineSu];
        self.lineSu = lineSu;
        
        [self.login mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self).offset(20);
            make.right.equalTo(self).offset(-20);
            make.height.equalTo(@50);
            make.top.equalTo(self).offset(20);
        }];
        [self.rerest mas_makeConstraints:^(MASConstraintMaker *make) {
            make.width.equalTo(@[self.guest]);
            make.centerY.equalTo(self.lineSu);
            make.left.equalTo(self.login);
        }];
        [self.guest mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(self.lineSu);
            make.left.equalTo(self.rerest.mas_right);
            make.right.equalTo(self.login);
        }];
        [self.lineSu mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(self);
            make.width.equalTo(@0.5);
            make.height.equalTo(@24);
            make.top.equalTo(self.login.mas_bottom).offset(40);
        }];
        self.lineSu.backgroundColor = ColorWithHex(0xACABAB, 1.0);
        [self.login SetFilletWith:4.0];
        [self.login setWithNormalColor:0xFFFFFF NormalAlpha:1.0 NormalTitle:NSLocalizedString(@"loginVcFootLogin", @"") NormalImage:nil NormalBackImage:nil SelectedColor:0x0  SelectedAlpha:0 SelectedTitle:nil SelectedImage:nil SelectedBackImage:nil Font:17 NormalROrM:@"M" backColor:0xED1C24 backAlpha:1.0];
        
        [self.rerest setWithNormalColor:0xACABAB NormalAlpha:1.0 NormalTitle:NSLocalizedString(@"loginVcFootgegist", @"") NormalImage:nil NormalBackImage:nil SelectedColor:0x0  SelectedAlpha:0 SelectedTitle:nil SelectedImage:nil SelectedBackImage:nil Font:14 NormalROrM:@"r" backColor:0xED1C24 backAlpha:0];
        
        [self.guest setWithNormalColor:0xACABAB  NormalAlpha:1.0 NormalTitle:NSLocalizedString(@"loginVcFootGuest", @"") NormalImage:nil NormalBackImage:nil SelectedColor:0x0  SelectedAlpha:0 SelectedTitle:nil SelectedImage:nil SelectedBackImage:nil Font:14 NormalROrM:@"r" backColor:0xED1C24 backAlpha:0];
        
        [self.login addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
        [self.rerest addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
        [self.guest addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
        self.login.restorationIdentifier = @"login";
        self.rerest.restorationIdentifier = @"rerest";
        self.guest.restorationIdentifier = @"guest";
    }
    return self;
}
- (void)btnClick:(UIButton *)btn{
    if (self.btnClick) {
        self.btnClick(btn.restorationIdentifier);
    }
}
@end
