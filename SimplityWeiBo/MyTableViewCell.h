//
//  MyTableViewCell.h
//  SimplityWeiBo
//
//  Created by Macx on 16/8/10.
//  Copyright © 2016年 Macx. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MyTableViewCell : UITableViewCell
@property (strong, nonatomic) IBOutlet UIImageView *headImageView;
@property (strong, nonatomic) IBOutlet UILabel *nameLabel;
@property (strong, nonatomic) IBOutlet UILabel *introduceLabel;
@property (strong, nonatomic) IBOutlet UIButton *VIPButton;
@property (strong, nonatomic) IBOutlet UIButton *weiBoButton;
@property (strong, nonatomic) IBOutlet UIButton *attentionButton;
@property (strong, nonatomic) IBOutlet UIButton *fansButton;

@end
