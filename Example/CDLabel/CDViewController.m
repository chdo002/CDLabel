//
//  CDViewController.m
//  CDLabel
//
//  Created by chdo002 on 12/01/2017.
//  Copyright (c) 2017 chdo002. All rights reserved.
//

#import "CDViewController.h"
#import <CDLabel/CDLabel.h>

@interface CDViewController ()

@end

@implementation CDViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    CDLabel *label = [[CDLabel alloc] initWithFrame:CGRectMake(20, 150, 200, 50)];
    
    label.backgroundColor = [UIColor greenColor];
    label.text = @"开始21341234定[发怒]山就结束佛寺定金佛山就结束佛寺定[微笑]山就结束佛寺定[抓狂]山就结束佛寺定金佛山就结束大家否金佛寺定金佛山就结[呲牙]佛山就结束佛寺定金佛山就结束佛寺定金[惊讶]结束佛芬撒低价结束";
    
    [self.view addSubview:label];
}


-(void)viewDidAppear:(BOOL)animated{

    
    
    
    
}

@end
