//
//  CDLabel.m
//  CDLabel
//
//  Created by chdo on 2017/12/1.
//

#import "CDLabel.h"


@implementation CDLabel

- (void)drawRect:(CGRect)rect {
    [super drawRect:rect];
    
    if (self.data == nil) {
        return;
    }
    
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetTextMatrix(context, CGAffineTransformIdentity);
    CGContextTranslateCTM(context, 0, self.bounds.size.height);
    CGContextScaleCTM(context, 1.0, -1.0);
    
//    if (self.state == CTDisplayViewStateTouching || self.state == CTDisplayViewStateSelecting) {
//        [self drawSelectionArea];
//        [self drawAnchors];
//    }
    
    CTFrameDraw(self.data.ctFrame, context);
    
    for (CTImageData * imageData in self.data.imageArray) {
        UIImage *image = [UIImage imageNamed:imageData.name];
        if (image) {
            CGContextDrawImage(context, imageData.imagePosition, image.CGImage);
        }
    }
    
}


@end
