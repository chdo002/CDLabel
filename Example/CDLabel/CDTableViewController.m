//
//  CDTableViewController.m
//  CDLabel_Example
//
//  Created by chdo on 2018/6/28.
//  Copyright © 2018年 chdo002. All rights reserved.
//

#import "CDTableViewController.h"
#import <CDLabel/CDLabel.h>

@interface CDTableViewController ()

@end

@implementation CDTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
}

#pragma mark - Table view data source
static CGFloat hei = 2;
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 50;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    NSString *msgContent = @"开始21341234定金佛山就结束佛寺定金佛山就结束佛寺定[微笑]山就结束佛寺定金佛山就结束佛寺定金佛山就结束佛寺定金佛山就结束大家否金佛寺定金佛山就结束佛寺定金佛山就结束佛寺定金佛山就结束佛寺定金佛山就结束佛芬撒低价结束";
    CTData *data = [CTData dataWithStr:msgContent containerWithSize:CGSizeMake(self.view.bounds.size.width, CGFLOAT_MAX)];
    CDLabel *label = (CDLabel *)cell.contentView.subviews.firstObject;
    label.frame = cell.contentView.bounds;
    label.data = data;
    
    hei = data.height;
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return hei;
}

@end
