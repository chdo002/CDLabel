//
//  ChatHelpr.h
//  CDChatList
//
//  Created by chdo on 2017/11/17.
//

#import <Foundation/Foundation.h>

@interface ChatHelpr : NSObject

/**
 配置表情字典
 
 @param emjDic 表情名->image
 */
+(void)loadImageDic: (NSMutableDictionary<NSString*, UIImage *> *)emjDic;

+(NSDictionary *)emoticonDic;

@end

