//
//  SK_ImageTool.h
//  SK_ImageToolDemo
//
//  Created by TrimbleZhang on 2019/1/24.
//  Copyright © 2019 AlexanderYeah. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

typedef enum{
    SKLogoImgTop_Left = 0,
    SKLogoImgTop_Right,
    SKLogoImgBot_Left,
    SKLogoImgBot_Right,
}SKLogoImgLocation;

NS_ASSUME_NONNULL_BEGIN

@interface SK_ImageTool : NSObject

/** MARK1: 给图片添加水印 可手动设置水印的位置 */
+ (UIImage *)addWatermarkImage:(UIImage *)image withName:(NSString *)name withFont:(NSInteger)font withTextColor:(UIColor *)textColor location:(SKLogoImgLocation)location;

/** MARK2: 给图片添加滤镜 */
+ (UIImage *)addDrawPiucureFrontImage:(UIImage *)personImage backImage:(UIImage *)hatImage blendMode:(CGBlendMode)blendMode alpha:(CGFloat)alpha;

/** MARK3: 压缩图片按照比例 */
+ (UIImage *)pressImgWithImg:(UIImage *)image scaleRatio:(CGFloat)ratio;

/** MARK4: 压缩图片按照大小 */
+ (UIImage *)pressImgWithImg:(UIImage *)image scaleToSize:(CGSize)size;

/** MARK5: 给图片添加Logo图片 */
+ (UIImage *)addLogoImage:(UIImage *)image addLogo:(UIImage *)logo;

/** MARK6: 获取启动图 */
+(UIImage *)getLaunchImage;






@end

NS_ASSUME_NONNULL_END
