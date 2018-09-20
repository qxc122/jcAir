//
//  registVcThree.h
//  portal
//
//  Created by Store on 2017/12/14.
//  Copyright © 2017年 qxc122@126.com. All rights reserved.
//

#import "basicUiTableView.h"

@interface registVcThree : basicUiTableView
@property (nonatomic, copy) void (^Fill_in_the_text)(countryOne *AreaJsonone,NSString *phone,NSString *xieyi);
@property (nonatomic,strong) countryOne *AreaJsonone;
@property (nonatomic,strong) NSString *phone;
@property (nonatomic,strong) NSString *xieyi;
@end
