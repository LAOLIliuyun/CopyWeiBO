//
//  SignViewController.m
//  SimplityWeiBo
//
//  Created by Macx on 16/8/16.
//  Copyright © 2016年 Macx. All rights reserved.
//

#import "SignViewController.h"
#import <CoreLocation/CoreLocation.h>
#import <WeiboSDK.h>
#import "SuggetionViewController.h"
@interface SignViewController ()<UITableViewDelegate,UITableViewDataSource,CLLocationManagerDelegate,WBHttpRequestDelegate>
{
    NSMutableArray *dataSource;;
    NSMutableArray *detailSource;
    NSString *longititude;
    NSString *latitude;
    UITableView  *myTableView;
}
@property (nonatomic,strong)CLLocationManager *cllManager;
@end

@implementation SignViewController
-(void)viewDidAppear:(BOOL)animated{
    self.navigationController.navigationBarHidden = NO;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    dataSource = [NSMutableArray array];
    detailSource = [NSMutableArray array];
    [self setUI];
    [self setLocationAction];
    [self initData];
}
-(CLLocationManager *)cllManager{
    if (!_cllManager) {
        _cllManager = [CLLocationManager new];
        _cllManager.delegate = self;
        _cllManager.distanceFilter = kCLDistanceFilterNone;
        _cllManager.desiredAccuracy = kCLLocationAccuracyKilometer;
    }return _cllManager;
}
#pragma mark CLLocationManagerDelegate
-(void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray<CLLocation *> *)locations{
    CLLocation *location = locations.lastObject;
    longititude = [NSString stringWithFormat:@"%lf",location.coordinate.longitude];
   latitude = [NSString stringWithFormat:@"%lf",location.coordinate.latitude];
}
-(void)setLocationAction{
    NSString *accetoken = [[NSUserDefaults standardUserDefaults]objectForKey:@"access_token"];
    [WBHttpRequest requestWithAccessToken:accetoken url:@"https://api.weibo.com/2/place/nearby/pois.json" httpMethod:@"GET" params:@{@"lat":@"23.20",@"long":@"113.20"} delegate:self withTag:@"1000"];
}
-(void)initData{
    NSURL *url = [NSURL URLWithString:@"https://api.weibo.com/2/place/nearby/pois.json?oauth_timestamp=1471335363&oauth_sign=21924c0&lat=23.20&long=113.20&aid=01AnVON3voDLgUEXGqe_dyoIJJRPyLYlnejpl60wNcNBuFZPg.&access_token=2.00Fj8_WG0Vemcwebedfd92c9KbYfcE"];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    NSURLSession *session = [NSURLSession sessionWithConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration]];
    NSURLSessionDataTask *task = [session dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:nil];
         NSArray *datArray = dic[@"pois"];
        for (int i = 0; i < datArray.count; i++) {
            NSString *detail = [NSString stringWithFormat:@"%@人去过：%@",datArray[i][@"district_info"][@"checkin_user_num"],datArray[i][@"address"]];
            NSString *dataText =datArray[i][@"title"];
            [detailSource addObject:detail];
            [dataSource  addObject:dataText];
            dispatch_async(dispatch_get_main_queue(), ^{
                [myTableView reloadData];
            });
        }
    }];
    [task resume];
}
-(void)setUI{
    self.title = @"我在这里";
    UITextField *textField = [[UITextField alloc]initWithFrame:CGRectMake(10,10, UISCREEN_WIDTCH-20, 44)];
    UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 44, 44)];
    UIImageView *ima = [[UIImageView alloc]initWithFrame:view.frame];
    ima.image = [UIImage imageNamed:@"search"];
    [view addSubview:ima];
    textField.leftView = view;
    
    myTableView = [[UITableView alloc]initWithFrame:self.view.frame style:UITableViewStylePlain];
    myTableView.delegate = self;
    myTableView.dataSource = self;
    myTableView.rowHeight = 80;
    [self.view addSubview:myTableView];
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    SuggetionViewController *sug = [SuggetionViewController new];
    sug.type = JumpFromSignViewController;
    sug.text = dataSource[indexPath.row];
    [self.navigationController pushViewController:sug animated:NO];
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return dataSource.count;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:@"reuse"];
    if (!cell) {
        cell=[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"reuse"];
    }
    cell.textLabel.text = dataSource[indexPath.row];
    cell.detailTextLabel.text = detailSource[indexPath.row];
    return cell;
}
-(void)request:(WBHttpRequest *)request didFailWithError:(NSError *)error{
    NSLog(@"error = %@",error);
}
-(void)request:(WBHttpRequest *)request didReceiveResponse:(NSURLResponse *)response{
    NSLog(@"sponse = %@",response);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
@end
