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
        single.cachedData = [NSMutableDictionary dictionary];
        single.calQue = dispatch_queue_create("CDLabel_CDCalculator_queue", DISPATCH_QUEUE_SERIAL);
        [NSNotificationCenter.defaultCenter addObserver:single
                                               selector:@selector(receivedNoti:)
                                                   name:UIApplicationDidReceiveMemoryWarningNotification object:nil];
    });
    return single;
}

-(void)calcuate:(NSString *)text
            and:(CGSize)containSize
            and:(CTDataConfig)config{
    
    dispatch_async(CDCalculator.share.calQue, ^{
        
        NSString *configId = CTDataConfigIdentity(config);
        
        NSString *dataId = [NSString stringWithFormat:@"%@%@",text,configId];
        
        CTData *data = CDCalculator.share.cachedData[dataId];
        
        if (data) {
            if (self.calComplete && self.label) { // 检查是否取消计算回调
                self.calComplete(data);
            }
        } else {
            CTData *data = [CTData dataWithStr:text containerWithSize:containSize configuration:config];
            CDCalculator.share.cachedData[dataId] = data;
            if (self.calComplete && self.label) { // 检查是否取消计算回调
                self.calComplete(data);
            }
        }
    });
}


-(void)receivedNoti:(NSNotification *)noti{
    dispatch_async(self.calQue, ^{
        if ([noti.name isEqualToString:UIApplicationDidReceiveMemoryWarningNotification]){
            self.cachedData = [NSMutableDictionary dictionary];
        }
    });
}

@end
