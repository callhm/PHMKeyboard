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
@property (nonatomic, assign) PHMAssetsMenuType menuType;
@property (nonatomic, strong) NSString *selectLocalImageTitle;     //图片选择器表述title
@property (nonatomic, weak) id<PHMAssetsSelectMenuDelegate> delegate;


/**
 * @brief 显示选取资源选项栏
 */
- (void)showWithMenuType:(PHMAssetsMenuType)menuType  delegate:(id<PHMAssetsSelectMenuDelegate>)delegate;
@end
