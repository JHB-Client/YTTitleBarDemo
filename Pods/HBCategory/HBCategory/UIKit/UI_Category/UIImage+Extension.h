//
//  UIImage+Extension.h
//  SLFDA
//
//  Created by 季怀斌 on 2017/12/5.
//  Copyright © 2017年 huazhuo. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (Extension)
//
// 加载最原始的图片，没有渲染
+ (instancetype)imageWithOriginalName:(NSString *)imageName;

+ (instancetype)imageWithStretchableName:(NSString *)imageName;

//
+ (UIImage *)setAdjustImageWithName:(NSString *)name;
//
+ (instancetype)circleImageNamed:(NSString *)name;
+ (instancetype)circleImage:(UIImage *)image;

//
- (NSData *)getCompressedImageDataWithMaxSizeCount:(int)sizeCount;
//
+ (UIImage*) createImageWithColor:(UIColor*)color;
+ (UIImage*)createImageWithColor:(UIColor*)color withSize:(CGSize)size;

//
- (UIImage *)resizeImageWithSize:(CGSize)newSize;
- (UIImage *)roundClip;
@end
