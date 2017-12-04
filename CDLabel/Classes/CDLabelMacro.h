//
//  CDLabelMacro.h
//  Pods
//
//  Created by chdo on 2017/12/1.
//

#ifndef CDLabelMacro_h
#define CDLabelMacro_h

#import "CDLabel.h"

// 16位颜色
#define CRMHexColor(hexColor)  [UIColor colorWithRed:((float)((hexColor & 0xFF0000) >> 16))/255.0 green:((float)((hexColor & 0xFF00) >> 8))/255.0 blue:((float)(hexColor & 0xFF))/255.0 alpha:1]

// 随机色
#define CRMRadomColor  [UIColor colorWithRed:arc4random_uniform(255)/255.0 green:arc4random_uniform(255)/255.0 blue:arc4random_uniform(255)/255.0 alpha:1]

#define RGB(A, B, C)    [UIColor colorWithRed:A/255.0 green:B/255.0 blue:C/255.0 alpha:1.0]

#endif /* CDLabelMacro_h */
