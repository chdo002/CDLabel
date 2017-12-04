#ifdef __OBJC__
#import <UIKit/UIKit.h>
#else
#ifndef FOUNDATION_EXPORT
#if defined(__cplusplus)
#define FOUNDATION_EXPORT extern "C"
#else
#define FOUNDATION_EXPORT extern
#endif
#endif
#endif

#import "CDLabel.h"
#import "CDLabelMacro.h"
#import "CTClickInfo.h"
#import "CTData.h"
#import "CDTextParser.h"
#import "CoreTextUtils.h"
#import "CTHelper.h"
#import "MagnifiterView.h"

FOUNDATION_EXPORT double CDLabelVersionNumber;
FOUNDATION_EXPORT const unsigned char CDLabelVersionString[];

