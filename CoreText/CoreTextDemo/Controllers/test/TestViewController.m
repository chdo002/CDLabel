//
//  TestViewController.m
//  CoreTextDemo
//
//  Created by chdo on 2017/11/21.
//  Copyright © 2017年 TangQiao. All rights reserved.
//

#import "TestViewController.h"
#import "TestView.h"

@interface TestViewController ()

@property (weak, nonatomic) IBOutlet UIScrollView *scrol;

@property (weak, nonatomic) IBOutlet TestView *ctTest;

@end

@implementation TestViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

-(void)viewDidAppear:(BOOL)animated{
    
    // 设置绘制内容
    
    /*-------------------------------------------*/
    NSMutableAttributedString *attString = [[NSMutableAttributedString alloc] init];
    
    NSAttributedString *str1 = [self generateAttributeString:@"asdfassssdf·是结束"
                                                       color:[UIColor blackColor]
                                                        link:NO
                                                    fontSize:16];
    [attString appendAttributedString:str1];
    
    /*-------------------------------------------*/
    NSAttributedString *str2 = [self generateAttributeString:@"共和国害怕附近傲视·是结束"
                                                       color:[UIColor blueColor]
                                                        link:YES
                                                    fontSize:26];
    [attString appendAttributedString:str2];
    
    /*-------------------------------------------*/
    NSAttributedString *str3 = [self generateAttributeString:@"个地方公共是结束"
                                                       color:[UIColor cyanColor]
                                                        link:YES
                                                    fontSize:12];
    [attString appendAttributedString:str3];

    

    // 创建framesetter
    CTFramesetterRef framesetter = CTFramesetterCreateWithAttributedString((CFAttributedStringRef)attString);
    
    // 设置绘制范围
        // -- 计算内容范围
    CGSize boundingSize = CGSizeMake(200, CGFLOAT_MAX);
    CGSize caedSize = CTFramesetterSuggestFrameSizeWithConstraints(framesetter, CFRangeMake(0,attString.length), nil, boundingSize, nil);
    
    CGSize caSize = CGSizeMake(200, ceilf(caedSize.height));
        // -- 创建显示范围
    CGPathRef path = CGPathCreateWithRect(CGRectMake(0, 0, caSize.width, caSize.height), NULL);
    // 创建显示frame
    CTFrameRef frame = CTFramesetterCreateFrame(framesetter,
                                 CFRangeMake(0, [attString length]), path, NULL);
    
    // 修改视图位置
    self.ctTest.frame = CGRectMake(0, 0, caSize.width, caSize.height);
    
    self.scrol.contentSize = caSize;
    self.scrol.frame = CGRectMake(self.scrol.origin.x, self.scrol.origin.y, caSize.width, caSize.height);
    self.scrol.backgroundColor = [UIColor greenColor];
    // 绘制
    self.ctTest.ctFrame = frame;
    
    CFRelease(path);
    CFRelease(framesetter);
//    CFRelease(frame);

    // 总共几行
    NSArray *lines = (NSArray *)CTFrameGetLines(frame);
    NSUInteger lineCount = [lines count];
    CGPoint lineOrigins[lineCount];
    // 每行位置
    CTFrameGetLineOrigins(frame, CFRangeMake(0, 0), lineOrigins);
    
    UIView *frist = [[UIView alloc] initWithFrame:CGRectMake(20, 150, 102, 500)];
    frist.backgroundColor = [UIColor greenColor];
    [self.view addSubview:frist];
    
    for (int i = 0; i < lineCount; i++) {
        NSLog(@"%@",NSStringFromCGPoint(lineOrigins[i]));
        UIView *test = [[UIView alloc] initWithFrame:CGRectMake(20, lineOrigins[i].y, 100, 5)];
        test.backgroundColor = [UIColor redColor];
        [frist addSubview:test];
    }

//    UILabel *test = [[UILabel alloc] initWithFrame:CGRectMake(20, 200, caSize.width, 200)];
//    test.attributedText = attString;
//    test.numberOfLines = 0;
//    test.backgroundColor = [UIColor redColor];
//    [test sizeToFit];
//    [self.view addSubview:test];
    
}

-(NSAttributedString *)generateAttributeString: (NSString *)content
                                         color: (UIColor *)textColor
                                          link: (BOOL)islink
                                      fontSize: (CGFloat)size
{

    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];

    paragraphStyle.lineSpacing = 3;
    
    NSDictionary * attriDic = @{
                                NSForegroundColorAttributeName: textColor,
                                NSUnderlineStyleAttributeName: [NSNumber numberWithInteger: islink ? NSUnderlineStyleSingle : NSUnderlineStyleNone],
                                NSFontAttributeName:  [UIFont systemFontOfSize:size],
                                NSParagraphStyleAttributeName: paragraphStyle
    };
    
    
    
    NSAttributedString *attString = [[NSAttributedString alloc]
                                            initWithString:content                                            attributes:attriDic];
    return attString;
}

@end
