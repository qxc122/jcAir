//
//  registVcThreeFoot.h
//  portal
//
//  Created by Store on 2017/12/20.
//  Copyright © 2017年 qxc122@126.com. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "YYLabel.h"
#import "NSAttributedString+YYText.h"
@interface registVcThreeFoot : UIView
@property (nonatomic,weak) YYLabel *label;
@property (nonatomic, copy) void (^btnClickxieuyi)(BOOL tongyi);
@end
