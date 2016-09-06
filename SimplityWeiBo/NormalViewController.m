//
//  NormalViewController.m
//  SimplityWeiBo
//
//  Created by Macx on 16/8/10.
//  Copyright © 2016年 Macx. All rights reserved.
//

#import "NormalViewController.h"

@interface NormalViewController ()<UITableViewDataSource,UITableViewDelegate>
{
    NSArray *dataSource;
    NSArray *detailText;
    UITableView *myTableView;
}

@end

@implementation NormalViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setUI];
}
-(void)setUI{
    self.title = @"通用设置";
    myTableView = [[UITableView alloc]initWithFrame:self.view.frame style:UITableViewStyleGrouped];
    myTableView.delegate = self;
    myTableView.dataSource = self;
    [self.view addSubview:myTableView];
    
    dataSource = @[
  @[@"阅读模式",@"字号设置",@"显示备注信息"],
  @[@"开启快速拖动"],
  @[@"横竖屏自动切换"],
  @[@"图片浏览设置",@"视频自动播放设置"],
  @[@"WiFi下自动下载微博安装包"],
  @[@"声音与震动",@"多语言环境"]];
    detailText = @[
  @[@"有图模式",@"中",@"switch"],
  @[@"switch"],
  @[@"switch"],
  @[@"自适应",@"关闭"],
  @[@"switch"],
  @[@"",@"简单中文"]];
}
#pragma mark uiTableViewDelegate
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return dataSource.count;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    NSArray *arr = dataSource[section];
    return arr.count;
    
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"reuse"];
    if (!cell) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"reuse"];
    }
    cell.textLabel.text = dataSource[indexPath.section][indexPath.row];
    NSString *string = detailText[indexPath.section][indexPath.row];
    if ([string isEqualToString:@"switch"]) {
        cell.accessoryView = [UISwitch new];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }else{
        cell.detailTextLabel.text = string;
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    }
    
    
    return cell;
}
-(CGFloat)tableView:(UITableView *)tableView estimatedHeightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 5;
}
-(NSString *)tableView:(UITableView *)tableView titleForFooterInSection:(NSInteger)section{
    if (section == 1) {
        return @"浏览列表时可使用拖动条快速拖动";
    }
    return nil;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}
@end
