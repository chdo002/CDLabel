//
//  ChatListInfo.h
//  CDLabel
//
//  Created by chdo on 2017/11/23.
//

#import <Foundation/Foundation.h>
#import "CDLabel.h"
#import "CDLabelMacro.h"

typedef enum : NSUInteger {
    ChatClickEventTypeTEXT,
    ChatClickEventTypeIMAGE,
} CTClickEventType;

/**
 点击事件
 */
@interface CTClickInfo: NSObject

/**
 事件类型
 */
@property (nonatomic, assign) CTClickEventType eventType;


/**
 全部消息字符
 */
@property (nonatomic, copy, nonnull) NSString *msgText;

/**
 点击文字range
 */
@property (nonatomic, assign) NSRange range;


/**
 文字视图容器
 */
@property (nonatomic, strong, nullable) UIView *containerView;


/**
 点击区域在containerView中的位置
 */
@property (nonatomic, assign) CGRect clicedkRect;

/*-------链接类型-------*/
/**
 链接文本
 */
@property (nonatomic, copy, nullable) NSString *clickedText;

/*-------图片-------*/
/**
 图片
 */
@property (nonatomic, strong, nullable) UIImage *image;

/**
 图片在容器中的位置
 */
@property (nonatomic, assign) CGRect msgImageRectInContainView;

+(CTClickInfo *_Nullable)info:(CTClickEventType)type
                containerView:(UIView *_Nullable)view
                      msgText:(NSString *_Nullable)msgText
                  clickedText:(NSString *_Nullable)clickedText
                         rnag:(NSRange)rang
                    clickRect:(CGRect) rect;


-(void)sendMessage;
@end
