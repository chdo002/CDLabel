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


@interface DataSource: NSObject

@property(nonatomic, strong)NSMutableArray *strs;
@property(class, nonatomic, strong, readonly) DataSource *share;
@end

@implementation DataSource
+(instancetype)share{
    
    static dispatch_once_t onceToken;
    static DataSource *single;
    
    dispatch_once(&onceToken, ^{
        single = [[DataSource alloc] init];
        single.strs = [NSMutableArray array];
        
        for (int i = 0; i < 1000; i++) {
            [single.strs addObject:[single generateRamowText]];
        }
    });
    return single;
}


-(NSString *)generateRamowText{
    uint32_t strLength = 2000;
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



@end

@interface CDTableViewController ()

@end

@implementation CDTableViewController
+ (void)load{
    DataSource.share;
}
- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    
}

-(void)viewDidAppear:(BOOL)animated{
    [self.tableView reloadData];
}

#pragma mark - Table view data source

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return DataSource.share.strs.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    
    CDLabel *label = (CDLabel *)cell.contentView.subviews.firstObject;
    if (!label) {
        label = [[CDLabel alloc] initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, 50)];
        [cell.contentView addSubview:label];
        CTDataConfig config = [CTData defaultConfig];
        config.textSize = 12;
        label.config = config;
    }
    label.text = [NSString stringWithFormat:@"%ld-----------:%@",(long)indexPath.row,DataSource.share.strs[indexPath.row]];
    
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 800;
}

-(void)didReceiveMemoryWarning{
    
}

@end
