//
//  AddressBookViewController.m
//  OTO
//
//  Created by apple on 16/3/1.
//  Copyright © 2016年 xyb100. All rights reserved.
//

#import "AddressBookViewController.h"
#import "MultiSelectedPanel.h"
#import "AddressBookCell.h"
#import <Contacts/Contacts.h>
#import <ContactsUI/ContactsUI.h>
#import "THContract.h"
@interface AddressBookViewController ()<UITableViewDelegate,UITableViewDataSource,MultiSelectedPanelDelegate,UISearchResultsUpdating>
@property (nonatomic,strong) UITableView *tableView;
@property (nonatomic,strong) MultiSelectedPanel *panel;
@property (nonatomic,strong) NSMutableArray *addressBookItems;
@property (nonatomic,strong) NSMutableDictionary *sectiondict;
@property (nonatomic,strong) UISearchController *searchController;
@property (nonatomic,strong) NSMutableArray *searchArray;
@property (nonatomic,strong) NSMutableArray *contractArray;
@property (nonatomic,strong) NSMutableArray *seletedArray;
@end

@implementation AddressBookViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view addSubview:self.tableView];
    [self.view addSubview:self.panel];
    [self loadAllAddressBookContacts];
    [self creatSearchBar];

}


- (void)creatSearchBar{
    self.searchController = [[UISearchController alloc] initWithSearchResultsController:nil];
    self.searchController.searchResultsUpdater = self;
    self.searchController.dimsBackgroundDuringPresentation = NO;
    self.searchController.hidesNavigationBarDuringPresentation = YES;
    self.searchController.searchBar.frame = CGRectMake(0, 0, self.view.width, 44);
    self.searchController.searchBar.backgroundColor = [UIColor clearColor];
    self.tableView.tableHeaderView = self.searchController.searchBar;
    self.sectiondict = [NSMutableDictionary dictionaryWithCapacity:0];
    NSMutableArray *letters = [@[@"A",@"B",@"C",@"D",@"E",@"F",@"G",@"H",@"I",@"J",@"K",@"L",@"M",@"N",@"O",@"P",@"Q",@"R",@"S",@"T",@"U",@"V",@"W",@"X",@"Y",@"Z",@"#"]mutableCopy];
    for (NSString *letter in letters) {
        self.sectiondict[letter] = [NSMutableArray array];
        
    }
    for (THContract *model in self.addressBookItems) {
        NSString *firstLetter = [self firstLetterOfString:model.fullName];
        [self.sectiondict[firstLetter] addObject:model];
    }
    
    // 删除没有元素的字母key
    for (NSString *key in self.sectiondict.allKeys) {
        NSArray *values = self.sectiondict[key];
        if (values.count == 0) {
            [letters removeObject:key];
        }else{
            
            self.sectiondict[key] = [values sortedArrayUsingComparator:^NSComparisonResult(id  _Nonnull obj1, id  _Nonnull obj2) {
                THContract *model1 = obj1;
                THContract *model2 = obj2;
                return [model1.fullName localizedCompare:model2.fullName];
            }];
        }
    }
    self.contractArray = letters;
    [self.tableView reloadData];

}

- (void)loadAllAddressBookContacts{
    CNContactStore *store = [[CNContactStore alloc] init];
    CNContactFetchRequest *request = [[CNContactFetchRequest alloc] initWithKeysToFetch:@[CNContactFamilyNameKey,CNContactGivenNameKey,CNContactPhoneNumbersKey,CNContactImageDataKey]];
    NSError *error = nil;
    
    //执行获取通讯录请求，若通讯录可获取，flag为YES，代码块也会执行，若获取失败，flag为NO，代码块不执行
    BOOL flag = [store enumerateContactsWithFetchRequest:request error:&error usingBlock:^(CNContact * _Nonnull contact, BOOL * _Nonnull stop) {
        //        NSLog(@"%@",contact);
        //去除数字以外的所有字符
        NSCharacterSet *setToRemove = [[ NSCharacterSet characterSetWithCharactersInString:@"0123456789"]
                                       invertedSet ];
        NSString *strPhone = @"";
        if (contact.phoneNumbers.count>0) {
            strPhone  = [[[contact.phoneNumbers firstObject].value.stringValue componentsSeparatedByCharactersInSet:setToRemove] componentsJoinedByString:@""];
        }
        
        THContract *contract = [[THContract alloc] init];
        contract.lastName = contact.familyName;
        contract.firstName = contact.givenName;
        contract.phone = strPhone;
        
        UIImage *image = [UIImage imageWithData:contact.imageData];
        if (!image) {
            
            image = [UIImage imageNamed:@"icon-avatar-60x60"];
            
        }
        contract.image = image;
        
        [self.addressBookItems addObject:contract];
        
    }];
    
    if (flag) {
//        [self.tableView reloadData];
    }

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {

    
    if (!self.searchController.active) {
        return self.contractArray.count;
    }else{
        return 1;
    }
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    if (!self.searchController.active) {
        NSArray *values = self.sectiondict[self.contractArray[section]];
        return values.count;
    }else{
        
        return self.searchArray.count;
    }
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *identifier = @"address";
    AddressBookCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (cell == nil) {
    
        NSArray *nibTableCells = [[NSBundle mainBundle] loadNibNamed:@"AddressBookCell" owner:self options:nil];
        cell = [nibTableCells objectAtIndex:0];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    if (!self.searchController.active) {
        NSArray *values = self.sectiondict[self.contractArray[indexPath.section]];
        
        THContract *contact = values[indexPath.row];
        cell.contact = contact;

    }else{
        
        THContract *contact = self.searchArray[indexPath.row];
        cell.contact = contact;
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
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{

//    THContract *contact = self.addressBookItems[indexPath.row];
    THContract *contact;
    if (!self.searchController.active) {
        NSArray *values = self.sectiondict[self.contractArray[indexPath.section]];
        
        contact = values[indexPath.row];

        
    }else{
        
        contact = self.searchArray[indexPath.row];

    }

    if (contact.selected) {
        
        contact.selected = NO;
        
    }else{
    
        contact.selected = YES;
    }
    if ([self.seletedArray containsObject:contact]) {
        [self.seletedArray removeObject:contact];
    }else{
        [self.seletedArray addObject:contact];
    }
    [self.tableView reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationNone];
    self.panel.selectedItems = self.seletedArray;

}
- (void)didConfirmWithMultiSelectedPanel:(MultiSelectedPanel *)multiSelectedPanel{

    NSLog(@"点击了确认按钮");
    
}

- (void)willDeleteRowWithItem:(THContract *)item withMultiSelectedPanel:(MultiSelectedPanel *)multiSelectedPanel{

    NSLog(@"删除组");
}

#pragma mark  UISearchResultsUpdating

- (void)updateSearchResultsForSearchController:(UISearchController *)searchController{
    NSString *searchString = self.searchController.searchBar.text;
    NSPredicate *preicate = [NSPredicate predicateWithFormat:@"fullName CONTAINS[c] %@", searchString];//用predicateWithFormat创建一个谓词，name作为键路径
    if (self.searchArray!= nil) {
        [self.searchArray removeAllObjects];
    }
    //过滤数据
    self.searchArray = [NSMutableArray arrayWithArray:[self.addressBookItems filteredArrayUsingPredicate:preicate]];
    
    
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




#pragma mark 懒加载

- (UITableView *)tableView{

    if (_tableView == nil) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, self.view.width, self.view.height - 44) style:UITableViewStylePlain];
        _tableView.rowHeight = 44;
        _tableView.delegate = self;
        _tableView.dataSource = self;
    }
    return _tableView;
}

- (MultiSelectedPanel *)panel{

    if (_panel == nil) {
        _panel = [MultiSelectedPanel instanceFromNib];
        _panel.frame = CGRectMake(0, CGRectGetMaxY(self.tableView.frame), self.view.width, 44);
        _panel.delegate = self;
        
    }
    return _panel;
}

- (NSMutableArray *)addressBookItems{

    if (_addressBookItems == nil) {
        _addressBookItems = [NSMutableArray arrayWithCapacity:0];
    }
    return _addressBookItems;
}

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

- (NSMutableArray *)seletedArray{

    if (_seletedArray == nil) {
        _seletedArray = [NSMutableArray arrayWithCapacity:0];
    }
    return _seletedArray;
}
@end
