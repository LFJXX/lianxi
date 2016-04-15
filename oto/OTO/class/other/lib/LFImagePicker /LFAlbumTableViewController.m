//
//  LFAlbumTableViewController.m
//  LFImagePicker
//
//  Created by apple on 16/3/4.
//  Copyright © 2016年 xyb100. All rights reserved.
//

#import "LFAlbumTableViewController.h"
#import "LFAlbum.h"
#import "LFAlbumTableViewCell.h"
#import "LFImageGridViewController.h"

static NSString *const LFAlbumTableViewCellIdentifier = @"LFAlbumTableViewCellIdentifier";

@interface LFAlbumTableViewController ()

@end

@implementation LFAlbumTableViewController {
    /// 相册资源集合
    NSArray<LFAlbum *> *_assetCollection;
    /// 选中素材数组
    NSMutableArray <PHAsset *> *_selectedAssets;
}

- (instancetype)initWithSelectedAssets:(NSMutableArray<PHAsset *> *)selectedAssets {
    self = [super init];
    if (self) {
        _selectedAssets = selectedAssets;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // 导航栏
    self.title = @"照片";
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"取消" style:UIBarButtonItemStylePlain target:self action:@selector(clickCloseButton)];
    
    // 获取相册
    [self fetchAssetCollectionWithCompletion:^(NSArray<LFAlbum *> *assetCollection, BOOL isDenied) {
        if (isDenied) {
            UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"提示" message:@"没有权限访问相册，请先在设置程序中授权访问" preferredStyle:UIAlertControllerStyleAlert];
            
            [alert addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil]];
            
            [self presentViewController:alert animated:YES completion:nil];
            
            return;
        }
        
        _assetCollection = assetCollection;
        
        [self.tableView reloadData];
        
        // 默认显示第一个相册
        if (_assetCollection.count > 0) {
            LFImageGridViewController *grid = [[LFImageGridViewController alloc]
                                               initWithAlbum:_assetCollection[0]
                                               selectedAssets:_selectedAssets
                                               maxPickerCount:_maxPickerCount];
            
            [self.navigationController pushViewController:grid animated:NO];
        }
    }];
    
    // 设置表格
    [self.tableView registerClass:[LFAlbumTableViewCell class] forCellReuseIdentifier:LFAlbumTableViewCellIdentifier];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.rowHeight = 80;
}

- (void)clickCloseButton {
    [self dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark - 加载相册
- (void)fetchAssetCollectionWithCompletion:(void (^)(NSArray<LFAlbum *> *, BOOL))completion {
    
    PHAuthorizationStatus status = [PHPhotoLibrary authorizationStatus];
    
    switch (status) {
        case PHAuthorizationStatusAuthorized:
            [self fetchResultWithCompletion:completion];
            break;
        case PHAuthorizationStatusNotDetermined:
        {
            [PHPhotoLibrary requestAuthorization:^(PHAuthorizationStatus status) {
                [self fetchResultWithCompletion:completion];
            }];
        }
            break;
        default:
            NSLog(@"拒绝访问相册");
            completion(nil, YES);
            
            break;
    }
}

- (void)fetchResultWithCompletion:(void (^)(NSArray<LFAlbum *> *, BOOL))completion {
    // 相机胶卷
    PHFetchResult *userLibrary = [PHAssetCollection
                                  fetchAssetCollectionsWithType:PHAssetCollectionTypeSmartAlbum
                                  subtype:PHAssetCollectionSubtypeSmartAlbumUserLibrary
                                  options:nil];
    
    // 同步相册
    PHFetchOptions *options = [[PHFetchOptions alloc] init];
    options.sortDescriptors = @[[NSSortDescriptor sortDescriptorWithKey:@"localizedTitle" ascending:NO]];
    
    PHFetchResult *syncedAlbum = [PHAssetCollection
                                  fetchAssetCollectionsWithType:PHAssetCollectionTypeAlbum
                                  subtype:PHAssetCollectionSubtypeAlbumSyncedAlbum
                                  options:options];
    
    NSMutableArray *result = [NSMutableArray array];
    [userLibrary enumerateObjectsUsingBlock:^(id _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        [result addObject:[LFAlbum albumWithAssetCollection:obj]];
    }];
    [syncedAlbum enumerateObjectsUsingBlock:^(id _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        [result addObject:[LFAlbum albumWithAssetCollection:obj]];
    }];
    
    dispatch_async(dispatch_get_main_queue(), ^{ completion(result.copy, NO); });
}

#pragma mark - Table view data source
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _assetCollection.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    LFAlbumTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:LFAlbumTableViewCellIdentifier forIndexPath:indexPath];
    
    cell.album = _assetCollection[indexPath.row];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    LFAlbum *album = _assetCollection[indexPath.row];
    LFImageGridViewController *grid = [[LFImageGridViewController alloc]
                                       initWithAlbum:album
                                       selectedAssets:_selectedAssets
                                       maxPickerCount:_maxPickerCount];
    
    [self.navigationController pushViewController:grid animated:YES];
}

@end
