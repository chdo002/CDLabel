//
//  CDPerformance.m
//  CDDevUtility
//
//  Created by chdo on 2018/6/29.
//

#import "CDPerformance.h"

@implementation CDPerformance
+(void)timeCost:(void(^)(void))block{
    if (block) {
        NSTimeInterval t1 = [[NSDate date] timeIntervalSince1970];
        block();
        NSTimeInterval t2 = [[NSDate date] timeIntervalSince1970];
        NSLog(@"消耗时间：%f",t2 - t1);
    }
}
@end
