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

    NSString *msgContent = @"开始21341234123asdfsdfo大家否金佛寺定金佛山就结束佛寺定金佛山就结束佛寺定金佛山就结束佛寺定金佛山就结束佛寺定金佛山就结束佛寺定金佛山就结束佛寺定金佛山就结束佛寺定金佛山就结束佛寺定金佛山就结束佛寺定金佛山就结束佛寺定金佛山就结束佛寺定金佛山就结束佛寺定金佛山就结束佛寺定金佛山就结束佛寺定金佛山就结束佛寺定金佛山就结束佛寺定金佛山就结束佛寺定金佛山就结束佛寺定金佛山就结束佛寺定金佛山就结束佛寺定金佛山就结束佛寺定金佛山就结束佛寺定金佛山就结束佛寺定金佛山就结束佛寺定金佛山就结束佛寺定金佛山就结束佛寺定金佛山就结束大家否金佛寺定金佛山就结束佛寺定金佛山就结束佛寺定金佛山就结束佛寺定金佛山就结束佛寺定金佛山就结束佛寺定金佛山就结束佛寺定金佛山就结束佛寺定金佛山就结束佛寺定金佛山就结束佛寺定金佛山就结束佛寺定金佛山就结束佛寺定金佛山就结束佛寺定金佛山就结束佛寺定金佛山就结束佛寺定金佛山就结束佛寺定金佛山就结束佛寺定金佛山就结束佛寺定金佛山就结束佛寺定金佛山就结束佛寺定金佛山就结束佛寺定金佛山就结束佛寺定金佛山就结束佛寺定金佛山就结束佛寺定金佛山就结束佛寺定金佛山就结束佛寺定金佛山就结束佛寺定金佛山就结束ijsdfoi阿斯蒂阿斯蒂芬奇偶及价格芬撒低价结束";
    

    CTData *data = [CTData dataWithStr:msgContent containerWithSize:CGSizeMake(200, CGFLOAT_MAX)];
    CDLabel *label = [[CDLabel alloc] initWithFrame:CGRectMake(50, 150, data.width, data.height)];
    label.backgroundColor = [UIColor whiteColor];
    label.data = data;
    [self.view addSubview:label];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(obsenoti:) name:CTCLICKMSGEVENTNOTIFICATION object:nil];
}

-(void)obsenoti:(NSNotification *)noti{
    
}

@end
