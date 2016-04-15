//
//  ContractListViewController.m
//  OTO
//
//  Created by apple on 16/2/29.
//  Copyright © 2016年 xyb100. All rights reserved.
//

#import "ContractListViewController.h"
#import "ContractModel.h"
#import "ContractListCell.h"
#import "UIImageView+WebCache.h"
@interface ContractListViewController ()<UISearchResultsUpdating,UITableViewDelegate,UITableViewDataSource>
@property (nonatomic,strong) UISearchController *searchController;
@property (nonatomic,strong) NSMutableArray *searchArray;
@property (nonatomic,strong) NSMutableArray *contractArray;
@property (nonatomic,strong) NSMutableDictionary *sectiondict;
@property (nonatomic,strong) UITableView *tableView;

@end

@implementation ContractListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    [self creatSearchController];
    self.sectiondict = [NSMutableDictionary dictionaryWithCapacity:0];
    NSMutableArray *letters = [@[@"A",@"B",@"C",@"D",@"E",@"F",@"G",@"H",@"I",@"J",@"K",@"L",@"M",@"N",@"O",@"P",@"Q",@"R",@"S",@"T",@"U",@"V",@"W",@"X",@"Y",@"Z",@"#"]mutableCopy];
    for (NSString *letter in letters) {
        self.sectiondict[letter] = [NSMutableArray array];
        
    }
    for (ContractModel *model in self.items) {
        NSString *firstLetter = [self firstLetterOfString:model.name];
        [self.sectiondict[firstLetter] addObject:model];
    }
    
    // 删除没有元素的字母key
    for (NSString *key in self.sectiondict.allKeys) {
        NSArray *values = self.sectiondict[key];
        if (values.count == 0) {
            [letters removeObject:key];
        }else{
        
            self.sectiondict[key] = [values sortedArrayUsingComparator:^NSComparisonResult(id  _Nonnull obj1, id  _Nonnull obj2) {
                ContractModel *model1 = obj1;
                ContractModel *model2 = obj2;
                return [model1.name localizedCompare:model2.name];
            }];
        }
    }
    self.contractArray = letters;
}

- (void)creatSearchController{
    [self.view addSubview:self.tableView];
    self.searchController = [[UISearchController alloc] initWithSearchResultsController:nil];
    self.searchController.searchResultsUpdater = self;
    self.searchController.dimsBackgroundDuringPresentation = NO;
    self.searchController.hidesNavigationBarDuringPresentation = YES;
    self.searchController.searchBar.frame = CGRectMake(0, 0, self.view.width, 44);
    self.searchController.searchBar.backgroundColor = [UIColor clearColor];
    self.tableView.tableHeaderView = self.searchController.searchBar;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{

    if (!self.searchController.active) {
        return self.contractArray.count;
    }else{
        
        return 1;
    }
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{

    if (!self.searchController.active) {
        NSArray *values = self.sectiondict[self.contractArray[section]];
        return values.count;
    }else{
    
        return self.searchArray.count;
    }
    
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{

    static NSString *identifier = @"contract";
    ContractListCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
   
    if (!self.searchController.active) {
         NSArray *values = self.sectiondict[self.contractArray[indexPath.section]];

        ContractModel *model = values[indexPath.row];
        [cell.iconView sd_setImageWithURL:model.iconUrl];
        cell.nameLable.text = model.name;
    }else{
    
        ContractModel *model = self.searchArray[indexPath.row];
        [cell.iconView sd_setImageWithURL:model.iconUrl];
        cell.nameLable.text = model.name;
    }
   
    return cell;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{

    if (!self.searchController.active) {
        return self.contractArray[section];
    }else{
    
        return nil;
    }
}

- (NSArray<NSString *> *)sectionIndexTitlesForTableView:(UITableView *)tableView{

    if (!self.searchController.active) {
        
        return self.contractArray;
    }else{
    
        return nil;
    }
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if (!self.searchController.active) {
        
        return 25;
    }else{
        
        return 0;
    }
   
}
#pragma mark  UISearchResultsUpdating

- (void)updateSearchResultsForSearchController:(UISearchController *)searchController{
    NSString *searchString = self.searchController.searchBar.text;
    NSPredicate *preicate = [NSPredicate predicateWithFormat:@"name CONTAINS[c] %@", searchString];//用predicateWithFormat创建一个谓词，name作为键路径
    if (self.searchArray!= nil) {
        [self.searchArray removeAllObjects];
    }
    //过滤数据
    self.searchArray = [NSMutableArray arrayWithArray:[self.items filteredArrayUsingPredicate:preicate]];
    

    [self.tableView reloadData];
}

#pragma mark - common
- (NSString*)firstLetterOfString:(NSString*)chinese
{
    CFMutableStringRef string = CFStringCreateMutableCopy(NULL, 0, (__bridge CFMutableStringRef)[NSMutableString stringWithString:chinese]);
    CFStringTransform(string, NULL, kCFStringTransformMandarinLatin, NO);
    CFStringTransform(string, NULL, kCFStringTransformStripDiacritics, NO);
    
    NSMutableString *aNSString = (__bridge NSMutableString *)string;
    NSString *finalString = [aNSString stringByReplacingOccurrencesOfString:[NSString stringWithFormat:@"%c", 32] withString:@""];
    
    
    NSString *firstLetter = [[finalString substringToIndex:1]uppercaseString];
    if (!firstLetter||firstLetter.length<=0) {
        firstLetter = @"#";
    }else{
        unichar letter = [firstLetter characterAtIndex:0];
        if (letter<65||letter>90) {
            firstLetter = @"#";
        }
    }
    return firstLetter;
}


#pragma mark  懒加载
- (NSMutableArray *)searchArray{
    if (_searchArray == nil) {
        _searchArray = [NSMutableArray arrayWithCapacity:0];
    }
    return _searchArray;
    
}

- (NSMutableArray *)contractArray{

    if (_contractArray == nil) {
        _contractArray = [NSMutableArray arrayWithCapacity:0];
    }
    return _contractArray;
}

- (UITableView *)tableView{
  
    if (_tableView == nil) {
        UITableView *tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, self.view.width, self.view.height)];
        _tableView = tableView;
        [_tableView registerNib:[UINib nibWithNibName:@"ContractListCell" bundle:nil] forCellReuseIdentifier:@"contract"];
        _tableView.delegate = self;
        _tableView.dataSource = self;
       
    }
    return _tableView;
}
@end
