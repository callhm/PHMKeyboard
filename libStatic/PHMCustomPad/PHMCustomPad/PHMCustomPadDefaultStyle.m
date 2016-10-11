//
//  PHMCustomPadDefaultStyle.m
//  PHMCustomPad
//
//  Created by PHM on 9/12/16.
//  Copyright © 2016 PHM. All rights reserved.
//

#import "PHMCustomPadDefaultStyle.h"
#import "PHMCustomPadStyle.h"
static inline UIColor *CPDS_UIColorFromRGB(rgbValue) {
    return [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0
                           green:((float)((rgbValue & 0xFF00) >> 8))/255.0
                            blue:((float)(rgbValue & 0xFF))/255.0
                           alpha:1.0];
};

@implementation PHMCustomPadDefaultStyle
#pragma mark - Pad Style
+(CGPadStyle)customPadStyle {
    return CGPadStyleMake(4, 4);
}

//按照customPadStyle 行列数进行排列
+ (NSArray *)customPadButtonPosition {
    return @[
             @[@"{1,1}",@"{1,1}",@"{1,1}",@"{1,1}"],
             @[@"{1,1}",@"{1,1}",@"{1,1}",@"{1,3}"],
             @[@"{1,1}",@"{1,1}",@"{1,1}",@"{1,0}"],
             @[@"{2,1}",@"{0,1}",@"{1,1}",@"{1,0}"],
             ];
}

+(CGRect)customPadStyleRect {
    return CGRectMake(0.f, 0.f, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.width);
}

+ (CGFloat)separator {
    return [UIScreen mainScreen].scale == 2.f ? 0.5f : 1.f;
}

+ (UIColor *)customPadBGColor {
    return CPDS_UIColorFromRGB(0x0000FF);
}

+ (NSArray *)customPadButtonTitle{
    return @[@"7",@"8",@"9",@"+",@"4",@"5",@"6",@"收款",@"1",@"2",@"3",@"0",@"."];
}

#pragma mark - Button Style
+ (UIFont *)customPadButtonFont{
    return [UIFont systemFontOfSize:28];
}

+ (UIColor *)customPadButtonTextColor{
    return [UIColor blackColor];
}

+ (UIColor *)customPadButtonBackgroundColor{
    return CPDS_UIColorFromRGB(0xFF0000);
}

+ (UIColor *)customPadButtonHighlightedColor{
    return CPDS_UIColorFromRGB(0xFFFF00);
}


@end
