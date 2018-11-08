//
//  JCImageTextField.h
//  JCProjectBase
//
//  Created by 江城 on 2018/11/7.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface JCImageTextField : UITextField

/**
 设置leftView

 @param frame 视图尺寸
 @param leftImage 左image
 @param size 尺寸
 @return textfield
 */
- (id)initWithFrame:(CGRect)frame leftImage:(UIImage *)leftImage imageSize:(CGSize)size;

/**
 设置textfield右image
 
 @param frame 视图尺寸
 @param rightImage 右image
 @param size 尺寸
 @return textfield
 */
- (id)initWithFrame:(CGRect)frame rightImage:(UIImage *)rightImage imageSize:(CGSize)size;


/**
 同时设置textfield左右视图

 @param frame 尺寸
 @param leftImage 左image
 @param size1 尺寸
 @param rightImage 右image
 @param size2 尺寸
 @return textfield
 */
- (id)initWithFrame:(CGRect)frame leftImage:(UIImage *)leftImage imageSize:(CGSize)size1 rightImage:(UIImage *)rightImage imageSize:(CGSize)size2;
@end

NS_ASSUME_NONNULL_END
