//
//  UIView+JCSize.m
//  JCProjectBase
//
//  Created by 江城 on 2018/11/7.
//

#import "UIView+JCSize.h"

@implementation UIView (JCSize)
- (CGSize)sizeWithText:(NSString *)text font:(UIFont *)font {
    CGRect textRect = [text boundingRectWithSize:CGSizeMake(FLT_MAX, FLT_MAX)
                                         options:NSStringDrawingUsesLineFragmentOrigin
                                      attributes:@{NSFontAttributeName:font}
                                         context:nil];
    return CGSizeMake(textRect.size.width, textRect.size.height);
}
@end
