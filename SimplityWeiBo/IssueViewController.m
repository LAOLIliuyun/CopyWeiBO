//
//  IssueViewController.m
//  SimplityWeiBo
//
//  Created by Macx on 16/8/9.
//  Copyright © 2016年 Macx. All rights reserved.
//

#import "IssueViewController.h"
#import "HomeViewController.h"
#import "MainNavigationViewController.h"
#import "DateModel.h"
#import "SuggetionViewController.h"
#import "SignViewController.h"

@interface IssueViewController ()<UINavigationControllerDelegate, UIImagePickerControllerDelegate>
{
    UILabel *weatherLabel;
    UILabel *dayLabel;
    UILabel *monthYearLabel;
    UIImagePickerController *piker;
}
@end

@implementation IssueViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setUI];
    [self initData];
}
-(void)setUI{
    NSArray *imageArray = @[[UIImage imageNamed:@"word"],[UIImage imageNamed:@"image"],[UIImage imageNamed:@"topline"],[UIImage imageNamed:@"checkin"],[UIImage imageNamed:@"video"],[UIImage imageNamed:@"issue_more"]];
    NSArray *textArray = @[@"文字",@"照片/视频",@"头条文章",@"签到",@"直播",@"更多"];
    for (int i = 0; i <2; i++) {
        for (int j = 0; j<3; j++) {
            UIButton *imageButton = [UIButton buttonWithType:UIButtonTypeSystem];
            UIButton *textButton = [UIButton buttonWithType:UIButtonTypeSystem];
            imageButton.frame = CGRectMake(UISCREEN_WIDTCH/10*(3*j+1), UISCREEN_HEIGHT/2+(80+UISCREEN_WIDTCH/5)*i, UISCREEN_WIDTCH/5, UISCREEN_WIDTCH/5);
            textButton.frame = CGRectMake(UISCREEN_WIDTCH/10*(3*j+1), UISCREEN_HEIGHT/2+UISCREEN_WIDTCH/5+(80+UISCREEN_WIDTCH/5)*i, UISCREEN_WIDTCH/5, 40);
            [imageButton setImage:[imageArray[3*i+j] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] forState:UIControlStateNormal];
            [textButton setTitle:textArray[3*i+j] forState:UIControlStateNormal];
            [textButton setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
            textButton.tag = 1000+(3*i+j);
            imageButton.tag = 1000 + (3*i+j);
            [textButton addTarget:self action:@selector(senderButtonAction:) forControlEvents:UIControlEventTouchUpInside];
            [imageButton addTarget:self action:@selector(senderButtonAction:) forControlEvents:UIControlEventTouchUpInside];
            [self.view addSubview:textButton];
            [self.view addSubview:imageButton];
        }
    }
    
    UIButton *backButton = [UIButton buttonWithType:UIButtonTypeSystem];
    backButton.frame = CGRectMake(0, UISCREEN_HEIGHT-44, UISCREEN_WIDTCH, 44);
    [backButton setImage:[[UIImage imageNamed:@"back"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] forState:UIControlStateNormal];
    [backButton setBackgroundColor:[UIColor whiteColor]];
    [backButton addTarget:self action:@selector(backButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:backButton];
    
    weatherLabel = [[UILabel alloc]initWithFrame:CGRectMake(30, 100, 200, 15)];
    [weatherLabel setFont:[UIFont systemFontOfSize:15]];
    [self.view addSubview:weatherLabel];
    
    dayLabel = [[UILabel alloc]initWithFrame:CGRectMake(30, 30, 60, 60)];
    [dayLabel setFont:[UIFont systemFontOfSize:50]];
    [self.view addSubview:dayLabel];
    
    monthYearLabel = [[UILabel alloc]initWithFrame:CGRectMake(90, 60, 80, 15)];
    [monthYearLabel setFont:[UIFont systemFontOfSize:15]];
    [self.view addSubview:monthYearLabel];
    
    NSDate *date = [NSDate date];
   UILabel *weekLabel = [[UILabel alloc]initWithFrame:CGRectMake(90, 30, 100, 15)];
    weekLabel.text =[DateModel weekdayStringFromDate:date];
    [weekLabel setFont:[UIFont systemFontOfSize:15]];
    [self.view addSubview:weekLabel];

    UIImageView *adImageView = [[UIImageView alloc]initWithFrame:CGRectMake(200, 30, UISCREEN_WIDTCH-230, 150)];
    adImageView.image = [UIImage imageNamed:@"issue_AD"];
    [self.view addSubview:adImageView];
}
-(void)senderButtonAction:(UIButton *)sender{
    if (sender.tag == 1000 ) {
        SuggetionViewController *sug = [SuggetionViewController new];
        sug.type = JumpFromSendingText;
        [self.navigationController pushViewController:sug animated:NO];
    }else if( sender.tag ==1001){
        [self setImagePikerViewControllerAction];
    }else if (sender.tag ==1003){
        SignViewController *sign = [SignViewController new];
        [self.navigationController pushViewController:sign animated:NO];
    }
}
-(void)setImagePikerViewControllerAction{
    if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypePhotoLibrary]) {
        NSLog(@"可以");
    }
    piker = [[UIImagePickerController alloc]init];
    piker.view.backgroundColor = [UIColor yellowColor];
    UIImagePickerControllerSourceType sourceType=UIImagePickerControllerSourceTypePhotoLibrary;
    piker.sourceType = sourceType;
    piker.delegate = self;
    piker.editing = YES;
    [self presentViewController:piker animated:NO completion:nil];
}
-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info{
    
    [self dismissViewControllerAnimated:YES completion:nil];
    UIImage *image = [info valueForKey:UIImagePickerControllerOriginalImage];
    SuggetionViewController *sug = [SuggetionViewController new];
    sug.chooseImage =image;
    sug.type = JumpfromSendingTextAndImage;
    [self.navigationController pushViewController:sug animated:NO];

    NSLog(@"ssss");
}
-(void)imagePickerControllerDidCancel:(UIImagePickerController *)picker{
    [self dismissViewControllerAnimated:YES completion:nil];
    
 
}
-(void)initData{
    NSString *string = @"https://api.thinkpage.cn/v3/weather/now.json?key=0fxynmipxnv3zfza&location=guangzhou&language=zh-Hans&unit=c";
    NSURL *url = [NSURL URLWithString:string];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    NSURLSession *session = [NSURLSession sharedSession];
    NSURLSessionDataTask *task = [session dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        dispatch_sync(dispatch_get_main_queue(), ^{
            NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:nil];
            
            weatherLabel.text = [NSString stringWithFormat:@"%@：%@ %@℃",dic[@"results"][0][@"location"][@"name"],dic[@"results"][0][@"now"][@"text"],dic[@"results"][0][@"now"][@"temperature"]];
            NSString *string =dic[@"results"][0][@"last_update"];
           NSString *year = [string substringToIndex:4];
            NSString *month = [string substringWithRange:NSMakeRange(5, 2)];
            NSString *day = [string substringWithRange:NSMakeRange(8, 2)];
            dayLabel.text = day;
            monthYearLabel.text = [NSString stringWithFormat:@"%@/%@",month,year];
        });
      }];
    [task resume];
    
}

-(void)backButtonAction:(UIButton *)sender{
    [self.navigationController popToRootViewControllerAnimated:NO];
    self.tabBarController.selectedIndex = 0 ;
}
-(void)viewDidAppear:(BOOL)animated{
    self.tabBarController.tabBar.hidden = YES;
    self.navigationController.navigationBarHidden = YES;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
