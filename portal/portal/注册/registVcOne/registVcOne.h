//
//  registVcOne.h
//  portal
//
//  Created by Store on 2017/12/14.
//  Copyright © 2017年 qxc122@126.com. All rights reserved.
//

#import "basicUiTableView.h"

@interface registVcOne : basicUiTableView
@property (nonatomic, copy) void (^Fill_in_the_text)(NSString *email,NSString *passWord);
@property (nonatomic,strong) NSString *email;
@property (nonatomic,strong) NSString *passWord;
@property (nonatomic,strong) NSString *passWordpre;
@end
