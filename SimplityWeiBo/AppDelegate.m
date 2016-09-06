//
//  AppDelegate.m
//  SimplityWeiBo
//
//  Created by Macx on 16/8/8.
//  Copyright © 2016年 Macx. All rights reserved.
//

#import "AppDelegate.h"
#import <WeiboSDK.h>
#import "HomeViewController.h"
#import "IssueViewController.h"
#import "MyViewController.h"

#import "MainNavigationViewController.h"
#import "LoginViewController.h"
#import <MBProgressHUD.h>
@interface AppDelegate ()<WeiboSDKDelegate>
{
    UINavigationController *loginVC;
}
@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {

    self.window = [[UIWindow alloc]initWithFrame:[UIScreen mainScreen].bounds];
    [self.window makeKeyAndVisible];
     _mainVC = [MainTabBarViewController new];
    _homeVC = [[MainNavigationViewController alloc]initWithRootViewController:[HomeViewController new]];
    _issueVC = [[MainNavigationViewController alloc]initWithRootViewController:[IssueViewController new]];
    if ([[NSUserDefaults standardUserDefaults] objectForKey:@"access_token"]) {
        loginVC = [[MainNavigationViewController alloc]initWithRootViewController:[LoginViewController new]];
        _mainVC.viewControllers=@[_homeVC,_issueVC,loginVC];
    }else{
        _myVC = [[MainNavigationViewController alloc]initWithRootViewController:[MyViewController new]];
        _mainVC.viewControllers = @[_homeVC,_issueVC,_myVC];
    }
    NSArray *names = @[@"首页",@"",@"我的"];
    NSArray *imageName = @[[UIImage imageNamed:@"home"],[[UIImage imageNamed:@"arrow-up"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal],[UIImage imageNamed:@"user"]];
    for (int i = 0; i < _mainVC.viewControllers.count; i++) {
        _mainVC.viewControllers[i].tabBarItem.title = names[i];
        _mainVC.viewControllers[i].tabBarItem.image = imageName[i];
        if (i == 1) {
            _mainVC.viewControllers[1].tabBarItem.title = @"";
            _mainVC.viewControllers[1].tabBarItem.imageInsets = UIEdgeInsetsMake(6, 0, -6, 0);
        }
    }
    
    _mainVC.tabBar.tintColor = [UIColor orangeColor];
    self.window.rootViewController = _mainVC;
    
    [WeiboSDK enableDebugMode:YES];
    [WeiboSDK registerApp:kAPPKey];
    return YES;
}
//下面两个方法都是被别的应用打开的时候被调用
-(BOOL)application:(UIApplication *)application openURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication annotation:(id)annotation{
    return [WeiboSDK handleOpenURL:url delegate:self];
}
-(BOOL)application:(UIApplication *)application handleOpenURL:(NSURL *)url{
    return [WeiboSDK handleOpenURL:url delegate:self];
}
#pragma mark weibodelegate
-(void)didReceiveWeiboRequest:(WBBaseRequest *)request{
    NSLog(@"收到请求");
    
}
-(void)didReceiveWeiboResponse:(WBBaseResponse *)response{
    NSLog(@"收到响应");
    
    if ([response isMemberOfClass:[WBAuthorizeResponse class]]) {
        WBAuthorizeResponse *aut = (WBAuthorizeResponse *)response;
        self.access_token1 = aut.accessToken;
        self.user_id = aut.userID;
        NSLog(@"access_token = %@",aut.accessToken);
        NSLog(@"userID = %@",aut.userID);
        
        NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
        [userDefaults setObject:aut.accessToken forKey:@"access_token"];
        [userDefaults setObject:aut.userID forKey:@"userID"];
        [userDefaults synchronize];
        
        [MBProgressHUD hideHUDForView:_mainVC.viewControllers[2].view animated:YES];

        if (response.statusCode == WeiboSDKResponseStatusCodeSuccess) {
            loginVC = [[MainNavigationViewController alloc]initWithRootViewController:[LoginViewController new]];
            _mainVC.viewControllers=@[_homeVC,_issueVC,loginVC];
            _mainVC.viewControllers[2].tabBarItem.title = @"我";
            _mainVC.viewControllers[2].tabBarItem.image = [UIImage imageNamed:@"user"];
            _mainVC.selectedIndex = 0 ;
        }
    }
    
}
- (void)applicationWillResignActive:(UIApplication *)application {
    }

- (void)applicationDidEnterBackground:(UIApplication *)application {
  
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
