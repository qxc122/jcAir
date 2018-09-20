//
//  baseFillCell.m
//  portal
//
//  Created by Store on 2017/10/9.
//  Copyright © 2017年 qxc122@126.com. All rights reserved.
//

#import "baseFillCell.h"

@interface baseFillCell ()<UITextFieldDelegate>


@end

@implementation baseFillCell
+ (instancetype)returnCellWith:(UITableView *)tableView
{
    baseFillCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([self class])];
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

        UIView *back = [UIView new];
        self.back = back;
        [self.contentView addSubview:back];
        
        UIImageView *CusaccessoryView = [UIImageView new];
        self.CusaccessoryView = CusaccessoryView;
        [self.contentView addSubview:CusaccessoryView];
        
        UILabel *content = [UILabel new];
        self.content = content;
        [self.contentView addSubview:content];
        
        UITextFieldAdd *input = [UITextFieldAdd new];
        [input addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
        self.input = input;
        self.input.delegate = self;
        [self.contentView addSubview:input];

        [self.back mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.contentView).offset(20);
            make.right.equalTo(self.contentView).offset(-20);
            make.bottom.equalTo(self.contentView).offset(-0.5);
            make.top.equalTo(self.contentView).offset(0.5);
            make.height.equalTo(@59);
        }];
        [self.input mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.back).offset(20);
            make.right.equalTo(self.back).offset(-20);
            make.bottom.equalTo(self.back);
            make.top.equalTo(self.back);
        }];
        [self.CusaccessoryView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(self.back).offset(-20);
            make.centerY.equalTo(self.back);
            make.width.equalTo(@6);
            make.height.equalTo(@11);
        }];
        [self.content mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(self.CusaccessoryView.mas_left).offset(-15);
            make.bottom.equalTo(self.input);
            make.top.equalTo(self.input);
        }];
        
        [self.content setWithColor:0x000000 Alpha:1.0 Font:15 ROrM:@"r"];
        self.CusaccessoryView.image = [UIImage imageNamed:@"更多"];
        self.CusaccessoryView.hidden = YES;
        self.content.hidden = YES;
        self.back.backgroundColor = [UIColor whiteColor];
        [self.input setWithColor:0x000000 Alpha:1.0 Font:15 ROrM:@"r"];
        [self.input setValue:ColorWithHex(0xACABAB, 1.0) forKeyPath:@"_placeholderLabel.textColor"];
    }
    return self;
}

#pragma  -mark<输入框改变了>
-(void)textFieldDidChange :(UITextField *)textField{
    if (self.inputInfo.existedLength && textField.text.length > self.inputInfo.existedLength) {
        textField.text = [textField.text substringToIndex:self.inputInfo.existedLength];
    }
    if (self.inputInfo.existedLength && textField.text.length == self.inputInfo.existedLength) {
        [self inputresignFirstResponder];
    }
    if (self.Fill_in_the_text && ![textField.placeholder isEqualToString:NSLocalizedString(@"registVcOnecell3", nil)]) {
        self.Fill_in_the_text(textField.placeholder, textField.text,textField);
    }
}
- (void)textFieldDidEndEditing:(UITextField *)textField{
    if (self.inputInfo.contentType == baseFillCellType_LetterCharacterSet) {
        textField.text = [textField.text uppercaseString];
//        textField.text = [textField.text filterCharactorwithRegex:@"^[A-Z]+$"];
    }
    if (self.inputInfo.contentType == baseFillCellType_LettersAndChinese) {
        textField.text = [textField.text filterCharactorwithRegex:@"[^\u4e00-\u9fa5]"];
    }
    if (self.Fill_in_the_text) {
        self.Fill_in_the_text(textField.placeholder, textField.text,textField);
    }
}
- (void)inputresignFirstResponder{
    if ([self.input canResignFirstResponder]) {
        [self.input resignFirstResponder];
    }
}

- (BOOL)textField:(UITextField*)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString*)string
{
    NSLog(@"nonBaseCharacterSet sring+%@",string);
    if ([string isEqualToString:@""]) {
        return YES;
    } else {
        BOOL tmp = NO;
        if (self.inputInfo.contentType == UIKeyboardTypeNumberPad) {
            NSCharacterSet*cs = [NSCharacterSet decimalDigitCharacterSet];
            NSString*filtered = [[string componentsSeparatedByCharactersInSet:cs] componentsJoinedByString:@""];
            tmp =  ![string isEqualToString:filtered];
        } else if (self.inputInfo.contentType == baseFillCellType_NumbersAndletters) {
            NSCharacterSet*cs1 = [NSCharacterSet lowercaseLetterCharacterSet];
            NSString*filtered1 = [[string componentsSeparatedByCharactersInSet:cs1] componentsJoinedByString:@""];

            NSCharacterSet*cs2 = [NSCharacterSet uppercaseLetterCharacterSet];
            NSString*filtered2 = [[string componentsSeparatedByCharactersInSet:cs2] componentsJoinedByString:@""];

            NSCharacterSet*cs3 = [NSCharacterSet decimalDigitCharacterSet];
            NSString*filtered3 = [[string componentsSeparatedByCharactersInSet:cs3] componentsJoinedByString:@""];

            tmp = !filtered1.length || !filtered2.length || !filtered3.length;
        } else if (self.inputInfo.contentType == baseFillCellType_LettersAndChinese) {
            tmp = YES;
        } else if (self.inputInfo.contentType == baseFillCellType_ID) {
            BOOL tmpOne = NO;;
            BOOL tmpTwo = NO;
            NSCharacterSet*cs = [NSCharacterSet decimalDigitCharacterSet];
            NSString*filtered = [[string componentsSeparatedByCharactersInSet:cs] componentsJoinedByString:@""];
            tmpOne =  ![string isEqualToString:filtered];
            tmpTwo = [self ThejudgmentisaletterXx:string];
            tmp = tmpOne||tmpTwo;
        } else if (self.inputInfo.contentType == baseFillCellType_LetterCharacterSet) {
            NSCharacterSet*cs1 = [NSCharacterSet lowercaseLetterCharacterSet];
            NSString*filtered1 = [[string componentsSeparatedByCharactersInSet:cs1] componentsJoinedByString:@""];

            NSCharacterSet*cs2 = [NSCharacterSet uppercaseLetterCharacterSet];
            NSString*filtered2 = [[string componentsSeparatedByCharactersInSet:cs2] componentsJoinedByString:@""];
            tmp = !filtered1.length || !filtered2.length;
            if (tmp) {
                string = [string uppercaseString];
                NSLog(@"sdf");
            }
            textField.text = [textField.text uppercaseString];
        } else if (self.inputInfo.contentType == baseFillCellType_phone) {
            tmp = [self ThejudgmentisaletterPhone:string];
        }else {
            tmp = YES;
        }
        if (tmp) {
            NSInteger existedLength = textField.text.length;
            NSInteger selectedLength = range.length;
            NSInteger replaceLength = string.length;
            
            if (self.inputInfo.existedLength && (existedLength - selectedLength + replaceLength) > self.inputInfo.existedLength) {
                tmp = NO;
            }
            if (self.inputInfo.existedLength && (existedLength - selectedLength + replaceLength) == self.inputInfo.existedLength) {
                NSString *tmp = textField.text;
                if (!tmp) {
                    tmp = @"";
                }
                textField.text = [tmp stringByAppendingString:string];
                [self inputresignFirstResponder];
            }
        }
        return tmp;
    }
}
//- (void)textFieldDidBeginEditing:(UITextField *)textField{
//    if (self.becomeFill_in_the_text) {
//        self.becomeFill_in_the_text(textField);
//    }
//}
#define NUMBERS @"0123456789"
- (BOOL)ThejudgmentisaletterPhone:(NSString *)string{
    NSCharacterSet *cs = [[NSCharacterSet characterSetWithCharactersInString:NUMBERS] invertedSet];
    NSString *filtered = [[string componentsSeparatedByCharactersInSet:cs] componentsJoinedByString:@""];
    return [string isEqualToString:filtered];
}
- (BOOL)ThejudgmentisaletterXx:(NSString *)string{
    NSCharacterSet *cs = [[NSCharacterSet characterSetWithCharactersInString:@"Xx"] invertedSet];
    NSString *filtered = [[string componentsSeparatedByCharactersInSet:cs] componentsJoinedByString:@""];
    return [string isEqualToString:filtered];
}

//#define NUM @"0123456789"
//#define ALPHA @"ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz"
//#define ALPHANUM @"ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789"
//
//
//
//- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
//{
//    NSCharacterSet *cs = [[NSCharacterSet characterSetWithCharactersInString:ALPHANUM] invertedSet];
//    NSString *filtered = [[string componentsSeparatedByCharactersInSet:cs] componentsJoinedByString:@""];
//    return [string isEqualToString:filtered];
//}


//1 controlCharacterSet//控制符
//2 whitespaceCharacterSet//空格
//3 whitespaceAndNewlineCharacterSet//空格换行
//4 decimalDigitCharacterSet//小数
//5 letterCharacterSet//文字
//6 lowercaseLetterCharacterSet//小写字母
//7 uppercaseLetterCharacterSet//大写字母
//8 nonBaseCharacterSet//非基础
//9 alphanumericCharacterSet//字母数字
//10 decomposableCharacterSet//可分解
//11 illegalCharacterSet//非法
//12 punctuationCharacterSet//标点
//13 capitalizedLetterCharacterSet//大写
//14 symbolCharacterSet//符号
//15 newlineCharacterSet//换行符

- (void)setInputInfo:(setUpData *)inputInfo{
    _inputInfo = inputInfo;
    self.input.placeholder = inputInfo.describe;
    self.input.clearButtonMode = inputInfo.clearButtonMode;
    self.input.keyboardType = inputInfo.keyboardType;
    if ([inputInfo.describe isEqualToString:NSLocalizedString(@"registVcTwocell4", @"")] || [inputInfo.describe isEqualToString:NSLocalizedString(@"registVcTwocell5", @"")] || [inputInfo.describe isEqualToString:NSLocalizedString(@"registVcThreecell1County", @"")] || [inputInfo.describe isEqualToString:NSLocalizedString(@"modififyInfoCell4", @"")] || [inputInfo.describe isEqualToString:NSLocalizedString(@"modififyInfoCell5", @"")]) {
        self.input.userInteractionEnabled = NO;
        self.CusaccessoryView.hidden = NO;
    } else {
        self.input.userInteractionEnabled = YES;
        self.CusaccessoryView.hidden = YES;
    }
    self.input.text = inputInfo.title;
    if ([inputInfo.describe isEqualToString:NSLocalizedString(@"loginVccell2", @"")] || [inputInfo.describe isEqualToString:NSLocalizedString(@"registVcOnecell2", @"")] || [inputInfo.describe isEqualToString:NSLocalizedString(@"registVcOnecell3", @"")]) {
        self.input.secureTextEntry = YES;
    } else {
        self.input.secureTextEntry = NO;
    }
}
@end
