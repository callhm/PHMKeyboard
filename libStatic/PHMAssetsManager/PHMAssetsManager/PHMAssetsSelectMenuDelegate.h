//
//  PHMAssetsSelectMenuDelegate.h
//  PHMAssetsManager
//
//  Created by PHM on 9/7/16.
//  Copyright © 2016 PHM. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
@protocol PHMAssetsSelectMenuDelegate <NSObject>
@optional
/**
 * @brief 发送图片
 *
 * @param photo : image
 */
- (void)didSendPhoto:(UIImage *)photo thumbnailImage:(UIImage *)thumbnailImage filePath:(NSString *)filePath;

@end
