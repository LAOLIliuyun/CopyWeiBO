//
//  NormalSettingViewController.m
//  SimplityWeiBo
//
//  Created by Macx on 16/8/9.
//  Copyright © 2016年 Macx. All rights reserved.
//

#import "NormalSettingViewController.h"

@interface NormalSettingViewController ()<UITableViewDelegate,UITableViewDataSource>
{
    
    NSArray *dataSource;
}
@end

@implementation NormalSettingViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setUI];
}
-(void)viewWillAppear:(BOOL)animated{
    self.tabBarController.tabBar.hidden = YES;
}
-(void)setUI{
    self.title = @"通用设置";
    UIView *setView = [[UIView alloc]initWithFrame:CGRectMake(0, 100, UISCREEN_WIDTCH, 44)];
    setView.backgroundColor = [UIColor whiteColor];
    UILabel *setLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 120, 44)];
    setLabel.text = @"开启快速拖动";
    setLabel.textAlignment = NSTextAlignmentCenter
    ;
    [setView addSubview:setLabel];
    
    UISwitch *switchButton = [[UISwitch alloc]initWithFrame:CGRectMake(UISCREEN_WIDTCH-60, 7, 0, 0)];
    [setView addSubview:switchButton];
    [self.view addSubview:setView];
    
    UILabel *explainLabel = [[UILabel alloc]initWithFrame:CGRectMake(10, 147, UISCREEN_WIDTCH-10, 11)];
    explainLabel.text = @"浏览列表时可使用拖动条快速拖动。";
    explainLabel.font = [UIFont systemFontOfSize:10];
    [self.view addSubview:explainLabel];
    
    UITableView *myTableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 160, UISCREEN_WIDTCH, 1500) style:UITableViewStyleGrouped];
    myTableView.delegate = self;
    myTableView.dataSource = self;
    [self.view addSubview:myTableView];
    myTableView.scrollEnabled = NO;
    dataSource = @[@[@"视频自动播放设置"],@[@"WiFi下自动下载微博安装包",@"声音与震动",@"多语言环境"]];
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (section ==0) {
        return 1;
    }else {
        return 3;
    }
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 2;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"reuse"];
    if (!cell) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"reuse"];
    }
    cell.textLabel.text = dataSource[indexPath.section][indexPath.row];
    if (indexPath.section == 0 && indexPath.row ==0) {
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        cell.detailTextLabel.text = @"关闭";
    }else if (indexPath.section ==1){
        if (indexPath.row ==0) {
            cell.accessoryView = [UISwitch new];
            
        }else if (indexPath.row ==1){
            cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        }
        else if (indexPath.row ==2){
            cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
            cell.detailTextLabel.text = @"简体中文";
        }
    }
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
