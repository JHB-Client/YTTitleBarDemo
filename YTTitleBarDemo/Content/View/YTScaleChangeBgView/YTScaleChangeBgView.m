//
//  YTBgView.m
//  YTMasonryAnimationDemo
//
//  Created by admin on 2019/10/30.
//  Copyright © 2019 admin. All rights reserved.
//

#import "YTScaleChangeBgView.h"
#import "Masonry.h"
@interface YTScaleChangeBgView()
@property (nonatomic, weak) UIView *cornerView;
@property (nonatomic, weak) UIImageView *contentImgView;
@property (nonatomic, strong) CABasicAnimation *animation;
@end
@implementation YTScaleChangeBgView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setUpSubLayer];
    }
    return self;
}

- (void)setUpSubLayer {
    self.backgroundColor = nil;
    self.layer.masksToBounds = NO;
    self.layer.shadowOffset = CGSizeZero;
    self.layer.shadowRadius = 3;
    self.layer.shadowOpacity = 0.2;
    
    
    UIView *cornerView = [UIView new];
    cornerView.backgroundColor = [UIColor whiteColor];
    [self addSubview:cornerView];
    self.cornerView = cornerView;

    // ----- 业务
    UIImageView *contentImgView = [UIImageView new];
    [self addSubview:contentImgView];
    self.contentImgView = contentImgView;
}

- (void)layoutSubviews {
    [super layoutSubviews];
 
    [self.cornerView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_offset(0);
    }];
  
    CGPathRef path = [UIBezierPath bezierPathWithRoundedRect:self.cornerView.bounds
    byRoundingCorners:UIRectCornerAllCorners cornerRadii:CGSizeMake(10,     10)].CGPath;
    CAShapeLayer *lay = [CAShapeLayer layer];
    lay.path = path;
    self.cornerView.layer.mask = lay;
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    NSLog(@"------touchesBegan:%lf", event.timestamp);
    [self setScaleChangeFromValue:1.0 toValue:0.95];
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event {
    NSLog(@"------touchesEnded");
    [self setScaleChangeFromValue:0.95 toValue:1.0];
}

- (void)touchesCancelled:(NSSet *)touches withEvent:(UIEvent *)event {
    NSLog(@"------touchesCancelled");
    [self setScaleChangeFromValue:0.95 toValue:1.0];
}

- (CABasicAnimation *)animation {
    if (_animation == nil) {
        _animation = [CABasicAnimation animationWithKeyPath:@"transform.scale"];
    }
    return _animation;
}

- (void)setScaleChangeFromValue:(float)fromValue toValue:(float)toValue{
    self.animation.fromValue = [NSNumber numberWithFloat:fromValue];
    self.animation.toValue = [NSNumber numberWithFloat:toValue];
    self.animation.duration = 0.20;
    self.animation.autoreverses = false;
    self.animation.repeatCount = 0;
    self.animation.removedOnCompletion = false;
    self.animation.fillMode = kCAFillModeBoth;
    [self.layer addAnimation:self.animation forKey:@"zoom"];
}
@end
