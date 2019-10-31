//
//  UIView+MasonryCornerCut.m
//  YTTitleBarDemo
//
//  Created by admin on 2019/10/29.
//  Copyright © 2019 admin. All rights reserved.
//

#import "UIView+MasonryCornerCut.h"

#import <UIKit/UIKit.h>
@implementation UIView (MasonryCornerCut)
- (void)setCornerRadius:(CGFloat)value addRectCorners:(UIRectCorner)rectCorner{
    [self layoutIfNeeded];//这句代码很重要，不能忘了
    
    UIBezierPath *path = [UIBezierPath bezierPathWithRoundedRect:self.bounds byRoundingCorners:rectCorner cornerRadii:CGSizeMake(value, value)];
    CAShapeLayer *shapeLayer = [CAShapeLayer layer];
    shapeLayer.frame = self.bounds;
    shapeLayer.path = path.CGPath;
    self.layer.mask = shapeLayer;
}
@end
