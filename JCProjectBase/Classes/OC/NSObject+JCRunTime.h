//
//  NSObject+JCRunTime.h
//  JCProjectBase
//
//  Created by 江城 on 2018/11/7.
//

#import <Foundation/Foundation.h>
NS_ASSUME_NONNULL_BEGIN
@interface NSObject (JCRunTime)

/**
 方法交换

 @param originSel 方法前身
 @param swizzleSel 方法后世
 */
+ (void)swizzleClassMethodWithOriginSel:(SEL)originSel swizzleSel:(SEL)swizzleSel;

/**
 方法实现交换
 
 @param originSel 方法前身
 @param swizzleSel 方法后世
 */
+ (void)swizzleInstanceMethodWithOriginSel:(SEL)originSel swizzleSel:(SEL)swizzleSel;

+ (Class)addMethodToStubClass:(SEL)aSel;

+ (BOOL)isMainBundleClass:(Class)cls;

- (BOOL)isMethodOverride:(Class)cls selector:(SEL)sel;

@end

NS_ASSUME_NONNULL_END
