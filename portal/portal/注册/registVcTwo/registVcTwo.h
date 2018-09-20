//
//  registVcTwo.h
//  portal
//
//  Created by Store on 2017/12/14.
//  Copyright © 2017年 qxc122@126.com. All rights reserved.
//

#import "basicUiTableView.h"

@interface registVcTwo : basicUiTableView
@property (nonatomic, copy) void (^Fill_in_the_text)(NSString *sex,NSString *name,NSString *xing,NSString *birthdaty,countryOne *countryone);
@property (nonatomic,strong) NSString *sex;
@property (nonatomic,strong) NSString *name;
@property (nonatomic,strong) NSString *xing;
@property (nonatomic,strong) NSString *birthdaty;
@property (nonatomic,strong) countryOne *countryone;
@end

