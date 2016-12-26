//
//  PHMKeyboardButton.h
//  Pods
//
//  Created by PHM on 26/12/2016.
//  Copyright © 2016 PHM. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PHMKeyboardButton : UIButton
+ (instancetype)buttonWithNormalBGColor:(UIColor *)normalColor highlightedBGColor:(UIColor *)highlightedColor;
- (instancetype)initWithNormalBGColor:(UIColor *)normalColor highlightedBGColor:(UIColor *)highlightedColor;

@end
