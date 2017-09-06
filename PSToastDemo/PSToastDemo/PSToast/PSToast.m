//
//  PSToast.m
//  PSToastDemo
//
//  Created by Passing on 2017/8/6.
//  Copyright © 2017年 Passing. All rights reserved.
//

#import "PSToast.h"

@interface PSToast ()<CAAnimationDelegate>

{
    UILabel *msgLb;
}

@end

@implementation PSToast

+(instancetype)sharedAlert
{
    static PSToast *toast = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        CGRect frame = CGRectZero;
        toast = [[self alloc] initWithFrame:frame];
    });
    return toast;
}

+(void)showMessage:(NSString *)message
{
    if (!message) {
        return;
    }
    NSEnumerator *windows = [[UIApplication sharedApplication].windows reverseObjectEnumerator];
    for (UIWindow *window in windows)
        if (window.windowLevel == UIWindowLevelNormal) {
            [self showMessage:message toView:window];
            break;
        }
}

+(void)showMessage:(NSString *)message toView:(UIView *)view
{
    if (!message) {
        return;
    }
    if (!view) {
        [self showMessage:message];
        return;
    }
    [self showMessage:message toView:view center:CGPointMake(view.width/2.0, view.height/2.0)];
}

+(void)showMessage:(NSString *)message toView:(UIView *)view center:(CGPoint)center
{
    [[self sharedAlert] showAlert:message toView:view center:(CGPoint)center];
}

-(id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.layer.backgroundColor = [UIColor blackColor].CGColor;
        self.layer.cornerRadius = 5.0;
        
        msgLb = [[UILabel alloc]init];
        msgLb.font = [UIFont boldSystemFontOfSize:16];
        msgLb.textAlignment = NSTextAlignmentCenter;
        msgLb.backgroundColor = [UIColor clearColor];
        msgLb.textColor = [UIColor whiteColor];
        msgLb.numberOfLines = 0;
        [self addSubview:msgLb];
    }
    return self;
}

-(void)showAlert:(NSString *)message toView:(UIView *)view center:(CGPoint)center
{
    self.message = message;
    self.alpha = 0.8;
    
    [view addSubview:self];
    self.center = center;
    
    [self beginAnimation];
}

-(void)beginAnimation
{
    CAKeyframeAnimation *animation = [CAKeyframeAnimation animationWithKeyPath:@"transform.translation.x"];
    CGFloat currentTx = self.transform.tx;
    
    animation.delegate = self;
    animation.duration = 0.5;
    animation.values = @[ @(currentTx), @(currentTx + 10), @(currentTx-8), @(currentTx + 8), @(currentTx -5), @(currentTx + 5), @(currentTx) ];
    animation.keyTimes = @[ @(0), @(0.225), @(0.425), @(0.6), @(0.75), @(0.875), @(1) ];
    animation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    [self.layer addAnimation:animation forKey:@"kAFViewShakerAnimationKey"];
    
    CGFloat keepTime = (CGFloat)msgLb.text.length / 6.;
    [self performSelector:@selector(hide) withObject:nil afterDelay:keepTime];
}

-(void)setMessage:(NSString *)message
{
    _message = message;
    
    if (![message isKindOfClass:[NSString class]]) {
        return;
    }
    
    msgLb.text = message;
    if (message.length) {
        CGRect rect = [message boundingRectWithSize:CGSizeMake(160, 100) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont boldSystemFontOfSize:16]} context:nil];
        CGFloat width = rect.size.width < 120 ? 120 : rect.size.width > 160 ? 160 : rect.size.width;
        self.frame = CGRectMake(0, 0, width + 20, rect.size.height + 24);
        self.center = CGPointMake(screenWidth/2, screenHeight/2);
        msgLb.frame = CGRectMake(10, 0, self.width-20, self.height);
    }
}

-(void)hide
{
    [UIView beginAnimations:@"kHideAnimationKey" context:nil];
    [UIView setAnimationDuration:1.0f];
    self.alpha = 0.0f;
    [UIView commitAnimations];
}

@end
