//
//  CDLabel.h
//  CDLabel
//
//  Created by chdo on 2017/12/1.
//

#import <UIKit/UIKit.h>
#import "CTData.h"
#import <CoreText/CoreText.h>


extern NSString *const  CHATLISTCLICKMSGEVENT;

@interface CDLabel : UIView

@property (strong, nonatomic) CTData * data;

@end
