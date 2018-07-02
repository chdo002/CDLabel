//
//  CDCalculator.m
//  CDLabel
//
//  Created by chdo on 2018/6/28.
//

#import "CDCalculator.h"
@interface CDCalculator()

@property(nonatomic, strong) dispatch_queue_t calQue;
@property(nonatomic, strong) NSCache *cachedData;

@end

@implementation CDCalculator

+(instancetype)share{
    
    static dispatch_once_t onceToken;
    static CDCalculator *single;
    
    dispatch_once(&onceToken, ^{
        single = [[CDCalculator alloc] init];
//        single.cachedData = [NSMutableDictionary dictionary];
        single.cachedData = [[NSCache alloc] init];
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
        
        NSString *dataId = [NSString stringWithFormat:@"%@%@",text,CTDataConfigIdentity(config)];
        
        CTData *data = [CDCalculator.share.cachedData objectForKey:dataId];
        
        if (data) {
            if (self.calComplete && self.label) { // 检查是否取消计算回调
                self.calComplete(data);
            }
        } else {
            CTData *data = [CTData dataWithStr:text containerWithSize:containSize configuration:config];
            [CDCalculator.share.cachedData setObject:data forKey:dataId];
            if (self.calComplete && self.label) { // 检查是否取消计算回调
                self.calComplete(data);
            }
        }
    });
}


-(void)receivedNoti:(NSNotification *)noti{
    dispatch_async(self.calQue, ^{
        if ([noti.name isEqualToString:UIApplicationDidReceiveMemoryWarningNotification]){
            [self.cachedData removeAllObjects];
        }
    });
}

@end
