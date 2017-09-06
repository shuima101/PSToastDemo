//
//  ViewController.m
//  PSToastDemo
//
//  Created by Passing on 2017/8/6.
//  Copyright © 2017年 Passing. All rights reserved.
//

#import "ViewController.h"
#import "PSToast.h"

@interface ViewController ()

- (IBAction)toastButtonAction:(UIButton *)sender;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [PSToast showMessage:@"Toast"];
    });
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (IBAction)toastButtonAction:(UIButton *)sender {
    [PSToast showMessage:@"Toast"];
}

@end
