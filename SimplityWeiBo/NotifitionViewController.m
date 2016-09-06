//
//  NotifitionViewController.m
//  SimplityWeiBo
//
//  Created by Macx on 16/8/10.
//  Copyright © 2016年 Macx. All rights reserved.
//

#import "NotifitionViewController.h"

@interface NotifitionViewController ()<UITableViewDelegate,UITableViewDataSource>
{
    NSArray *dataSource;
    NSArray *detailText;
    NSArray *switchView;
}
@end

@implementation NotifitionViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setUI];
}
-(void)setUI{
    self.title = @"通知";
    UITableView *myTableView = [[UITableView alloc]initWithFrame:self.view.frame style:UITableViewStyleGrouped];
    myTableView.delegate = self ;
    myTableView.dataSource = self;
    [self.view addSubview:myTableView];
    
    dataSource = @[@[@"@我的",@"评论",@"赞",@"消息",@"群通知",@"未关注人消息",@"新粉丝"],@[@"好友圈微博",@"特别关注微博",@"群微博",@"微博热点"],@[@"免打扰设置",@"获取新消息"]];
    detailText = @[@[@"所有人",@"所有人",@"",@"switch",@"switch",@"我关注的人",@"所有人"],@[@"switch",@"智能通知",@"switch",@"switch"],@[@"",@"每2分钟"]];
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 3;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    NSArray *arr = dataSource[section];
    return arr.count;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"reuse"];
    if (!cell) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"reuse"];
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
       
        
    }
    cell.textLabel.text = dataSource[indexPath.section][indexPath.row];
    NSString *string = detailText[indexPath.section][indexPath.row];
    if ([string isEqualToString:@"switch"]) {
        cell.accessoryView = [UISwitch new];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }else{
        cell.detailTextLabel.text = string;
    }
    return cell;
}
-(NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
    NSArray *arr = @[@"",@"新微博推送通知",@""];
    return arr[section];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
@end
