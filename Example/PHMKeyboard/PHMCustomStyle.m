

//
//  PHMCustomStyle.m
//  PHMKeyboard
//
//  Created by PHM on 26/12/2016.
//  Copyright © 2016 PHM. All rights reserved.
//

#import "PHMCustomStyle.h"
static UIColor *PHMKS_UIColorFromRGB(rgbValue) {
    return [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0
                           green:((float)((rgbValue & 0xFF00) >> 8))/255.0
                            blue:((float)(rgbValue & 0xFF))/255.0
                           alpha:1.0];
};

@implementation PHMCustomStyle
#pragma mark - Pad Style
+(CGKeyboardStyle)keyboardStyle {
    return CGKeyboardStyleMake(4, 5);
}

//按照keyboardStyle 行列数进行排列
+ (NSArray *)keyboardButtonPosition {
    return @[
             @[@"{1,1}",@"{1,3}",@"{1,1}",@"{2,1}",@"{0,1}"],
             @[@"{1,1}",@"{1,0}",@"{2,1}",@"{0,1}",@"{1,1}"],
             @[@"{1,1}",@"{1,0}",@"{1,1}",@"{1,2}",@"{1,1}"],
             @[@"{3,1}",@"{0,1}",@"{0,1}",@"{2,0}",@"{1,1}"],
             ];
}

+ (CGFloat)separator {
    return [UIScreen mainScreen].scale == 2.f ? 0.5f : 1.f;
}

+ (UIColor *)keyboardBGColor {
    return PHMKS_UIColorFromRGB(0xE2E2E2);
}

+ (NSArray *)keyboardButtonTitle{
    return @[@"1",@"2",@"3",@"-",@"4",@"5",@"6",@"+",@"Q",@"7",@"8",@"9",@"0"];
}

#pragma mark - Button Style
+ (UIFont *)keyboardButtonFont{
    return [UIFont systemFontOfSize:30];
}

+ (UIColor *)keyboardButtonTextColor{
    return PHMKS_UIColorFromRGB(0x666666);
}

+ (UIColor *)keyboardButtonBackgroundColor{
    return PHMKS_UIColorFromRGB(0xFFFF00);
}

+ (UIColor *)keyboardButtonHighlightedColor{
    return PHMKS_UIColorFromRGB(0xF2F2F2);
}


@end
