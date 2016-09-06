//
//  SuggetionViewController.h
//  SimplityWeiBo
//
//  Created by Macx on 16/8/10.
//  Copyright © 2016年 Macx. All rights reserved.
//

#import "LWNViewController.h"
typedef NS_ENUM (NSInteger ,Type) {
    JumpFromSendingText ,//发微博
    JumpFromSettingAfterLogin,  //设置页面跳转
    JumpfromSendingTextAndImage,//图文微博
    JumpFromSignViewController,//签到页
};

@interface SuggetionViewController : LWNViewController
@property (nonatomic,assign)Type type;
@property (nonatomic,strong)UIImage *chooseImage;
@property (nonatomic,strong)NSString *text;
@end
