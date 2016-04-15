//
//  CatoryViewController.m
//  OTO
//
//  Created by apple on 15/12/29.
//  Copyright © 2015年 xyb100. All rights reserved.
//

#import "CatoryViewController.h"
#import "GoodsListCell.h"

@interface CatoryViewController ()<UITableViewDelegate,UITableViewDataSource,GoodsListCellDelegate>
@property (nonatomic,weak) UITableView *menuView;
@property (nonatomic,weak) UITableView *listView;
@property (nonatomic,strong) NSMutableArray *menuArray;
@property (nonatomic,strong) NSMutableArray *listArray;

@end

@implementation CatoryViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    [self prepareMenuAndList];
    

}

- (void)prepareMenuAndList{
    UITableView *firstView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, 100, self.view.height) style:UITableViewStylePlain];
    self.menuView = firstView;
    self.menuView.delegate = self;
    self.menuView.dataSource = self;
    self.menuView.backgroundColor = LFLightGrayColor;
    [self.view addSubview:firstView];
    UITableView *secondView = [[UITableView alloc] initWithFrame:CGRectMake(CGRectGetMaxX(firstView.frame)+10,64, self.view.width - CGRectGetMaxX(firstView.frame)-10, self.view.height-64) style:UITableViewStylePlain];
    self.listView = secondView;
    self.listView.delegate = self;
    self.listView.dataSource = self;
//    [self.listView registerNib:[UINib nibWithNibName:@"GoodsListView" bundle:nil] forCellReuseIdentifier:@"list"];
    [self.listView registerNib:[UINib nibWithNibName:@"GoodsListView" bundle:nil] forCellReuseIdentifier:@"list"];
    [self.view addSubview:secondView];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    return tableView == self.menuView ? 1 : self.menuArray.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return tableView == self.menuView ? self.menuArray.count : 15;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UIView *bgView = [[UIView alloc] init];
    bgView.backgroundColor = [UIColor whiteColor];
    NSString *identifier = tableView == self.menuView ? @"menu" : @"list";
    if ([identifier isEqualToString:@"menu"]) {
        UITableViewCell *cell =[tableView dequeueReusableCellWithIdentifier:identifier];
        if (cell == nil) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
        }
        cell.backgroundColor = LFLightGrayColor;
        cell.selectedBackgroundView  = bgView;
        cell.textLabel.text = self.menuArray[indexPath.row];
        cell.textLabel.font = [UIFont systemFontOfSize:14];
        return cell;
    }else{
        GoodsListCell *listCell = [tableView dequeueReusableCellWithIdentifier:@"list" forIndexPath:indexPath];
//        listCell.selectedBackgroundView  = bgView;
        listCell.selectionStyle = UITableViewCellSelectionStyleNone;
        listCell.delegate = self;
        [listCell confignData];
        return listCell;
    }
    
    
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (tableView == self.menuView) {
        
        [self.listView selectRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:indexPath.row] animated:NO scrollPosition:UITableViewScrollPositionTop];
    }else{
        
        [self.menuView selectRowAtIndexPath:[NSIndexPath indexPathForRow:indexPath.section inSection:0] animated:NO scrollPosition:UITableViewScrollPositionNone];
    }
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    
    UILabel *headView = [[UILabel alloc] init];
    headView.text = [self.menuArray objectAtIndex:section];
    headView.font = [UIFont systemFontOfSize:14];
    headView.backgroundColor = LFLightGrayColor;
    if (tableView == self.menuView) {
        return nil;
    }
    return headView;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if (tableView == self.menuView) {
        return 0;
    }
    return 30;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (tableView == self.menuView) {
        return 40;
    }
    return 105;
    
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    
    NSIndexPath *indexPath = [self.listView indexPathForRowAtPoint:CGPointMake(scrollView.contentOffset.x, scrollView.contentOffset.y)];
    [self.menuView selectRowAtIndexPath:[NSIndexPath indexPathForRow:indexPath.section inSection:0] animated:NO scrollPosition:UITableViewScrollPositionNone];
//    NSLog(@"%zd---%zd",indexPath.section,indexPath.row);
}

- (void)buyButtonClick:(UIButton *)sender event:(id)event{
    NSSet *touches =[event allTouches];
    UITouch *touch =[touches anyObject];
    CGPoint currentTouchPosition = [touch locationInView:self.listView];
    NSIndexPath *indexPath= [self.listView indexPathForRowAtPoint:currentTouchPosition];
    
    NSLog(@"按钮点击的组和行%zd--%zd",indexPath.section,indexPath.row);
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSArray *)menuArray{

    if (_menuArray == nil) {
        _menuArray = [NSMutableArray arrayWithObjects:@"热销榜",@"优质水果",@"香浓牛奶",@"生鲜蔬菜",@"美味熟食",@"精品肉禽",@"零食上新",@"日常用品",@"其它", nil];
        
    }
    return _menuArray;
}

@end
