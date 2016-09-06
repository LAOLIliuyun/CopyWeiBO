//
//  AddFriendViewController.m
//  SimplityWeiBo
//
//  Created by Macx on 16/8/11.
//  Copyright © 2016年 Macx. All rights reserved.
//

#import "AddFriendViewController.h"
#import "HomeViewController.h"
#import "SwpeViewController.h"
@interface AddFriendViewController ()<UITableViewDelegate,UITableViewDataSource>
{
    NSArray *dataSource;
    NSArray *imageArray;
    NSArray *subText;
    UITableView *myTableView;

}
@end

@implementation AddFriendViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    [self setUI];
}
-(void)setUI{
    self.title = @"添加好友";
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithImage:[[UIImage imageNamed:@"navigationbar_more@2x 2"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] style:UIBarButtonItemStylePlain target:self action:@selector(rightBarButtonItemAction:)];
    
    UITextField *textField = [[UITextField alloc]initWithFrame:CGRectMake(20, 74, UISCREEN_WIDTCH-40, 30)];
    textField.layer.cornerRadius = 5;
    textField.backgroundColor = [UIColor whiteColor];
    textField.placeholder = @"搜索昵称";
    UIImageView *imageView =[[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 20, 20)];
    imageView.image = [UIImage imageNamed:@"searchbar_textfield_search_icon@2x 2"];
    textField.leftViewMode = UITextFieldViewModeAlways;
    textField.leftView = imageView;
    [self.view addSubview:textField];
    
    myTableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 120, UISCREEN_WIDTCH, UISCREEN_HEIGHT-120) style:UITableViewStylePlain];
    myTableView.delegate = self;
    myTableView.dataSource = self;
    myTableView.scrollEnabled = NO;
    myTableView.rowHeight = 80 ;
    [self.view addSubview:myTableView];
    
    dataSource = @[@"扫一扫",@"通讯录好友"];
    imageArray = @[[UIImage imageNamed:@"sweep"],[UIImage imageNamed:@"addressbook"]];
    subText =@[@"扫描二维码名片",@"添加或邀请通讯录中的好友"];

}
-(void)rightBarButtonItemAction:(UIBarButtonItem *)sender{
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:nil message:nil preferredStyle:UIAlertControllerStyleActionSheet];
    UIAlertAction *cancle = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil];
    UIAlertAction *refresh = [UIAlertAction actionWithTitle:@"刷新" style:UIAlertActionStyleDefault handler:nil];
    UIAlertAction *backFirst = [UIAlertAction actionWithTitle:@"返回首页" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
       dispatch_async(dispatch_get_main_queue(), ^{
           [self.navigationController popToRootViewControllerAnimated:YES];
           self.tabBarController.selectedIndex = 0 ;
       });
      
    }];
    [alert addAction:cancle];
    [alert addAction:refresh];
    [alert addAction:backFirst];
    [self presentViewController:alert animated:NO completion:nil];
}
-(void)viewWillAppear:(BOOL)animated{
    self.tabBarController.tabBar.hidden = YES;
}
-(void)viewWillDisappear:(BOOL)animated{
    self.tabBarController.tabBar.hidden = NO;
}
#pragma mark UITableViewDelegate
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
      return dataSource.count;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"reuse"];
    if (!cell) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"reuse"];
    }
    cell.textLabel.text = dataSource[indexPath.row];
    cell.imageView.image = imageArray[indexPath.row];
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    cell.detailTextLabel.text = subText[indexPath.row];
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    switch (indexPath.row) {
        case 0:
        {
            [self.navigationController pushViewController:[SwpeViewController new] animated:NO];
        }break;
        default:
            break;
    }
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
@end
