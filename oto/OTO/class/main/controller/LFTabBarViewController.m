//
//  LFTabBarViewController.m
//  XinYongZhangZhongBao
//
//  Created by apple on 15/9/21.
//  Copyright (c) 2015年 xyb100. All rights reserved.
//


#import "LFTabBarViewController.h"
#import "LFTabBar.h"

@interface LFTabBarViewController ()<LFTabBarDelegate>
@property (nonatomic,strong) NSMutableArray *items;
@end

@implementation LFTabBarViewController

- (void)viewDidLoad {
    [super viewDidLoad];
//    [self.tabBar setBarTintColor: [UIColor whiteColor]];
    [self.tabBar setBarTintColor:LFLightGrayColor];
    [self addChindrenController];
    [self setUpTabBar];

    
}

- (NSMutableArray *)items{

    if (_items == nil) {
        _items = [NSMutableArray arrayWithCapacity:0];
    }
    return _items;
}
- (void)setUpTabBar{

    LFTabBar *tabbar = [[LFTabBar alloc] init];
    tabbar.frame = self.tabBar.bounds;
    tabbar.items = self.items;
    tabbar.delegate = self;
    [self.tabBar addSubview:tabbar];
}

- (void)viewWillAppear:(BOOL)animated{

    [super viewWillAppear:animated];
    for (UIView *child in self.tabBar.subviews) {
        LFLOG(@"%@",child);
        if ([child isKindOfClass:NSClassFromString(@"UITabBarButton")]) {

            child.hidden = YES;


            
        }
    
        
    }
}

- (void)addChindrenController{
    
    
    
    HomeViewController *firstVC = [[HomeViewController alloc] init];
    [self addOneChildrenConreoller:firstVC WithImage:@"" selectImage:@"" title:@"首页"];
    
    CatoryViewController *secondVC = [[CatoryViewController alloc] init];
    [self addOneChildrenConreoller:secondVC WithImage:@"" selectImage:@"" title:@"分类"];
    
    MessageViewController *friends = [[MessageViewController alloc] init];
    [self addOneChildrenConreoller:friends WithImage:@"" selectImage:@"" title:@"发现"];
    
   
     ProfleViewController *fourVC = [UIStoryboard storyboardWithName:@"ProfleViewController" bundle:nil].instantiateInitialViewController;
//    ProfleViewController *fourVC = [[ProfleViewController alloc] init];
    [self addOneChildrenConreoller:fourVC WithImage:@"" selectImage:@"" title:@"我的"];
    
}

- (void)addOneChildrenConreoller:(UIViewController *)VC WithImage:(NSString *)image selectImage:(NSString *)selectImage title:(NSString *)title{
    UIImage *images = [UIImage imageNamed:image];
    UIImage *seleImage = [UIImage imageNamed:selectImage];
    images = [images imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    seleImage = [seleImage imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    VC.tabBarItem.image = images;
    VC.tabBarItem.selectedImage = seleImage
    ;
    VC.tabBarItem.title = title;
//    VC.title = title;
    
    
    LFNavigationController *nav = [[LFNavigationController alloc] initWithRootViewController:VC];
    [self addChildViewController:nav];
    [self.items addObject:VC.tabBarItem];
    
    
    
}

- (void)tabbarDidClick:(LFTabBar *)tabBar WithIndex:(int)index{

    self.selectedIndex = index;
}

@end
