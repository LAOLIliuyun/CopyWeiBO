//
//  UIWebViewViewController.m
//  SimplityWeiBo
//
//  Created by Macx on 16/8/11.
//  Copyright © 2016年 Macx. All rights reserved.
//

#import "UIWebViewViewController.h"

@interface UIWebViewViewController ()

@end

@implementation UIWebViewViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    UIWebView *webView = [[UIWebView alloc]initWithFrame:self.view.frame];
    [webView loadRequest:[NSURLRequest requestWithURL:_url]];
    [self.view addSubview:webView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
