//
//  CDCTData.h
//  CDLabel
//
//  Created by chdo on 2017/12/1.
//

#import <Foundation/Foundation.h>
#import <CoreText/CoreText.h>


/**
 图片文本对象
 */
@interface CTImageData : NSObject
@property (strong, nonatomic) NSString * name;
@property (nonatomic) int position;

// 此坐标是 CoreText 的坐标系，而不是UIKit的坐标系
@property (nonatomic) CGRect imagePosition;
@end


/**
 绘制文本对象
 */
@interface CTData : NSObject

/**
 绘制在label上的
 */
@property (assign, nonatomic) CTFrameRef ctFrame;

@property (assign, nonatomic) CGFloat height;

@property (strong, nonatomic) NSArray<CTImageData *> * imageArray;
@property (strong, nonatomic) NSArray * linkArray;
@property (strong, nonatomic) NSAttributedString *content;




@end
