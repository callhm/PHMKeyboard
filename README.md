# PHMKeyboard

[![CI Status](http://img.shields.io/travis/PHM/PHMKeyboard.svg?style=flat)](https://travis-ci.org/PHM/PHMKeyboard)
[![Version](https://img.shields.io/cocoapods/v/PHMKeyboard.svg?style=flat)](http://cocoapods.org/pods/PHMKeyboard)
[![License](https://img.shields.io/cocoapods/l/PHMKeyboard.svg?style=flat)](http://cocoapods.org/pods/PHMKeyboard)
[![Platform](https://img.shields.io/cocoapods/p/PHMKeyboard.svg?style=flat)](http://cocoapods.org/pods/PHMKeyboard)

## Example

To run the example project, clone the repo, and run `pod install` from the Example directory first.

## Where should I create my keyboard
```
@interface PHMViewController ()<PHMKeyboardViewDelegate>

@end

@implementation PHMViewController
- (void)viewDidLoad {
[super viewDidLoad];

PHMKeyboardView *keyboard = [PHMKeyboardView keyboardWithDelegate:self];
[self.view addSubview:keyboard];
keyboard.frame = CGRectMake(0, 40, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height/2-40);

//自定义Style
PHMKeyboardView *keyboardT = [PHMKeyboardView keyboardWithDelegate:self styleClass:[PHMCustomStyle class]] ;
[self.view addSubview:keyboardT];
keyboardT.frame = CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height/2);
}

#pragma mark PHMKeyboardViewDelegate
- (void)keyboardView:(PHMKeyboardView *)view
button:(UIButton *)button
text:(NSString *)text {
NSLog(@"%@",text);
}
@end

## Installation

PHMKeyboard is available through [CocoaPods](http://cocoapods.org). To install
it, simply add the following line to your Podfile:

```ruby
pod "PHMKeyboard"
```

Get busy Masoning
>'#import "PHMKeyboard.h"'

## Author

PHM, 251962881@qq.com

## License

PHMKeyboard is available under the MIT license. See the LICENSE file for more info.
