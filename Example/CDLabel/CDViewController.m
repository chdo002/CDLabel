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
    
    NSString *msgContent = @"开始奥斯丁金佛琼斯[微笑][微笑][微笑][微笑][微笑][微笑][微笑]就哦爱时间佛寺结束";
    
    CTData *data = [CTData dataWithStr:msgContent containerWithSize:CGSizeMake(200, CGFLOAT_MAX)];
    
    CDLabel *label = [[CDLabel alloc] initWithFrame:CGRectMake(50, 50, data.width, data.height)];
    label.data = data;
    [self.view addSubview:label];
}

@end
