//
//  YTHealthHeadListCell.h
//  YTTitleBarDemo
//
//  Created by admin on 2019/10/28.
//  Copyright © 2019 admin. All rights reserved.
//

#import <UIKit/UIKit.h>
@class YTHealthHead;
NS_ASSUME_NONNULL_BEGIN

@interface YTHealthHeadListCell : UITableViewCell
@property (nonatomic, strong) YTHealthHead *healthHead;
+ (instancetype)cellWithTableView:(UITableView *)tableView;
- (void)setShadeShadow;
@end

NS_ASSUME_NONNULL_END
