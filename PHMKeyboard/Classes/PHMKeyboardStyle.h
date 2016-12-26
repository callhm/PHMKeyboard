//
//  PHMKeyboardStyle.h
//  Pods
//
//  Created by PHM on 26/12/2016.
//  Copyright © 2016 PHM. All rights reserved.
//

#import <Foundation/Foundation.h>

struct CGKeyboardStyle {
    NSInteger horizontal;   //横向个数
    NSInteger vertical;     //竖向个数
};
typedef struct CGKeyboardStyle CGKeyboardStyle;

CG_INLINE CGKeyboardStyle
CGKeyboardStyleMake(NSInteger horizontal, NSInteger vertical)
{
    CGKeyboardStyle style;
    style.horizontal = horizontal;
    style.vertical = vertical;
    return style;
}

@protocol PHMKeyboardStyle <NSObject>
+ (CGKeyboardStyle)keyboardStyle; //设置自定义键盘 横向及列向个数
+ (NSArray *)keyboardButtonPosition; //设置自定义Pad每个Button的位置 
+ (CGFloat)separator;//分割线宽度
+ (UIColor *)keyboardBGColor;//分割线宽度
+ (NSArray *)keyboardButtonTitle;//顺序排列Pad上的Button

//Buttons
+ (UIFont *)keyboardButtonFont; //设置Button上的文字大小
+ (UIColor *)keyboardButtonTextColor; //设置Button上的文字颜色
+ (UIColor *)keyboardButtonBackgroundColor; //设置Button上默认背景色
+ (UIColor *)keyboardButtonHighlightedColor; //设置Button上高亮杯景色
@end
