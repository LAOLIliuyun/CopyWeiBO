//
//  SwpeViewController.m
//  SimplityWeiBo
//
//  Created by Macx on 16/8/12.
//  Copyright © 2016年 Macx. All rights reserved.
//

#import "SwpeViewController.h"
#import <AVFoundation/AVFoundation.h>
@interface SwpeViewController ()<AVCaptureMetadataOutputObjectsDelegate>
{
    NSTimer *timer;
}
@property (nonatomic,strong)AVCaptureDevice *device;
@property (nonatomic,strong)AVCaptureDeviceInput *input;
@property (nonatomic,strong)AVCaptureMetadataOutput *output;
@property (nonatomic,strong)AVCaptureSession *session;
@property (nonatomic,strong)AVCaptureVideoPreviewLayer *preview;
@end

@implementation SwpeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}
- (void)setupCamera
{
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        // 耗时的操作
        // Device
        _device = [AVCaptureDevice defaultDeviceWithMediaType:AVMediaTypeVideo];
        
        // Input
        _input = [AVCaptureDeviceInput deviceInputWithDevice:self.device error:nil];
        
        // Output
        _output = [[AVCaptureMetadataOutput alloc]init];
        [_output setMetadataObjectsDelegate:self queue:dispatch_get_main_queue()];
        
        // Session
        _session = [[AVCaptureSession alloc]init];
        [_session setSessionPreset:AVCaptureSessionPresetHigh];
        if ([_session canAddInput:self.input])
        {
            [_session addInput:self.input];
        }
        
        if ([_session canAddOutput:self.output])
        {
            [_session addOutput:self.output];
        }
        
        // 条码类型 AVMetadataObjectTypeQRCode
        _output.metadataObjectTypes =@[AVMetadataObjectTypeQRCode];
        dispatch_async(dispatch_get_main_queue(), ^{
            // 更新界面
            // Preview
            _preview =[AVCaptureVideoPreviewLayer layerWithSession:self.session];
            _preview.videoGravity = AVLayerVideoGravityResizeAspectFill;
            //    _preview.frame =CGRectMake(20,110,280,280);
            _preview.frame = self.view.bounds;
            [self.view.layer insertSublayer:self.preview atIndex:0];
            // Start
            [_session startRunning];
        });
    });
}
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.tabBarController.tabBar.hidden = YES;
    if (_session && ![_session isRunning]) {
        [_session startRunning];
    }
    
    AVAuthorizationStatus status = [AVCaptureDevice authorizationStatusForMediaType:AVMediaTypeVideo];
    
    if(status ==AVAuthorizationStatusAuthorized) {
        
        [self setupCamera];
    } else {
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"请在iPhone的“设定-隐私-相机”选项中，允许知众网访问你的相机"message:nil delegate:nil cancelButtonTitle:@"确定"otherButtonTitles:nil];
        [alert show];
    }
    
    
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    
}
- (void)captureOutput:(AVCaptureOutput *)captureOutput didOutputMetadataObjects:(NSArray *)metadataObjects fromConnection:(AVCaptureConnection *)connection{
    
    NSString *stringValue;
    
    if ([metadataObjects count] >0)
    {
        AVMetadataMachineReadableCodeObject * metadataObject = [metadataObjects objectAtIndex:0];
        stringValue = metadataObject.stringValue;
    }
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:stringValue]];
    [_session stopRunning];
    NSLog(@"%@",stringValue);
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
@end
