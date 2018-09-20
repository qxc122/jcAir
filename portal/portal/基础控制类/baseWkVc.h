//
//  baseWkVc.h
//  portal
//
//  Created by Store on 2017/8/31.
//  Copyright © 2017年 qxc122@126.com. All rights reserved.
//

#import "basicVc.h"
#import <WebKit/WKFoundation.h>
#import <WebKit/WebKit.h>

@interface baseWkVc : basicVc
@property (nonatomic,assign) BOOL netError;
@property (nonatomic,weak) WKWebView *webView;
@property (weak,nonatomic) UIProgressView *pro1;
@property (strong,nonatomic) WKWebViewConfiguration *config;
@property (nonatomic,strong) id url;

-(void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSString *,id> *)change context:(void *)context;
@end
