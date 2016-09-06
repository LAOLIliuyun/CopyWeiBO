//
//  BeforeSettingViewController.m
//  SimplityWeiBo
//
//  Created by Macx on 16/8/9.
//  Copyright © 2016年 Macx. All rights reserved.
//

#import "BeforeSettingViewController.h"
#import "NormalSettingViewController.h"
#import "AboutWeiboViewController.h"

@interface BeforeSettingViewController ()<UITableViewDelegate,UITableViewDataSource>
{
    NSArray *dataSource;
}
@end

@implementation BeforeSettingViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setUI];
}
-(void)viewWillAppear:(BOOL)animated{
    self.tabBarController.tabBar.hidden = YES;
}
-(void)setUI{
    self.title = @"设置";
    UIView *hotView = [[UIView alloc]initWithFrame:CGRectMake(0, 80, UISCREEN_WIDTCH, 44)];
    hotView.backgroundColor = [UIColor whiteColor];
    UILabel *hotLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 90, 44)];
    hotLabel.text = @"微博热搜";
    hotLabel.textAlignment = NSTextAlignmentCenter
    ;
    [hotView addSubview:hotLabel];
    
    UISwitch *switchButton = [[UISwitch alloc]initWithFrame:CGRectMake(UISCREEN_WIDTCH-60, 7, 0, 0)];
    [hotView addSubview:switchButton];
    [self.view addSubview:hotView];
    
    UITableView *myTableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 150, UISCREEN_WIDTCH, 88) style:UITableViewStylePlain];
    myTableView.delegate = self;
    myTableView.dataSource = self;
    [self.view addSubview:myTableView];
    myTableView.scrollEnabled = NO;
    dataSource = @[@"通用设置",@"关于微博"];
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 2;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"reuse"];
    if (!cell) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"reuse"];
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    }
    cell.textLabel.text = dataSource[indexPath.row];
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    switch (indexPath.row) {
        case 0:
        {
            [self.navigationController pushViewController:[NormalSettingViewController new] animated:NO];
        } break;
        case 1:
        {
            [self.navigationController pushViewController:[AboutWeiboViewController new] animated:NO];
        } break;
            
        default:
            break;
    }
}
-(void)normalButtonAction:(UIButton *)sender{
    
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
