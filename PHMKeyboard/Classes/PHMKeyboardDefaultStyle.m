//
//  PHMKeyboardDefaultStyle.m
//  Pods
//
//  Created by PHM on 26/12/2016.
//  Copyright © 2016 PHM. All rights reserved.
//

#import "PHMKeyboardDefaultStyle.h"
static UIColor *PHMKS_UIColorFromRGB(rgbValue) {
    return [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0
                           green:((float)((rgbValue & 0xFF00) >> 8))/255.0
                            blue:((float)(rgbValue & 0xFF))/255.0
                           alpha:1.0];
};

@implementation PHMKeyboardDefaultStyle
#pragma mark - Pad Style
+(CGKeyboardStyle)keyboardStyle {
    return CGKeyboardStyleMake(4, 4);
}

/*
 按照keyboardStyle 行列数进行排列 数组为keyboardStyle类型的二维数组  
 每个元素都有x,y  例：@"{1,2}" 横向扩展1位 纵向扩展2位
 x代表横向扩展位数 起始位置从数组所在当前位置开始 范围（0～keyboardStyle中X最大值）
 y代表竖向扩展位数 起始位置从数组所在当前位置开始  范围（0～keyboardStyle中Y最大值）
 */
+ (NSArray *)keyboardButtonPosition {
    return @[
             @[@"{1,1}",@"{1,1}",@"{1,1}",@"{1,1}"],
             @[@"{1,1}",@"{1,1}",@"{1,1}",@"{1,3}"],
             @[@"{1,1}",@"{1,1}",@"{1,1}",@"{1,0}"],
             @[@"{2,1}",@"{0,1}",@"{1,1}",@"{1,0}"],
             ];
}

+ (CGFloat)separator {
    return [UIScreen mainScreen].scale == 2.f ? 0.5f : 1.f;
}

+ (UIColor *)keyboardBGColor {
    return PHMKS_UIColorFromRGB(0xE2E2E2);
}
/*
 从左上方开始向右排列 到横向最大值自动换行
 */
+ (NSArray *)keyboardButtonTitle{
    return @[@"7",@"8",@"9",@"+",@"4",@"5",@"6",@"确定",@"1",@"2",@"3",@"0",@"."];
}

#pragma mark - Button Style
+ (UIFont *)keyboardButtonFont{
    return [UIFont systemFontOfSize:30];
}

+ (UIColor *)keyboardButtonTextColor{
    return PHMKS_UIColorFromRGB(0x666666);
}

+ (UIColor *)keyboardButtonBackgroundColor{
    return PHMKS_UIColorFromRGB(0xFFFFFF);
}

+ (UIColor *)keyboardButtonHighlightedColor{
    return PHMKS_UIColorFromRGB(0xF2F2F2);
}

@end
