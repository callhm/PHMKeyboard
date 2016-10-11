//
//  PHMCustomPadDefaultView.h
//  PHMCustomPad
//
//  Created by PHM on 9/12/16.
//  Copyright © 2016 PHM. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol PHMCustomPadDefaultViewDelegate;
@interface PHMCustomPadDefaultView : UIView
@property (nonatomic, weak) id<PHMCustomPadDefaultViewDelegate> delegate;

@property (nonatomic, strong) NSArray *buttons;
+ (instancetype)customPadWithDelegate:(id<PHMCustomPadDefaultViewDelegate>)delegate;
+ (instancetype)customPadWithDelegate:(id<PHMCustomPadDefaultViewDelegate>)delegate StyleClass:(Class)styleClass;

@end


@protocol PHMCustomPadDefaultViewDelegate <NSObject>
@optional
- (void)customPad:(PHMCustomPadDefaultView *)customPadDefaultView
     buttonAction:(UIButton *)button
             text:(NSString *)text;

@end