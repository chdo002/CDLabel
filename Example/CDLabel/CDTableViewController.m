//
//  CDTableViewController.m
//  CDLabel_Example
//
//  Created by chdo on 2018/6/28.
//  Copyright © 2018年 chdo002. All rights reserved.
//

#import "CDTableViewController.h"
#import <CDLabel/CDLabel.h>
#import <CDDevUtility/CDDevuUtilty.h>
@interface CDTableViewController ()
{
    NSMutableArray *strs;
    
}
@end

@implementation CDTableViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    
    strs = [NSMutableArray array];
   
}

-(void)viewDidAppear:(BOOL)animated{
    for (int i = 0; i < 100; i++) {
        [strs addObject:[self generateRamowText]];
    }
    [self.tableView reloadData];
    NSLog(@"ok");
}

#pragma mark - Table view data source

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return strs.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    __block UITableViewCell *cell;
    [CDPerformance timeCost:^{
        cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
        
        CDLabel *label = (CDLabel *)cell.contentView.subviews.firstObject;
        if (!label) {
            label = [[CDLabel alloc] initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, 50)];
            [cell.contentView addSubview:label];
            CTDataConfig config = [CTData defaultConfig];
            config.textSize = 12;
            label.config = config;
        }
        label.text = [NSString stringWithFormat:@"%ld--:%@",(long)indexPath.row,self->strs[indexPath.row]];
    }];
    
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 800;
}

-(NSString *)generateRamowText{
    uint32_t strLength = 1000;
    NSMutableString *str = [NSMutableString string];
    NSArray *emojiArr = @[@"[尴尬]",@"[发怒]",@"[微笑]",@"[大笑]",@"[大哭]",@"[色]",@"[冷汗]",@"[抓狂]",@"[吐]",@"[愉快]",@"[白眼]",@"[傲慢]",@"[困]"];
    for (int i = 0; i < strLength; i++) {
        if (i % 2 == 1) {
            [str appendFormat:@"%@",emojiArr[arc4random() % emojiArr.count]];
        } else {
            [str appendFormat:@"%d",i];
        }
    }
    return [str copy];
}

-(void)didReceiveMemoryWarning{
    
}

@end
