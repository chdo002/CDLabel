//
//  CDTextParser.m
//  CDLabel
//
//  Created by chdo on 2017/12/1.
//

#import "CDTextParser.h"
#import <CoreText/CoreText.h>

@implementation CDTextParser

static CGFloat ascentfunc(void *ref){
    return [(NSNumber*)[(__bridge NSDictionary*)ref objectForKey:@"ascent"] floatValue];
}

static CGFloat dscentfunc(void *ref){
    return [(NSNumber*)[(__bridge NSDictionary*)ref objectForKey:@"descent"] floatValue];
}

static CGFloat widthfunc(void *ref){
    return [(NSNumber*)[(__bridge NSDictionary*)ref objectForKey:@"width"] floatValue];
}

static void deallocfunc(void *ref){
    NSDictionary *self = (__bridge_transfer NSDictionary *)(ref);
    self = nil;
}


+(NSMutableAttributedString *)imagePlaceHolderStrFromFontSize: (CGFloat )fontSize{
    
    
    UIFont *font = [UIFont systemFontOfSize:15];
    
    NSDictionary *imgInfoDic = @{@"ascent":@(font.ascender),
                                 @"descent":@(font.descender),
                                 @"width":@(font.pointSize)
                                 };
    // 字形参数
    CTRunDelegateCallbacks callbacks;
    
    memset(&callbacks, 0, sizeof(CTRunDelegateCallbacks));
    callbacks.version = kCTRunDelegateCurrentVersion;
    callbacks.getAscent = ascentfunc;   // 顶边到基线
    callbacks.getDescent = dscentfunc; // 底边到基线
    callbacks.getWidth = widthfunc;     //
    callbacks.dealloc = deallocfunc;
    CTRunDelegateRef delegate = CTRunDelegateCreate(&callbacks, (__bridge_retained void *)(imgInfoDic));
    
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
