//
//  PHMCustomPadButton.h
//  PHMCustomPad
//
//  Created by PHM on 9/12/16.
//  Copyright © 2016 PHM. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PHMCustomPadButton : UIButton
+ (instancetype)buttonWithNormalBGColor:(UIColor *)normalColor highlightedBGColor:(UIColor *)highlightedColor;
- (instancetype)initWithNormalBGColor:(UIColor *)normalColor highlightedBGColor:(UIColor *)highlightedColor;

@end
