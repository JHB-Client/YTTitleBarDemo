//
//  UITabBar+Badge.h
//  SLFDA
//
//  Created by 季怀斌 on 2017/9/18.
//  Copyright © 2017年 huazhuo. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UITabBar (Badge)
- (void)showBadgeOnItmIndex:(int)index;
- (void)hideBadgeOnItemIndex:(int)index;
@end
