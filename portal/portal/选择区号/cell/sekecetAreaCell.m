//
//  sekecetAreaCell.m
//  portal
//
//  Created by Store on 2017/12/18.
//  Copyright © 2017年 qxc122@126.com. All rights reserved.
//

#import "sekecetAreaCell.h"

@implementation sekecetAreaCell

+ (instancetype)returnCellWith:(UITableView *)tableView
{
    sekecetAreaCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([self class])];
    if (cell == nil) {
        cell = [[sekecetAreaCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:NSStringFromClass([self class])];
    }
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    cell.selectionStyle = UITableViewCellSelectionStyleDefault;
    return cell;
}

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
    }
    return self;
}

@end
