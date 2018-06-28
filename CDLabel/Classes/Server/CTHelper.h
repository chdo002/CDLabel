//
//  CTHelper.h
//  CDLabel
//
//  Created by chdo on 2017/12/4.
//


#import <UIKit/UIKit.h>
@interface CTHelper : NSObject
@property(nonatomic, class, readonly, strong) CTHelper *share;

/**
 配置表情字典  emjDic 表情名->image
 */
@property(nonatomic, strong) NSDictionary<NSString*, UIImage *> *emojDic;

@end
