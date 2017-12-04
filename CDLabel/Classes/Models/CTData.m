//
//  CDCTData.m
//  CDLabel
//
//  Created by chdo on 2017/12/1.
//

#import "CTData.h"
#import "CDTextParser.h"
#import "CDLabelMacro.h"

@implementation CTImageData
@end

@implementation CTLinkData
@end

@implementation CTData

+(CTData *)dataWithStr:(NSString *)msgString containerWithSize: (CGSize)size{
    
    CTDataConfig config;
    config.textColor = [UIColor blackColor].CGColor;
    config.hilightColor = [UIColor lightGrayColor].CGColor;
    config.clickStrColor = [UIColor blueColor].CGColor;
    config.lineSpace = 0;
    config.textSize = 18;
    config.lineBreakMode = NSLineBreakByCharWrapping;
    return [self dataWithStr:msgString containerWithSize:size configuration:config];
}

+(CTData *)dataWithStr:(NSString *)msgString containerWithSize:(CGSize)size configuration:(CTDataConfig)config{
    
    CTData *data = [[CTData alloc] init];
    data.msgString = msgString;
    // 构建富文本
    UIFont *font = [UIFont systemFontOfSize:config.textSize];
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    paragraphStyle.lineSpacing = config.lineSpace;
    paragraphStyle.lineBreakMode = config.lineBreakMode;
    NSDictionary *dic = @{
                          NSFontAttributeName: font,
                          NSForegroundColorAttributeName: [UIColor colorWithCGColor:config.textColor],
                          NSBackgroundColorAttributeName: [UIColor clearColor],
                          NSParagraphStyleAttributeName: paragraphStyle
                          };
    
    NSMutableAttributedString *attString = [[NSMutableAttributedString alloc] initWithString:msgString attributes:dic];
    
    /*
     ===========================================================================
     各种匹配
     ===========================================================================
     */
    
    // 匹配图片(主要是表情) 并返回图片
    NSMutableArray <CTImageData *>*imageDataArr = [CDTextParser matchImage:attString configuration:config];
    
    // 匹配链接
    NSMutableArray <CTLinkData *> *linkDataArr = [CDTextParser matchLink:attString configuration:config];
    
    
    /*
     ===========================================================================
     构建CTFrame
     ===========================================================================
     */
    
    // 创建framesetter
    CTFramesetterRef framesetter = CTFramesetterCreateWithAttributedString((CFAttributedStringRef)attString);
    
    // 设置绘制范围
    // -- 计算内容范围
    CGSize caSize = CTFramesetterSuggestFrameSizeWithConstraints(framesetter, CFRangeMake(0,attString.length), nil, size, nil);
    // -- 创建显示范围
    CGPathRef path = CGPathCreateWithRect(CGRectMake(0, 0, caSize.width, caSize.height), NULL);
    // 创建显示frame
    CTFrameRef frame = CTFramesetterCreateFrame(framesetter,
                                                CFRangeMake(0, [attString length]), path, NULL);
    data.width = caSize.width;
    data.height = caSize.height;
    data.ctFrame = frame;
    data.imageArray = imageDataArr;
    data.linkArray = linkDataArr;
    return data;
}

- (void)setImageArray:(NSArray *)imageArray {
    _imageArray = imageArray;
    [self fillImagePosition];
}


// 计算图片位置
- (void)fillImagePosition {
    
    if (self.imageArray.count == 0) {
        return;
    }

    // CTLineRef
    NSArray *lines = (NSArray *)CTFrameGetLines(self.ctFrame);
    
    // 总共几行文本
    NSUInteger lineCount = [lines count];
    
    // 每行的原点坐标
    CGPoint lineOrigins[lineCount];
    CTFrameGetLineOrigins(self.ctFrame, CFRangeMake(0, 0), lineOrigins);
    
    int imgIndex = 0;
    CTImageData * imageData = self.imageArray[0];
    
    for (int i = 0; i < lineCount; ++i) {
        if (imageData == nil) {
            // 没有图片需要计算，则结束
            break;
        }
        CTLineRef line = (__bridge CTLineRef)lines[i];
        NSArray * runObjArray = (NSArray *)CTLineGetGlyphRuns(line);
        for (id runObj in runObjArray) {
            CTRunRef run = (__bridge CTRunRef)runObj;
            NSDictionary *runAttributes = (NSDictionary *)CTRunGetAttributes(run);
            CTRunDelegateRef delegate = (__bridge CTRunDelegateRef)[runAttributes valueForKey:(id)kCTRunDelegateAttributeName];
            // 不是图片
            if (delegate == nil) {
                continue;
            }
            
            NSDictionary * metaDic = CTRunDelegateGetRefCon(delegate);
            if (![metaDic isKindOfClass:[NSDictionary class]]) {
                continue;
            }
            
            CGRect runBounds;
            CGFloat ascent;
            CGFloat descent;
            CGFloat leading;
            // 字形
            runBounds.size.width = CTRunGetTypographicBounds(run, CFRangeMake(0, 0), &ascent, &descent, &leading);
            runBounds.size.height = ascent - descent;
            CGFloat xOffset = CTLineGetOffsetForStringIndex(line, CTRunGetStringRange(run).location, NULL);
            runBounds.origin.x = lineOrigins[i].x + xOffset;
            runBounds.origin.y = lineOrigins[i].y;
            runBounds.origin.y += descent;
            
            //
            CGPathRef pathRef = CTFrameGetPath(self.ctFrame);
            
            //
            CGRect colRect = CGPathGetBoundingBox(pathRef);
            
            // 最终图片位置
            CGRect delegateBounds = CGRectOffset(runBounds, colRect.origin.x, colRect.origin.y);
            
            imageData.imagePosition = delegateBounds;
            
            imgIndex++;
            if (imgIndex == self.imageArray.count) {
                imageData = nil;
                break;
            } else {
                imageData = self.imageArray[imgIndex];
            }
        }
    }
}

@end
