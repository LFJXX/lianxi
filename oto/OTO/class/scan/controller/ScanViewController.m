//
//  ScanViewController.m
//  OTO
//
//  Created by apple on 16/3/1.
//  Copyright © 2016年 xyb100. All rights reserved.
//
#define DsW self.view.width
#define DsH self.view.height
#import "ScanViewController.h"

@interface ScanViewController ()
{
    NSTimer *_timer;
    UIImageView *_imageView;
    
    UIImageView *_lineImageView;
}
@end

@implementation ScanViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.view.autoresizingMask = YES;
    
    //    self.view.backgroundColor = [UIColor grayColor];
    
    //    [self.navigationController.navigationBar setBarStyle:UIBarStyleBlack];
    [self initUiConfig];
}


- (void)initUI:(CGRect)previewFrame
{
    self.device = [AVCaptureDevice defaultDeviceWithMediaType:AVMediaTypeVideo];
    
    NSError *error = nil;
    
    self.input = [AVCaptureDeviceInput deviceInputWithDevice:self.device error:&error];
    
    if (error) {
        
        if ([self.delegate respondsToSelector:@selector(qrCodeError:)]) {
            [self.delegate qrCodeError:error];
        }
        
        return;
    }
    
    self.output = [[AVCaptureMetadataOutput alloc]init];
    
    [self.output setMetadataObjectsDelegate:self queue:dispatch_get_main_queue()];
    
    
    self.session = [[AVCaptureSession alloc]init];
    
    if ([self.session canAddInput:self.input])
    {
        [self.session addInput:self.input];
    }
    
    if ([self.session canAddOutput:self.output])
    {
        [self.session addOutput:self.output];
    }
    
    self.output.metadataObjectTypes = @[AVMetadataObjectTypeEAN13Code, AVMetadataObjectTypeEAN8Code, AVMetadataObjectTypeCode128Code, AVMetadataObjectTypeQRCode];
    
    _imageView.frame = CGRectMake(DsW * 0.5 - 140, DsH * 0.5 - 140, 280, 280);
    
    
    // 设置扫描 区域
    [self.output setRectOfInterest:CGRectMake((self.view.bounds.size.height * 0.5 - 140)/DsH, (self.view.bounds.size.width * 0.5 - 140)/DsW, 280/DsH, 280/DsW)];
    
    self.preview = [AVCaptureVideoPreviewLayer layerWithSession:self.session];
    
    self.preview.videoGravity = AVLayerVideoGravityResizeAspectFill;
    
    self.preview.frame = previewFrame;
    
    [self.view.layer addSublayer:self.preview];
    
    if (DsH == 480)
    {
        [self.session setSessionPreset:AVCaptureSessionPreset640x480];
    }
    else
    {
        [self.session setSessionPreset:AVCaptureSessionPresetHigh];
    }
    
    [self.session startRunning];
}


- (void)captureOutput:(AVCaptureOutput *)captureOutput didOutputMetadataObjects:(NSArray *)metadataObjects fromConnection:(AVCaptureConnection *)connection
{
    
    [self.session stopRunning];
    
    [self.preview removeFromSuperlayer];
    
    NSString *val = nil;
    if (metadataObjects.count > 0)
    {
        AVMetadataMachineReadableCodeObject *obj = metadataObjects[0];
        
        val = obj.stringValue;
        
        if ([self.delegate respondsToSelector:@selector(qrCodeComplete:)]) {
            [self.delegate qrCodeComplete:val];
            [self dismissViewControllerAnimated:YES completion:nil];
        }
    }
}



- (void)initUiConfig
{
    [self initUI:CGRectMake(0, 0, DsW,DsH)];
    
    _imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"capture"]];
    _imageView.frame = CGRectMake(DsW * 0.5 - 140, DsH * 0.5 - 140, 280, 280);
    [self.view addSubview:_imageView];
    
    
    _lineImageView = [[UIImageView alloc] initWithFrame:CGRectMake(30, 10, 220, 4)];
    _lineImageView.image = [UIImage imageNamed:@"scan_line"];
    [_imageView addSubview:_lineImageView];
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemCancel target:self action:@selector(cancelBtnClick:)];
    
    
    
    _timer = [NSTimer scheduledTimerWithTimeInterval:2 target:self selector:@selector(animation) userInfo:nil repeats:YES];
}



- (void)animation
{
    [UIView animateWithDuration:2 delay:0 options:UIViewAnimationOptionCurveLinear animations:^{
        
        _lineImageView.frame = CGRectMake(10, 260, 260, 4);
        
    } completion:^(BOOL finished) {
        _lineImageView.frame = CGRectMake(10, 10, 260, 4);
    }];
}

- (void)cancelBtnClick:(id)sender
{
    // 将定时器移除
    [self removeTimer];
    [self dismissViewControllerAnimated:YES completion:nil];
}
- (void)removeTimer
{
    [_timer invalidate];
    _timer = nil;
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
