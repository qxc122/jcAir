//
//  phoneCell.m
//  portal
//
//  Created by Store on 2017/12/19.
//  Copyright © 2017年 qxc122@126.com. All rights reserved.
//

#import "phoneCell.h"

@interface phoneCell ()<UITextFieldDelegate>
@property (nonatomic,weak) UIView *suLine;
@property (nonatomic,weak) UIButton *seleArea;
@end


@implementation phoneCell
+ (instancetype)returnCellWith:(UITableView *)tableView
{
    phoneCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([self class])];
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
        
        UIView *suLine = [UIView new];
        self.suLine = suLine;
        [self.contentView addSubview:suLine];
        
        UILabel *zone = [UILabel new];
        self.zone = zone;
        [self.contentView addSubview:zone];
        
        UIButton *seleArea = [UIButton new];
        self.seleArea = seleArea;
        [self.contentView addSubview:seleArea];
        
        [self.titleN mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.back).offset(20);
            make.bottom.equalTo(self.back);
            make.top.equalTo(self.back);
        }];
        
        if ([[[PortalHelper sharedInstance]get_AppSetPlist].internation isEqualToString:@"0"]) {
            [self.suLine mas_makeConstraints:^(MASConstraintMaker *make) {
                make.centerY.equalTo(self.back);
                make.height.equalTo(@30);
                make.width.equalTo(@0.5);
                make.centerX.equalTo(self.back).offset(-11.5);
            }];
            [self.seleArea mas_makeConstraints:^(MASConstraintMaker *make) {
                make.centerY.equalTo(self.back);
                make.right.equalTo(self.suLine).offset(0.65);
                make.height.equalTo(@44);
                make.width.equalTo(@44);
            }];
            [self.zone mas_makeConstraints:^(MASConstraintMaker *make) {
                make.centerY.equalTo(self.back);
                make.right.equalTo(self.suLine.mas_left).offset(-33);
            }];
            
            [self.input mas_remakeConstraints:^(MASConstraintMaker *make) {
                make.left.equalTo(self.suLine).offset(20);
                make.right.equalTo(self.back).offset(-20);
                make.bottom.equalTo(self.back);
                make.top.equalTo(self.back);
            }];
        } else if ([[[PortalHelper sharedInstance]get_AppSetPlist].internation isEqualToString:@"1"]) {
            [self.suLine mas_makeConstraints:^(MASConstraintMaker *make) {
                make.centerY.equalTo(self.back);
                make.height.equalTo(@30);
                make.width.equalTo(@0.5);
                make.left.equalTo(self.seleArea.mas_right).offset(0.65);
            }];
            [self.seleArea mas_makeConstraints:^(MASConstraintMaker *make) {
                make.centerY.equalTo(self.back);
                make.left.equalTo(self.zone.mas_right).offset(-10.35);
                make.height.equalTo(@44);
                make.width.equalTo(@44);
            }];
            [self.zone mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.equalTo(self.titleN.mas_right).offset(15);
                make.centerY.equalTo(self.back);
            }];
            
            [self.input mas_remakeConstraints:^(MASConstraintMaker *make) {
                make.left.equalTo(self.suLine.mas_right).offset(10);
                make.right.equalTo(self.back).offset(-20);
                make.bottom.equalTo(self.back);
                make.top.equalTo(self.back);
            }];
        }
        self.input.keyboardType = UIKeyboardTypePhonePad;
        self.input.clearButtonMode = UITextFieldViewModeWhileEditing;
        self.suLine.backgroundColor = ColorWithHex(0xDFDFDF, 1.0);
        [titleN setWithColor:0xACABAB Alpha:1.0 Font:14 ROrM:@"r"];
        [zone setWithColor:0x000000 Alpha:1.0 Font:14 ROrM:@"r"];
        [self.seleArea setImage:[UIImage imageNamed:@"下拉"] forState:UIControlStateNormal];
        [self.seleArea addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
    }
    return self;
}

- (BOOL)textField:(UITextField*)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString*)string
{
    NSLog(@"nonBaseCharacterSet sring+%@",string);
    if ([string isEqualToString:@""]) {
        return YES;
    } else {
        bool tmp = [self ThejudgmentisaletterPhone:string];
        if (tmp) {
            NSInteger existedLength = textField.text.length;
            NSInteger selectedLength = range.length;
            NSInteger replaceLength = string.length;
            if ((existedLength - selectedLength + replaceLength) > 20) {
                tmp = NO;
            }
        }
        return tmp;
    }
}

#define NUMBERS @"0123456789"
- (BOOL)ThejudgmentisaletterPhone:(NSString *)string{
    NSCharacterSet *cs = [[NSCharacterSet characterSetWithCharactersInString:NUMBERS] invertedSet];
    NSString *filtered = [[string componentsSeparatedByCharactersInSet:cs] componentsJoinedByString:@""];
    return [string isEqualToString:filtered];
}


- (void)btnClick:(UIButton *)btn{
    if (self.selezone) {
        self.selezone();
    }
}
@end
