//
//  YTHealthHeadListCell.m
//  YTTitleBarDemo
//
//  Created by admin on 2019/10/28.
//  Copyright © 2019 admin. All rights reserved.
//

#import "YTHealthHeadListCell.h"
#import "Masonry.h"
#import "YTAudioSlider.h"
#import "YTHealthHead.h"
#import "UIView+MasonryCornerCut.h"
#import "YTScaleChangeBgView.h"
@interface YTHealthHeadListCell()<YTAudioSliderDelegate>
@property (nonatomic, weak) UIView *bgView;
@property (nonatomic, weak) UIView *topView;
@property (nonatomic, weak) UILabel *titleView;
@property (nonatomic, weak) UILabel *hospitalView;
@property (nonatomic, weak) UILabel *timeView;
@property (nonatomic, weak) UIView *inforContentView;
@property (nonatomic, weak) UIImageView *contetImgView;
@property (nonatomic, weak) YTAudioSlider *audioSlider;
@property (nonatomic, assign) double sliderProgress;
@end

@implementation YTHealthHeadListCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self == [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self setUpSubViews];
    }
    return self;
}

- (void)setUpSubViews {
    
    //1.
    YTScaleChangeBgView *bgView = [YTScaleChangeBgView new];
    [self addSubview:bgView];
    self.bgView = bgView;
    

    UIView *topView = [UIView new];
//    topView.backgroundColor = [UIColor yellowColor];
    [self.bgView addSubview:topView];
    self.topView = topView;
    
    UILabel *titleView = [UILabel new];
    titleView.font = [UIFont boldSystemFontOfSize:18];
    [titleView sizeToFit];
//    titleView.backgroundColor = [UIColor greenColor];
    [self.topView addSubview:titleView];
    self.titleView = titleView;
    
    UILabel *hospitalView = [UILabel new];
    hospitalView.font = [UIFont systemFontOfSize:12];
    hospitalView.textColor = [UIColor lightGrayColor];
    [hospitalView sizeToFit];
    [self.topView addSubview:hospitalView];
    self.hospitalView = hospitalView;
    
    UILabel *timeView = [UILabel new];
    timeView.font = [UIFont systemFontOfSize:12];
    timeView.textColor = [UIColor lightGrayColor];
    [timeView sizeToFit];
    [self.topView addSubview:timeView];
    self.timeView = timeView;
 
    //2.
    UIView *inforContentView = [UIView new];
    inforContentView.backgroundColor = [UIColor whiteColor];
    [self.bgView addSubview:inforContentView];
    self.inforContentView = inforContentView;
    
    //
    UIImageView *contetImgView = [UIImageView new];
    [self.inforContentView addSubview:contetImgView];
    self.contetImgView = contetImgView;
    
    YTAudioSlider *audioSlider = [YTAudioSlider new];
    audioSlider.delegate = self;
    [self.inforContentView addSubview:audioSlider];
    self.audioSlider = audioSlider;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    self.titleView.text = self.healthHead.title;
    self.hospitalView.text = self.healthHead.hospital;
    self.timeView.text = self.healthHead.time;
    self.contetImgView.image = [UIImage imageNamed:self.healthHead.img];
    
    //1.
    [self.bgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.equalTo(self).offset(10);
        make.right.bottom.equalTo(self).offset(-10);
    }];
    
    
    //
    [self.topView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.equalTo(self.bgView).offset(12);
        make.right.equalTo(self.bgView).offset(-12);
    }];
    
    
    [self.titleView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.equalTo(self.topView);
        make.right.equalTo(self.topView);
        make.height.mas_equalTo(@20);
    }];
    
    
    [self.hospitalView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.topView);
        make.top.mas_equalTo(self.titleView.mas_bottom);
        make.bottom.mas_equalTo(self.topView.mas_bottom);
    }];
    
    
    [self.timeView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.hospitalView);
        make.right.mas_equalTo(self.topView);
        make.bottom.mas_equalTo(self.topView.mas_bottom);
    }];
    
    
    //2.
   [self.inforContentView mas_makeConstraints:^(MASConstraintMaker *make) {
       make.top.equalTo(self.topView.mas_bottom).offset(0);
       make.left.right.bottom.mas_equalTo(self.bgView).mas_offset(0);
   }];


    
    if ([self.healthHead.title containsString:@"1"]) {
            [self.contetImgView mas_makeConstraints:^(MASConstraintMaker *make) {
                make.right.bottom.top.left.equalTo(self.inforContentView).offset(0);
            }];
    } else {
        [self.audioSlider mas_makeConstraints:^(MASConstraintMaker *make) {
                make.center.mas_equalTo(self.inforContentView);
        //        make.size.mas_equalTo(CGSizeMake(300, 50));
                make.left.mas_offset(5);
                make.height.mas_equalTo(@50);
            }];
    }
    
    [self.inforContentView setCornerRadius:5 addRectCorners:UIRectCornerBottomLeft | UIRectCornerBottomRight];
    self.inforContentView.layer.shadowRadius = 5;
    self.inforContentView.layer.cornerRadius = 5;
    self.inforContentView.layer.shadowColor = [UIColor grayColor].CGColor;
    self.inforContentView.layer.shadowOffset = CGSizeMake(1,1);
    self.inforContentView.layer.shadowOpacity = 0.5;
}


- (void)setHealthHead:(YTHealthHead *)healthHead {
    NSLog(@"=======:%@", healthHead);
    //
    _healthHead = healthHead;
    [self layoutIfNeeded];
}


+ (instancetype)cellWithTableView:(UITableView *)tableView {
    static NSString *cellId = @"cellID";
    
    YTHealthHeadListCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId];
    if (cell == nil) {
        cell = [[self alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId];
    }
    
    return cell;
}


- (void)setSliderProgress {
    self.sliderProgress += 1;
    self.audioSlider.progress = self.sliderProgress;
}

- (void)setShadeShadow {
    CABasicAnimation *animation=[CABasicAnimation animationWithKeyPath:@"transform.scale"];
    animation.fromValue=[NSNumber numberWithFloat:1.0];
    animation.toValue=[NSNumber numberWithFloat:0.88];
    animation.duration=0.25;
    animation.autoreverses = false;
    animation.repeatCount=0;
    animation.removedOnCompletion=false;
    animation.fillMode=kCAFillModeBoth;
    [self.bgView.layer addAnimation:animation forKey:@"zoom"];
}

@end
