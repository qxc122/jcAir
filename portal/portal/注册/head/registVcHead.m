//
//  registVcHead.m
//  portal
//
//  Created by Store on 2017/12/14.
//  Copyright © 2017年 qxc122@126.com. All rights reserved.
//

#import "registVcHead.h"
#import "HeaderAll.h"

@interface registVcHead ()
@property (nonatomic,weak) UIImageView *one;
@property (nonatomic,weak) UIImageView *two;
@property (nonatomic,weak) UIImageView *three;

@property (nonatomic,weak) UILabel *one1;
@property (nonatomic,weak) UILabel *two2;
@property (nonatomic,weak) UILabel *three3;


@property (nonatomic,weak) UIProgressView *line;
@end


@implementation registVcHead

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        UIProgressView *line = [UIProgressView new];
        [self addSubview:line];
        self.line = line;
        
        UIImageView *one = [UIImageView new];
        [self addSubview:one];
        self.one = one;

        UIImageView *two = [UIImageView new];
        [self addSubview:two];
        self.two = two;
        
        UIImageView *three = [UIImageView new];
        [self addSubview:three];
        self.three = three;
        
        UILabel *one1 = [UILabel new];
        [self addSubview:one1];
        self.one1 = one1;
        
        UILabel *two2 = [UILabel new];
        [self addSubview:two2];
        self.two2 = two2;
        
        UILabel *three3 = [UILabel new];
        [self addSubview:three3];
        self.three3 = three3;
        
        [self.one mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(self).offset(-4);
            make.centerX.equalTo(self).offset(-SCREENWIDTH*0.25);
        }];
        [self.one1 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(self.one);
            make.top.equalTo(self.one.mas_bottom).offset(10);
        }];
        [self.two mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(self);
            make.centerY.equalTo(self.one);
            make.width.equalTo(@[@30,self.one,self.three]);
            make.height.equalTo(@[@30,self.one,self.three]);
        }];
        [self.two2 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(self.two);
            make.top.equalTo(self.two.mas_bottom).offset(10);
        }];
        [self.three mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(self.one);
            make.centerX.equalTo(self).offset(SCREENWIDTH*0.25);
        }];
        [self.three3 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(self.three);
            make.top.equalTo(self.three.mas_bottom).offset(10);
        }];
        [self.line mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self);
            make.right.equalTo(self);
            make.centerY.equalTo(self.two);
            make.height.equalTo(@2);
        }];
        self.one.image = [UIImage imageNamed:@"红1"];
        self.one.highlightedImage = [UIImage imageNamed:@"红1"];
        self.two.image = [UIImage imageNamed:@"灰色2"];
        self.two.highlightedImage = [UIImage imageNamed:@"红2"];
        self.three.image = [UIImage imageNamed:@"灰3"];
        self.three.highlightedImage = [UIImage imageNamed:@"红3"];
//        self.line.tintColor = ColorWithHex(0xDFDFDF, 1.0);
        self.line.trackTintColor = ColorWithHex(0xDFDFDF, 1.0);
        self.line.progressTintColor = ColorWithHex(0xED1C24, 1.0);
        self.line.progress = 0.25;
        [self.one1 setWithColor:0xED1C24 Alpha:1.0 Font:14 ROrM:@"r"];
        [self.two2 setWithColor:0xED1C24 Alpha:1.0 Font:14 ROrM:@"r"];
        [self.three3 setWithColor:0xED1C24 Alpha:1.0 Font:14 ROrM:@"r"];
        self.one1.text = NSLocalizedString(@"registVcHead1", nil);
        self.two2.text = NSLocalizedString(@"registVcHead2", nil);
        self.three3.text = NSLocalizedString(@"registVcHead3", nil);
    }
    return self;
}
- (void)setProgress:(CGFloat)progress{
    _progress = progress;
    [self.line setProgress:progress animated:YES];
//    self.line.progress = progress;
    if (progress >= 0.75) {
        self.one.highlighted = YES;
        self.two.highlighted = YES;
        self.three.highlighted = YES;
        
        self.one1.hidden = YES;
        self.two2.hidden = YES;
        self.three3.hidden = NO;
    } else if (progress >= 0.5) {
        self.one.highlighted = YES;
        self.two.highlighted = YES;
        self.three.highlighted = NO;
        
        self.one1.hidden = YES;
        self.two2.hidden = NO;
        self.three3.hidden = YES;
    }else if (progress >= 0.25) {
        self.one.highlighted = YES;
        self.two.highlighted = NO;
        self.three.highlighted = NO;
        
        self.one1.hidden = NO;
        self.two2.hidden = YES;
        self.three3.hidden = YES;
    }
}
@end
