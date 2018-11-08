//
//  UIView+JCRoundedCorners.m
//  JCProjectBase
//
//  Created by 江城 on 2018/11/7.
//

#import "UIView+JCRoundedCorners.h"

@implementation UIView (JCRoundedCorners)

- (void)drawCornersWithCorners:(UIRectCorner)corners
                   cornerRadii:(CGSize)radii {
    UIBezierPath *maskPath = [UIBezierPath bezierPathWithRoundedRect:self.bounds byRoundingCorners:corners cornerRadii:radii];
    CAShapeLayer *shape = [[CAShapeLayer alloc] init];
    shape.path = maskPath.CGPath;
    self.layer.mask = shape;
}

- (void)drawCornersWithCorners:(UIRectCorner)corners
                   cornerRadii:(CGSize)radii
                      viewRect:(CGRect)rect {
    UIBezierPath *maskPath = [UIBezierPath bezierPathWithRoundedRect:rect byRoundingCorners:corners cornerRadii:radii];
    CAShapeLayer *shape = [[CAShapeLayer alloc] init];
    shape.path = maskPath.CGPath;
    self.layer.mask = shape;
}


@end
