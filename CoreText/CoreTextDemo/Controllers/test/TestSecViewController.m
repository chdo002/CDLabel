//
//  TestSecViewController.m
//  CoreTextDemo
//
//  Created by chdo on 2017/11/30.
//  Copyright © 2017年 TangQiao. All rights reserved.
//

#import "TestSecViewController.h"
#import "TestView.h"

#import "CTFrameParserConfig.h"
#import "CTFrameParser.h"


@interface TestSecViewController ()

@end

@implementation TestSecViewController

- (void)viewDidLoad {
    [super viewDidLoad];
   
}
    
-(void)viewDidAppear:(BOOL)animated{
    
    NSMutableAttributedString *attString = [[NSMutableAttributedString alloc] init];
    
    //     普通富文本
    NSAttributedString *attStr = [self fact: @"isjoijosa哦时间大佛我熬时间佛已董事局佛我阿佛奇偶ojf"
                                      color: [UIColor blueColor]
                                   fontSize: 15];
    
    //     产生一个图片占位符
    UIFont *font = [UIFont systemFontOfSize:15];
    
    NSDictionary *imgInfoDic = @{@"ascent":@(font.ascender),
                                 @"descent":@(font.descender),
                                 @"width":@(font.pointSize)
                                 };

    NSMutableAttributedString *imageString = [self imageStrFromDictionary:imgInfoDic size:15];
    [attString appendAttributedString:attStr];
    [attString appendAttributedString:imageString];
    
    //     创建framesetter
    CTFramesetterRef framesetter = CTFramesetterCreateWithAttributedString((CFAttributedStringRef)attString);
    
    // 设置绘制范围
    // -- 计算内容范围
    CGSize boundingSize = CGSizeMake(200, CGFLOAT_MAX);
    CGSize caedSize = CTFramesetterSuggestFrameSizeWithConstraints(framesetter, CFRangeMake(0,attString.length), nil, boundingSize, nil);

    CGSize caSize = CGSizeMake(ceilf(caedSize.width), ceilf(caedSize.height));
    // -- 创建显示范围
    CGPathRef path = CGPathCreateWithRect(CGRectMake(0, 0, caSize.width, caSize.height), NULL);
    // 创建显示frame
    CTFrameRef frame = CTFramesetterCreateFrame(framesetter,
                                                CFRangeMake(0, [attString length]), path, NULL);

    TestView *testV = [[TestView alloc] initWithFrame:CGRectMake(50, 50, caSize.width, caSize.height)];
    [self.view addSubview:testV];

    testV.ctFrame = frame;
    
}
    
-(NSAttributedString *)fact: (NSString *)content color: (UIColor *)textColor fontSize: (CGFloat)size {

        NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
        paragraphStyle.lineSpacing = 0;
        NSDictionary * attriDic = @{
                                    NSForegroundColorAttributeName: textColor,
                                    NSFontAttributeName:  [UIFont systemFontOfSize:size],
                                    NSParagraphStyleAttributeName: paragraphStyle
                                    };
        NSAttributedString *attString = [[NSAttributedString alloc] initWithString:content attributes:attriDic];
        return attString;
}



#pragma mark
static CGFloat ascentfunc(void *ref){
    return [(NSNumber*)[(__bridge NSDictionary*)ref objectForKey:@"ascent"] floatValue];
}

static CGFloat dscentfunc(void *ref){
    return [(NSNumber*)[(__bridge NSDictionary*)ref objectForKey:@"descent"] floatValue];
}

static CGFloat widthfunc(void *ref){
    return [(NSNumber*)[(__bridge NSDictionary*)ref objectForKey:@"width"] floatValue];
}

/**
 <#Description#>

 @param dict <#dict description#>
 @param fontSize <#fontSize description#>
 @return <#return value description#>
 */
-(NSMutableAttributedString *)imageStrFromDictionary:(NSDictionary *)dict size: (CGFloat )fontSize{
    
    
    // 字形参数
    CTRunDelegateCallbacks callbacks;
    
    memset(&callbacks, 0, sizeof(CTRunDelegateCallbacks));
    callbacks.version = kCTRunDelegateVersion1;
    
    callbacks.getAscent = ascentfunc;   // 顶边到基线
    callbacks.getDescent = dscentfunc; // 底边到基线
    callbacks.getWidth = widthfunc;     //
    CTRunDelegateRef delegate = CTRunDelegateCreate(&callbacks, (__bridge void *)(dict));
    
    // 使用0xFFFC作为空白的占位符
    unichar objectReplacementChar = 0xFFFC;
    NSString * content = [NSString stringWithCharacters:&objectReplacementChar length:1];
    
    NSMutableParagraphStyle *para = [[NSMutableParagraphStyle alloc] init];
    para.lineSpacing = 0;
    NSMutableDictionary *attributes = [NSMutableDictionary dictionaryWithDictionary:@{
                                                                                NSFontAttributeName : [UIFont systemFontOfSize:fontSize],
                                                                                NSBackgroundColorAttributeName: [UIColor blackColor],
                                                                                NSParagraphStyleAttributeName:para
                                                                                }];
    NSMutableAttributedString * space = [[NSMutableAttributedString alloc] initWithString:content
                                                                               attributes:attributes];
    CFAttributedStringSetAttribute((CFMutableAttributedStringRef)space, CFRangeMake(0, 1),
                                   kCTRunDelegateAttributeName, delegate);
    CFRelease(delegate);
    
    return space;
}
    
@end
