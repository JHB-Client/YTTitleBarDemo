//
//  YTAudioSlider.h
//  YTTitleBarDemo
//
//  Created by admin on 2019/10/28.
//  Copyright © 2019 admin. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol YTAudioSliderDelegate <NSObject>
- (void)setSliderProgress;
@end
NS_ASSUME_NONNULL_BEGIN

@interface YTAudioSlider : UIView
@property (nonatomic, copy) NSString *total;
@property (nonatomic, assign) double progress;
@property (nonatomic, weak) id delegate;
@end

NS_ASSUME_NONNULL_END
