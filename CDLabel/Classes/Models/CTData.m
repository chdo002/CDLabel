//
//  CDCTData.m
//  CDLabel
//
//  Created by chdo on 2017/12/1.
//

#import "CTData.h"
#import "CDTextParser.h"


@implementation CTImageData

@end


@implementation CTData

+(CTData *)dataWithStr:(NSString *)msgString containerWithSize: (CGSize)size{
    
    CTDataConfig config;
    config.textColor = [UIColor blackColor].CGColor;
    config.hilightColor = [UIColor lightGrayColor].CGColor;
    config.clickStrColor = [UIColor blueColor].CGColor;
    config.lineSpace = 0;
    config.textSize = 14;
    return [self dataWithStr:msgString containerWithSize:size configuration:config];
}

+(CTData *)dataWithStr:(NSString *)msgString containerWithSize:(CGSize)size configuration:(CTDataConfig)config{
    
    CTData *data = [[CTData alloc] init];
    
    // 构建富文本
    UIFont *font = [UIFont systemFontOfSize:config.textSize];
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    paragraphStyle.lineSpacing = config.lineSpace;
    NSDictionary *dic = @{
                          NSFontAttributeName: font,
                          NSForegroundColorAttributeName: [UIColor colorWithCGColor:config.textColor],
                          NSParagraphStyleAttributeName: paragraphStyle
                          };
    
    NSMutableAttributedString *attString = [[NSMutableAttributedString alloc] initWithString:msgString attributes:dic];
    
    // 处理表情   将所有[呵呵]换成占位字符  并计算图片位置
    NSMutableArray *imageDataArrr = [NSMutableArray array];
    NSRegularExpression *regEmoji = [NSRegularExpression regularExpressionWithPattern:@"\\[[^\\[\\]]+?\\]"
                                                                              options:kNilOptions error:NULL];
    
    NSArray<NSTextCheckingResult *> *emoticonResults = [regEmoji matchesInString:msgString
                                                                         options:kNilOptions range:NSMakeRange(0, msgString.length)];
    NSInteger shift = 0;
    for (NSTextCheckingResult *emo in emoticonResults) {
        if (emo.range.location == NSNotFound && emo.range.length <= 1) continue;
        NSRange range = emo.range;
        range.location += shift;
        NSString *oldStr = [msgString substringWithRange:range];
        NSMutableAttributedString *newStr = [CDTextParser imagePlaceHolderStrFromFontSize:config.textSize];
        [attString replaceCharactersInRange:range withAttributedString:newStr];
        shift += newStr.length - oldStr.length;
        
        CTImageData *imageData = [[CTImageData alloc] init];
        imageData.position = range.location;
        imageData.name = oldStr;
        [imageDataArrr addObject:imageData];
    }
    data.imageArray = imageDataArrr;
    
    
    // 创建framesetter
    CTFramesetterRef framesetter = CTFramesetterCreateWithAttributedString((CFAttributedStringRef)attString);
    
    // 设置绘制范围
    // -- 计算内容范围
    CGSize caedSize = CTFramesetterSuggestFrameSizeWithConstraints(framesetter, CFRangeMake(0,attString.length), nil, size, nil);
    CGSize caSize = CGSizeMake(ceilf(caedSize.width), ceilf(caedSize.height));
    // -- 创建显示范围
    CGPathRef path = CGPathCreateWithRect(CGRectMake(0, 0, caSize.width, caSize.height), NULL);
    // 创建显示frame
    CTFrameRef frame = CTFramesetterCreateFrame(framesetter,
                                                CFRangeMake(0, [attString length]), path, NULL);
    data.width = caSize.width;
    data.height = caSize.height;
    data.ctFrame = frame;
    
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
            
            runBounds.size.width = CTRunGetTypographicBounds(run, CFRangeMake(0, 0), &ascent, &descent, NULL);
            runBounds.size.height = ascent + descent;
            
            CGFloat xOffset = CTLineGetOffsetForStringIndex(line, CTRunGetStringRange(run).location, NULL);
            runBounds.origin.x = lineOrigins[i].x + xOffset;
            runBounds.origin.y = lineOrigins[i].y;
            runBounds.origin.y -= descent;
            
            CGPathRef pathRef = CTFrameGetPath(self.ctFrame);
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
