//
//  SuggetionViewController.m
//  SimplityWeiBo
//
//  Created by Macx on 16/8/10.
//  Copyright © 2016年 Macx. All rights reserved.
//

#import "SuggetionViewController.h"
#import "User.h"
#import <WeiboSDK.h>
#import "contectViewController.h"
#import "EmotionCollectionViewCell.h"
#import <UIImageView+YYWebImage.h>

@interface SuggetionViewController ()<UITextViewDelegate,WBHttpRequestDelegate,UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>
{
    UITextView *textViewIn;
    UIButton *positionButton;
    UIView *showImageView;
    NSMutableArray *dataSource;
    NSMutableArray *emotionDataSource;
    UICollectionView *emotionCollectionView;
    UIView *emotionView;
}


@end

@implementation SuggetionViewController
-(void)viewWillAppear:(BOOL)animated{
    if (_type == 0 || _type ==2) {
        self.navigationController.navigationBarHidden = NO;
    }
}
- (void)viewDidLoad {
    [super viewDidLoad];
    dataSource=[NSMutableArray array];
    emotionDataSource = [NSMutableArray array];
    [self setUI];
}
-(void)setUI{
    User *user = [User shareUser];
    UILabel *yijianLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 200, 30)];
    yijianLabel.textAlignment = NSTextAlignmentCenter;
    UILabel *name = [[UILabel alloc]initWithFrame:CGRectMake(0, 30, 200, 14)];
    name.text = user.name;
    name.textAlignment = NSTextAlignmentCenter;
    name.textColor = [UIColor lightGrayColor];
    UIView *view = [[UIView alloc]initWithFrame:CGRectMake(UISCREEN_WIDTCH/2-100, 0, 200, 44)];
    [view addSubview:yijianLabel];
    [view addSubview:name];
     self.navigationItem.titleView = view;
    
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"取消" style:UIBarButtonItemStylePlain target:self     action:@selector(leftBarButtonItemAction:)];
    UIView *view1= [[UIView alloc]initWithFrame:CGRectMake(0, 0, 60, 30)];
    UIButton *sure = [UIButton buttonWithType:UIButtonTypeSystem];
    sure.frame = view1.frame;
    [sure setTitle:@"发送" forState:UIControlStateNormal];
    [sure setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
    sure.layer.borderWidth = 1;
    sure.layer.borderColor = [UIColor lightGrayColor].CGColor;
    [sure addTarget:self action:@selector(sendMessageButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    [view1 addSubview:sure];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:view1];
    
    textViewIn = [[UITextView alloc]initWithFrame:self.view.frame textContainer:nil];
    textViewIn.delegate = self;
    textViewIn.font = [UIFont systemFontOfSize:40];
    textViewIn.textColor = [UIColor lightGrayColor];
    textViewIn.backgroundColor = [UIColor whiteColor];
    
    [self.view addSubview:textViewIn];
    
    NSArray *textArray = @[[UIImage imageNamed:@"picture"],[UIImage imageNamed:@"@"],[UIImage imageNamed:@"topic"],[UIImage imageNamed:@"emoji"],[UIImage imageNamed:@"add"]];
    for (int i =0; i<5; i++) {
        UIButton *button = [UIButton buttonWithType:UIButtonTypeSystem];
        button.frame = CGRectMake(UISCREEN_WIDTCH/5*i, UISCREEN_HEIGHT-50, UISCREEN_WIDTCH/5, 50);
        [button setImage:[textArray[i] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] forState:UIControlStateNormal];
        [button addTarget:self action:@selector(buttonAction:) forControlEvents:UIControlEventTouchUpInside];
        button.tag = 1000+i;
        [self.view addSubview:button];
    }
    
    CGRect rect = [self.text boundingRectWithSize:CGSizeMake(210, 30) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:15]} context:nil];
    UIView *leftView = [[UIView alloc]initWithFrame:CGRectMake(10, UISCREEN_HEIGHT-80,rect.size.width+30, 30)];
        leftView.layer.borderWidth = 2 ;
        leftView.layer.cornerRadius = 15;
        leftView.layer.borderColor = BackGroundColor.CGColor;
        leftView.backgroundColor = BackGroundColor;
        [self.view addSubview:leftView];
        
        positionButton = [UIButton buttonWithType:UIButtonTypeSystem];
        positionButton.frame = CGRectMake(25, 5,rect.size.width, 20);
        [positionButton setTitle:self.text forState:UIControlStateNormal];
        positionButton.titleLabel.font = [UIFont systemFontOfSize:15.0];
        [positionButton setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
        [leftView addSubview:positionButton];
        
        UIButton *positionImage = [UIButton buttonWithType:UIButtonTypeSystem];
        [positionImage setImage:[[UIImage imageNamed:@"location"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] forState:UIControlStateNormal];
        positionImage.frame = CGRectMake(5, 5, 20, 20);
        [leftView addSubview:positionImage];
        
        UIView *rightView = [[UIView alloc]initWithFrame:CGRectMake(UISCREEN_WIDTCH-110, UISCREEN_HEIGHT-80, 100, 30)];
        rightView.layer.borderWidth = 2 ;
        rightView.layer.cornerRadius = 15;
        rightView.layer.borderColor = BackGroundColor.CGColor;
        rightView.backgroundColor = BackGroundColor;
        [self.view addSubview:rightView];
        
        UIButton *position = [UIButton buttonWithType:UIButtonTypeSystem];
        position.frame = CGRectMake(25, 5, 80, 20);
        [position setTitle:@"公开" forState:UIControlStateNormal];
        position.titleLabel.font = [UIFont systemFontOfSize:15.0];
        [rightView addSubview:position];
        
        UIButton *positionImg = [UIButton buttonWithType:UIButtonTypeSystem];
        [positionImg setImage:[UIImage imageNamed:@"global"] forState:UIControlStateNormal];
        positionImg.frame = CGRectMake(5, 5, 20, 20);
        [rightView addSubview:positionImg];

    
    if (_type ==0 || _type ==2) {
        yijianLabel.text = @"发微博";
        textViewIn.text = @"分享新鲜事";
        UIImageView *textAndImageView = [[UIImageView alloc]initWithFrame:CGRectMake(30, UISCREEN_HEIGHT/2, 100, 100)];
        textAndImageView.image = self.chooseImage;
        [textViewIn addSubview:textAndImageView];
    }else if (_type == 3){
        yijianLabel.text = @"签到";
    }
    else{
        yijianLabel.text = @"意见反馈";
        textViewIn.text = @"说点儿什么吧.........";
    }

}
-(void)buttonAction:(UIButton *)sender{
    if (sender.tag == 1001) {
        contectViewController *con = [contectViewController new];
        [self.navigationController pushViewController:con animated:NO];
    }else if (sender.tag ==1003){
        sender.selected = ! sender.selected;
        if (sender.selected) {
            [textViewIn becomeFirstResponder];
            emotionView = [[UIView alloc]initWithFrame:CGRectMake(0, UISCREEN_HEIGHT/2, UISCREEN_WIDTCH, 250)];
            emotionView.layer.borderColor = [UIColor lightGrayColor].CGColor;
            emotionView.layer.borderWidth = 2;
            [self initData];
            [self setCollectionAction];
            emotionView.hidden = NO;
            [self.view addSubview:emotionView];
        }else{
            emotionView.hidden = YES;
            [emotionView removeFromSuperview];
        }
     }
}
-(void)sendMessageButtonAction:(UIButton *)sender{
    if (_type == 0) {
        NSString *accetoken = [[NSUserDefaults standardUserDefaults]objectForKey:@"access_token"];
        [WBHttpRequest requestWithAccessToken:accetoken url:@"https://api.weibo.com/2/statuses/update.json" httpMethod:@"POST" params:@{@"status":textViewIn.text} delegate:self withTag:@"100"];
    }else if (_type == 2){
        NSString *accetoken = [[NSUserDefaults standardUserDefaults]objectForKey:@"access_token"];
        [WBHttpRequest requestWithAccessToken:accetoken url:@"https://upload.api.weibo.com/2/statuses/upload.json" httpMethod:@"POST" params:@{@"status":textViewIn.text,@"pic":self.chooseImage} delegate:self withTag:@"104"];
        
    }
}
-(void)leftBarButtonItemAction:(UIBarButtonItem *)sender{
    [self.navigationController popViewControllerAnimated:NO];
}
#pragma mark UITextViewDelagate
-(BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text{
    if (textViewIn.text.length ==0) {
        textViewIn.textColor = [UIColor lightGrayColor];
    }else{
        textViewIn.textColor = [UIColor blackColor];
    }
    return YES;
}
-(void)textViewDidBeginEditing:(UITextView *)textView{
    textViewIn.text = @"";
}
-(void)textViewDidEndEditing:(UITextView *)textView{
    textViewIn.text = @"说点儿什么吧.........";
}
- (void)request:(WBHttpRequest *)request didReceiveResponse:(NSURLResponse *)response{
    NSLog(@"response = %@",response);
}
- (void)request:(WBHttpRequest *)request didFailWithError:(NSError *)error{
    NSLog(@"error = %@",error);
}

- (void)request:(WBHttpRequest *)request didFinishLoadingWithResult:(NSString *)result{
    NSLog(@"result = %@",result);
    [self.navigationController popToRootViewControllerAnimated:NO];
    self.tabBarController.selectedIndex = 1;
}
-(void)initData{
    NSURL *url = [NSURL URLWithString:@"https://api.weibo.com/2/emotions.json?oauth_sign=7e9c575&aid=01AnVON3voDLgUEXGqe_dyoIJJRPyLYlnejpl60wNcNBuFZPg.&oauth_timestamp=1471416363&access_token=2.00Fj8_WG0Vemcwebedfd92c9KbYfcE"];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    NSURLSession *session = [NSURLSession sessionWithConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration]];
    NSURLSessionDataTask *task = [session dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        NSArray *array = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:nil];
        for (int i = 0; i < array.count; i++) {
            NSString *string = array[i][@"icon"];
            [emotionDataSource addObject:string];
        }
   
        for (int j=0; j<emotionDataSource.count/28; j++) {
            [emotionDataSource insertObject:@"search" atIndex:27+28*j];
        }
        dispatch_async(dispatch_get_main_queue(), ^{
            [emotionCollectionView reloadData];
        });
    }];
    [task resume];
}

-(void)setCollectionAction{
    UICollectionViewFlowLayout *flow = [[UICollectionViewFlowLayout alloc]init];
    flow.itemSize = CGSizeMake(UISCREEN_WIDTCH/11, UISCREEN_WIDTCH/11);
//    flow.minimumLineSpacing = 20;
//    flow.minimumInteritemSpacing = 20;
    flow.scrollDirection = UICollectionViewScrollDirectionHorizontal;

    
    emotionCollectionView = [[UICollectionView alloc]initWithFrame:CGRectMake(0, 0, UISCREEN_WIDTCH, 250) collectionViewLayout:flow];
    emotionCollectionView.delegate = self;
    emotionCollectionView.dataSource = self;
    emotionCollectionView.backgroundColor = [UIColor yellowColor];
    emotionCollectionView.bounces = YES;
    emotionCollectionView.pagingEnabled = YES;
    [emotionView addSubview:emotionCollectionView];
    
    [emotionCollectionView registerNib:[UINib nibWithNibName:@"EmotionCollectionViewCell" bundle:[NSBundle mainBundle]] forCellWithReuseIdentifier:@"EmotionCollectionViewCell"];
    
}
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    if ([emotionDataSource[indexPath.row] isEqualToString:@"search"]) {
        if (textViewIn.selectedRange.location >0) {
            [textViewIn.textStorage deleteCharactersInRange:NSMakeRange(textViewIn.selectedRange.location-1,1)];
        }
      }else{
        NSTextAttachment *attach = [NSTextAttachment new];
        attach.image = [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:emotionDataSource[indexPath.row]]]];
        NSAttributedString *text = [NSAttributedString attributedStringWithAttachment:attach]
        ;
        NSLog(@"location = %ld",textViewIn.selectedRange.location);
        [textViewIn.textStorage insertAttributedString:text atIndex:textViewIn.selectedRange.location];
        NSUInteger length = textViewIn.selectedRange.location + 1;
        textViewIn.selectedRange = NSMakeRange(length,0);
    }
}
-(CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section{
    return 20;
}
-(UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section{
    return UIEdgeInsetsMake(15,10,10,21);
}
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return emotionDataSource.count;

}
-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    EmotionCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"EmotionCollectionViewCell" forIndexPath:indexPath];
    
    [cell.emotionButton setTitle:@"" forState:UIControlStateNormal];
    cell.emotionButton.hidden = YES;
    if ([emotionDataSource[indexPath.row] isEqualToString:@"search"]) {
        cell.emotionImageView.image = [[UIImage imageNamed:@"search"]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    }else{
        [cell.emotionImageView setImageWithURL:[NSURL URLWithString:emotionDataSource[indexPath.row]] placeholder:[UIImage imageNamed:@"progresshud_background"]];
    }
    return cell;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
@end
