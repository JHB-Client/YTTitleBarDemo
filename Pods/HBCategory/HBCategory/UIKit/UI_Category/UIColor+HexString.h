//
//  UIColor+HexString.h
//  SLIOP
//
//  Created by 季怀斌 on 16/8/10.
//  Copyright © 2016年 huazhuo. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIColor (HexString)
+ (UIColor *) colorWithHexString:(NSString *)color;
+ (UIColor *) colorWithHexString:(NSString *)color alpha:(float)opacity;
@end
