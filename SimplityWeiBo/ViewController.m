//
//  ViewController.m
//  SimplityWeiBo
//
//  Created by Macx on 16/8/8.
//  Copyright © 2016年 Macx. All rights reserved.
//

#import "ViewController.h"
#import <WeiboSDK.h>
#import "AppDelegate.h"

@interface ViewController ()<WBHttpRequestDelegate>
@property (strong, nonatomic) IBOutlet UILabel *access_token;
@property (strong, nonatomic) IBOutlet UITextField *sendMessageTextField;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    
    AppDelegate *a = (AppDelegate *)[UIApplication sharedApplication].delegate;
    [a addObserver:self forKeyPath:@"access_token1" options:NSKeyValueObservingOptionNew|NSKeyValueObservingOptionOld context:nil];
}
-(void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSString *,id> *)change context:(void *)context{
    if ([keyPath isEqualToString:@"access_token1"]) {
        self.access_token.text = change[NSKeyValueChangeNewKey];
    }
}
-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    self.access_token.text = [(AppDelegate *)[UIApplication sharedApplication].delegate access_token1];
 }
-(void)dealloc{
    [(AppDelegate *)[UIApplication sharedApplication].delegate removeObserver:self forKeyPath:@"access_token1"];
}

- (IBAction)sendMessagebuttonAction:(UIButton *)sender {
    [WBHttpRequest requestWithAccessToken:self.access_token.text url:@"https://api.weibo.com/2/place/pois/add_checkin.json" httpMethod:@"GET" params:@{@"status":@"80",@"long":@"80"} delegate:self withTag:@"101"];
    
    
//    WBAuthorizeRequest *authrequest = [WBAuthorizeRequest request];
//    authrequest.redirectURI = kRedirectURI;
//    authrequest.scope = @"all";
//    WBSendMessageToWeiboRequest *request = [WBSendMessageToWeiboRequest requestWithMessage:[self messageObject] authInfo:authrequest access_token:self.access_token.text];
//    [WeiboSDK sendRequest:request];
}
//-(WBMessageObject *)messageObject{
//    WBMessageObject *wbmessage = [WBMessageObject message];
//    wbmessage.text = self.sendMessageTextField.text;
//    
//    WBImageObject *imageobject = [WBImageObject object];
//    imageobject.imageData = [NSData dataWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"apple-67" ofType:@"jpg"]];
//    wbmessage.imageObject = imageobject;
//    return wbmessage;
//}
- (IBAction)loginButton:(UIButton *)sender {
    WBAuthorizeRequest *request = [WBAuthorizeRequest request];
    request.redirectURI = kRedirectURI;
    request.scope = @"all";
    request.userInfo = @{@"SSO_From":@"ViewController",@"Other_Info_1":[NSNumber numberWithInteger:123]};
    [WeiboSDK sendRequest:request];
    
}
#pragma mark WBHttpRequestDelegate
-(void)request:(WBHttpRequest*)request didReceiveResponse: (NSURLResponse *)response{
    NSLog(@"response = %@",response);
}
- (void)request:(WBHttpRequest *)request didFailWithError:(NSError *)error{
    NSLog(@"error = %@",error);
}
- (void)request:(WBHttpRequest *)request didFinishLoadingWithResult:(NSString *)result{
    NSLog(@"result = %@",result);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
