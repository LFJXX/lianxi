//
//  ScanViewController.h
//  OTO
//
//  Created by apple on 16/3/1.
//  Copyright © 2016年 xyb100. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AVFoundation/AVFoundation.h>


@protocol ScanViewControllerDelegate <NSObject>

- (void)qrCodeComplete:(NSString *)codeString;

- (void)qrCodeError:(NSError *)error;

@end


@interface ScanViewController : UIViewController<AVCaptureMetadataOutputObjectsDelegate>

@property(assign,nonatomic)id<ScanViewControllerDelegate> delegate;

@property (strong,nonatomic)AVCaptureDevice *device;

@property (strong,nonatomic)AVCaptureMetadataOutput *output;

@property (strong,nonatomic)AVCaptureDeviceInput *input;

@property (strong, nonatomic)AVCaptureSession *session;

@property (strong, nonatomic)AVCaptureVideoPreviewLayer *preview;

@end
