//
//  registVcTwoSex.h
//  portal
//
//  Created by Store on 2017/12/14.
//  Copyright © 2017年 qxc122@126.com. All rights reserved.
//

#import "baseFillCell.h"

@interface registVcTwoSex : baseFillCell
@property (nonatomic,weak) UIButton *man;
@property (nonatomic,weak) UIButton *Woman;
@property (nonatomic, copy) void (^btnClickSex)(NSString *identifer);
@end
