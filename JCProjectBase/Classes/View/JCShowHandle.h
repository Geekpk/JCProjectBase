//
//  JCShowHandle.h
//  SunlandsMBA
//
//  Created by 江城 on 2018/8/28.
//  Copyright © 2018年 Cecilia. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef NS_ENUM(NSUInteger, JCShowHandleType) {
    JCShowHandleTypeQRCode,
};

@interface JCShowHandle : NSObject

+ (instancetype)share;
/**
 对应的的type 自定义nib
 clickWantToDo callback
 */
- (void)show:(JCShowHandleType)type clickWantToDo:(void(^)(void))block;
- (void)show:(JCShowHandleType)type clickWantToDo:(void(^)(void))block closeBlock:(void(^)(void))close;
///对应的的type 自定义nib
+ (void (^)(JCShowHandleType type))show;
///对应的的type 自定义nib
- (void (^)(JCShowHandleType type))show;

+ (void (^)(NSTimeInterval time))delayRemove;

- (void (^)(NSTimeInterval time))delayRemove;

+ (void (^)(void))remove;

- (void (^)(void))remove;
@end

