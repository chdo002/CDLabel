//
//  TestView.m
//  CoreTextDemo
//
//  Created by chdo on 2017/11/20.
//  Copyright © 2017年 TangQiao. All rights reserved.
//

#import "TestView.h"

@implementation TestView

-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    self.backgroundColor = [UIColor whiteColor];
    return self;
}

-(void)setCtFrame:(CTFrameRef)ctFrame{
    _ctFrame = ctFrame;
    [self setNeedsDisplay];
}
- (void)drawRect:(CGRect)rect {
    // Drawing code
    
    // 步骤 1 获取上下文
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    // 步骤 2 翻转坐标
    CGContextSetTextMatrix(context, CGAffineTransformIdentity);
    CGContextTranslateCTM(context, 0, self.bounds.size.height);
    CGContextScaleCTM(context, 1.0, -1.0);
    
   
//    // 步骤 5 绘制
    CTFrameDraw(self.ctFrame, context);
//    // 步骤 6
//    CFRelease(self.ctFrame);
//    CFRelease(path);
//    CFRelease(framesetter);
 
}


@end
