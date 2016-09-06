//
//  LoginViewController.m
//  SimplityWeiBo
//
//  Created by Macx on 16/8/9.
//  Copyright © 2016年 Macx. All rights reserved.
//

#import "LoginViewController.h"
#import "SettingViewController.h"
#import <WeiboSDK.h>
#import "User.h"
#import "MyTableViewCell.h"
#import <NSObject+YYModel.h>
#import <UIImageView+YYWebImage.h>//这是图片缓存
#import "UIWebViewViewController.h"
#import "AddFriendViewController.h"


@interface LoginViewController ()<WBHttpRequestDelegate,UITableViewDelegate,UITableViewDataSource>
{
    NSArray *dataSource;
    NSArray *imageArray;
    User *user;
    UITableView *myTableView;
}
@end

@implementation LoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setUI];
    [self initData];
}
-(void)initData{
    
    dataSource = @[@[@"新的好友",@"微博等级"],@[@"我的相册",@"我的点评",@"我的赞"],@[@"微博支付",@"微博运动"],@[@"粉丝头条",@"粉丝服务"],@[@"草稿箱"],@[@"更多"]];

    imageArray = @[
  @[[UIImage imageNamed:@"new_friend"],[UIImage imageNamed:@"weibo_level"]],
  @[[UIImage imageNamed:@"my_photo"],[UIImage imageNamed:@"my_comment"],[UIImage imageNamed:@"my_zan"]],
  @[[UIImage imageNamed:@"weibo_pay"],[UIImage imageNamed:@"weibo_exercise"]],
  @[[UIImage imageNamed:@"fans_topline"],[UIImage imageNamed:@"fans_serve"]],
  @[[UIImage imageNamed:@"draft"]],
  @[[UIImage imageNamed:@"more"]]];
    
    
    
    NSString *accetoken = [[NSUserDefaults standardUserDefaults]objectForKey:@"access_token"];
    NSString *uid = [[NSUserDefaults standardUserDefaults]objectForKey:@"userID"];
    [WBHttpRequest requestWithAccessToken:accetoken url:@"https://api.weibo.com/2/users/show.json" httpMethod:@"GET" params:@{@"uid":uid} delegate:self withTag:@"100"];
}
-(void)viewWillAppear:(BOOL)animated{
    self.tabBarController.tabBar.hidden = NO;
    NSLog(@"111");
}
-(void)setUI{
    self.title = @"我";
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"添加好友" style:UIBarButtonItemStylePlain target:self action:@selector(addFriendsButtonAction:)];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"设置" style:UIBarButtonItemStylePlain target:self action:@selector(settingButtonAction:)];
    
    myTableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, UISCREEN_WIDTCH, UISCREEN_HEIGHT) style:UITableViewStyleGrouped];
    myTableView.delegate = self;
    myTableView.dataSource = self;
    [self.view addSubview:myTableView];
    
    [myTableView registerNib:[UINib nibWithNibName:@"MyTableViewCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"MyTableViewCell"];
    
}
#pragma mark uitableviewdelegate
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section ==0 && indexPath.row ==0) {
        return 150;
    }else{
        return 44;
    }
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return dataSource.count+1;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (section ==0) {
        return 1;
    }
    NSArray *arr = dataSource[section-1];
    return arr.count;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section >= 1) {
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"reuse"];
        if (!cell) {
            cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"reuse"];
        }
        cell.textLabel.text = dataSource[indexPath.section-1][indexPath.row];
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        cell.imageView.image = imageArray[indexPath.section-1][indexPath.row];
        return cell;
    }else{
        MyTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"MyTableViewCell"];
        [cell.headImageView setImageWithURL:[NSURL URLWithString:user.profile_image_url] placeholder:[UIImage imageNamed:@"head"]];
        cell.nameLabel.text = user.name;
        if ([user.userDescription isEqualToString:@""]) {
            cell.introduceLabel.text = [NSString stringWithFormat:@"简介：暂无介绍"];
        }else{
            cell.introduceLabel.text = [NSString stringWithFormat:@"简介：%@",user.userDescription];
        }
        [cell.weiBoButton setTitle:[NSString stringWithFormat:@" %@\n微博",user.statuses_count] forState:UIControlStateNormal];
        [cell.attentionButton setTitle:[NSString stringWithFormat:@" %@\n关注",user.friends_count] forState:UIControlStateNormal];
        [cell.fansButton setTitle:[NSString stringWithFormat:@" %@\n粉丝",user.followers_count] forState:UIControlStateNormal];

        [cell.weiBoButton addTarget:self action:@selector(weiBoButtonAction:) forControlEvents:UIControlEventTouchUpInside];
        [cell.attentionButton addTarget:self action:@selector(attentionButtonAction:) forControlEvents:UIControlEventTouchUpInside];
        [cell.fansButton addTarget:self action:@selector(fansButtonAction:) forControlEvents:UIControlEventTouchUpInside];
        return cell;
    }
    
}
-(void)weiBoButtonAction:(UIButton *)sender{
    UIWebViewViewController *webvIEW = [UIWebViewViewController new];
        NSString *url = [NSString stringWithFormat:@"http://m.weibo.cn/u/%@",user.uid];
        webvIEW.url =[NSURL URLWithString:url] ;
    [self.navigationController pushViewController:webvIEW animated:NO];
}
-(void)attentionButtonAction:(UIButton *)sender{
    
}
-(void)fansButtonAction:(UIButton *)sender{
    
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 5;
}
-(void)addFriendsButtonAction:(UIBarButtonItem *)sender{
    AddFriendViewController *add = [AddFriendViewController new];
    [self.navigationController pushViewController:add animated:NO];
}
-(void)settingButtonAction:(UIBarButtonItem *)sender{
    SettingViewController *setting = [SettingViewController new];
    [self.navigationController pushViewController:setting animated:NO];
}
#pragma mark wbhttpdelegate
- (void)request:(WBHttpRequest *)request didReceiveResponse:(NSURLResponse *)response{
    NSLog(@"response = %@",response);
}
- (void)request:(WBHttpRequest *)request didFailWithError:(NSError *)error{
    NSLog(@"error = %@",error);
}

- (void)request:(WBHttpRequest *)request didFinishLoadingWithResult:(NSString *)result{
    NSLog(@"result = %@",result);
}
- (void)request:(WBHttpRequest *)request didFinishLoadingWithDataResult:(NSData *)data{
    NSLog(@"data = %@",data);
    NSError *error;
    NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:&error];
    if (error) {
        NSLog(@"error = %@",error);
    }else{
        user = [User shareUser];
        [user modelSetWithJSON:dic];
        [myTableView reloadData];
    }
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
