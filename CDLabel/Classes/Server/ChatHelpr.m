//
//  ChatHelpr.m
//  CDChatList
//
//  Created by chdo on 2017/11/17.
//

#import "ChatHelpr.h"

@interface ChatHelpr()
@property(nonatomic, strong) NSMutableDictionary<NSString*, UIImage *> *emojDic;
@end

@implementation ChatHelpr

+(instancetype)share{
    static dispatch_once_t onceToken;
    static ChatHelpr *helper;
    dispatch_once(&onceToken, ^{
        helper = [[ChatHelpr alloc] init];
    });
    return helper;
}

+(void)loadImageDic: (NSMutableDictionary<NSString*, UIImage *> *)emjDic{
    [ChatHelpr share].emojDic = emjDic;
}

#pragma mark  表情替换
+(NSDictionary *)emoticonDic {
    return [ChatHelpr share].emojDic;
}

@end

