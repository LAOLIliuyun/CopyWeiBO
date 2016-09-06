//
//  CountManageViewController.m
//  SimplityWeiBo
//
//  Created by Macx on 16/8/10.
//  Copyright © 2016年 Macx. All rights reserved.
//

#import "CountManageViewController.h"
#import <WeiboSDK.h>
#import "AppDelegate.h"

@interface CountManageViewController ()<WBHttpRequestDelegate>
{
    NSArray *dataSouce;
}
@end

@implementation CountManageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setUI];
}

-(void)setUI{
    self.title = @"账号管理";
    UIButton *outButton = [UIButton buttonWithType:UIButtonTypeSystem];
    outButton.frame = CGRectMake(0, 100, UISCREEN_WIDTCH, 44);
    [outButton setTitle:@"退出微博" forState:UIControlStateNormal];
    [outButton setBackgroundColor:[UIColor whiteColor]];
    [outButton addTarget:self action:@selector(setOutButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:outButton];
}
-(void)setOutButtonAction:(UIButton *)sender{
    NSString *acc = [[NSUserDefaults standardUserDefaults]valueForKey:@"access_token"];
    [WBHttpRequest requestWithAccessToken:acc url:@"https://api.weibo.com/oauth2/revokeoauth2" httpMethod:@"POST" params:nil delegate:self withTag:@"101"];
    AppDelegate *p = (AppDelegate *)[UIApplication sharedApplication].delegate;
    p.mainVC.viewControllers = @[p.homeVC,p.issueVC,p.myVC];
}

- (void)request:(WBHttpRequest *)request didReceiveResponse:(NSURLResponse *)response{
    NSLog(@"outresponse = %@",response);
}
- (void)request:(WBHttpRequest *)request didFailWithError:(NSError *)error{
    NSLog(@"outerror = %@",error);
}

- (void)request:(WBHttpRequest *)request didFinishLoadingWithResult:(NSString *)result{
    NSLog(@"outresult = %@",result);
    if ([result containsString:@"true"]) {
        [[NSUserDefaults standardUserDefaults] setObject:nil  forKey:@"access_token"];
        [[NSUserDefaults standardUserDefaults] setObject:nil forKey:@"userID"];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}
@end
