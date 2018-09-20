//
//  registVcThree.m
//  portal
//
//  Created by Store on 2017/12/14.
//  Copyright © 2017年 qxc122@126.com. All rights reserved.
//

#import "registVcThree.h"
#import "baseFillCell.h"
#import "selecetAreaVc.h"
#import "registVcThreeFoot.h"

@interface registVcThree ()
@property (nonatomic,strong) NSMutableArray *dataArry;
@end

@implementation registVcThree

- (void)viewDidLoad {
    [super viewDidLoad];
    self.header.hidden = YES;
    self.view.backgroundColor = ColorWithHex(0xF3F3F3, 1.0);
    self.registerClasss = @[[baseFillCell class]];
    self.empty_type = succes_empty_num;
    [self setFoot];
    // Do any additional setup after loading the view.
}
- (void)setFoot{
    
    NSDictionary *dic = [NSDictionary dictionaryWithObjectsAndKeys:PingFangSC_Regular(15),NSFontAttributeName,ColorWithHex(0xACABAB, 1.0),NSForegroundColorAttributeName, nil];
    NSMutableAttributedString *All = [NSMutableAttributedString new];
    [All appendAttributedString:[[NSAttributedString alloc] initWithString:NSLocalizedString(@"woyiyuedubingtongyi", nil) attributes:dic]];
    NSMutableAttributedString *one = [[NSMutableAttributedString alloc] initWithString:NSLocalizedString(@"yingshitiaoyue", nil) attributes:dic];
    one.yy_underlineStyle = NSUnderlineStyleSingle;
    kWeakSelf(self);
    [one yy_setTextHighlightRange:NSMakeRange(0, one.length) color:ColorWithHex(0xACABAB, 1.0) backgroundColor:nil tapAction:^(UIView * _Nonnull containerView, NSAttributedString * _Nonnull text, NSRange range, CGRect rect) {
        if ([[PortalHelper sharedInstance]get_Globaldata].jcPrivacyPolicyUrl) {
            [weakself openEachWkVcWithId:[[PortalHelper sharedInstance]get_Globaldata].jcPrivacyPolicyUrl];
        } else {
            [MBProgressHUD showPrompt:NSLocalizedString(@"wuxiaodedizhi", nil) toView:weakself.view];
        }
    }];
    [All appendAttributedString:one];
    
    NSMutableAttributedString *dian = [[NSMutableAttributedString alloc] initWithString:NSLocalizedString(@"dian", nil) attributes:dic];
    [All appendAttributedString:dian];
    
    NSMutableAttributedString *Two = [[NSMutableAttributedString alloc] initWithString:NSLocalizedString(@"fuwutiaoyue", nil) attributes:dic];
    Two.yy_underlineStyle = NSUnderlineStyleSingle;
    [Two yy_setTextHighlightRange:NSMakeRange(0, Two.length) color:ColorWithHex(0xACABAB, 1.0) backgroundColor:nil tapAction:^(UIView * _Nonnull containerView, NSAttributedString * _Nonnull text, NSRange range, CGRect rect) {
        if ([[PortalHelper sharedInstance]get_Globaldata].jcGccUrl) {
            [weakself openEachWkVcWithId:[[PortalHelper sharedInstance]get_Globaldata].jcGccUrl];
        } else {
            [MBProgressHUD showPrompt:NSLocalizedString(@"wuxiaodedizhi", nil) toView:weakself.view];
        }
    }];
    [All appendAttributedString:Two];
    
    NSMutableAttributedString *juhao = [[NSMutableAttributedString alloc] initWithString:NSLocalizedString(@"juhao", nil) attributes:dic];
    [All appendAttributedString:juhao];

    
    YYTextLayout *layout = [YYTextLayout layoutWithContainerSize:CGSizeMake(SCREENWIDTH - 65, CGFLOAT_MAX) text:All];
    registVcThreeFoot *foot = [[registVcThreeFoot alloc]initWithFrame:CGRectMake(0, 0, SCREENWIDTH, layout.textBoundingSize.height+20)];
    self.tableView.tableFooterView = foot;
    foot.label.attributedText = All;
    foot.btnClickxieuyi = ^(BOOL tongyi) {
        if (tongyi) {
            weakself.xieyi = @"1";
        } else {
            weakself.xieyi = nil;
        }
        if (weakself.Fill_in_the_text) {
            weakself.Fill_in_the_text(weakself.AreaJsonone, weakself.phone,weakself.xieyi);
        }
    };
}
#pragma --mark< UITableViewDelegate 高>
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 60;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataArry.count;
}
#pragma --mark< 创建cell >
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    baseFillCell *cell = [baseFillCell returnCellWith:tableView];
    [self configurebaseFillCell:cell atIndexPath:indexPath];
    return  cell;
}
#pragma --mark< 点击了 cell >
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:NO];// 取消选中
    setUpData *one = self.dataArry[indexPath.row];
    if ([one.describe isEqualToString:NSLocalizedString(@"registVcThreecell1County", @"")]) {
        selecetAreaVc *vc = [selecetAreaVc new];
        kWeakSelf(self);
        vc.selecetData = ^(countryOne *data) {
            weakself.AreaJsonone = data;
            for (setUpData *one in self.dataArry) {
                if ([one.describe isEqualToString:NSLocalizedString(@"registVcThreecell1County", @"")]) {
                    one.title = [NSString stringWithFormat:@"%@(+%@)",data.countryName,data.areaCode];
                    [weakself.tableView reloadData];
                }
            }
            if (weakself.Fill_in_the_text) {
                weakself.Fill_in_the_text(weakself.AreaJsonone, weakself.phone,weakself.xieyi);
            }
        };
        [self OPenVc:vc];
    }
}

#pragma --mark< 配置HomeVcCell 的数据>
- (void)configurebaseFillCell:(baseFillCell *)cell atIndexPath:(NSIndexPath *)indexPath {
    setUpData *one = self.dataArry[indexPath.row];
    cell.inputInfo = one;
    kWeakSelf(self);
    cell.Fill_in_the_text = ^(NSString *identifer, NSString *inText, UITextField *intput) {
        weakself.phone = inText;
        setUpData *data = weakself.dataArry[1];
        data.title = inText;
        if (weakself.Fill_in_the_text) {
            weakself.Fill_in_the_text(weakself.AreaJsonone, weakself.phone,weakself.xieyi);
        }
    };
}
- (NSMutableArray *)dataArry{
    if (!_dataArry) {
        _dataArry = [NSMutableArray new];
        for (NSInteger tmp = 0; tmp<2; tmp++) {
            setUpData *data = [setUpData new];
            NSString *placeholder = nil;
            UITextFieldViewMode clearButtonMode = UITextFieldViewModeWhileEditing;
            UIKeyboardType keyboardType = UIKeyboardTypeASCIICapable;
            NSInteger contentType = 0;
            NSInteger existedLength = 100;
            if (tmp == 0) {
                placeholder =NSLocalizedString(@"registVcThreecell1County", @"");
                clearButtonMode = UITextFieldViewModeWhileEditing;
                keyboardType = UIKeyboardTypeASCIICapable;
            } else {
                placeholder =NSLocalizedString(@"registVcThreecell2", @"");
                clearButtonMode = UITextFieldViewModeWhileEditing;
                keyboardType = UIKeyboardTypePhonePad;
                contentType = baseFillCellType_phone;
                existedLength = 20;
            }
            data.describe = placeholder;
            data.clearButtonMode = clearButtonMode;
            data.keyboardType = keyboardType;
            data.contentType = contentType;
            data.existedLength = existedLength;
            [_dataArry addObject:data];
        }
    }
    return _dataArry;
}
@end
