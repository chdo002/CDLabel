//
//  CDCTData.m
//  CDLabel
//
//  Created by chdo on 2017/12/1.
//

#import "CTData.h"

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
    
    // 处理表情
    
    
    return data;
}
@end
