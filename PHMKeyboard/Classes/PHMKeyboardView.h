//
//  PHMKeyboardView.h
//  Pods
//
//  Created by PHM on 26/12/2016.
//  Copyright © 2016 PHM. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol PHMKeyboardViewDelegate;
@interface PHMKeyboardView : UIView
@property (nonatomic, weak) id<PHMKeyboardViewDelegate> delegate;
@property (nonatomic, strong) NSArray *buttons;

/**
 * @brief 创建默认UI键盘
 *
 * @param delegate
 *
 * @return instance
 */
+ (instancetype)keyboardWithDelegate:(id<PHMKeyboardViewDelegate>)delegate;

/**
 * @brief 创建自定义UI自定义键盘
 *
 * @param delegate
 * @param styleClass ： 自定义UI类
 *
 * @return instance
 */
+ (instancetype)keyboardWithDelegate:(id<PHMKeyboardViewDelegate>)delegate styleClass:(Class)styleClass;

@end

@protocol PHMKeyboardViewDelegate <NSObject>
@optional
/**
 * @brief 键盘响应Button及内容
 *
 * @param button ：响应Button
 * @param text ： 返回Text
 */
- (void)keyboardView:(PHMKeyboardView *)view
              button:(UIButton *)button
                text:(NSString *)text;

@end
