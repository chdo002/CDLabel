//
//  CDLabel.m
//  CDLabel
//
//  Created by chdo on 2017/12/1.
//

#import "CDLabel.h"
#import "MagnifiterView.h"
#import "ChatHelpr.h"

typedef enum CTDisplayViewState : NSInteger {
    CTDisplayViewStateNormal,       // 普通状态
    CTDisplayViewStateTouching,     // 正在按下，需要弹出放大镜
    CTDisplayViewStateSelecting     // 选中了一些文本，需要弹出复制菜单
}CTDisplayViewState;

#define ANCHOR_TARGET_TAG 1
#define FONT_HEIGHT  40

@interface CDLabel()<UIGestureRecognizerDelegate>

@property (nonatomic) NSInteger selectionStartPosition;
@property (nonatomic) NSInteger selectionEndPosition;
@property (nonatomic) CTDisplayViewState state;
@property (strong, nonatomic) UIImageView *leftSelectionAnchor;
@property (strong, nonatomic) UIImageView *rightSelectionAnchor;
@property (strong, nonatomic) MagnifiterView *magnifierView;

@end

@implementation CDLabel

- (id)init {
    return [self initWithFrame:CGRectZero];
}

-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    self.backgroundColor = [UIColor whiteColor];
    return self;
}

- (void)setData:(CTData *)data {
    _data = data;
    self.state = CTDisplayViewStateNormal;
}

- (void)setState:(CTDisplayViewState)state {
    if (_state == state) {
        return;
    }
    _state = state;
    if (_state == CTDisplayViewStateNormal) {
        _selectionStartPosition = -1;
        _selectionEndPosition = -1;
//        [self removeSelectionAnchor];
//        [self removeMaginfierView];
//        [self hideMenuController];
    } else if (_state == CTDisplayViewStateTouching) {
        if (_leftSelectionAnchor == nil && _rightSelectionAnchor == nil) {
//            [self setupAnchors];
        }
    } else if (_state == CTDisplayViewStateSelecting) {
        if (_leftSelectionAnchor == nil && _rightSelectionAnchor == nil) {
//            [self setupAnchors];
        }
        
        if (_leftSelectionAnchor.tag != ANCHOR_TARGET_TAG && _rightSelectionAnchor.tag != ANCHOR_TARGET_TAG) {
//            [self removeMaginfierView];
//            [self hideMenuController];
        }
    }
    [self setNeedsDisplay];
}

- (MagnifiterView *)magnifierView {
    if (_magnifierView == nil) {
        _magnifierView = [[MagnifiterView alloc] init];
        _magnifierView.viewToMagnify = self;
        [self addSubview:_magnifierView];
    }
    return _magnifierView;
}

- (void)drawRect:(CGRect)rect {
    [super drawRect:rect];
    
    if (self.data == nil) {
        return;
    }
    
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetTextMatrix(context, CGAffineTransformIdentity);
    CGContextTranslateCTM(context, 0, self.bounds.size.height);
    CGContextScaleCTM(context, 1.0, -1.0);
    
//    if (self.state == CTDisplayViewStateTouching || self.state == CTDisplayViewStateSelecting) {
//        [self drawSelectionArea];
//        [self drawAnchors];
//    }
    
    CTFrameDraw(self.data.ctFrame, context);
    
    for (CTImageData * imageData in self.data.imageArray) {
        UIImage *image = [ChatHelpr emoticonDic][imageData.name];
        if (image) {
            NSLog(@"%@",NSStringFromCGRect(imageData.imagePosition));
            CGContextDrawImage(context, imageData.imagePosition, image.CGImage);
        }
    }
    
}


@end
