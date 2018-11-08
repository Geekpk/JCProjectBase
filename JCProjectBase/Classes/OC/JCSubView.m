//
//  JCSubView.m
//  JCProjectBase
//
//  Created by Arvin on 2018/11/8.
//

#import "JCSubView.h"

@interface JCSubView () {
    CGPoint isPoint;
}

@end

@implementation JCSubView

- (instancetype)initWithFrame:(CGRect)frame Identifier:(NSString *)indentifier{
    self = [super initWithFrame:frame];
    if (self) {
        
        self.identifier = indentifier;
        
        [self createUI];

    }
    return self;
}



#pragma mark - 重写

- (void)createUI{ }
@end
