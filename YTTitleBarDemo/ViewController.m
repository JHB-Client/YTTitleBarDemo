//
//  ViewController.m
//  YTTitleBarDemo
//
//  Created by admin on 2019/9/6.
//  Copyright © 2019 admin. All rights reserved.
//

#import "ViewController.h"
#import "Masonry.h"
#import "UICategory.h"
#import "YTHealthHeadListViewController.h"
#define kScreenW [UIScreen mainScreen].bounds.size.width
#define kScreenH  [UIScreen mainScreen].bounds.size.height

//
#define kColor(r , g ,b) [UIColor colorWithRed:(r)  green:(g)  blue:(b) alpha:1]
@interface ViewController ()<UIScrollViewDelegate>
@property (nonatomic, weak) UIScrollView *titleBar;
@property (nonatomic, weak) UIScrollView *contentBgView;
@property (nonatomic, weak) UIButton *lastBtn;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
   
    //1.
    UIScrollView *titleBar = [UIScrollView new];
//    titleBar.backgroundColor = [UIColor greenColor];
    [self.view addSubview:titleBar];
    self.titleBar = titleBar;
    [self.titleBar mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_offset(20);
        make.left.right.equalTo(self.view).offset(0);
        make.height.equalTo(self.view.mas_height).multipliedBy(0.08);
    }];
    
    
    //2.
    UIScrollView *contentBgView = [UIScrollView new];
    contentBgView.backgroundColor = [UIColor redColor];
    contentBgView.delegate = self;
    [self.view addSubview:contentBgView];
    self.contentBgView = contentBgView;
    [self.contentBgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.equalTo(self.view).offset(0);
        make.top.equalTo(self.titleBar.mas_bottom).offset(0);
    }];
    
   
    //3.
    NSArray *titleArr = @[@"综合", @"健康科普", @"听医说", @"孕产育儿", @"慧医小贴士", @"标题1", @"标题2", @"标题33333"];
    
    for (int i = 0; i < titleArr.count; i++) {
        YTHealthHeadListViewController *myVCtr = [YTHealthHeadListViewController new];
        myVCtr.navigationItem.title = titleArr[i];
        myVCtr.vCtrTag = i;
        [self addChildViewController:myVCtr];
    }
  
    
    //
    [self setChildVctr];
}

- (void)setChildVctr {
    
    NSInteger childVctrCount = self.childViewControllers.count;
    
    self.contentBgView.contentSize = CGSizeMake(kScreenW * childVctrCount, self.contentBgView.bounds.size.height);
    self.contentBgView.pagingEnabled = true;
    self.contentBgView.bounces = false;
    
    
    //
    self.titleBar.showsHorizontalScrollIndicator = false;
    CGFloat titleBarContentWidth = 0;
    //
    for (int i = 0; i < childVctrCount; i++) {
        UIViewController *childVctr = self.childViewControllers[i];
        [self.contentBgView addSubview:childVctr.view];
        CGFloat contenLeftOffSet = i * kScreenW;
        [childVctr.view mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.contentBgView).offset(contenLeftOffSet);
            make.size.equalTo(self.contentBgView);
        }];
        
        //
        UIButton *titleBtn = [UIButton new];
        titleBtn.tag = 100 + i;
//        titleBtn.backgroundColor = [UIColor blueColor];
        titleBtn.titleLabel.textAlignment = NSTextAlignmentCenter;
        titleBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;
        titleBtn.contentVerticalAlignment = UIControlContentVerticalAlignmentBottom;
        titleBtn.imageView.contentMode = UIViewContentModeCenter;
        [titleBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        titleBtn.titleLabel.font = [UIFont boldSystemFontOfSize:14];
        [titleBtn setTitle:childVctr.navigationItem.title forState:UIControlStateNormal];
        [titleBtn addTarget:self action:@selector(titleBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        [self.titleBar addSubview:titleBtn];
        
        
        CGFloat titleLeftOffSet = titleBarContentWidth;
        [titleBtn sizeToFit];
        titleBtn.width += 10;
        titleBarContentWidth += titleBtn.width + 10;
        
//        CGFloat titleLeftOffSet = i * titleBtnWidth;
        
        [titleBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.titleBar).offset(titleLeftOffSet);
//            make.width.mas_equalTo(titleBtnWidth);
            make.height.mas_equalTo(self.titleBar.mas_height);
        }];
       
        //默认选择第一个
        if (i == 0) {
            [self titleBtnClick:titleBtn];
        }
    }
     self.titleBar.contentSize = CGSizeMake(titleBarContentWidth, self.titleBar.height);
}

- (void)titleBtnClick:(UIButton *)titleBtn {
    
    //1.
    [self titleBtnSelected:titleBtn];
    
    //2.
    [self titleBarScroll:titleBtn];
    
    //3.
    [self contentBgViewScroll:titleBtn];
    
    //4.刷新数据
    [self reloadData];
}

- (void)reloadData {
    NSLog(@"-------");
}

- (void)titleBtnSelected:(UIButton *)titleBtn {
    [self.lastBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    self.lastBtn.titleLabel.font = [UIFont boldSystemFontOfSize:14];
    
//    self.lastBtn.transform = CGAffineTransformIdentity;
    
    [titleBtn setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    titleBtn.titleLabel.font = [UIFont boldSystemFontOfSize:16];
//    titleBtn.transform = CGAffineTransformMakeScale(1.3, 1.3);
    self.lastBtn = titleBtn;
}

- (void)titleBarScroll:(UIButton *)titleBtn {
    
    CGFloat offsetX = titleBtn.centerX - kScreenW * 0.5;
    offsetX = offsetX < 0 ? 0 : offsetX;
    offsetX = offsetX > self.titleBar.contentSize.width - kScreenW ? self.titleBar.contentSize.width - kScreenW : offsetX;
    [self.titleBar setContentOffset:CGPointMake(offsetX, 0) animated:true];
}

- (void)contentBgViewScroll:(UIButton *)titleBtn {
    //
    CGFloat contentOffsetX = (titleBtn.tag - 100) * kScreenW;
    [self.contentBgView setContentOffset:CGPointMake(contentOffsetX, 0) animated:false];
}


- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    //    NSLog(@"-----:%lf", scrollView.contentOffset.x);
    NSInteger index = (NSInteger)scrollView.contentOffset.x / kScreenW;
    
//    NSLog(@"---qqqqq--:%ld", index);
    
    UIButton *titleBtn = (UIButton *)[self.view viewWithTag:100 + index];
    
    //
    [self titleBtnSelected:titleBtn];
    [self titleBarScroll:titleBtn];
    
    //4.刷新数据
    [self reloadData];
}


//- (void)scrollViewDidScroll:(UIScrollView *)scrollView
//{
//    NSInteger leftI = scrollView.contentOffset.x / kScreenW;
//
//    NSInteger rightI = leftI + 1;
//
//    // 1.获取需要形变的按钮
//
//    // left
//    // 获取左边按钮
//    UIButton *leftButton = (UIButton *)[self.view viewWithTag:leftI + 100];
//
//    // right
//    NSUInteger count = self.childViewControllers.count;
//    UIButton *rigthButton;
//    // 获取右边按钮
//    if (rightI < count) {
//        rigthButton = (UIButton *)[self.view viewWithTag:rightI + 100];;
//    }
//
//    // 计算右边按钮偏移量
//    CGFloat rightScale = scrollView.contentOffset.x / kScreenW;
//    // 只想要 0~1
//    rightScale = rightScale - leftI;
//
//    CGFloat leftScale = 1 - rightScale;
//
//    // 形变按钮
//    // scale 0 ~ 1 => 1 ~ 1.3
//    leftButton.transform = CGAffineTransformMakeScale(leftScale * 0.3 + 1, leftScale * 0.3 + 1);
//    rigthButton.transform = CGAffineTransformMakeScale(rightScale * 0.3 + 1, rightScale * 0.3 + 1);
//
//    [rigthButton setTitleColor:kColor(0, 0, rightScale) forState:UIControlStateNormal];
//    [leftButton setTitleColor:kColor(0, 0, leftScale) forState:UIControlStateNormal];
//}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.navigationController.navigationBarHidden = true;
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    self.navigationController.navigationBarHidden = false;
}

@end
