//
//  AppDelegate.h
//  SimplityWeiBo
//
//  Created by Macx on 16/8/8.
//  Copyright © 2016年 Macx. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MainTabBarViewController.h"
@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;
@property (nonatomic,strong)NSString *user_id;
@property (nonatomic,strong)NSString *access_token1;

@property (nonatomic,strong)MainTabBarViewController *mainVC;
@property (nonatomic,strong)UINavigationController *homeVC;
@property (nonatomic,strong)UINavigationController *issueVC;
@property (nonatomic,strong)UINavigationController *myVC;
@end

