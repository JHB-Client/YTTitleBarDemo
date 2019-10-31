\
//
//  UIImage+Extension.m
//  SLFDA
//
//  Created by 季怀斌 on 2017/12/5.
//  Copyright © 2017年 huazhuo. All rights reserved.
//

#import "UIImage+Extension.h"

@implementation UIImage (Extension)

//
+ (instancetype)imageWithOriginalName:(NSString *)imageName {
    UIImage *image = [UIImage imageNamed:imageName];
    return [image imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
}

+ (instancetype)imageWithStretchableName:(NSString *)imageName
{
    UIImage *image = [UIImage imageNamed:imageName];
    return [image stretchableImageWithLeftCapWidth:image.size.width * 0.5 topCapHeight:image.size.height * 0.5];
}

//
+ (UIImage *)setAdjustImageWithName:(NSString *)name{
    UIImage *normalImg = [UIImage imageNamed:name];
    
    CGFloat w = normalImg.size.width * 0.5f;
    CGFloat h = normalImg.size.height * 0.5f;
    
    return [normalImg resizableImageWithCapInsets:UIEdgeInsetsMake(h, w, h, w)];
}

- (instancetype)circleImage {
    // 开启图形上下文 （这个就用到前面的UIView的分类可以直接点出来）
    UIGraphicsBeginImageContext(self.size);
    
    // 获得上下文
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    
    // 矩形框
    CGRect rect = CGRectMake(0, 0, self.size.width, self.size.height);
    
    // 添加一个圆
    CGContextAddEllipseInRect(ctx, rect);
    
    // 裁剪(裁剪成刚才添加的图形形状)
    CGContextClip(ctx);
    
    // 往圆上面画一张图片
    [self drawInRect:rect];
    
    // 获得上下文中的图片
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    
    // 关闭图形上下文
    UIGraphicsEndImageContext();
    
    return image;
}

+ (instancetype)circleImageNamed:(NSString *)name {
    return [[self imageNamed:name] circleImage];
}

+ (instancetype)circleImage:(UIImage *)image {
    return [[self new] circleImage];
}

//
/**
 压图片质量 // 最大 32kb---300k : 10---80k
 
 @param sizeCount image
 @return Data
 */
- (NSData *)getCompressedImageDataWithMaxSizeCount:(int)sizeCount {
    if (!self) {
        return nil;
    }
    CGFloat maxFileSize = sizeCount * 1024;
    CGFloat compression = 0.9f;
    NSData *compressedData = UIImageJPEGRepresentation(self, compression);
    
    while ([compressedData length] > maxFileSize) {
        compression *= 0.9;
        compressedData = UIImageJPEGRepresentation([self compressImage:self newWidth:self.size.width * compression], compression);
    }
    return compressedData;
}


/**
 *  等比缩放本图片大小
 *
 *  @param newImageWidth 缩放后图片宽度，像素为单位
 *
 *  @return self-->(image)
 */
- (UIImage *)compressImage:(UIImage *)image newWidth:(CGFloat)newImageWidth
{
    if (!image) return nil;
    float imageWidth = image.size.width;
    float imageHeight = image.size.height;
    float width = newImageWidth;
    float height = image.size.height/(image.size.width/width);
    
    float widthScale = imageWidth /width;
    float heightScale = imageHeight /height;
    
    // 创建一个bitmap的context
    // 并把它设置成为当前正在使用的context
    UIGraphicsBeginImageContext(CGSizeMake(width, height));
    
    if (widthScale > heightScale) {
        [image drawInRect:CGRectMake(0, 0, imageWidth /heightScale , height)];
    }
    else {
        [image drawInRect:CGRectMake(0, 0, width , imageHeight /widthScale)];
    }
    
    // 从当前context中创建一个改变大小后的图片
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    // 使当前的context出堆栈
    UIGraphicsEndImageContext();
    
    return newImage;
    
}
//
+ (UIImage*)createImageWithColor:(UIColor*)color{
    
    CGSize size = CGSizeMake(1, 1);
    return [self createImageWithColor:color withSize:size];
}

+ (UIImage*)createImageWithColor:(UIColor*)color withSize:(CGSize)size {
    
    CGRect rect = CGRectMake(0, 0, size.width, size.height);
    UIGraphicsBeginImageContext(size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
    UIImage *theImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return theImage;
}


//
- (UIImage *)resizeImageWithSize:(CGSize)newSize {
    CGFloat newWidth = newSize.width;
    CGFloat newHeight = newSize.height;
    float width  = self.size.width;
    float height = self.size.height;
    if (width != newWidth || height != newHeight) {
        UIGraphicsBeginImageContextWithOptions(CGSizeMake(newWidth, newHeight), YES, [UIScreen mainScreen].scale);
        [self drawInRect:CGRectMake(0, 0, newWidth, newHeight)];
        
        UIImage *resized = UIGraphicsGetImageFromCurrentImageContext();
        UIGraphicsEndImageContext();
        return resized;
    }
    return self;
}
- (UIImage *)roundClip {
    
    CGSize size = self.size;
    UIGraphicsBeginImageContextWithOptions(size, NO, [UIScreen mainScreen].scale);
    UIBezierPath *path = [UIBezierPath bezierPathWithOvalInRect:CGRectMake(0, 0, self.size.width, self.size.height)];
    [path addClip];
    [self drawAtPoint:CGPointZero];
    UIImage * image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return image;
}

@end
