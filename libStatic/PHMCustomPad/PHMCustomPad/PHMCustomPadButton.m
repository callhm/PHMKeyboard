//
//  PHMCustomPadButton.m
//  PHMCustomPad
//
//  Created by PHM on 9/12/16.
//  Copyright © 2016 PHM. All rights reserved.
//

#import "PHMCustomPadButton.h"

@implementation UIImage (PHMCustomPadButton)

+(UIImage *)phm_imageWithColor:(UIColor *)color{
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

@implementation PHMCustomPadButton
+ (instancetype)buttonWithNormalBGColor:(UIColor *)normalColor highlightedBGColor:(UIColor *)highlightedColor
{
    return [[self alloc] initWithNormalBGColor:normalColor highlightedBGColor:highlightedColor];

}

- (instancetype)initWithNormalBGColor:(UIColor *)normalColor highlightedBGColor:(UIColor *)highlightedColor;
{
    self = [super initWithFrame:CGRectZero];
    if (self) {
        [self setBackgroundImage:[UIImage phm_imageWithColor:normalColor] forState:UIControlStateNormal];
        [self setBackgroundImage:[UIImage phm_imageWithColor:highlightedColor] forState:UIControlStateHighlighted];
    }
    return self;
}

#pragma mark - UIResponder
- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    [super touchesBegan:touches withEvent:event];
    [self.nextResponder touchesBegan:touches withEvent:event];
}

- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event {
    [super touchesMoved:touches withEvent:event];
    [self.nextResponder touchesMoved:touches withEvent:event];
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event {
    [super touchesEnded:touches withEvent:event];
    [self.nextResponder touchesEnded:touches withEvent:event];
}

- (void)touchesCancelled:(NSSet *)touches withEvent:(UIEvent *)event {
    [super touchesCancelled:touches withEvent:event];
    [self.nextResponder touchesCancelled:touches withEvent:event];
}

@end
