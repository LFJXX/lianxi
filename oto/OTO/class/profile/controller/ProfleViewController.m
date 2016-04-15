//
//  ProfleViewController.m
//  OTO
//
//  Created by apple on 15/12/29.
//  Copyright © 2015年 xyb100. All rights reserved.
//

#import "ProfleViewController.h"

@interface ProfleViewController ()
@property (weak, nonatomic) IBOutlet UIImageView *iconVIew;
@property (weak, nonatomic) IBOutlet UILabel *nameLable;
@property (weak, nonatomic) IBOutlet UILabel *accountLable;
@property (weak, nonatomic) IBOutlet UILabel *integralLable;
@end

@implementation ProfleViewController
- (IBAction)signIn:(id)sender {
}
- (IBAction)waitPay:(id)sender {
}
- (IBAction)waitShipments:(id)sender {
}
- (IBAction)waitConsignee:(id)sender {
}
- (IBAction)waitComment:(id)sender {
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.iconVIew.layer.cornerRadius = 10;
    self.iconVIew.layer.masksToBounds = YES;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{

    if (section == 0) {
        return 0;
    }
    return 10;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{

    if (section == 0) {
        return nil;
    }
    UIView *headView = [[UIView alloc] init];
    headView.backgroundColor = LFLightGrayColor;
    return headView;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{

    
    
    
}
@end
