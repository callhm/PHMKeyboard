//
//  PHMKeyboardButton.m
//  Pods
//
//  Created by PHM on 26/12/2016.
//  Copyright © 2016 PHM. All rights reserved.
//

#import "PHMKeyboardButton.h"
@implementation UIImage (PHMKeyboardButton)

+(UIImage *)creatImageWithColor:(UIColor *)color{
    CGRect rect = CGRectMake(0, 0, 1, 1);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef ref = UIGraphicsGetCurrentContext();
    
    CGContextSetFillColorWithColor(ref, [color CGColor]);
    CGContextFillRect(ref, rect);
    
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;
}
@end

@implementation PHMKeyboardButton
+ (instancetype)buttonWithNormalBGColor:(UIColor *)normalColor highlightedBGColor:(UIColor *)highlightedColor
{
    return [[self alloc] initWithNormalBGColor:normalColor highlightedBGColor:highlightedColor];
}

- (instancetype)initWithNormalBGColor:(UIColor *)normalColor highlightedBGColor:(UIColor *)highlightedColor;
{
    self = [super initWithFrame:CGRectZero];
    if (self) {
        [self setBackgroundImage:[UIImage creatImageWithColor:normalColor] forState:UIControlStateNormal];
        [self setBackgroundImage:[UIImage creatImageWithColor:highlightedColor] forState:UIControlStateHighlighted];
    }
    return self;
}

@end
