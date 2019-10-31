//
//  YTProgressBar.m
//  YTProgressBarDemo
//
//  Created by admin on 2019/9/9.
//  Copyright © 2019 admin. All rights reserved.
//

#import "YTAudioSlider.h"
#import "UICategory.h"
#import "Masonry.h"

@interface YTAudioSlider()
@property (nonatomic, weak) UIButton *barBtn;
@property (nonatomic, weak) UIView *progressItem;
@property (nonatomic, weak) UILabel *progressLabel;
@property (nonatomic, weak) UIView *progressTrack;
@property (nonatomic, weak) UIView *indicator;
@end
@implementation YTAudioSlider

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setUpSubViews:frame];
    }
    return self;
}

- (void)setUpSubViews:(CGRect)frame {
    //
    UIButton *barBtn = [UIButton new];
    [barBtn setImage:[UIImage imageNamed:@"barBtnClose"] forState:UIControlStateNormal];
    [barBtn setImage:[UIImage imageNamed:@"barBtnOpen"] forState:UIControlStateSelected];
    [barBtn addTarget:self action:@selector(barBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    barBtn.layer.shadowRadius = 3;
    barBtn.layer.shadowColor = [UIColor lightGrayColor].CGColor;
    barBtn.layer.shadowOffset = CGSizeMake(2,3);
    barBtn.layer.shadowOpacity = 0.5;
    [self addSubview:barBtn];
    self.barBtn = barBtn;
    
    //
    UIView *progressItem = [UIView new];
    progressItem.backgroundColor = [UIColor lightGrayColor];
    [self addSubview:progressItem];
    
    self.progressItem = progressItem;
    
    //
    UILabel *progressLabel = [UILabel new];
    progressLabel.text = @"08:03";
    progressLabel.textAlignment = NSTextAlignmentCenter;
    progressLabel.adjustsFontSizeToFitWidth = true;
    [self addSubview:progressLabel];
    
    self.progressLabel = progressLabel;
    
    //
    UIView *progressTrack = [UIView new];
    progressTrack.backgroundColor = [UIColor darkGrayColor];
    [progressItem addSubview:progressTrack];
    
    self.progressTrack = progressTrack;
    
    //
    UIView *indicator = [UIView new];
    indicator.backgroundColor = [UIColor blueColor];
    indicator.layer.shadowRadius = 3;
    indicator.layer.shadowColor = [UIColor lightGrayColor].CGColor;
    indicator.layer.shadowOffset = CGSizeMake(2,3);
    indicator.layer.shadowOpacity = 0.5;
    [self addSubview:indicator];
    
    self.indicator = indicator;
    
    
    //
    [self layoutIfNeeded];
}

- (void)layoutSubviews {
    [self.barBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.mas_equalTo(0);
        make.width.height.mas_equalTo(self.mas_height);
    }];
    
    //
    [self.progressItem mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self.mas_centerX);
        make.centerY.mas_equalTo(self.mas_centerY);
        make.height.mas_equalTo(self.mas_height).multipliedBy(0.25);
        make.left.mas_equalTo(self.barBtn.mas_right).offset(5);
    }];
    
    //
    [self.progressLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.top.mas_equalTo(0);
        make.width.height.mas_equalTo(self.mas_height);
    }];
    
    //
    [self.progressTrack mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.bottom.mas_offset(0);
    }];
    
    //
    [self.indicator mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(self.progressItem.mas_height).multipliedBy(0.9);
        make.height.mas_equalTo(self.progressItem.mas_height).multipliedBy(2.2);
        make.centerY.mas_equalTo(self.progressItem.centerY);
        make.left.mas_equalTo(self.progressTrack.mas_right);
    }];
    
    
    //
    self.progressItem.layer.cornerRadius = self.height * 0.1;
    self.progressItem.clipsToBounds = true;
    
    //
    self.indicator.layer.cornerRadius = self.height * 0.1;
}


- (void)setTotal:(NSString *)total {
    self.progressLabel.text = total;
}

- (void)setProgress:(double)progress {
    [self.indicator layoutIfNeeded];
    
    NSLog(@"-------------==============-----------");
    float trackLong = self.progressItem.width - self.indicator.width;
    float trackRate = progress / trackLong;
    double lastRate = floor(trackRate*100) / 100;
    if (lastRate > 1.0) return;
    NSLog(@"--------sssss-------:%lf", lastRate);
    if (trackLong >= self.progressTrack.width) {
        [self.progressTrack mas_remakeConstraints:^(MASConstraintMaker *make) {
           make.width.mas_equalTo(progress);
        }];
    } else {
        NSLog(@"==========播放结束!");
    }
    
}


- (void)barBtnClick:(UIButton *)barBtn {
    barBtn.selected = !barBtn.isSelected;
    if (self.delegate != nil) {
        [self.delegate setSliderProgress];
    }
}
@end
