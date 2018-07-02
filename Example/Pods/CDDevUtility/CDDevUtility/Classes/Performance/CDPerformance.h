//
//  CDPerformance.h
//  CDDevUtility
//
//  Created by chdo on 2018/6/29.
//

#import <Foundation/Foundation.h>

@interface CDPerformance : NSObject

+(void)timeCost:(void(^)(void))block;

@end
