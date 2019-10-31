//
//  UIView+MasonryCornerCut.h
//  YTTitleBarDemo
//
//  Created by admin on 2019/10/29.
//  Copyright © 2019 admin. All rights reserved.
//

#import <UIKit/UIKit.h>
NS_ASSUME_NONNULL_BEGIN

@interface UIView (MasonryCornerCut)
- (void)setCornerRadius:(CGFloat)value addRectCorners:(UIRectCorner)rectCorner;
@end

NS_ASSUME_NONNULL_END
