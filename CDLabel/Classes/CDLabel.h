//
//  CDLabel.h
//  CDLabel
//
//  Created by chdo on 2017/12/1.
//

#import <UIKit/UIKit.h>
#import "CTData.h"
#import <CoreText/CoreText.h>
#import "CTHelper.h"

extern NSString * const  CTCLICKMSGEVENTNOTIFICATION;

@interface CDLabel : UIView


@property (assign, nonatomic) CTDataConfig config;

@property (strong, nonatomic) CTData * data;

@property (strong, nonatomic) NSString *text;

@end
