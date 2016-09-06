//
//  AboutWeiboViewController.m
//  SimplityWeiBo
//
//  Created by Macx on 16/8/10.
//  Copyright © 2016年 Macx. All rights reserved.
//

#import "AboutWeiboViewController.h"

@interface AboutWeiboViewController ()<UITableViewDelegate,UITableViewDataSource>
{
    NSArray *dataSource;
}
@end

@implementation AboutWeiboViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setUI];

}
-(void)viewWillAppear:(BOOL)animated{
    self.tabBarController.tabBar.hidden = YES;
}
-(void)setUI{
    self.title = @"关于微博";
    UIImageView *headImageView = [[UIImageView alloc]initWithFrame:CGRectMake(UISCREEN_WIDTCH/2-40, 84, 80, 60)];
    headImageView.image = [UIImage imageNamed:@"weiboIcon"];
    [self.view addSubview:headImageView];
    
    UILabel *wbLabel = [[UILabel alloc]initWithFrame:CGRectMake(UISCREEN_WIDTCH/2-30, 150, 60, 40)];
    wbLabel.text = @"微博";
    wbLabel.textAlignment = NSTextAlignmentCenter;
    wbLabel.font = [UIFont systemFontOfSize:30];
    [self.view addSubview:wbLabel];
    
    UILabel *versionLabel = [[UILabel alloc]initWithFrame:CGRectMake(UISCREEN_WIDTCH/2-30, 190, 60, 20)];
    versionLabel.text = @"6.8.0版";
    versionLabel.textColor = [UIColor redColor];
    versionLabel.textAlignment = NSTextAlignmentCenter;
    versionLabel.font = [UIFont systemFontOfSize:10];
    [self.view addSubview:versionLabel];
    
    UIImageView *phoneImageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 386, UISCREEN_WIDTCH, UISCREEN_HEIGHT-386)];
    phoneImageView.image = [UIImage imageNamed:@"connect"];
    [self.view addSubview:phoneImageView];
    
    UITableView *myTableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 210, UISCREEN_WIDTCH, 176) style:UITableViewStylePlain];
    myTableView.delegate = self;
    myTableView.dataSource = self;
    myTableView.scrollEnabled = NO;
    [self.view addSubview:myTableView];
    
    dataSource = @[@"给我评分",@"官方微博",@"常见问题",@"版本更新"];

}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 4;
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
