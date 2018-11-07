//
//  JCImageTextField.h
//  JCProjectBase
//
//  Created by 江城 on 2018/11/7.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface JCImageTextField : UITextField
- (id)initWithFrame:(CGRect)frame leftImage:(UIImage *)leftImage imageSize:(CGSize)size;

- (id)initWithFrame:(CGRect)frame rightImage:(UIImage *)rightImage imageSize:(CGSize)size;

- (id)initWithFrame:(CGRect)frame leftImage:(UIImage *)leftImage imageSize:(CGSize)size1 rightImage:(UIImage *)rightImage imageSize:(CGSize)size2;
@end

NS_ASSUME_NONNULL_END
