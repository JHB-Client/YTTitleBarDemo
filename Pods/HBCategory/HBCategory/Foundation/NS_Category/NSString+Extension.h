//
//  NSString+Extension.h
//  SLFDA
//
//  Created by 季怀斌 on 2017/12/5.
//  Copyright © 2017年 huazhuo. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
@interface NSString (Extension)
+ (instancetype)deviceVersion;
- (BOOL)containsNumberString;
//获取当前的时间
+ (NSString*)getCurrentTimeWithFormatter:(NSString *)timeFormatter;
- (CGSize)getTextSizeWithMaxWidth:(CGFloat)maxWidth textFontSize:(NSInteger)textFontSize;
- (CGFloat)getTextWidthWithMaxWidth:(CGFloat)maxWidth textFontSize:(NSInteger)textFontSize;
- (CGFloat)getTextHeightWithMaxWidth:(CGFloat)maxWidth textFontSize:(NSInteger)textFontSize;
+ (BOOL)isBlankString:(NSString *)string;
+ (UIImage *)imageWithBase64String:(NSString *)base64String;
- (long long)fileSize;
- (NSString *)fileSizeStr;
// emojiToUnicode
- (NSString *)stringByReplacingEmojiUnicodeWithCheatCodes;
// unicodeToEmoji
- (NSString *)stringByReplacingEmojiCheatCodesWithUnicode;
//判断是否有emoji
+ (BOOL)stringContainsEmoji:(NSString *)string;
//
- (NSDictionary *)turnToDict;
//
- (NSMutableAttributedString *)changeContentColorWithString:(NSString *)colorStr color:(UIColor *)newColor;
- (NSMutableAttributedString *)changeContentColorWithRange:(NSRange)strRange color:(UIColor *)newColor;
@end
