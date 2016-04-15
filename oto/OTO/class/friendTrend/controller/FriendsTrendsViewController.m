//
//  FriendsTrendsViewController.m
//  OTO
//
//  Created by apple on 16/3/4.
//  Copyright © 2016年 xyb100. All rights reserved.
//

#import "FriendsTrendsViewController.h"
#import "FriendsTrendsCell.h"
#import "ComposeViewController.h"
#import <MobileCoreServices/MobileCoreServices.h>
#import <AVFoundation/AVFoundation.h>
#import <MediaPlayer/MediaPlayer.h>


@interface FriendsTrendsViewController ()<UITableViewDelegate,UITableViewDataSource,LFImagePickerControllerDelegate,UINavigationControllerDelegate,UIImagePickerControllerDelegate>
@property (nonatomic,strong) UITableView *mytableView;
@property (nonatomic,strong) UIView *heardView;
@property (nonatomic,strong) UIImageView *photoView;
@property (nonatomic,strong) UIButton *iconBtn;
@property (nonatomic,strong) NSMutableArray *friendDataSource;
/// 选中照片数组
@property (nonatomic) NSArray *images;
/// 选中资源素材数组，用于定位已经选择的照片
@property (nonatomic) NSArray *selectedAssets;
@end

@implementation FriendsTrendsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"照片" style:UIBarButtonItemStyleDone target:self action:@selector(获取)];
    [self.view addSubview:self.mytableView];
    self.mytableView.tableHeaderView = self.heardView;

    NSString *filePath = [[NSBundle mainBundle] pathForResource:@"friend.plist" ofType:nil];
    NSDictionary *dict = [NSDictionary dictionaryWithContentsOfFile:filePath];
    

    NSMutableArray *arr = [FriendSTrends mj_objectArrayWithKeyValuesArray:dict[@"frendsTrend"]];
    for (FriendSTrends *trend in arr) {
       FriendTrendsFrame *trendF = [[FriendTrendsFrame alloc] init];
        trendF.trends = trend;
        [self.friendDataSource addObject:trendF];
    }
     [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(changeImage:) name:@"changeImage" object:nil];

}

- (void)获取{

    UIAlertController *alter = [UIAlertController alertControllerWithTitle:nil message:nil preferredStyle:UIAlertControllerStyleActionSheet];
    
    UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"拍照" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {

//        UIImagePickerController *picker = [[UIImagePickerController alloc] init];//初始化
//        if ([UIImagePickerController isSourceTypeAvailable: UIImagePickerControllerSourceTypeCamera]) {
//            picker.delegate = self;
//            picker.allowsEditing = YES;//设置可编辑
//            picker.sourceType = UIImagePickerControllerSourceTypeCamera;
//            [self presentViewController:picker animated:YES completion:nil];;//进入照相界面
//        }else{
//            
//            NSLog(@"不支持拍照");
//        }
        ComposeViewController *composeVc = [[ComposeViewController alloc] init];
        [self.navigationController pushViewController:composeVc animated:YES];

    }];
    UIAlertAction *okAction1 = [UIAlertAction actionWithTitle:@"从手机相册选择" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        LFImagePickerController *picker = [[LFImagePickerController alloc] initWithSelectedAssets:self.selectedAssets];
        
        // 设置图像选择代理
        picker.pickerDelegate = self;
        // 设置目标图片尺寸
        picker.targetSize = CGSizeMake(600, 600);
        // 设置最大选择照片数量
        picker.maxPickerCount = 9;
        
        [self presentViewController:picker animated:YES completion:nil];
        
    }];
    UIAlertAction *okAction2 = [UIAlertAction actionWithTitle:@"视频" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {

        UIImagePickerController *picker = [[UIImagePickerController alloc] init];//初始化
        if ([UIImagePickerController isSourceTypeAvailable: UIImagePickerControllerSourceTypeCamera]) {
            picker.sourceType = UIImagePickerControllerSourceTypeCamera;
            picker.delegate = self;
            picker.allowsEditing = YES;//设置可编辑
            //录制视频时长，默认10s
            picker.videoMaximumDuration = 20;
            picker.mediaTypes = @[(NSString *)kUTTypeMovie,(NSString *)kUTTypeImage];

            picker.videoQuality = UIImagePickerControllerQualityTypeHigh;
            
            //设置摄像头模式（拍照，录制视频）为录像模式
            picker.cameraCaptureMode = UIImagePickerControllerCameraCaptureModeVideo;
            [self presentViewController:picker animated:YES completion:nil];;//进入照相界面
        }else{
            
            NSLog(@"不支持录制视频");
        }

    }];
    
    UIAlertAction *cancleAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        
        
    }];

    [cancleAction setValue:[UIColor redColor] forKeyPath:@"titleTextColor"];
    [alter addAction:okAction];
    [alter addAction:okAction1];
    [alter addAction:okAction2];
    [alter addAction:cancleAction];
    [self presentViewController:alter animated:YES completion:nil];
}
- (void)changeImage:(NSNotification *)noti{

    UIImage *image = noti.object[@"image"];
    self.photoView.image = image;
    
}

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info{

    NSString *mediaType = info[UIImagePickerControllerMediaType];
    if ([mediaType isEqualToString:(NSString *)kUTTypeMovie]) {
        NSURL *videoURL = info[UIImagePickerControllerMediaURL];
        // video url:
        // we will convert it to mp4 format
        NSURL *mp4 = [self _convert2Mp4:videoURL];
        NSFileManager *fileman = [NSFileManager defaultManager];
        if ([fileman fileExistsAtPath:videoURL.path]) {
            NSError *error = nil;
            [fileman removeItemAtURL:videoURL error:&error];
            if (error) {
                NSLog(@"failed to remove file, error:%@.", error);
            }
        }

        // 根据URL加载视频
        
        [self dismissViewControllerAnimated:YES completion:nil];
        ComposeViewController *compose = [[ComposeViewController alloc] init];
        compose.videoUrl = mp4;

        [self.navigationController pushViewController:compose animated:YES];
        
    }else{
    
        [self dismissViewControllerAnimated:YES completion:nil];
        ComposeViewController *compose = [[ComposeViewController alloc] init];
        UIImage *image = info[UIImagePickerControllerOriginalImage];
        [compose.imageArr addObject:image];
        [self.navigationController pushViewController:compose animated:YES];
        
    }

    
    
}

- (NSURL *)_convert2Mp4:(NSURL *)movUrl
{
    NSURL *mp4Url = nil;
    AVURLAsset *avAsset = [AVURLAsset URLAssetWithURL:movUrl options:nil];
    NSArray *compatiblePresets = [AVAssetExportSession exportPresetsCompatibleWithAsset:avAsset];
    
    if ([compatiblePresets containsObject:AVAssetExportPresetHighestQuality]) {
        AVAssetExportSession *exportSession = [[AVAssetExportSession alloc]initWithAsset:avAsset
                                                                              presetName:AVAssetExportPresetHighestQuality];
        mp4Url = [movUrl copy];
        mp4Url = [mp4Url URLByDeletingPathExtension];
        mp4Url = [mp4Url URLByAppendingPathExtension:@"mp4"];
        exportSession.outputURL = mp4Url;
        exportSession.shouldOptimizeForNetworkUse = YES;
        exportSession.outputFileType = AVFileTypeMPEG4;
        dispatch_semaphore_t wait = dispatch_semaphore_create(0l);
        [exportSession exportAsynchronouslyWithCompletionHandler:^{
            switch ([exportSession status]) {
                case AVAssetExportSessionStatusFailed: {
                    NSLog(@"failed, error:%@.", exportSession.error);
                } break;
                case AVAssetExportSessionStatusCancelled: {
                    NSLog(@"cancelled.");
                } break;
                case AVAssetExportSessionStatusCompleted: {
                    NSLog(@"completed.");
                } break;
                default: {
                    NSLog(@"others.");
                } break;
            }
            dispatch_semaphore_signal(wait);
        }];
        long timeout = dispatch_semaphore_wait(wait, DISPATCH_TIME_FOREVER);
        if (timeout) {
            NSLog(@"timeout.");
        }
        if (wait) {
            //dispatch_release(wait);
            wait = nil;
        }
    }
    
    return mp4Url;
}
#pragma mark - LFImagePickerControllerDelegate
- (void)imagePickerController:(LFImagePickerController *)picker
      didFinishSelectedImages:(NSArray<UIImage *> *)images
               selectedAssets:(NSArray<PHAsset *> *)selectedAssets {
    
    // 记录图像，方便在 CollectionView 显示
    self.images = images;
    // 记录选中资源集合，方便再次选择照片定位
     self.selectedAssets = selectedAssets;
    [self dismissViewControllerAnimated:YES completion:nil];
    ComposeViewController *compose = [[ComposeViewController alloc] init];
    compose.imageArr = [self.images mutableCopy];
    [self.navigationController pushViewController:compose animated:YES];
}
#pragma mark UITableViewDataSource   delegate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{

    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{

    return self.friendDataSource.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{

    static NSString *identifier = @"trand";
    FriendsTrendsCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (!cell) {
        cell = [[FriendsTrendsCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    FriendTrendsFrame *trendF = self.friendDataSource[indexPath.row];
    cell.trendsFrame = trendF;
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{

    FriendTrendsFrame *trendF = self.friendDataSource[indexPath.row];
    return trendF.rowHeight;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}
#pragma mark action
- (void)changePhoto:(UIGestureRecognizer *)tap{
// NSLocalizedString(@"Cancel", nil);
    UIAlertController *alter = [UIAlertController alertControllerWithTitle:nil message:nil preferredStyle:UIAlertControllerStyleActionSheet];
    
    UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"更换相册封面" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
       
        ChangePhotoViewController *changePhoto = [[ChangePhotoViewController alloc] init];
        [self.navigationController pushViewController:changePhoto animated:YES];
       
    }];
    
    UIAlertAction *cancleAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        
     
    }];
    

    [okAction setValue:[UIColor blackColor] forKeyPath:@"titleTextColor"];
    [cancleAction setValue:[UIColor redColor] forKeyPath:@"titleTextColor"];
    [alter addAction:okAction];
    [alter addAction:cancleAction];
    [self presentViewController:alter animated:YES completion:nil];

}

- (void)checkTrend:(UIButton *)sender{
    PersonTrendViewController *personTrendVc = [[PersonTrendViewController alloc] init];
    [self.navigationController pushViewController:personTrendVc animated:YES];

}
#pragma mark 懒加载
- (UITableView *)mytableView{

    if (_mytableView == nil) {
        _mytableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, self.view.width, self.view.height)];
        _mytableView.delegate = self;
        _mytableView.dataSource = self;
    }
    return _mytableView;
}

- (UIView *)heardView{

    if (_heardView == nil) {
        _heardView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.width, 200)];
//        _heardView.backgroundColor = [UIColor yellowColor];
        UIImageView *imageV = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, self.view.width, 170)];
        imageV.contentMode = UIViewContentModeScaleAspectFill;
        imageV.layer.masksToBounds = YES;
        self.photoView = imageV;
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(changePhoto:)];
        [self.photoView addGestureRecognizer:tap];
        imageV.userInteractionEnabled = YES;
        imageV.image = [UIImage imageNamed:@"photo"];
        [_heardView addSubview:imageV];
        UIButton *iconBtn = [[UIButton alloc] initWithFrame:CGRectMake(self.view.width - 80, CGRectGetMaxY(imageV.frame)-30, 60, 60)];
        self.iconBtn = iconBtn;
        _iconBtn.layer.cornerRadius = 10;
        _iconBtn.layer.masksToBounds = YES;
        [iconBtn setImage:[UIImage imageNamed:@"photo"] forState:UIControlStateNormal];
        [iconBtn addTarget:self action:@selector(checkTrend:) forControlEvents:UIControlEventTouchUpInside];
        [_heardView addSubview:iconBtn];
        
    }
    return _heardView;
}

- (NSMutableArray *)friendDataSource{

    if (_friendDataSource == nil) {
        _friendDataSource = [NSMutableArray arrayWithCapacity:0];
        
    }
    return _friendDataSource;
}

@end
