//
//  loginVcFoot.h
//  portal
//
//  Created by Store on 2017/12/14.
//  Copyright © 2017年 qxc122@126.com. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface loginVcFoot : UIView
@property (nonatomic,weak) UIButton *login;
@property (nonatomic, copy) void (^btnClick)(NSString *identifer);
@end
