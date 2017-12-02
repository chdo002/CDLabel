//
//  ChatListInfo.m
//  CDLabel
//
//  Created by chdo on 2017/11/23.
//

#import "ChatListInfo.h"


@implementation ChatListInfo
+(ChatListInfo *)info:(ChatClickEventType)type containerView:(UIView *)view msgText:(NSString *)msgText clickedText:(NSString *)clickedText rnag:(NSRange )rang clickRect:(CGRect)rect
{
    ChatListInfo *info = [[ChatListInfo alloc] init];
    info.eventType = type;
    info.containerView = view;
    info.msgText = msgText;
    info.clickedText = clickedText;
    info.range = rang;
    info.clicedkRect = rect;
    return info;
}

-(void)sendMessage{
    [[NSNotificationCenter defaultCenter] postNotificationName:CHATLISTCLICKMSGEVENT object:self];
}
@end
