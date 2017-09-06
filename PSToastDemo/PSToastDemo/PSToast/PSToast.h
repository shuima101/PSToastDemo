//
//  PSToast.h
//  PSToastDemo
//
//  Created by Passing on 2017/8/6.
//  Copyright © 2017年 Passing. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PSToast : UIView

@property(nonatomic,strong)NSString *message;

+(void)showMessage:(NSString *)message;
+(void)showMessage:(NSString *)message toView:(UIView *)view;
+(void)showMessage:(NSString *)message toView:(UIView *)view center:(CGPoint)center;

@end
