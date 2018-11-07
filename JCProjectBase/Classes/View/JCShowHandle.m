//
//  JCShowHandle.m
//  JCProgramBase
//
//  Created by 江城 on 2018/8/28.
//  Copyright © 2018年 Cecilia. All rights reserved.
//

#import "JCShowHandle.h"
#import <YYKit/YYKit.h>

@interface JCShowHandle ()
@property (nonatomic, strong) UIView *montuView;
@property (nonatomic, strong) UIView *showTimeView;
@property (nonatomic, copy) void(^ClickWantToDoCallBack)(void);
@property (nonatomic, copy) void(^CloseCallBack)(void);

@end
static JCShowHandle *handle = nil;
@implementation JCShowHandle

+ (instancetype)share {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        handle = [[JCShowHandle alloc] init];
    });
    return handle;
}

/**
 点击了关闭

 @param sender 按钮
 */
- (IBAction)clickToRemove:(UIButton *)sender {
    [self hidden];
    if (self.CloseCallBack) {
        self.CloseCallBack();
        //用完即销毁
        self.CloseCallBack = nil;
    }
}

/**
 确定想做

 @param sender 确定按钮
 */
- (IBAction)sureWantToDo:(UIButton *)sender {
    if (self.ClickWantToDoCallBack) {
        self.ClickWantToDoCallBack();
        //用完即销毁
        self.ClickWantToDoCallBack = nil;
    }
    [self hidden];
}

/**
 取消想做

 @param sender 取消按钮
 */
- (IBAction)cancelToDo:(UIButton *)sender {
    [self hidden];
}

+ (void (^)(JCShowHandleType type))show {
    return ^(JCShowHandleType type){
        JCShowHandle.share.show(type);
    };
}

/**
 代理方法

 @param type show view的类型
 @param block 回调方法
 */
- (void)show:(JCShowHandleType)type clickWantToDo:(void(^)(void))block {
    self.ClickWantToDoCallBack = block;
    [self showContent:type];
}

/**
 代理方法

 @param type show view的类型
 @param block <#block description#>
 @param close <#close description#>
 */
- (void)show:(JCShowHandleType)type clickWantToDo:(void (^)(void))block closeBlock:(void (^)(void))close {
    self.CloseCallBack = close;
    [self show:type clickWantToDo:block];
}

- (void (^)(JCShowHandleType type))show{
    
    return ^(JCShowHandleType type) {
        [self showContent:type];
    };
}

+ (void (^)(NSTimeInterval time))delayRemove {
    return ^(NSTimeInterval time){
        JCShowHandle.share.delayRemove(time);
    };
}
- (void (^)(NSTimeInterval time))delayRemove {
    return ^(NSTimeInterval time){
        dispatch_async(dispatch_get_main_queue(), ^{
            [JCShowHandle cancelPreviousPerformRequestsWithTarget:self selector:@selector(hidden) object:nil];
            [JCShowHandle performSelector:@selector(hidden) withObject:nil afterDelay:time];
        });
    };
}

+ (void (^)(void))remove {
    return ^(){
        [JCShowHandle.share hidden];
    };
}
- (void (^)(void))remove {
    return ^(){
        [self hidden];
    };
}
- (void)hidden {
    dispatch_async(dispatch_get_main_queue(), ^{
        if (JCShowHandle.share.montuView.superview) {
            [JCShowHandle.share.montuView removeFromSuperview];
        }
        if (JCShowHandle.share.showTimeView.superview) {
            [JCShowHandle.share.showTimeView removeFromSuperview];
        }
    });
}

- (void)showContent:(JCShowHandleType)type {
    dispatch_async(dispatch_get_main_queue(), ^{
        self.montuView = [NSBundle.mainBundle loadNibNamed:JCShowHandle.className
                                                     owner:self
                                                   options:nil].firstObject;
        
        self.showTimeView = [NSBundle.mainBundle loadNibNamed:JCShowHandle.className
                                                        owner:self
                                                      options:nil][type + 1];
        
        BOOL contain = false;
        for (UIView *v in UIApplication.sharedApplication.windows.firstObject.subviews) {
            if ([v isEqual:self.montuView] ||
                [v isEqual:self.showTimeView]) {
                contain = true;
            }
        }
        
        
        if (!contain) {
            for (UIView *v in self.showTimeView.subviews) {
                if (v.tag == 110) {
                    v.layer.cornerRadius = 4;
                }
            }
            UIWindow *w = UIApplication.sharedApplication.windows.firstObject;
            self.montuView.frame = CGRectMake(0, 0, w.width, w.height);
            self.showTimeView.frame = CGRectMake(0, 0, w.width, w.height);
            [UIApplication.sharedApplication.windows.firstObject addSubview:self.montuView];
            [UIApplication.sharedApplication.windows.firstObject addSubview:self.showTimeView];
            
        }
    });

}
@end
