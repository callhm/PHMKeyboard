//
//  PHMCustomPadStyle.h
//  PHMCustomPad
//
//  Created by PHM on 9/12/16.
//  Copyright © 2016 PHM. All rights reserved.
//

#import <Foundation/Foundation.h>
/* CGStyle. */
struct CGPadStyle {
    NSInteger horizontal;   //横向个数
    NSInteger vertical;     //竖向个数
};
typedef struct CGPadStyle CGPadStyle;

CG_INLINE CGPadStyle
CGPadStyleMake(NSInteger horizontal, NSInteger vertical)
{
    CGPadStyle s;
    s.horizontal = horizontal;
    s.vertical = vertical;
    return s;
}

@protocol PHMCustomPadStyle <NSObject>
+ (CGRect)customPadStyleRect;
+ (NSArray *)customPadButtonPosition;
+ (CGPadStyle)customPadStyle;
+ (CGFloat)separator;
+ (UIColor *)customPadBGColor;
+ (NSArray *)customPadButtonTitle;

//buttons
+ (UIFont *)customPadButtonFont;
+ (UIColor *)customPadButtonTextColor;
+ (UIColor *)customPadButtonBackgroundColor;
+ (UIColor *)customPadButtonHighlightedColor;
@end