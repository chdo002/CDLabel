//
//  CTHelper.m
//  CDLabel
//
//  Created by chdo on 2017/12/4.
//

#import "CTHelper.h"

@interface CTHelper()
@property(nonatomic, strong) NSMutableDictionary<NSString*, UIImage *> *emojDic;
@end

@implementation CTHelper

+(instancetype)share{
    static dispatch_once_t onceToken;
    static CTHelper *helper;
    dispatch_once(&onceToken, ^{
        helper = [[CTHelper alloc] init];
    });
    return helper;
}

+(void)loadImageDic: (NSMutableDictionary<NSString*, UIImage *> *)emjDic{
    [CTHelper share].emojDic = emjDic;
}

#pragma mark  表情替换
+(NSDictionary *)emoticonDic {
    return [CTHelper share].emojDic;
}
@end
