//
//  PHMAssetsSelectMenu.h
//  PHMAssetsManager
//
//  Created by PHM on 9/7/16.
//  Copyright © 2016 PHM. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "PHMAssetsSelectMenuDelegate.h"

typedef NS_ENUM(NSInteger, PHMAssetsMenuType) {
    PHMAssetsMenuTypeSelectLocalCamera,
    PHMAssetsMenuTypeSelectLocalImage,
    PHMAssetsMenuTypeSelectLocalCameraAndImage,
    PHMAssetsMenuTypeMultiSelectLocalImage,
};


@interface PHMAssetsSelectMenu : NSObject <UIActionSheetDelegate>
@property (nonatomic, weak) UIViewController *rootViewController;  //根控制器
@property (nonatomic, assign) PHMAssetsMenuType menuType;
@property (nonatomic, strong) NSString *selectLocalImageTitle;     //图片选择器表述title
@property (nonatomic, weak) id<PHMAssetsSelectMenuDelegate> delegate;


/**
 * @brief 显示
 */
- (void)show:(id<PHMAssetsSelectMenuDelegate>)delegates;
@end
