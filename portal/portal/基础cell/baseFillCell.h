//
//  baseFillCell.h
//  portal
//
//  Created by Store on 2017/10/9.
//  Copyright © 2017年 qxc122@126.com. All rights reserved.
//

#import "baseCell.h"
#import "UITextFieldAdd.h"


typedef enum {
    baseFillCellType_NumbersAndletters =100 ,  //数字和字母
    baseFillCellType_LettersAndChinese,         //中文
    baseFillCellType_ID,                        //数字和字母Xx
    baseFillCellType_LetterCharacterSet,       //所有字母
    baseFillCellType_phone,       //手机号码
} baseFillCellType;

@interface baseFillCell : baseCell
/**
 *  按钮
 */
@property (nonatomic, copy) void (^Fill_in_the_text)(NSString *identifer,NSString *inText,UITextField *intput);
@property (nonatomic,weak) UITextFieldAdd *input;
@property (nonatomic,weak) UIView *back;
@property (nonatomic,weak) UIImageView *CusaccessoryView;
@property (nonatomic,weak) UILabel *content;

@property (nonatomic,strong) setUpData *inputInfo;

- (void)setInputInfo:(setUpData *)inputInfo;
@end
