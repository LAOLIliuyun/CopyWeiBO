//
//  MyViewController.m
//  SimplityWeiBo
//
//  Created by Macx on 16/8/9.
//  Copyright © 2016年 Macx. All rights reserved.
//

#import "MyViewController.h"
#import <WeiboSDK.h>
#import <MBProgressHUD.h>
#import "BeforeSettingViewController.h"
@interface MyViewController ()

@end

@implementation MyViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setUI];
    
}
-(void)setUI{
    self.title = @"我";
    self.navigationController.navigationBar.tintColor = [UIColor darkGrayColor];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"设置" style:UIBarButtonItemStylePlain target:self action:@selector(pushSettingButtonAction:)];
    UIImageView *imageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 64, UISCREEN_WIDTCH, UISCREEN_WIDTCH/2.11)];
    imageView.image = [UIImage imageNamed:@"my_background"];
    [self.view addSubview:imageView];
    
    UIView *guanzhuView = [[UIView alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(imageView.frame), UISCREEN_WIDTCH, 44)];
    guanzhuView.backgroundColor = [UIColor whiteColor];
    UILabel *guanzhuLabel = [[UILabel alloc]initWithFrame:CGRectMake(20, 0, 60, 44)];
    guanzhuLabel.text = @"关注";
    guanzhuLabel.font = [UIFont systemFontOfSize:20];
    [guanzhuView addSubview:guanzhuLabel];
    
    UILabel *cheoutLabel = [[UILabel alloc]initWithFrame:CGRectMake(80, 0, 150, 44)];
    cheoutLabel.text = @"快看看大家都在关注谁";
    cheoutLabel.font = [UIFont systemFontOfSize:15];
    cheoutLabel.textColor = [UIColor grayColor];
    [guanzhuView addSubview:cheoutLabel];
    
    UIImageView *rightImageView = [[UIImageView alloc]initWithFrame:CGRectMake(UISCREEN_WIDTCH-64, 7, 30, 30)];
    rightImageView.image = [UIImage imageNamed:@"cut"];
    [guanzhuView addSubview:rightImageView];
    [self.view addSubview:guanzhuView];
//为视图添加手势
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(cheoutGuanzhuz:)];
    [guanzhuView addGestureRecognizer:tap];
    
    
    UILabel *jieshaoLabel = [[UILabel alloc]initWithFrame:CGRectMake(60,(UISCREEN_HEIGHT+CGRectGetMaxY(guanzhuView.frame))/2-60, UISCREEN_WIDTCH-120, 60)];
    jieshaoLabel.text = @"登录后，你的微博、相册、个人资料会显示着这里，展示给他人";
    jieshaoLabel.textColor = [UIColor grayColor];
    jieshaoLabel.numberOfLines = 0;
    jieshaoLabel.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:jieshaoLabel];
    
    UIButton *loginButton = [UIButton buttonWithType: UIButtonTypeCustom];
    loginButton.layer.borderWidth = 2;
    loginButton.frame = CGRectMake(UISCREEN_WIDTCH/2-60, (UISCREEN_HEIGHT+CGRectGetMaxY(guanzhuView.frame))/2, 120, 44);
    [loginButton setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    [loginButton setTitle:@"登录" forState:UIControlStateNormal];
    [loginButton addTarget:self action:@selector(loginButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    loginButton.layer.borderColor = [UIColor lightGrayColor].CGColor;
    [self.view addSubview:loginButton];
    
}
-(void)viewWillAppear:(BOOL)animated{
    [MBProgressHUD hideHUDForView:self.view animated:YES];
    self.tabBarController.tabBar.hidden = NO;
 }
-(void)loginButtonAction: (UIButton *)sender{
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    WBAuthorizeRequest *request = [WBAuthorizeRequest request];
    request.redirectURI = kRedirectURI;
    request.scope = @"all";
    request.userInfo = @{@"SSO_From":@"MyViewController",@"Other_Info_1":[NSNumber numberWithInteger:123]};
    [WeiboSDK sendRequest:request];

}
-(void)pushSettingButtonAction:(UIBarButtonItem *)sender{
    [self.navigationController pushViewController:[BeforeSettingViewController new] animated:NO];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
