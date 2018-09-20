//
//  rightVc.h
//  portal
//
//  Created by Store on 2017/12/18.
//  Copyright © 2017年 qxc122@126.com. All rights reserved.
//

#import "basicUiTableView.h"

@interface rightVc : basicUiTableView
@property (nonatomic, copy) void (^didselecetCell)(id url);
@property (nonatomic,strong) UIImage *backimage;
@end
