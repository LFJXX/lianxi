//
//  ComposeViewController.m
//  OTO
//
//  Created by apple on 16/3/9.
//  Copyright © 2016年 xyb100. All rights reserved.
//

#import "ComposeViewController.h"
#import <AVKit/AVKit.h>
#import "LFTextView.h"
#import "LFPhotoViewCell.h"
#import "LFComposeCell.h"
#import "MapViewController.h"
@interface ComposeViewController ()<UITableViewDelegate,UITableViewDataSource,UICollectionViewDelegate,UICollectionViewDataSource,UITextViewDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate,LFImagePickerControllerDelegate>

@property (nonatomic,strong) AVPlayer *player;
@property (nonatomic,strong) AVPlayerViewController *playVc;
@property (nonatomic,strong) UITableView *myTableView;

@property (nonatomic,strong) LFTextView *textView;
@property (nonatomic,strong) UIView *photoView;
@property (nonatomic,strong) UICollectionView *myCollectionView;


@end

@implementation ComposeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"发表" style:UIBarButtonItemStyleDone target:self action:@selector(composeStatus)];
    [self.view addSubview:self.myTableView];
 
    
}

- (void)addPlayer{
    AVPlayer *player = [[AVPlayer alloc] initWithURL:self.videoUrl];
    self.player = player;
    AVPlayerViewController *playVc = [[AVPlayerViewController alloc] init];
    self.playVc = playVc;
    playVc.player = player;
    [self addChildViewController:playVc];
    [self.view addSubview:playVc.view];
    playVc.view.frame = CGRectMake(0, 100, self.view.width, self.view.width);
    [player play];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(moviePlayDidEnd:) name:AVPlayerItemDidPlayToEndTimeNotification object:nil];
}





#pragma mark UITableViewDataSource  Delegate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{

    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{

    return 2;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{

    static NSString *identifier = @"compose";
    LFComposeCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (cell == nil) {
        cell = [[LFComposeCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    if (indexPath.section == 0 && indexPath.item == 0) {
        [cell.contentView addSubview:self.textView];
        [cell.contentView addSubview:self.photoView];
    }else if(indexPath.section == 0 && indexPath.item == 1){
        cell.iconVIew.image = [UIImage imageNamed:@"10000033"];
        cell.nameLable.text = @"所在位置";
        cell.detailLable.text = @"";
    
    }else if(indexPath.section == 1 && indexPath.item == 0){
        cell.iconVIew.image = [UIImage imageNamed:@"10000033"];
        cell.nameLable.text = @"谁可以看";
        cell.detailLable.text = @"公开";
        UIView *linView = [[UIView alloc] initWithFrame:CGRectMake(10, cell.height - 1, self.view.width - 20, 1)];
        linView.backgroundColor = [UIColor lightGrayColor];
        [cell.contentView addSubview:linView];
    }else if(indexPath.section == 1 && indexPath.item == 1){
        cell.iconVIew.image = [UIImage imageNamed:@"10000033"];
        cell.nameLable.text = @"提醒谁看";
        cell.detailLable.text = @"";
        
    }
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
 
    if (indexPath.section == 0 && indexPath.row == 1) {
        // 定位
        MapViewController *mapVc = [[MapViewController alloc] init];
        [self.navigationController pushViewController:mapVc animated:YES];
    }else if (indexPath.section == 1 && indexPath.row == 0){
        // 选择群组
        
    }else if (indexPath.section == 1 && indexPath.row == 1){
      // 选择联系人
        
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{

    if (indexPath.section == 0 && indexPath.item == 0) {
        return self.photoView.height+ self.textView.height;
    }else{
    
        return 50;
    }
    
   
}


- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{

    if (section == 0) {
    
        return 0.01;
    }else{
    
        return 10;
    }
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{

    UIView *view = [[UIView alloc] init];
    if (section == 1) {
        UIButton *btn = [[UIButton alloc] initWithFrame:CGRectMake(10, 10, 30, 30)];
        [btn setBackgroundImage:[UIImage imageNamed:@"10000009"] forState:UIControlStateNormal];
        [btn addTarget:self action:@selector(shareQQ:) forControlEvents:UIControlEventTouchUpInside];
        [view addSubview:btn];
        return view;
    }else{
    
        return nil;
    }
}

#pragma mark UICollectionDateSource delegate
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{

    return self.imageArr.count == 9 ? self.imageArr.count:self.imageArr.count + 1;
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{

    static NSString *identifier = @"photo";
    LFPhotoViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:identifier forIndexPath:indexPath];
    if (self.imageArr.count != 9) {
        
        if (self.imageArr.count == indexPath.item ) {
            cell.iconView.image = [UIImage imageNamed:@"zhaopian"];
        }else{
            
            cell.iconView.image = self.imageArr[indexPath.row];
        }
    }else{
        cell.iconView.image = self.imageArr[indexPath.row];

    }
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{

    if (self.imageArr.count != 9) {
        
        if (self.imageArr.count == indexPath.item ) {
            
            // 点击添加按钮
            [self addImage];
        }else{
            

        }
    }else{
        
        // 点击照片
        
    }
}

- (void)addImage{
    
    UIAlertController *alter = [UIAlertController alertControllerWithTitle:nil message:nil preferredStyle:UIAlertControllerStyleActionSheet];
    
    UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"拍照" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
        UIImagePickerController *picker = [[UIImagePickerController alloc] init];//初始化
//         LFImagePickerController *picker = [[LFImagePickerController alloc] initWithSelectedAssets:self.selectedAssets];
        if ([UIImagePickerController isSourceTypeAvailable: UIImagePickerControllerSourceTypeCamera]) {
            picker.delegate = self;
            picker.allowsEditing = YES;//设置可编辑
            picker.sourceType = UIImagePickerControllerSourceTypeCamera;
            [self presentViewController:picker animated:YES completion:nil];;//进入照相界面
        }else{
            
            NSLog(@"不支持拍照");
        }
        
    }];
    UIAlertAction *okAction1 = [UIAlertAction actionWithTitle:@"从手机相册选择" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        LFImagePickerController *picker = [[LFImagePickerController alloc] initWithSelectedAssets:@[]];
        
        // 设置图像选择代理
        picker.pickerDelegate = self;
        // 设置目标图片尺寸
        picker.targetSize = CGSizeMake(600, 600);
        // 设置最大选择照片数量
        picker.maxPickerCount = 9 - self.imageArr.count;
        
        [self presentViewController:picker animated:YES completion:nil];
        
    }];
    
    UIAlertAction *cancleAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        
        
    }];
    
    [cancleAction setValue:[UIColor redColor] forKeyPath:@"titleTextColor"];
    [alter addAction:okAction];
    [alter addAction:okAction1];
    [alter addAction:cancleAction];
    [self presentViewController:alter animated:YES completion:nil];
}
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info{
    
    UIImage *image = info[UIImagePickerControllerOriginalImage];
    [self.imageArr addObject:image];
  
    [self dismissViewControllerAnimated:YES completion:nil];
    [self.myCollectionView reloadData];
    [self.myTableView reloadData];

    
    
}
#pragma mark - LFImagePickerControllerDelegate
- (void)imagePickerController:(LFImagePickerController *)picker
      didFinishSelectedImages:(NSArray<UIImage *> *)images
               selectedAssets:(NSArray<PHAsset *> *)selectedAssets {
    
    // 记录图像，方便在 CollectionView 显示
    [self.imageArr addObjectsFromArray:images];
    // 记录选中资源集合，方便再次选择照片定位
    [self dismissViewControllerAnimated:YES completion:nil];
    [self.myCollectionView reloadData];
    [self.myTableView reloadData];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];

}

#pragma mark action
- (void)composeStatus{
    
}
- (void)moviePlayDidEnd:(NSNotification *)noti{
    
    
    //    [self.player play];
    
    
}
- (void)shareQQ:(UIButton *)sender{

    
}
#pragma mark 懒加载
- (UITableView *)myTableView{

    if (_myTableView == nil) {
        _myTableView =  [[UITableView alloc] initWithFrame:CGRectMake(0,0,self.view.width, self.view.height) style:UITableViewStyleGrouped];
        _myTableView.tableHeaderView = [[UIView alloc] initWithFrame:CGRectMake(0.0f, 0.0f, _myTableView.width, 0.01f)];
        _myTableView.delegate = self;
        _myTableView.dataSource = self;
        _myTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _myTableView.scrollEnabled = NO;
        [_myTableView registerNib:[UINib nibWithNibName:@"LFComposeCell" bundle:nil] forCellReuseIdentifier:@"compose"];

    }
    return _myTableView;
}

- (LFTextView *)textView{

    if (_textView == nil) {
        _textView = [[LFTextView alloc] initWithFrame:CGRectMake(0, 0, self.view.width, 60)];
        _textView.placehoder = @"这一刻的想法...";
        _textView.delegate = self;
    }
    return _textView;
}

- (UIView *)photoView{

    if (_photoView == nil) {
        _photoView = [[UIView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(self.textView.frame)+10, self.view.width, 80)];
         [_photoView addSubview:self.myCollectionView];
        
    }
    _photoView.height = [self heightForRowWothCount:self.imageArr.count] +20;
    return _photoView;
}

- (UICollectionView *)myCollectionView{

    if (_myCollectionView == nil) {
        UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
        flowLayout.minimumLineSpacing = 5;
        flowLayout.minimumInteritemSpacing = 5;
        CGFloat margin = 5;
        CGFloat ItemW = ([UIScreen mainScreen].bounds.size.width - 5*margin)/4;
        CGFloat ItemH = ItemW;

        flowLayout.itemSize = CGSizeMake(ItemW, ItemH);
        
        CGFloat X = 5;
        CGFloat Y = 5;
        CGFloat W = self.photoView.width-2*X;
        CGFloat H = [self heightForRowWothCount:self.imageArr.count];
//        CGFloat H = self.photoView.height;
        _myCollectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(X, Y, W, H) collectionViewLayout:flowLayout];

        _myCollectionView.delegate = self;
        _myCollectionView.dataSource = self;
        [_myCollectionView registerNib:[UINib nibWithNibName:@"LFPhotoViewCell" bundle:nil] forCellWithReuseIdentifier:@"photo"];
        _myCollectionView.backgroundColor = [UIColor whiteColor];
    }
    
    _myCollectionView.height = [self heightForRowWothCount:self.imageArr.count];
    return _myCollectionView;
}

- (CGFloat)heightForRowWothCount:(NSInteger)count{
    
    
    //    NSUInteger total = count;
    NSUInteger maxCols = 4;
    CGFloat margin = 5;
    CGFloat imageVW = ([UIScreen mainScreen].bounds.size.width - 5*margin)/4;
    CGFloat imageVH = imageVW;
    
    NSUInteger row =count / maxCols;
    //    NSUInteger col =count % maxCols;
    
    //    CGFloat x=  (margin + imageVW) * col + margin;
    CGFloat y = (margin + imageVH) * row ;
    
    return y + imageVH + margin;
}

- (void)textViewDidEndEditing:(UITextView *)textView{

    [self.view endEditing:YES];
}

- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text
{
    
    if ([text isEqualToString:@"\n"]) {
        
        [textView resignFirstResponder];
        return NO;
    }
    
    return YES;
}

@end
