//
//  CDViewController.m
//  CDLabel
//
//  Created by chdo002 on 12/01/2017.
//  Copyright (c) 2017 chdo002. All rights reserved.
//

#import "AttributeTextViewController.h"
#import <CDLabel/CDLabel.h>

@interface AttributeViewController ()

@end

@implementation AttributeViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    CDLabel *label = [[CDLabel alloc] initWithFrame:CGRectMake(20, 150, 200, 50)];
    
    [self.view addSubview:label];
    
    NSMutableAttributedString *attrString = [[NSMutableAttributedString alloc] init];
    NSMutableDictionary *attributs = [NSMutableDictionary dictionary];
    
    attributs[NSFontAttributeName] = [UIFont systemFontOfSize:12];
    attributs[NSForegroundColorAttributeName] = [UIColor blackColor];
    attributs[NSBackgroundColorAttributeName] = [UIColor cyanColor];
    NSAttributedString *line1 = [[NSAttributedString alloc] initWithString:@"123123" attributes:attributs];
    
    attributs[NSForegroundColorAttributeName] = [UIColor blueColor];
    attributs[NSFontAttributeName] = [UIFont systemFontOfSize:15];
    NSAttributedString *line2 = [[NSAttributedString alloc] initWithString:@"\n第二行" attributes:attributs];
    
    attributs[NSForegroundColorAttributeName] = [UIColor redColor];
    attributs[NSFontAttributeName] = [UIFont systemFontOfSize:20];
    attributs[NSBackgroundColorAttributeName] = [UIColor greenColor];
    NSAttributedString *line3 = [[NSAttributedString alloc] initWithString:@"\n第3行" attributes:attributs];
    
    //富文本
    NSString *message = @"我是郝高明，外号小胖，哈哈~";
    NSMutableAttributedString *str = [[NSMutableAttributedString alloc]initWithString:message attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:16]}];
    
    NSTextAttachment *attachment = [[NSTextAttachment alloc]initWithData:nil ofType:nil];
    UIImage *image = [UIImage imageNamed:@"123.png"];
    attachment.image = image;
    attachment.bounds = CGRectMake(0, 0, 20, 20);

    NSAttributedString *text = [NSAttributedString attributedStringWithAttachment:attachment];
    [str insertAttributedString:text atIndex:5];

    [attrString appendAttributedString:line1];
    [attrString appendAttributedString:line2];
    [attrString appendAttributedString:line3];
    [attrString appendAttributedString:str];
    
    label.attributedText = attrString;
    
    
    UILabel *labs = [[UILabel alloc] initWithFrame:CGRectMake(20, 300, 200, 200)];
    labs.attributedText = str;
    [self.view addSubview:labs];
}


-(void)viewDidAppear:(BOOL)animated{

    
    
    
    
}

@end
