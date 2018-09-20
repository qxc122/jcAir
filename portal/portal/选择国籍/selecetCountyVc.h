//
//  selecetCountyVc.h
//  portal
//
//  Created by Store on 2017/12/18.
//  Copyright © 2017年 qxc122@126.com. All rights reserved.
//

#import "basicUiTableView.h"
#import "sekecetAreaCell.h"
@interface selecetCountyVc : basicUiTableView
@property (nonatomic,strong) NSMutableArray *AreaJsonOneAll;
@property (nonatomic, copy) void (^selecetData)(countryOne *data);
@end
