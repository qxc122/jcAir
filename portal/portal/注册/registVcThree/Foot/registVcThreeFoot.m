//
//  registVcThreeFoot.m
//  portal
//
//  Created by Store on 2017/12/20.
//  Copyright © 2017年 qxc122@126.com. All rights reserved.
//

#import "registVcThreeFoot.h"
#import "HeaderAll.h"

@interface registVcThreeFoot ()
@property (nonatomic,weak) UIButton *btn;
@end

@implementation registVcThreeFoot

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        UIButton *btn = [UIButton new];
        [self addSubview:btn];
        self.btn = btn;
        
        YYLabel *label = [YYLabel new];
        [self addSubview:label];
        self.label = label;
        [self.btn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self).offset(9.5);
            make.centerY.equalTo(self.label);
            make.width.equalTo(@44);
            make.height.equalTo(@44);
        }];
        [self.label mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self).offset(45);
            make.top.equalTo(self).offset(19);
            make.bottom.equalTo(self);
            make.right.equalTo(self).offset(-20);
        }];
        [self.btn setImage:[UIImage imageNamed:@"未选"] forState:UIControlStateNormal];
        [self.btn setImage:[UIImage imageNamed:@"选择"] forState:UIControlStateSelected];
        [self.btn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
        self.label.numberOfLines = 0;
    }
    return self;
}
- (void)btnClick:(UIButton *)btn{
    btn.selected = !btn.selected;
    if (self.btnClickxieuyi) {
        self.btnClickxieuyi(btn.selected);
    }
}
@end
