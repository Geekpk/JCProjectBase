//
//  UIView+JCDashLine.h
//  JCProjectBase
//
//  Created by 江城 on 2018/11/7.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIView (JCDashLine)
/**
 绘制虚线
 
 @param height 虚线高度
 @param width 虚线宽度
 @param space 虚线间距
 @param color 虚线颜色
 */
- (void)drawDashLineWithLineHeight:(CGFloat)height dashLineWidth:(NSNumber *)width dashLineSpace:(NSNumber *)space lineColor:(UIColor *)color;
@end

NS_ASSUME_NONNULL_END
