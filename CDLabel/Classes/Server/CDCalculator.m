//
//  CDCalculator.m
//  CDLabel
//
//  Created by chdo on 2018/6/28.
//

#import "CDCalculator.h"
@interface CDCalculator()

@property(nonatomic, strong) dispatch_queue_t calQue;
@property(nonatomic, strong) NSMutableDictionary *cachedData;

@end

@implementation CDCalculator

+(instancetype)share{
    
    static dispatch_once_t onceToken;
    static CDCalculator *single;
    
    dispatch_once(&onceToken, ^{
        single = [[CDCalculator alloc] init];
        single.calQue = dispatch_queue_create("CDLabel_CDCalculator_queue", DISPATCH_QUEUE_SERIAL);
    });
    return single;
}


//self.data = [CTData dataWithStr:text containerWithSize:CGSizeMake(self.frame.size.width, CGFLOAT_MAX)];

-(void)calcuate:(NSString *)text and:(CGSize)containSize and:(CTDataConfig)config{
    
    NSString *configId = CTDataConfigIdentity(config);
    NSString *dataId = [NSString stringWithFormat:@"%@%@",text,configId];
    
    CTData *data = [CTData dataWithStr:text containerWithSize:containSize];
    
}


@end
