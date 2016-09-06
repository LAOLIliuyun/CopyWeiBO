//
//  SettingViewController.m
//  SimplityWeiBo
//
//  Created by Macx on 16/8/10.
//  Copyright © 2016年 Macx. All rights reserved.
//

#import "SettingViewController.h"
#import "CountManageViewController.h"
#import "CounrtSaveViewController.h"
#import "NotifitionViewController.h"
#import "SecurityViewController.h"
#import "NormalViewController.h"
#import "SuggetionViewController.h"
#import "AboutWeiboViewController.h"
#import <WeiboSDK.h>
#import "AppDelegate.h"
@interface SettingViewController ()<UITableViewDelegate,UITableViewDataSource,UIApplicationDelegate,WBHttpRequestDelegate>
{
    NSArray *dataSource;
}
@end

@implementation SettingViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setUI];
}
-(void)setUI{
    self.title = @"设置";
    UITableView *myTableView = [[UITableView alloc]initWithFrame:CGRectMake(0,0, UISCREEN_WIDTCH, UISCREEN_HEIGHT) style:UITableViewStyleGrouped];
    myTableView.delegate = self;
    myTableView.dataSource = self;
    myTableView.scrollEnabled = NO;
    [self.view addSubview:myTableView];
    
    
    UIButton *signInButton = [UIButton buttonWithType:UIButtonTypeSystem];
    signInButton.frame = CGRectMake(0, UISCREEN_HEIGHT-108, UISCREEN_WIDTCH, 44);
    [signInButton setTitle:@"退出微博" forState:UIControlStateNormal];
    [signInButton setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    [signInButton setBackgroundColor:[UIColor whiteColor]];
    [signInButton addTarget:self action:@selector(signInButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:signInButton];
    
    
    
    dataSource = @[@[@"账号管理",@"账号安全"],@[@"通知",@"隐私",@"通用设置"],@[@"意见反馈",@"关于微博"],@[@"清除缓存"]];
}
-(void)signInButtonAction:(UIButton *)sender{
    exit(0);
}
-(void)viewWillAppear:(BOOL)animated{
    self.tabBarController.tabBar.hidden = YES;
}
#pragma mark uitableViewDelegate

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    switch (indexPath.section) {
        case 0:
        {
            if (indexPath.row ==0) {
                [self.navigationController pushViewController:[CountManageViewController new] animated:NO];
            }else{
                [self.navigationController pushViewController:[CounrtSaveViewController new] animated:NO];
            }
        } break;
        case 1:
        {
            if (indexPath.row == 0) {
                [self.navigationController pushViewController:[NotifitionViewController new] animated:NO];
            }else if (indexPath.row == 1){
                [self.navigationController pushViewController:[SecurityViewController new] animated:NO];
            }else{
                [self.navigationController pushViewController:[NormalViewController new] animated:NO];
            }
        } break;
        case 2:
        {
            if (indexPath.row == 0) {
                SuggetionViewController *sug = [SuggetionViewController new];
                sug.type = JumpFromSettingAfterLogin;
                [self.navigationController pushViewController:sug animated:NO];
            }else{
                [self.navigationController pushViewController:[AboutWeiboViewController new] animated:NO];
            }
         } break;
        case 3:
        {
            UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"确定清除缓存吗？" message:nil preferredStyle:UIAlertControllerStyleAlert];
            UIAlertAction *cancle = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil];
            UIAlertAction *sure = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:nil];
            [alert addAction:cancle];
            [alert addAction:sure];
            [self presentViewController:alert animated:NO completion:nil];
        } break;
        default:
            break;
    }
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (section ==0) {
        return 2;
    }else if (section ==1){
        return 3;
    }else if (section ==2){
        return 2;
    }else{
        return 1;
    }
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return dataSource.count;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"reuse"];
    if (!cell) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"reuse"];
     }
    cell.textLabel.text = dataSource[indexPath.section][indexPath.row];
    if (indexPath.section ==3 && indexPath.row == 0) {
        cell.detailTextLabel.text = @"0.3MB";
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    }else{
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;

    }
    return cell;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
@end
