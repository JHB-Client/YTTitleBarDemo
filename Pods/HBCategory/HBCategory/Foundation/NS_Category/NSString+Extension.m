
//
//  NSString+Extension.m
//  SLFDA
//
//  Created by 季怀斌 on 2017/12/5.
//  Copyright © 2017年 huazhuo. All rights reserved.
//

#import "NSString+Extension.h"
#import <sys/utsname.h>
@implementation NSString (Extension)

/**
  是否包含数字
 */
- (BOOL)containsNumberString {
    NSRegularExpression *numberRegular = [NSRegularExpression regularExpressionWithPattern:@"[0-9]" options:NSRegularExpressionCaseInsensitive error:nil];
    
    NSInteger count = [numberRegular numberOfMatchesInString:self options:NSMatchingReportProgress range:NSMakeRange(0, self.length)];
    
    //count是str中包含[0-9]数字的个数，只要count>0，说明str中包含数字
    return count;
}
//获取当前的时间
+ (NSString*)getCurrentTimeWithFormatter:(NSString *)timeFormatter {
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    // ----------设置你想要的格式,hh与HH的区别:分别表示12小时制,24小时制
    if (timeFormatter == nil || timeFormatter.length == 0) {
        [formatter setDateFormat:@"YYYY-MM-dd"];
    } else {
        [formatter setDateFormat:timeFormatter];
    }
    
    //现在时间,你可以输出来看下是什么格式
    NSDate *datenow = [NSDate date];
    //----------将nsdate按formatter格式转成nsstring
    NSString *currentTimeString = [formatter stringFromDate:datenow];
    NSLog(@"currentTimeString = %@",currentTimeString);
    return currentTimeString;
}
+ (instancetype)deviceVersion {
    // 需要
    struct utsname systemInfo;
    uname(&systemInfo);
    NSString *deviceString = [NSString stringWithCString:systemInfo.machine encoding:NSUTF8StringEncoding];
    
    //iPhone
    if ([deviceString isEqualToString:@"iPhone1,1"])    return @"iPhone 1G";
    if ([deviceString isEqualToString:@"iPhone1,2"])    return @"iPhone 3G";
    if ([deviceString isEqualToString:@"iPhone2,1"])    return @"iPhone 3GS";
    if ([deviceString isEqualToString:@"iPhone3,1"])    return @"iPhone 4";
    if ([deviceString isEqualToString:@"iPhone3,2"])    return @"Verizon iPhone 4";
    if ([deviceString isEqualToString:@"iPhone4,1"])    return @"iPhone 4S";
    if ([deviceString isEqualToString:@"iPhone5,1"])    return @"iPhone 5";
    if ([deviceString isEqualToString:@"iPhone5,2"])    return @"iPhone 5";
    if ([deviceString isEqualToString:@"iPhone5,3"])    return @"iPhone 5C";
    if ([deviceString isEqualToString:@"iPhone5,4"])    return @"iPhone 5C";
    if ([deviceString isEqualToString:@"iPhone6,1"])    return @"iPhone 5S";
    if ([deviceString isEqualToString:@"iPhone6,2"])    return @"iPhone 5S";
    if ([deviceString isEqualToString:@"iPhone7,1"])    return @"iPhone 6 Plus";
    if ([deviceString isEqualToString:@"iPhone7,2"])    return @"iPhone 6";
    if ([deviceString isEqualToString:@"iPhone8,1"])    return @"iPhone 6s";
    if ([deviceString isEqualToString:@"iPhone8,2"])    return @"iPhone 6s Plus";
    
    //iPod
    if ([deviceString isEqualToString:@"iPod1,1"])      return @"iPod Touch 1G";
    if ([deviceString isEqualToString:@"iPod2,1"])      return @"iPod Touch 2G";
    if ([deviceString isEqualToString:@"iPod3,1"])      return @"iPod Touch 3G";
    if ([deviceString isEqualToString:@"iPod4,1"])      return @"iPod Touch 4G";
    if ([deviceString isEqualToString:@"iPod5,1"])      return @"iPod Touch 5G";
    
    //iPad
    if ([deviceString isEqualToString:@"iPad1,1"])      return @"iPad";
    if ([deviceString isEqualToString:@"iPad2,1"])      return @"iPad 2 (WiFi)";
    if ([deviceString isEqualToString:@"iPad2,2"])      return @"iPad 2 (GSM)";
    if ([deviceString isEqualToString:@"iPad2,3"])      return @"iPad 2 (CDMA)";
    if ([deviceString isEqualToString:@"iPad2,4"])      return @"iPad 2 (32nm)";
    if ([deviceString isEqualToString:@"iPad2,5"])      return @"iPad mini (WiFi)";
    if ([deviceString isEqualToString:@"iPad2,6"])      return @"iPad mini (GSM)";
    if ([deviceString isEqualToString:@"iPad2,7"])      return @"iPad mini (CDMA)";
    
    if ([deviceString isEqualToString:@"iPad3,1"])      return @"iPad 3(WiFi)";
    if ([deviceString isEqualToString:@"iPad3,2"])      return @"iPad 3(CDMA)";
    if ([deviceString isEqualToString:@"iPad3,3"])      return @"iPad 3(4G)";
    if ([deviceString isEqualToString:@"iPad3,4"])      return @"iPad 4 (WiFi)";
    if ([deviceString isEqualToString:@"iPad3,5"])      return @"iPad 4 (4G)";
    if ([deviceString isEqualToString:@"iPad3,6"])      return @"iPad 4 (CDMA)";
    
    if ([deviceString isEqualToString:@"iPad4,1"])      return @"iPad Air";
    if ([deviceString isEqualToString:@"iPad4,2"])      return @"iPad Air";
    if ([deviceString isEqualToString:@"iPad4,3"])      return @"iPad Air";
    if ([deviceString isEqualToString:@"iPad5,3"])      return @"iPad Air 2";
    if ([deviceString isEqualToString:@"iPad5,4"])      return @"iPad Air 2";
    if ([deviceString isEqualToString:@"i386"])         return @"Simulator";
    if ([deviceString isEqualToString:@"x86_64"])       return @"Simulator";
    
    if ([deviceString isEqualToString:@"iPad4,4"]
        ||[deviceString isEqualToString:@"iPad4,5"]
        ||[deviceString isEqualToString:@"iPad4,6"])      return @"iPad mini 2";
    
    if ([deviceString isEqualToString:@"iPad4,7"]
        ||[deviceString isEqualToString:@"iPad4,8"]
        ||[deviceString isEqualToString:@"iPad4,9"])      return @"iPad mini 3";
    
    return deviceString;
}

- (CGSize)getTextSizeWithMaxWidth:(CGFloat)maxWidth textFontSize:(NSInteger)textFontSize {
    
    return  [self boundingRectWithSize:CGSizeMake(maxWidth, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin|NSStringDrawingUsesFontLeading|NSStringDrawingTruncatesLastVisibleLine attributes:@{NSFontAttributeName : [UIFont systemFontOfSize:textFontSize]} context:nil].size;
    
}
- (CGFloat)getTextWidthWithMaxWidth:(CGFloat)maxWidth textFontSize:(NSInteger)textFontSize {
    return  [self boundingRectWithSize:CGSizeMake(maxWidth, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin|NSStringDrawingUsesFontLeading|NSStringDrawingTruncatesLastVisibleLine attributes:@{NSFontAttributeName : [UIFont systemFontOfSize:textFontSize]} context:nil].size.width;
}

- (CGFloat)getTextHeightWithMaxWidth:(CGFloat)maxWidth textFontSize:(NSInteger)textFontSize {
    return  [self boundingRectWithSize:CGSizeMake(maxWidth, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin|NSStringDrawingUsesFontLeading|NSStringDrawingTruncatesLastVisibleLine attributes:@{NSFontAttributeName : [UIFont systemFontOfSize:textFontSize]} context:nil].size.height;
    
    //    NSDictionary *dic = @{NSFontAttributeName:[UIFont systemFontOfSize:textFontSize]};
    //    CGSize size = CGSizeMake(maxWidth, CGFLOAT_MAX);
    //    CGRect rect = [self boundingRectWithSize:size options:NSStringDrawingUsesLineFragmentOrigin attributes:dic context:nil];
    //    return rect.size.height;
}

+ (BOOL)isBlankString:(NSString *)string {
    
    if (![string isKindOfClass:[NSString class]]) return YES;
    
    if (string == nil || string == NULL) {
        return YES;
    }
    if ([string isKindOfClass:[NSNull class]]) {
        return YES;
    }
    
    NSLog(@"----3335-----%@", string);
    if ([[string stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]] length]==0) {
        return YES;
    }
    return NO;
}
+ (UIImage *)imageWithBase64String:(NSString *)base64String {
    NSURL *url = [NSURL URLWithString: base64String];
    NSData *data = [NSData dataWithContentsOfURL: url];
    UIImage *image = [UIImage imageWithData: data];
    return image;
}

- (long long)fileSize {
    
    //1. 创建文件管理者
    NSFileManager *fmgr = [NSFileManager defaultManager];
    
    //2. 判断file是否存在
    BOOL isDirectory = NO;// 是否是文件夹
    BOOL fileExixts = [fmgr fileExistsAtPath:self isDirectory:&isDirectory];
    
    // 文件／文件夹是否存在
    if (!fileExixts) return 0;
    
    //3. 判断file是否是文件夹
    if (isDirectory) { // 是文件夹
        
        NSArray *subPaths = [fmgr contentsOfDirectoryAtPath:self error:nil];
        
        long long totalSize = 0;
        
        for (NSString *subPath in subPaths) {
            NSString *fullSubPath = [self stringByAppendingPathComponent:subPath];
            
            totalSize += [fullSubPath fileSize];
        }
        
        return totalSize;
        
    }else { // 文件，不是文件夹
        
        // 直接计算当前文件的大小
        NSDictionary *attrDic = [fmgr attributesOfItemAtPath:self error:nil];
        
        return [attrDic[NSFileSize] longLongValue];
    }
}

- (NSString *)fileSizeStr {
    // 总大小
    unsigned long long size = 0;
    NSString *sizeText = nil;
    // 文件管理者
    NSFileManager *mgr = [NSFileManager defaultManager];
    
    // 文件属性
    NSDictionary *attrs = [mgr attributesOfItemAtPath:self error:nil];
    // 如果这个文件或者文件夹不存在,或者路径不正确直接返回0;
    if (attrs == nil) return @"";
    if ([attrs.fileType isEqualToString:NSFileTypeDirectory]) { // 如果是文件夹
        // 获得文件夹的大小  == 获得文件夹中所有文件的总大小
        NSDirectoryEnumerator *enumerator = [mgr enumeratorAtPath:self];
        for (NSString *subpath in enumerator) {
            // 全路径
            NSString *fullSubpath = [self stringByAppendingPathComponent:subpath];
            // 累加文件大小
            size += [mgr attributesOfItemAtPath:fullSubpath error:nil].fileSize;
            
            if (size >= pow(1024, 3)) { // size >= 1GB
                sizeText = [NSString stringWithFormat:@"%.1fGB", size / pow(1024, 3)];
            } else if (size >= pow(1024, 2)) { // 1GB > size >= 1MB
                sizeText = [NSString stringWithFormat:@"%.1fMB", size / pow(1024, 2)];
            } else if (size >= 1024) { // 1MB > size >= 1KB
                sizeText = [NSString stringWithFormat:@"%lluKB", size / 1024];
            } else { // 1KB > size
                sizeText = [NSString stringWithFormat:@"%zdB", size];
            }
            
        }
        return sizeText;
    } else { // 如果是文件
        size = attrs.fileSize;
        if (size >= pow(1024, 3)) { // size >= 1GB
            sizeText = [NSString stringWithFormat:@"%.1fGB", size / pow(1024, 3)];
        } else if (size >= pow(1024, 2)) { // 1GB > size >= 1MB
            sizeText = [NSString stringWithFormat:@"%.1fMB", size / pow(1024, 2)];
        } else if (size >= 1024) { // 1MB > size >= 1KB
            sizeText = [NSString stringWithFormat:@"%lluKB", size / 1024];
        } else { // 1KB > size
            sizeText = [NSString stringWithFormat:@"%zdB", size];
        }
        
    }
    return sizeText;
}


- (NSString *)stringByConvertEmojiToCheatCodes {
    if (self.length <= 1) {
        return self;
    }
    
    // emoji 现在有 2、4、6、8、字节的，最多处理前4位，
    NSMutableString *hexMutStr = [[NSMutableString alloc] init];
    
    for (int i=0; (i<self.length-1) && (i<3); ) {
        const unichar hs = [self characterAtIndex:i];
        const unichar ls = [self characterAtIndex:i+1];
        
        // surrogate pair
        if (0xd800 <= hs && hs <= 0xdbff) {
            
            const int uc = ((hs - 0xd800) * 0x400) + (ls - 0xdc00) + 0x10000;
            
            if (0x1d000 <= uc && uc <= 0x1f9cf) {
                [hexMutStr appendFormat:@"[U+%X]",uc];
                i+=2;
            } else {
                break;
            }
            
        } else if ((0x2100 <= hs && hs <= 0x269f) ||
                   (0x26a0 <= hs && hs <= 0x329f)) {
            [hexMutStr appendFormat:@"[U+%X]",hs];
            i+=2;
        } else {
            break;
        }
    }
    
    return hexMutStr;
}

- (NSString *)stringByConvertCheatCodesToEmoji {
    if (self.length <= 1) {
        return self;
    }
    
    NSString *str = [self stringByReplacingOccurrencesOfString:@"U+" withString:@"0x"];
    str = [str stringByTrimmingCharactersInSet:[NSCharacterSet characterSetWithCharactersInString:@"[]"]];
    
    NSScanner *aScanner = [NSScanner scannerWithString:str];
    unsigned uc;
    [aScanner scanHexInt:&uc];
    
    //    NSString *scanString = @"[0x1F600]";
    //    NSScanner *bScanner = [NSScanner scannerWithString:scanString];
    //    unsigned r;
    //    [bScanner scanHexInt:&r];
    
    NSString *emoji = @"";
    // 转换参照地址 http://blog.csdn.net/u014702999/article/details/43055445
    if (0x1d000 <= uc && uc <= 0x1f9cf) {
        unsigned short hex = (unsigned short)(uc - 0x10000);
        unsigned short hs = (hex>>10)|0xD800;
        unsigned short ls = (hex&0x03ff)|0xDC00;
        
        unichar array[2];
        array[0] = hs;
        array[1] = ls;
        emoji = [NSString stringWithCharacters:array length:2];
    }else if ((0x2100 <= uc && uc <= 0x269f) ||
              (0x26a0 <= uc && uc <= 0x329f)) {
        unsigned short ls = (unsigned short)(uc&0xffff);
        emoji = [NSString stringWithCharacters:&ls length:1];
    }
    
    return emoji;
}

- (NSString *)stringByReplacingEmojiUnicodeWithCheatCodes {
    if (self.length <= 1) {
        return self;
    }
    
    NSMutableString *str = [NSMutableString stringWithString:self];
    
    [str enumerateSubstringsInRange:NSMakeRange(0, [str length]) options:NSStringEnumerationByComposedCharacterSequences usingBlock:
     ^(NSString *substring, NSRange substringRange, NSRange enclosingRange, BOOL *stop) {
         NSString *unicode = [substring stringByConvertEmojiToCheatCodes];
         [str replaceCharactersInRange:substringRange withString:unicode];
     }];
    
    return str;
}


- (NSString *)stringByReplacingEmojiCheatCodesWithUnicode {
    if (self.length <= 1) {
        return self;
    }
    
    NSRegularExpression *regex = [[NSRegularExpression alloc] initWithPattern:@"\\[U\\+[a-f0-9A-F]+\\]" options:NSRegularExpressionCaseInsensitive error:NULL];
    
    __block NSString *resultText = self;
    __block NSRange matchingRange = NSMakeRange(0, [resultText length]);
    
    for (; matchingRange.location < resultText.length;) {
        [regex enumerateMatchesInString:resultText
                                options:NSMatchingReportCompletion
                                  range:matchingRange
                             usingBlock:^(NSTextCheckingResult *result, NSMatchingFlags flags, BOOL *stop) {
                                 if (result && ([result resultType] == NSTextCheckingTypeRegularExpression) && !(flags & NSMatchingInternalError)) {
                                     NSRange range = result.range;
                                     if (range.location != NSNotFound) {
                                         NSString *unicodeStr = [resultText substringWithRange:range];
                                         NSString *emji = [unicodeStr stringByConvertCheatCodesToEmoji];
                                         if (emji.length) {
                                             resultText = [resultText stringByReplacingCharactersInRange:range withString:emji];
                                             matchingRange = NSMakeRange(range.location + emji.length, resultText.length-range.location - emji.length);
                                             *stop = YES;
                                         }
                                     }
                                 } else {
                                     matchingRange = NSMakeRange(resultText.length, 0);
                                 }
                             }];
    }
    
    return resultText;
}

//判断是否有emoji
+ (BOOL)stringContainsEmoji:(NSString *)string {
    __block BOOL returnValue = NO;
    
    [string enumerateSubstringsInRange:NSMakeRange(0, [string length])
                               options:NSStringEnumerationByComposedCharacterSequences
                            usingBlock:^(NSString *substring, NSRange substringRange, NSRange enclosingRange, BOOL *stop) {
                                const unichar high = [substring characterAtIndex: 0];
                                
                                // Surrogate pair (U+1D000-1F9FF)
                                if (0xD800 <= high && high <= 0xDBFF) {
                                    const unichar low = [substring characterAtIndex: 1];
                                    const int codepoint = ((high - 0xD800) * 0x400) + (low - 0xDC00) + 0x10000;
                                    
                                    if (0x1D000 <= codepoint && codepoint <= 0x1F9FF){
                                        returnValue = YES;
                                    }
                                    
                                    // Not surrogate pair (U+2100-27BF)
                                } else {
                                    if (0x2100 <= high && high <= 0x27BF){
                                        returnValue = YES;
                                    }
                                }
                            }];
    
    return returnValue;
}

//
- (NSDictionary *)turnToDict{
    if (self == nil) {
        return nil;
    }
    NSData *jsonData = [self dataUsingEncoding:NSUTF8StringEncoding];
    NSError *err;
    NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:jsonData
                                                        options:NSJSONReadingMutableContainers
                                                          error:&err];
    if(err) {
        NSLog(@"json解析失败：%@",err);
        return nil;
    }
    return dic;
}

//
- (NSMutableAttributedString *)changeContentColorWithString:(NSString *)colorStr color:(UIColor *)newColor {
    
    
    NSMutableAttributedString *mAttStri = [[NSMutableAttributedString alloc] initWithString:self];
    NSRange range = [self rangeOfString:colorStr];
    [mAttStri addAttribute:NSForegroundColorAttributeName value:newColor range:range];
    return mAttStri;
}

//
- (NSMutableAttributedString *)changeContentColorWithRange:(NSRange)strRange color:(UIColor *)newColor {
    NSMutableAttributedString *mAttStri = [[NSMutableAttributedString alloc] initWithString:self];
    [mAttStri addAttribute:NSForegroundColorAttributeName value:newColor range:strRange];
    return mAttStri;
}
@end
