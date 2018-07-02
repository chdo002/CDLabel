//
//  CDAppDelegate.m
//  CDLabel
//
//  Created by chdo002 on 12/01/2017.
//  Copyright (c) 2017 chdo002. All rights reserved.
//

#import "CDAppDelegate.h"
#import <CDLabel/CDLabel.h>
#import <GDPerformanceView/GDPerformanceMonitor.h>

@implementation CDAppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    // Override point for customization after application launch.
    [[GDPerformanceMonitor sharedInstance] startMonitoringWithConfiguration:^(UILabel *textLabel) {
        textLabel.font = [UIFont systemFontOfSize:10];
        textLabel.numberOfLines = 1;
    }];
    
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
    
    [CTHelper share].emojDic = dic;
    
    
    return YES;
}


@end
