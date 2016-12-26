//
//  PHMViewController.m
//  PHMKeyboard
//
//  Created by PHM on 12/26/2016.
//  Copyright (c) 2016 PHM. All rights reserved.
//

#import "PHMViewController.h"
#import "PHMKeyboard.h"
#import "PHMCustomStyle.h"
@interface PHMViewController ()<PHMKeyboardViewDelegate>
@property (nonatomic, strong) UILabel *textLB;
@end

@implementation PHMViewController

- (void)viewDidLoad {
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    PHMKeyboardView *keyboard = [PHMKeyboardView keyboardWithDelegate:self];
    [self.view addSubview:keyboard];
    keyboard.frame = CGRectMake(0, 40, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height/2-40);

    //自定义Style
    PHMKeyboardView *keyboardT = [PHMKeyboardView keyboardWithDelegate:self styleClass:[PHMCustomStyle class]] ;
    [self.view addSubview:keyboardT];
    keyboardT.frame = CGRectMake(0, [UIScreen mainScreen].bounds.size.height/2+40, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height/2-40);

    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark PHMKeyboardViewDelegate
- (void)keyboardView:(PHMKeyboardView *)view
              button:(UIButton *)button
                text:(NSString *)text {
    NSLog(@"%@",text);
}
@end
