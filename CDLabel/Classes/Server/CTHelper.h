//
//  CTHelper.h
//  CDLabel
//
//  Created by chdo on 2017/12/4.
//

#import <Foundation/Foundation.h>

@interface CTHelper : NSObject
/**
 配置表情字典
 
 @param emjDic 表情名->image
 */
+(void)loadImageDic: (NSMutableDictionary<NSString*, UIImage *> *)emjDic;

+(NSDictionary *)emoticonDic;

@end
