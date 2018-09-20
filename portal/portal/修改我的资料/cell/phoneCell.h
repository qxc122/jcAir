//
//  phoneCell.h
//  portal
//
//  Created by Store on 2017/12/19.
//  Copyright © 2017年 qxc122@126.com. All rights reserved.
//

#import "baseFillCell.h"

@interface phoneCell : baseFillCell
@property (nonatomic, copy) void (^selezone)();

@property (nonatomic,weak) UILabel *titleN;
@property (nonatomic,weak) UILabel *zone;
@end
