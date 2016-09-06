//
//  contectViewController.m
//  SimplityWeiBo
//
//  Created by Macx on 16/8/17.
//  Copyright © 2016年 Macx. All rights reserved.
//

#import "contectViewController.h"
#import <WeiboSDK.h>
#import <UIImageView+YYWebImage.h>//图片缓存
@interface contectViewController ()<UITableViewDelegate,UITableViewDataSource,WBHttpRequestDelegate>
{
    NSMutableArray *dataSource;
    NSMutableArray *imageArray;
    NSArray *titileArray;
    UITableView *myTableView;
}

@end

@implementation contectViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    dataSource = [NSMutableArray array];
    imageArray = [NSMutableArray array];
    [self setUI];
    [self initData1];
    [self initData];
}
-(void)setUI{
    self.title = @"联系人";
    myTableView = [[UITableView alloc]initWithFrame:self.view.frame style:UITableViewStyleGrouped];
    myTableView.delegate = self;
    myTableView.dataSource = self;
    myTableView.rowHeight = 60;
    [self.view addSubview:myTableView];
}
-(void)initData1{
    NSString *accetoken = [[NSUserDefaults standardUserDefaults]objectForKey:@"access_token"];
    NSString *uid = [[NSUserDefaults standardUserDefaults]objectForKey:@"userID"];
    [WBHttpRequest requestWithAccessToken:accetoken url:@"https://api.weibo.com/2/friendships/friends.json" httpMethod:@"GET" params:@{@"uid":uid} delegate:self withTag:@"1071"];
}
-(void)initData{
    NSURL *url = [NSURL URLWithString:@"https://api.weibo.com/2/friendships/friends.json?oauth_sign=0dfe9fd&uid=5974274559&aid=01AnVON3voDLgUEXGqe_dyoIJJRPyLYlnejpl60wNcNBuFZPg.&access_token=2.00Fj8_WG0Vemcwebedfd92c9KbYfcE&oauth_timestamp=1471403312"];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    NSURLSession *session = [NSURLSession sessionWithConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration]];
    NSURLSessionDataTask *task = [session dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:nil];
        NSArray *datArray = dic[@"users"];
        for (int i = 0; i < datArray.count; i++) {
            NSString *text = datArray[i][@"screen_name"];
            NSString *ima = datArray[i][@"avatar_large"];
            [dataSource addObject:text];
            [imageArray addObject:ima];
            dispatch_async(dispatch_get_main_queue(), ^{
                [myTableView reloadData];
            });
        }
    }];
    [task resume];
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
     return dataSource.count;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"reuse"];
    if (!cell) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"reuse"];
    }
    cell.textLabel.text = dataSource[indexPath.row];
    [cell.imageView setImageWithURL:[NSURL URLWithString:imageArray[indexPath.row]] placeholder:[UIImage imageNamed:@"head"]];
    return cell;
}
-(void)request:(WBHttpRequest *)request didReceiveResponse:(NSURLResponse *)response{
    NSLog(@"rrrrrr = %@",response);
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
@end
