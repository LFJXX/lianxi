//
//  QRCodeViewController.m
//  OTO
//
//  Created by apple on 16/3/1.
//  Copyright © 2016年 xyb100. All rights reserved.
//

#import "QRCodeViewController.h"

@interface QRCodeViewController ()
@property (nonatomic,strong) QRCodeView *qrcodeView;
@property (nonatomic,strong) UIView *commandView;
@end

@implementation QRCodeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor blackColor];
    [self.view addSubview:self.qrcodeView];
    [self.view addSubview:self.commandView];
    [self adddata];
    
}

- (void)adddata{
    User *user = [[User alloc] init];
    user.iconUrl = @"http://img4.duitang.com/uploads/item/201601/03/20160103175943_SkFQf.png";
    user.name = @"小胖胖";
    user.sex = 0;
    user.qrUrl = @"https://www.baidu.com";
    user.location = @"北京 昌平";
    self.qrcodeView.user = user;
}

- (void)sendCommand:(UIGestureRecognizer *)tap{
    NSLog(@"发送口令给好友");
    UIAlertController *alter = [UIAlertController alertControllerWithTitle:@"" message:@"#吱口令#点击复制此条消息,打开欣来宝即可添加我为好友" preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *cancleAction = [UIAlertAction actionWithTitle:@"去QQ粘贴" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [self pasteMessage];
    }];
    UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"去微信粘贴" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
        [self copyMessgae];
    }];
    
    [alter addAction:cancleAction];
    [alter addAction:okAction];
    [self presentViewController:alter animated:YES completion:nil];
}

- (void)pasteMessage{
//    UIPasteboard *paste = [UIPasteboard pasteboardWithName:@"myApp" create:YES];
    UIPasteboard *paste = [UIPasteboard generalPasteboard];
    paste.string = @"再试一试,看看这怎么";
    
}

- (void)copyMessgae{

    UIPasteboard *copy = [UIPasteboard generalPasteboard];
//    UIPasteboard *copy = [UIPasteboard pasteboardWithName:@"myApp" create:YES];
    NSLog(@"====%@",copy.string);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];

}

#pragma mark 懒加载
- (QRCodeView *)qrcodeView{

    if (_qrcodeView == nil) {
        _qrcodeView = [[QRCodeView alloc] initWithFrame:CGRectMake(15, 90, self.view.width - 30, self.view.height - 210)];
        _qrcodeView.layer.cornerRadius = 5;
        _qrcodeView.layer.masksToBounds = YES;
    }
    return _qrcodeView;
    
}

- (UIView *)commandView{

    if (_commandView == nil) {
        _commandView = [[UIView alloc] initWithFrame:CGRectMake(15, CGRectGetMaxY(self.qrcodeView.frame)+10, self.qrcodeView.width, 60)];
        _commandView.backgroundColor = [UIColor whiteColor];
        _commandView.layer.cornerRadius = 5;
        _commandView.layer.masksToBounds = YES;
        UILabel *titleLable = [[UILabel alloc] initWithFrame:CGRectMake(0, 5,_commandView.width, 25)];
        titleLable.text = @"点击生成吱口令";
        titleLable.font = [UIFont systemFontOfSize:16];
        titleLable.textAlignment = NSTextAlignmentCenter;
        UILabel *lable = [[UILabel alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(titleLable.frame)+5, _commandView.width, 20)];
        lable.text = @"发送微信,QQ,加朋友";
        lable.font = [UIFont systemFontOfSize:13];
        lable.textColor = [UIColor lightGrayColor];
        lable.textAlignment = NSTextAlignmentCenter;
        [_commandView addSubview:titleLable];
        [_commandView addSubview:lable];
        
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(sendCommand:)];
        [_commandView addGestureRecognizer:tap];
    }
    
    return _commandView;
}
@end
