//
//  CounrtSaveViewController.m
//  SimplityWeiBo
//
//  Created by Macx on 16/8/10.
//  Copyright © 2016年 Macx. All rights reserved.
//

#import "CounrtSaveViewController.h"

@interface CounrtSaveViewController ()<UITableViewDelegate,UITableViewDataSource>
{
    NSArray *dataSource;
    NSArray *detailText;
}
@end

@implementation CounrtSaveViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setUI];

}
-(void)setUI{
    self.title = @"账号安全";
        UITableView *myTableView = [[UITableView alloc]initWithFrame:self.view.frame style:UITableViewStyleGrouped];
        myTableView.delegate = self;
        myTableView.dataSource = self;
        myTableView.scrollEnabled = NO;
        [self.view addSubview:myTableView];

    dataSource = @[@[@"登录名"],@[@"修改密码",@"绑定手机",@"证件信息"],@[@"登录保护",@"微盾保护"]];
    
    detailText = @[@[@"150****540"],@[@"",@"150****540",@"未绑定"],@[@"未开启",@"未开启"]];
}
#pragma mark uitableviewdelagete
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return dataSource.count;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (section == 0) {
        return 1;
    }else if (section ==1){
        return 3;
    }else{
        return 2;
    }
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"reuse"];
    if (!cell) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"reuse"];
    }
    cell.textLabel.text = dataSource[indexPath.section][indexPath.row];

        cell.detailTextLabel.text = detailText[indexPath.section][indexPath.row];
    return cell;
    
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 5;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
@end
