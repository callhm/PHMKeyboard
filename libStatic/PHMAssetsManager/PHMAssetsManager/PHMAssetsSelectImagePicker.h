//
//  PHMAssetsSelectImagePicker.h
//  PHMAssetsManager
//
//  Created by PHM on 9/7/16.
//  Copyright © 2016 PHM. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
typedef void(^didFinishTakeImageCompledBlock)(UIImage *image, UIImage *thumbnailImage,NSString *url);

@interface PHMAssetsSelectImagePicker : NSObject
@property (nonatomic, copy) didFinishTakeImageCompledBlock didFinishTakePhotoCompled;
/**
 * @brief imagePicker 并返回选区图片
 *
 * @param sourceType : imagePicker类型
 * @param viewController : presentViewController
 * @param compled : 回调Photo
 */
- (void)showImagePickerControllerSourceType:(UIImagePickerControllerSourceType)sourceType
                           onViewController:(UIViewController *)viewController
                                    compled:(didFinishTakeImageCompledBlock)compled;
@end
