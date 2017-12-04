//
//  CDViewController.m
//  CDLabel
//
//  Created by chdo002 on 12/01/2017.
//  Copyright (c) 2017 chdo002. All rights reserved.
//

#import "CDViewController.h"
#import <CDLabel/CDLabel.h>
#import <CDLabel/CTHelper.h>

@interface CDViewController ()

@end

@implementation CDViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    

    NSMutableDictionary *dic;
    // 表情bundle地址
    NSString *emojiBundlePath = [[[NSBundle mainBundle] resourcePath] stringByAppendingPathComponent:@"Expression.bundle"];
    // 表情键值对
    NSDictionary<NSString *, id> *temp = [[NSDictionary alloc] initWithContentsOfFile:[emojiBundlePath stringByAppendingPathComponent:@"files/expressionImage_custom.plist"]];
    // 表情图片bundle
    NSBundle *bundle = [NSBundle bundleWithPath:emojiBundlePath];
    dic = [NSMutableDictionary dictionary];
    for (NSString *imagName in temp.allKeys) {
        UIImage *img = [UIImage imageNamed:temp[imagName] inBundle:bundle compatibleWithTraitCollection:nil];
        [dic setValue:img forKey:imagName];
    }

    [CTHelper loadImageDic:dic];

    NSString *msgContent = @"[微笑][睡][微笑][睡]回我回我回我回我回我回我回我回我回我文化和我回我回我回我回我回我回我回我回我回我文化[微笑][微笑][微笑]5678";
    
    
    CTDataConfig config;
    config.textColor = [UIColor cyanColor].CGColor;
    config.clickStrColor = [UIColor blueColor].CGColor;
    config.hilightColor = [UIColor blackColor].CGColor;
    config.lineSpace = 0;
    config.textSize = 20;
    config.lineBreakMode = NSLineBreakByCharWrapping;
    CTData *data = [CTData dataWithStr:msgContent containerWithSize:CGSizeMake(200, CGFLOAT_MAX) configuration:config];
    CDLabel *label = [[CDLabel alloc] initWithFrame:CGRectMake(50, 150, data.width, data.height)];
    label.backgroundColor = [UIColor lightGrayColor];
    label.data = data;
    [self.view addSubview:label];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(obsenoti:) name:CHATLISTCLICKMSGEVENT object:nil];
}

-(void)obsenoti:(NSNotification *)noti{
    
}

@end
