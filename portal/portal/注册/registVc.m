//
//  registVc.m
//  portal
//
//  Created by Store on 2017/12/14.
//  Copyright © 2017年 qxc122@126.com. All rights reserved.
//

#import "registVc.h"
#import "registVcHead.h"
#import "registVcOne.h"
#import "registVcTwo.h"
#import "registVcThree.h"
#import "UIColor+Add.h"
#import "loginVc.h"
@interface registVc ()<UIScrollViewDelegate>
@property (nonatomic,weak) registVcHead *head;
@property (nonatomic,weak) UIScrollView *scro;
@property (nonatomic,weak) UIButton *next;
@property (nonatomic,assign) NSInteger page;
@property (nonatomic,strong) registVcOne *registVcOneVc;
@property (nonatomic,strong) registVcTwo *registVcTwoVc;
@property (nonatomic,strong) registVcThree *registVcThreeVc;

@property (nonatomic,strong) NSString *Passemail;  //通过后台验证的邮箱
@end

@implementation registVc

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title =NSLocalizedString(@"registVctitle", @"");
    [self setregistVcUI];
    
    // Do any additional setup after loading the view.
}
- (void)setregistVcUI{
    self.view.backgroundColor = ColorWithHex(0xF3F3F3, 1.0);
    registVcHead *head = [registVcHead new];
    [self.view addSubview:head];
    self.head = head;
    
    UIScrollView *scro = [UIScrollView new];
    [self.view addSubview:scro];
    self.scro = scro;
    
    UIButton *next = [UIButton new];
    [self.view addSubview:next];
    self.next = next;
    [self.head mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view);
        make.right.equalTo(self.view);
        make.top.equalTo(self.view);
        make.height.equalTo(@139);
    }];
    
    self.scro.frame = CGRectMake(0, 139, SCREENWIDTH,SCREENHEIGHT-139-50);
    [self.next mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view);
        make.right.equalTo(self.view);
        make.bottom.equalTo(self.view);
        make.height.equalTo(@50);
    }];
    
    self.registVcOneVc = [registVcOne new];
    [self addChildViewController:self.registVcOneVc];

    self.registVcTwoVc = [registVcTwo new];
    [self addChildViewController:self.registVcTwoVc];
    
    self.registVcThreeVc = [registVcThree new];
    [self addChildViewController:self.registVcThreeVc];
    
    scro.contentSize = CGSizeMake(SCREENWIDTH*3, self.view.bounds.size.height-139-50);
    self.registVcOneVc.view.frame = CGRectMake(0, 0,SCREENWIDTH, self.view.bounds.size.height-139-50);
    self.registVcTwoVc.view.frame = CGRectMake(1 * SCREENWIDTH, 0,SCREENWIDTH, self.view.bounds.size.height-139-50);
    self.registVcThreeVc.view.frame = CGRectMake(2 * SCREENWIDTH, 0,SCREENWIDTH, self.view.bounds.size.height-139-50);
    [self.scro addSubview:self.registVcOneVc.view];
    [self.scro addSubview:self.registVcTwoVc.view];
    [self.scro addSubview:self.registVcThreeVc.view];
    
    scro.showsHorizontalScrollIndicator = NO;
    scro.showsVerticalScrollIndicator = NO;
    self.scro.pagingEnabled = YES;
    self.scro.delegate = self;
    self.scro.bounces= NO;
    self.scro.scrollEnabled= NO;
    [self.next setWithNormalColor:0xFFFFFF NormalAlpha:1.0 NormalTitle:nil NormalImage:nil NormalBackImage:nil SelectedColor:0x0 SelectedAlpha:0 SelectedTitle:nil SelectedImage:nil SelectedBackImage:nil Font:17 NormalROrM:@"m" backColor:0xED1C24 backAlpha:1.0];

    self.page = 0;
    [self.next setEnabled:NO];
    [self.next addTarget:self action:@selector(nextClick:) forControlEvents:UIControlEventTouchUpInside];
    [self setBlock];
}
- (void)setBlock{
    kWeakSelf(self);
    self.registVcOneVc.Fill_in_the_text = ^(NSString *email, NSString *passWord) {
        [weakself setOenBlock];
    };
    self.registVcTwoVc.Fill_in_the_text = ^(NSString *sex, NSString *name, NSString *xing, NSString *birthdaty, countryOne *countryone) {
        [weakself setTwoBlock];
    };
    self.registVcThreeVc.Fill_in_the_text = ^(countryOne *AreaJsonone, NSString *phone,NSString *xieyi) {
        [weakself setThreeBlock];
    };
}
- (void)setOenBlock{
    if (self.registVcOneVc.email.length && self.registVcOneVc.passWord.length) {
        self.next.enabled = YES;
    } else {
        self.next.enabled = NO;
    }
}
- (void)setTwoBlock{
    if (self.registVcTwoVc.sex.length && self.registVcTwoVc.name.length && self.registVcTwoVc.xing.length && self.registVcTwoVc.birthdaty.length && self.registVcTwoVc.countryone) {
        self.next.enabled = YES;
    } else {
        self.next.enabled = NO;
    }
}
- (void)setThreeBlock{
    if (self.registVcThreeVc.phone.length && self.registVcThreeVc.AreaJsonone && self.registVcThreeVc.xieyi.length) {
        self.next.enabled = YES;
    } else {
        self.next.enabled = NO;
    }
}
- (void)nextClick:(UIButton *)btn{
//    if ([btn.restorationIdentifier isEqualToString:@"nextOne"]) {
//
//    } else if ([btn.restorationIdentifier isEqualToString:@"nextTwo"]) {
//
//    } else if ([btn.restorationIdentifier isEqualToString:@"nextThree"]) {
//
//    }
    if (self.page == 0) {
        if ([self.registVcOneVc.email isEqualToString:self.Passemail]) {
            [self jugePassWord];
        } else {
            if (!self.registVcOneVc.passWordpre.length || [self.registVcOneVc.passWord PureLetters] || [self.registVcOneVc.passWord isPureNumandCharacters]) {
                [MBProgressHUD showPrompt:NSLocalizedString(@"mimichangdeng", @"") toView:self.view];
            }else{
                if ([self.registVcOneVc.email isValidateEmail]) {
                    kWeakSelf(self);
                    [MBProgressHUD showLoadingMessage:NSLocalizedString(@"youxjiaoyangzohbng", nil) toView:self.view];
                    [[ToolRequest sharedInstance]URLBASIC_appjcEmailValidWithemail:self.registVcOneVc.email success:^(id dataDict, NSString *msg, NSInteger code) {
                        [MBProgressHUD hideHUDForView:weakself.view];
                        weakself.Passemail = weakself.registVcOneVc.email;
                        [weakself jugePassWord];
                    } failure:^(NSInteger errorCode, NSString *msg) {
                        [MBProgressHUD hideHUDForView:weakself.view];
                        [MBProgressHUD showPrompt:msg toView:weakself.view];
                    }];
                } else {
                    [MBProgressHUD showPrompt:NSLocalizedString(@"qignshuruzhengEmai", nil) toView:self.view];
                }
            }
        }
    }else if(self.page == 1){
        [self setPageAdd];
    } else  if (self.page == 2) {
        if ([self.registVcThreeVc.AreaJsonone.areaCode containsString:@"86"]) {
            if ([self.registVcThreeVc.phone IsTelNumber]) {
                [self registAll];
            } else {
                [MBProgressHUD showPrompt:NSLocalizedString(@"shoujihaocuowu", nil) toView:self.view];
            }
        } else {
            [self registAll];
        }
    }
}
- (void)registAll{
    kWeakSelf(self);
    [MBProgressHUD showLoadingMessage:NSLocalizedString(@"zhucezhogn", nil) toView:self.view];
    [[ToolRequest sharedInstance]URLBASIC_jcRegisteredWithemail:self.registVcOneVc.email password:self.registVcOneVc.passWord mobile:self.registVcThreeVc.phone zone:self.registVcThreeVc.AreaJsonone.areaCode surname:self.registVcTwoVc.xing enName:self.registVcTwoVc.name sex:self.registVcTwoVc.sex birthday:self.registVcTwoVc.birthdaty nationality:self.registVcTwoVc.countryone.countryCode success:^(id dataDict, NSString *msg, NSInteger code) {
        [MBProgressHUD hideHUDForView:weakself.view];
        [MBProgressHUD showPrompt:NSLocalizedString(@"zhucesuccesregistVc", nil) toView:weakself.view];
        [weakself login];
    } failure:^(NSInteger errorCode, NSString *msg) {
        [MBProgressHUD hideHUDForView:weakself.view];
        [MBProgressHUD showPrompt:msg toView:weakself.view];
    }];
}
- (void)jugePassWord{
    if (!self.registVcOneVc.passWordpre.length || [self.registVcOneVc.passWord PureLetters] || [self.registVcOneVc.passWord isPureNumandCharacters]) {
        [MBProgressHUD showPrompt:NSLocalizedString(@"mimichangdeng", @"") toView:self.view];
    }else{
        [self setPageAdd];
    }
}
- (void)setPageAdd{
    if (self.page<2) {
        self.page++;
        if (self.page == 1) {
            [self setTwoBlock];
        } else if (self.page == 2) {
            [self setThreeBlock];
        }
    }
}

- (void)login{
    kWeakSelf(self);
    [MBProgressHUD showLoadingMessage:NSLocalizedString(@"dengluzhong", nil) toView:self.view];
    [[ToolRequest sharedInstance]URLBASIC_jcLoginWithemail:self.registVcOneVc.email password:self.registVcOneVc.passWord success:^(id dataDict, NSString *msg, NSInteger code) {
        UserInfo *tmp = [UserInfo mj_objectWithKeyValues:dataDict];
        [[PortalHelper sharedInstance]set_userInfo:tmp];
        if (tmp.authenTicket.length && tmp.authenUserId.length && tmp.surname.length && tmp.enName.length) {
            [MBProgressHUD hideHUDForView:weakself.view];
            [MBProgressHUD showPrompt:NSLocalizedString(@"dengluzhongOK", nil) toView:weakself.view];
            [weakself popRegsVc];
        }else{
            [weakself getMyinfo];
        }
        NSNotification *notification =[NSNotification notificationWithName:@"resetCokie" object:nil userInfo:nil];
        [[NSNotificationCenter defaultCenter] postNotification:notification];
    } failure:^(NSInteger errorCode, NSString *msg) {
        [MBProgressHUD hideHUDForView:weakself.view];
        [MBProgressHUD showPrompt:msg toView:weakself.view];
        [weakself loginFailGologin];
    }];
}
- (void)loginFailGologin{
    loginVc *vc = self.navigationController.childViewControllers[1];
    if ([vc isKindOfClass:[loginVc class]]) {
        vc.email = self.registVcOneVc.email;
        vc.passWord = self.registVcOneVc.passWord;
    }
    [self popSelf];
}
- (void)popRegsVc{
    if (self.navigationController.childViewControllers.count > 2) {
        [self.navigationController popToViewController:self.navigationController.childViewControllers[self.navigationController.childViewControllers.count-2-1] animated:YES];
    }
}
- (void)getMyinfo{
    kWeakSelf(self);
    [[ToolRequest sharedInstance]URLBASIC_jcMyInfosuccess:^(id dataDict, NSString *msg, NSInteger code) {
        UserInfo *tmp = [UserInfo mj_objectWithKeyValues:dataDict];
        [[PortalHelper sharedInstance]set_userInfo:tmp];
        [MBProgressHUD hideHUDForView:weakself.view];
        [MBProgressHUD showPrompt:NSLocalizedString(@"dengluzhongOK", nil) toView:weakself.view];
        [weakself popRegsVc];
    } failure:^(NSInteger errorCode, NSString *msg) {
        [MBProgressHUD hideHUDForView:weakself.view];
        [MBProgressHUD showPrompt:msg toView:weakself.view];
    }];
}
- (void)popSelf
{
    if (self.page>0) {
        self.page--;
        [self.next setEnabled:YES];
    } else {
        [self.navigationController popViewControllerAnimated:YES];
    }
}
- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    CGPoint currentOffset = scrollView.contentOffset;
    self.page = currentOffset.x / self.view.bounds.size.width;
}
- (void)setPage:(NSInteger)page{
    _page = page;
    [self.scro setContentOffset:CGPointMake(page*SCREENWIDTH,0) animated:NO];
    if (page == 0) {
        self.head.progress = 0.25;
        self.next.restorationIdentifier = @"nextOne";
        [self.next setTitle:NSLocalizedString(@"nextOne", @"") forState:UIControlStateNormal];
    } else if (page == 1) {
        self.head.progress = 0.5;
        self.next.restorationIdentifier = @"nextTwo";
        [self.next setTitle:NSLocalizedString(@"nextTwo", @"") forState:UIControlStateNormal];
    } else if (page == 2) {
        self.head.progress = 1.0;
        self.next.restorationIdentifier = @"nextThree";
        [self.next setTitle:NSLocalizedString(@"nextThree", @"") forState:UIControlStateNormal];
    }
}
@end
