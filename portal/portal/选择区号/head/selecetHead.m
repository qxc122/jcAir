//
//  selecetHead.m
//  portal
//
//  Created by Store on 2017/12/18.
//  Copyright © 2017年 qxc122@126.com. All rights reserved.
//

#import "selecetHead.h"
#import "HeaderAll.h"
@interface selecetHead ()

@end


@implementation selecetHead

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = ColorWithHex(0xF3F3F3, 1.0);
        UILabel *titlee = [UILabel new];
        [self addSubview:titlee];
        [titlee mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self).offset(22);
            make.right.equalTo(self).offset(-40);
            make.top.equalTo(self).offset(0);
            make.bottom.equalTo(self).offset(0);
        }];
        
        [titlee setWithColor:0x6D6868 Alpha:1.0 Font:12 ROrM:@"r"];
        self.titlee  =titlee;
    }
    return self;
}

@end
