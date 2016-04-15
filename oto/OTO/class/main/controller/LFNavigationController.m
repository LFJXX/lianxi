//
//  NavigationController.m
//  XinYongZhangZhongBao
//
//  Created by apple on 15/10/12.
//  Copyright © 2015年 xyb100. All rights reserved.
//



#import "LFNavigationController.h"

@interface LFNavigationController ()<UINavigationControllerDelegate,UITableViewDataSource,UITableViewDelegate,ScanViewControllerDelegate>
{
    UIImageView *navBarHairlineImageView;
}
@end

@implementation LFNavigationController



- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationBar.barTintColor = LFLightBlueColor;
    [self.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor whiteColor],NSFontAttributeName:[UIFont boldSystemFontOfSize:18]}];
    self.navigationBar.tintColor = [UIColor whiteColor];
    self.delegate = self;
   
    navBarHairlineImageView = [self findHairlineImageViewUnder:self.navigationBar];
}
- (UIImageView *)findHairlineImageViewUnder:(UIView *)view {
    if ([view isKindOfClass:UIImageView.class] && view.bounds.size.height <= 1.0) {
        return (UIImageView *)view;
    }
    for (UIView *subview in view.subviews) {
        UIImageView *imageView = [self findHairlineImageViewUnder:subview];
        if (imageView) {
            return imageView;
        }
    }
    return nil;
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    navBarHairlineImageView.hidden = YES;
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    navBarHairlineImageView.hidden = NO;
}
- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated{
    if (self.viewControllers.count != 0) {
        viewController.hidesBottomBarWhenPushed = YES;
        viewController.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"返回" style:UIBarButtonItemStyleDone target:self action:@selector(back)];
    }else{
    
        UIButton *searchBtn=[[UIButton alloc] initWithFrame:CGRectMake(0, 0, 40, 40)];
        searchBtn.titleLabel.font = [UIFont systemFontOfSize:15];
        [searchBtn setTitle:@"购物" forState:UIControlStateNormal];
//        [searchBtn setImage:[UIImage imageNamed:@"10000003"] forState:UIControlStateNormal];
        [searchBtn addTarget:self action:@selector(buyCarClick) forControlEvents:UIControlEventTouchUpInside];
        UIButton *contractBtn=[[UIButton alloc] initWithFrame:CGRectMake(0, 0, 40, 40)];
        contractBtn.titleLabel.font = [UIFont systemFontOfSize:15];
        [contractBtn setTitle:@"朋友" forState:UIControlStateNormal];
//        [contractBtn setImage:[UIImage imageNamed:@"sample.png"] forState:UIControlStateNormal];
        [contractBtn addTarget:self action:@selector(contactListClick) forControlEvents:UIControlEventTouchUpInside];
        UIButton *moreBtn=[[UIButton alloc] initWithFrame:CGRectMake(0, 0, 40, 40)];
        moreBtn.titleLabel.font = [UIFont systemFontOfSize:15];
        [moreBtn setTitle:@"更多" forState:UIControlStateNormal];
//        [moreBtn setImage:[UIImage imageNamed:@"sample.png"] forState:UIControlStateNormal];
        [moreBtn addTarget:self action:@selector(addMoreClick) forControlEvents:UIControlEventTouchUpInside];
        
       
        UIBarButtonItem *barSearchBtn=[[UIBarButtonItem alloc]initWithCustomView:searchBtn];
        UIBarButtonItem *barContractBtn=[[UIBarButtonItem alloc]initWithCustomView:contractBtn];
        UIBarButtonItem *barMoreBtn=[[UIBarButtonItem alloc]initWithCustomView:moreBtn];
        NSArray *rightBtns=[NSArray arrayWithObjects:barMoreBtn,barSearchBtn,barContractBtn, nil];
        viewController.navigationItem.rightBarButtonItems = rightBtns;
    }
    [super pushViewController:viewController animated:animated];

}

#pragma mark - 跳转时 

- (nullable id <UIViewControllerAnimatedTransitioning>)navigationController:(UINavigationController *)navigationController
                                            animationControllerForOperation:(UINavigationControllerOperation)operation
                                                         fromViewController:(UIViewController *)fromVC
                                                           toViewController:(UIViewController *)toVC
{
    return nil;
}

#pragma  mark - Action

- (void)back{
    [self popViewControllerAnimated:YES];
}
- (void)contactListClick{

    [self addContactForGroup];
}

- (void)buyCarClick{
    
    BugCarViewController *buycarVC = [[BugCarViewController alloc] init];
    [self pushViewController:buycarVC animated:YES];
}

- (void)addMoreClick{

//    MenuTableViewController *menuVc = [[MenuTableViewController alloc] init];
    UITableView *tableView = [[UITableView alloc] init];
    tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    tableView.backgroundColor = [UIColor clearColor];
    tableView.rowHeight = 44;
    tableView.delegate = self;
    tableView.dataSource = self;
    tableView.scrollEnabled =NO;
    LFPopView *popView = [LFPopView popMenuWithContentView:tableView];
    popView.arrowPostion = LFPoPMenuArrowPositionRight;
    [popView showInRect:CGRectMake(self.view.width - 140, 64, 120, 200)];
    
}

- (void)addContactForGroup {
    //建立100个测试数据
    NSMutableArray *items = [NSMutableArray array];
    //网上拉的昵称列表，请忽视非主流。
    NSArray *names = @[@"貓眼无敌",
                       @"涽暗丶芉咮帘",
                       @"一个人搁浅",
                       @"时间像沙漏一样穿过瓶颈。",
                       @"朶，莪哋囡亾-",
                       @"得不到的在乎",
                       @"请不要留恋 .",
                       @"草bian的戒指",
                       @"y1旧、狠轻狂",
                       @"阿娇的垃圾的死了快回答了",
                       @"Angel、葬爱",
                       @"花无心。",
                       @"別致の情緒",
                       @"最近的心跳╰",
                       @"莪想莪慬嘚",
                       @"祂誓〃：毅丹",
                       @"╃渼锝Ъú橡話♂",
                       @"盗梦空间",
                       @"飘流瓶丶逆反",
                       @"①個〆国产纯货ル",
                       @"请你别敷衍ら",
                       @"乱挺爱4@",
                       @"︶￣浮动",
                       @"无规则 Rules°",
                       @"——拽、杀。",
                       @"1③⒋4.⒈",
                       @"殇、箌茈僞祉",
                       ];
    
    NSArray *avatarURLs = @[
                            @"http://v1.qzone.cc/avatar/201406/08/18/50/53943ff25f268523.jpg!180x180.jpg",
                            @"http://v1.qzone.cc/avatar/201406/08/18/35/53943c70b54e9227.jpeg!180x180.jpg",
                            @"http://v1.qzone.cc/avatar/201406/08/18/51/539440434b1c7139.jpg!180x180.jpg",
                            @"http://v1.qzone.cc/avatar/201406/08/18/48/53943f8408bea913.jpg!180x180.jpg",
                            @"http://v1.qzone.cc/avatar/201406/08/18/48/53943f8ae0384052.jpg!180x180.jpg",
                            @"http://v1.qzone.cc/avatar/201406/08/18/49/53943fcbb3be9306.jpg!180x180.jpg",
                            @"http://v1.qzone.cc/avatar/201406/08/18/38/53943d320f616180.png!180x180.jpg",
                            @"http://v1.qzone.cc/avatar/201406/08/18/47/53943f469a925760.jpg!180x180.jpg",
                            @"http://v1.qzone.cc/avatar/201406/08/18/46/53943f1a6b0ee418.jpg!180x180.jpg",
                            @"http://v1.qzone.cc/avatar/201406/08/18/47/53943f5ec2961034.jpg!180x180.jpg",
                            @"http://v1.qzone.cc/avatar/201406/08/18/47/53943f486e7ae921.jpg!180x180.jpg",
                            @"http://v1.qzone.cc/avatar/201406/08/18/45/53943ebae083b101.jpg!180x180.jpg",
                            @"http://v1.qzone.cc/avatar/201406/08/18/45/53943ec67c849838.jpg!180x180.jpg",
                            @"http://v1.qzone.cc/avatar/201406/08/18/45/53943ed21aa91813.jpg!180x180.jpg",
                            @"http://v1.qzone.cc/avatar/201406/08/18/45/53943ec4449f3999.jpg!180x180.jpg",
                            @"http://v1.qzone.cc/avatar/201406/08/18/43/53943e4e5733a368.jpg!180x180.jpg",
                            @"http://v1.qzone.cc/avatar/201406/08/18/43/53943e5d120b6630.jpg!180x180.jpg",
                            @"http://v1.qzone.cc/avatar/201406/08/18/41/53943dc293e22403.jpg!180x180.jpg",
                            @"http://v1.qzone.cc/avatar/201406/08/18/43/53943e6188616462.jpg!180x180.jpg",
                            @"http://v1.qzone.cc/avatar/201406/08/18/43/53943e3b42266017.jpg!180x180.jpg",
                            @"http://v1.qzone.cc/avatar/201406/08/18/41/53943dea86fa9728.png!180x180.jpg",
                            @"http://v1.qzone.cc/avatar/201406/08/18/42/53943e2c732d6796.jpg!180x180.jpg",
                            @"http://v1.qzone.cc/avatar/201406/08/18/40/53943da63ea18098.jpg!180x180.jpg",
                            @"http://v1.qzone.cc/avatar/201406/08/18/41/53943dec0428e119.jpg!180x180.jpg",
                            @"http://v1.qzone.cc/avatar/201406/08/18/41/53943dea86fa9728.png!180x180.jpg",
                            @"http://v1.qzone.cc/avatar/201406/08/18/41/53943dec0428e119.jpg!180x180.jpg",
                            @"http://v1.qzone.cc/avatar/201406/08/18/42/53943e2c732d6796.jpg!180x180.jpg",
                            ];
    
    for (NSUInteger i=0; i<names.count; i++) {
        ContractModel *item = [[ContractModel alloc]init];
        item.iconUrl = [NSURL URLWithString:avatarURLs[i]];
        item.name = names[i];
        [items addObject:item];
    }
    
    ContractListViewController *contractVc = [[ContractListViewController alloc] init];
    contractVc.items = items;
    [self pushViewController:contractVc animated:YES];
   
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return 4;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
   
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"cell"];
        cell.backgroundColor = [UIColor clearColor];
    }
//    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.selectedBackgroundView = [[UIView alloc] initWithFrame:cell.frame];
    cell.selectedBackgroundView.backgroundColor = [UIColor colorWithRed:0.302 green:0.302 blue:0.302 alpha:1.0];
    cell.textLabel.textColor = [UIColor whiteColor];
    cell.textLabel.font = [UIFont systemFontOfSize:14];
    if (indexPath.row == 0) {
        
        cell.textLabel.text = @"添加朋友";
        
    }else if (indexPath.row == 1){
    
        cell.textLabel.text = @"发起群聊";
        
    }else if (indexPath.row == 2){
        
        cell.textLabel.text = @"扫一扫";
        
    }else if (indexPath.row == 3){
        
        cell.textLabel.text = @"我的二维码";
        
    }
    
    
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{

    for (UIView *cover in [UIApplication sharedApplication].keyWindow.subviews) {
        if ([cover isKindOfClass:[LFPopView class]]) {
            cover.hidden = YES;
            [cover removeFromSuperview];
            
        }
    }
    if (indexPath.row == 0) {

        AddressBookViewController *addressVc = [[AddressBookViewController alloc] init];
       
//       [self presentViewController:addressVc animated:YES completion:nil];
        [self pushViewController:addressVc animated:YES];
        
    }else if (indexPath.row == 1){
    
        GroupChatViewController *groupVc = [[GroupChatViewController alloc] init];
        [self pushViewController:groupVc animated:YES];
        
    }else if (indexPath.row == 2){
        
//        ScanViewController *scanVc = [[ScanViewController alloc] init];
//        [self pushViewController:scanVc animated:YES];
        [self scan];
        
    }else if (indexPath.row == 3){
        
        QRCodeViewController *qrcodeVc = [[QRCodeViewController alloc] init];
        [self pushViewController:qrcodeVc animated:YES];
    }
    
}

- (void)scan{
    ScanViewController *scanVc = [[ScanViewController alloc] init];
    scanVc.delegate = self;
    if (![UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
        NSLog(@"不支持相机");
        return;
    }
    [self pushViewController:scanVc animated:YES];
    
    
}
- (void)qrCodeError:(NSError *)error{}
- (void)qrCodeComplete:(NSString *)codeString{}
@end
