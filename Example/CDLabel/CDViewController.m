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

    NSString *msgContent = @"开始偶是奇偶覅到iOS哦粉丝哦法搜藕丝飞机师ios飞飞机是滴哦附件阿婆是否POI骄傲怕死哦ISA熊生怕第psoriasis奥鹏已哦s附件搜if就偶记[凋谢][惊恐][困][得意][鼓掌][刀][害羞][礼物][瓢虫][流泪][吐][悠闲][磕头][糗大了][啤酒][NO][菜刀][咒骂][睡][爱情][蛋糕][便便][胜利][勾引][委屈][右太极][篮球][愉快][嘘][衰][抠鼻][献吻][心碎][强][OK][弱][调皮][晕][憨笑][左哼哼][酷][呲牙][激动][跳跳][握手][鄙视][抱拳][尴尬][吓][回头][炸弹][转圈][饭][可怜][闪电][拥抱][左太极][哈欠][拳头][飞吻][发抖][嘴唇][难过][色][撇嘴][玫瑰][咖啡][差劲][偷笑][微笑][爱你][抓狂][擦汗][月亮][再见][西瓜][阴险][乱舞][快哭了][投降][疑问][亲亲][敲打][骷髅][乒乓][饥饿][奋斗][跳绳][闭嘴][太阳][疯了][发呆][白眼][坏笑][怄火][惊讶][右哼哼][凋谢][惊恐][困][得意][鼓掌][刀][害羞][礼物][瓢虫][流泪][吐][悠闲][磕头][糗大了][啤酒][NO][菜刀][咒骂][睡][爱情][蛋糕][便便][胜利][勾引][委屈][右太极][篮球][愉快][嘘][衰][抠鼻][献吻][心碎][强][OK][弱][调皮][晕][憨笑][左哼哼][酷][呲牙][激动][跳跳][握手][鄙视][抱拳][尴尬][吓][回头][炸弹][转圈][饭][可怜][闪电][拥抱][左太极][哈欠]结束";
    

    CTData *data = [CTData dataWithStr:msgContent containerWithSize:CGSizeMake(200, CGFLOAT_MAX)];
    CDLabel *label = [[CDLabel alloc] initWithFrame:CGRectMake(50, 150, data.width, data.height)];
    label.backgroundColor = [UIColor whiteColor];
    label.data = data;
    [self.view addSubview:label];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(obsenoti:) name:CHATLISTCLICKMSGEVENT object:nil];
}

-(void)obsenoti:(NSNotification *)noti{
    
}

@end
