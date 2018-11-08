//
//  JCSubView.h
//  JCProjectBase
//
//  Created by Arvin on 2018/11/8.
//

#import <UIKit/UIKit.h>

@interface JCSubView : UIView

@property (nonatomic,strong)NSString            *identifier;
@property (nonatomic,assign)BOOL                isUser;   //是否在使用

- (void)createUI;
- (instancetype)initWithFrame:(CGRect)frame Identifier:(NSString *)indentifier;

@end
