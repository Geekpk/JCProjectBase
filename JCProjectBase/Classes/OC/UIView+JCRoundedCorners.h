//
//  UIView+JCRoundedCorners.h
//  JCProjectBase
//
//  Created by 江城 on 2018/11/7.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIView (JCRoundedCorners)

- (void)drawCornersWithCorners:(UIRectCorner)corners
                   cornerRadii:(CGSize)radii;

- (void)drawCornersWithCorners:(UIRectCorner)corners
                   cornerRadii:(CGSize)radii
                      viewRect:(CGRect)rect;
@end

NS_ASSUME_NONNULL_END
