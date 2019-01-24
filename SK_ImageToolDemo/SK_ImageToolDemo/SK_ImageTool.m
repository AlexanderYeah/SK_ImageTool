//
//  SK_ImageTool.m
//  SK_ImageToolDemo
//
//  Created by TrimbleZhang on 2019/1/24.
//  Copyright © 2019 AlexanderYeah. All rights reserved.
//

#import "SK_ImageTool.h"

@implementation SK_ImageTool

/** MARK1: 给图片添加水印 可手动设置水印的位置 */
+ (UIImage *)addWatermarkImage:(UIImage *)image withName:(NSString *)name withFont:(NSInteger)font withTextColor:(UIColor *)textColor location:(SKLogoImgLocation)location
{
    NSString* mark = name;
    
    int w = image.size.width;
    int h = image.size.height;
    
    UIGraphicsBeginImageContext(image.size);
    [image drawInRect:CGRectMake(0, 0, w, h)];
    
    NSDictionary *attrDic = @{
                              NSFontAttributeName: [UIFont boldSystemFontOfSize:font],  //设置字体
                              NSForegroundColorAttributeName : textColor   //设置字体颜色
                              };
    

    // 计算出文字的高度和宽度
    CGRect logoRect = [name boundingRectWithSize:CGSizeMake(0, 0) options:NSStringDrawingUsesLineFragmentOrigin attributes:attrDic context:nil];

    CGFloat logo_w = logoRect.size.width;
    CGFloat logo_h = logoRect.size.height;
    
    switch (location) {
        case SKLogoImgTop_Left:
            // 左上角
            [mark drawInRect:CGRectMake(10, 0,logo_w, logo_h) withAttributes:attrDic];
            
            break;
        case SKLogoImgTop_Right:
            // 右上角
            [mark drawInRect:CGRectMake(w - logo_w - 10, 0, logo_w, logo_h) withAttributes:attrDic];
            break;
        case SKLogoImgBot_Left:
            // 右下角
            [mark drawInRect:CGRectMake(w - logo_w - 10, h -logo_h - 10, logo_w, logo_h) withAttributes:attrDic];
            break;
        case SKLogoImgBot_Right:
            // 左下角
            [mark drawInRect:CGRectMake(10, h -logo_h - 10, logo_w, logo_h) withAttributes:attrDic];
            break;
            
        default:
            break;
    }

    
    UIImage *waterImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return waterImage;
    
}


/** MARK2: 给图片添加滤镜 */
//图片显示模式处理
/*
 这个是混合模式的效果  在ps中是正常，以下是常用的模式
 kCGBlendModeNormal --ok  正常,
 kCGBlendModeMultiply,    正片叠底
 kCGBlendModeScreen,      滤色
 kCGBlendModeOverlay,     叠加
 kCGBlendModeDarken,      变暗
 kCGBlendModeLighten,     变亮
 kCGBlendModeColorDodge,  颜色减淡
 kCGBlendModeColorBurn,   颜色加深
 kCGBlendModeSoftLight,   柔光
 kCGBlendModeHardLight,   强光
 kCGBlendModeDifference,  差值
 kCGBlendModeExclusion,   排除
 kCGBlendModeHue,         色相
 kCGBlendModeSaturation,  保护度
 kCGBlendModeColor,       颜色
 kCGBlendModeLuminosity   明度,
 */
+ (UIImage *)drawPiucureFrontImage:(UIImage *)personImage backImage:(UIImage *)hatImage blendMode:(CGBlendMode)blendMode alpha:(CGFloat)alpha
{
    CGSize newSize =[personImage size];
    UIGraphicsBeginImageContext(newSize);
    [personImage drawInRect:CGRectMake(0,0,newSize.width,newSize.height) blendMode:kCGBlendModeNormal alpha:0.3];
    [hatImage drawInRect:CGRectMake(0,0,newSize.width,newSize.height) blendMode:blendMode alpha:alpha];
    UIImage*newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return newImage;
}


/** MARK3: 压缩图片按照比例 */
+ (UIImage *)pressImgWithImg:(UIImage *)image scaleRatio:(CGFloat)ratio
{
    
    CGImageRef imgRef = image.CGImage;
    if (ratio > 1 || ratio <= 0) {
        return image;
    }
    CGSize size = CGSizeMake(CGImageGetWidth(imgRef) * ratio, CGImageGetHeight(imgRef) * ratio); // 缩放后大小
    
    
    return [self pressImgWithImg:image scaleToSize:size];
    
}


/** MARK4: 压缩图片按照大小 */
+ (UIImage *)pressImgWithImg:(UIImage *)image scaleToSize:(CGSize)size
{
    CGImageRef imgRef = image.CGImage;
    CGSize originSize = CGSizeMake(CGImageGetWidth(imgRef), CGImageGetHeight(imgRef)); // 原始大小
    if (CGSizeEqualToSize(originSize, size)) {
        return image;
    }
    UIGraphicsBeginImageContextWithOptions(size, NO, 0);
    CGContextRef context = UIGraphicsGetCurrentContext();
    /**
     *  设置CGContext集插值质量
     *  kCGInterpolationHigh 插值质量高
     */
    CGContextSetInterpolationQuality(context, kCGInterpolationHigh);
    [image drawInRect:CGRectMake(0, 0, size.width, size.height)];
    UIImage *scaledImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return scaledImage;
}

/** MARK5: 给图片添加Logo图片 */
+ (UIImage *)addLogoImage:(UIImage *)image addLogo:(UIImage *)logo
{
    if (logo == nil ) {
        return image;
    }
    if (image == nil) {
        return nil;
    }
    //get image width and height
    int w = image.size.width;
    int h = image.size.height;
    int logoWidth = logo.size.width;
    int logoHeight = logo.size.height;
    
    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
    //create a graphic context with CGBitmapContextCreate
    CGContextRef context = CGBitmapContextCreate(NULL, w, h, 8, 44 * w, colorSpace, kCGImageAlphaPremultipliedFirst);
    CGContextDrawImage(context, CGRectMake(0, 0, w, h), image.CGImage);
    CGContextDrawImage(context, CGRectMake(w-logoWidth-15, 10, logoWidth, logoHeight), [logo CGImage]);
    CGImageRef imageMasked = CGBitmapContextCreateImage(context);
    UIImage *returnImage = [UIImage imageWithCGImage:imageMasked];
    CGContextRelease(context);
    CGImageRelease(imageMasked);
    CGColorSpaceRelease(colorSpace);
    return returnImage;
    
}

/** MARK6: 获取启动图 */
+(UIImage *)getLaunchImage{
    UIImage *lauchImage  = nil;
    NSString *viewOrientation = nil;
    CGSize viewSize = [UIScreen mainScreen].bounds.size;
    UIInterfaceOrientation orientation = [[UIApplication sharedApplication] statusBarOrientation];
    if(orientation == UIInterfaceOrientationLandscapeLeft || orientation == UIInterfaceOrientationLandscapeRight) {
        viewOrientation = @"Landscape";
    }else{
        viewOrientation = @"Portrait";
    }
    NSArray *imagesDictionary = [[[NSBundle mainBundle] infoDictionary] valueForKey:@"UILaunchImages"];
    for (NSDictionary *dict in imagesDictionary) {
        CGSize imageSize = CGSizeFromString(dict[@"UILaunchImageSize"]);
        if (CGSizeEqualToSize(imageSize, viewSize) && [viewOrientation isEqualToString:dict[@"UILaunchImageOrientation"]]) {
            lauchImage = [UIImage imageNamed:dict[@"UILaunchImageName"]];
        }
    }
    return lauchImage;
}

@end
