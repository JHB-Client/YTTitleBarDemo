//
//  UILabel+Extension.m
//  Example
//
//  Created by 季怀斌 on 2018/4/2.
//  Copyright © 2018年 huazhuo. All rights reserved.
//

#import "UILabel+Extension.h"
#import "UIColor+HexString.h"
@implementation UILabel (Extension)
- (void)setTextFont:(CGFloat)font textColor:(NSString *)hexString alpha:(CGFloat)alpha{
    self.font = [UIFont systemFontOfSize:font];
    self.textColor = [UIColor colorWithHexString:hexString alpha:alpha];
}

- (NSUInteger)numberOfLabelContent{
    [self sizeToFit];
    //
    NSString *labelText = self.text;
    NSUInteger enterCount = [labelText componentsSeparatedByString:@"\n"].count - 1;
    labelText = [labelText stringByReplacingOccurrencesOfString:@"\n" withString:@""];
    //
    CGRect rect = [labelText boundingRectWithSize:CGSizeMake(self.bounds.size.width, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:self.font} context:nil];
    CGSize textSize = [labelText sizeWithAttributes:@{NSFontAttributeName : self.font}];
    NSUInteger textRow = (NSUInteger)(rect.size.height / textSize.height);
    return textRow + enterCount;
}
@end
