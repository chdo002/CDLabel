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
}


-(void)viewDidAppear:(BOOL)animated{
    CDLabel *label = [[CDLabel alloc] initWithFrame:CGRectMake(20, 150, 200, 50)];
    
    
    label.text = @"开始21341234定金佛山就结束佛寺定金佛山就结束佛寺定[微笑]山就结束佛寺定金佛山就结束佛寺定金佛山就结束佛寺定金佛山就结束大家否金佛寺定金佛山就结束佛寺定金佛山就结束佛寺定金佛山就结束佛寺定金佛山就结束佛芬撒低价结束";
    
    [self.view addSubview:label];
    
    
    
    
}

@end
