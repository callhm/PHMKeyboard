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
- (UILabel *)textLB
{
    if (!_textLB) {
        UILabel *textLB = [[UILabel alloc] init];
        textLB.frame = CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 60);
        textLB.textAlignment = NSTextAlignmentCenter;
        textLB.font = [UIFont systemFontOfSize:26];
        _textLB = textLB;
    }
    return _textLB;
}


- (void)viewDidLoad {
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    [self.view addSubview:self.textLB];
    
    PHMKeyboardView *keyboard = [PHMKeyboardView keyboardWithDelegate:self];
    [self.view addSubview:keyboard];
    keyboard.frame = CGRectMake(0, 60, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height/2);

    //自定义Style
    PHMKeyboardView *keyboardT = [PHMKeyboardView keyboardWithDelegate:self styleClass:[PHMCustomStyle class]] ;
    [self.view addSubview:keyboardT];
    keyboardT.frame = CGRectMake(0, [UIScreen mainScreen].bounds.size.height/2+60, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height/2-60);
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
    _textLB.text = text;
}
@end
