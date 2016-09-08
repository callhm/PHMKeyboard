//
//  PHMAssetsSelectMenu.m
//  PHMAssetsManager
//
//  Created by PHM on 9/7/16.
//  Copyright © 2016 PHM. All rights reserved.
//

#import "PHMAssetsSelectMenu.h"
#import "PHMAssetsSelectImagePicker.h"

@interface PHMAssetsSelectMenu ()
@property (nonatomic, strong) PHMAssetsSelectImagePicker *assetsSelectImagePicker;
@end

@implementation PHMAssetsSelectMenu
#pragma mark - Getter and Setter
#pragma mark -
- (PHMAssetsSelectImagePicker *)assetsSelectImagePicker
{
    if (!_assetsSelectImagePicker) {
        PHMAssetsSelectImagePicker *assetsSelectImagePicker = [[PHMAssetsSelectImagePicker alloc] init];
        _assetsSelectImagePicker = assetsSelectImagePicker;
    }
    return _assetsSelectImagePicker;
}

#pragma mark 显示
- (void)show:(id<PHMAssetsSelectMenuDelegate>)delegate {
    self.delegate = delegate;
    switch (_menuType) {
        case PHMAssetsMenuTypeSelectLocalCamera:
            [self selectLocalImageWithSourceType:UIImagePickerControllerSourceTypeCamera];
            break;
        case PHMAssetsMenuTypeSelectLocalImage:
            [self selectLocalImageWithSourceType:UIImagePickerControllerSourceTypePhotoLibrary];
            break;
        case PHMAssetsMenuTypeSelectLocalCameraAndImage:
        {
            UIActionSheet *sheet = [[UIActionSheet alloc] initWithTitle:self.selectLocalImageTitle?self.selectLocalImageTitle:@"选取图片"
                                                               delegate:self
                                                      cancelButtonTitle:@"取消"
                                                 destructiveButtonTitle:nil
                                                      otherButtonTitles:@"拍照", @"从相册选取", nil];
            
            UIWindow *currentWindow = nil;
            NSEnumerator *frontToBackWindows = [[[UIApplication sharedApplication] windows] reverseObjectEnumerator];
            for (UIWindow *window in frontToBackWindows) {
                if (window.windowLevel == UIWindowLevelNormal) {
                    currentWindow = window;
                    break;
                }
            }
            [sheet showInView:currentWindow];
        }
            break;
        case PHMAssetsMenuTypeMultiSelectLocalImage:
        {
            UIActionSheet *sheet = [[UIActionSheet alloc] initWithTitle:self.selectLocalImageTitle?self.selectLocalImageTitle:@"选取图片"
                                                               delegate:self
                                                      cancelButtonTitle:@"取消"
                                                 destructiveButtonTitle:nil
                                                      otherButtonTitles:@"拍照", @"从相册选取", nil];
            
            UIWindow *currentWindow = nil;
            NSEnumerator *frontToBackWindows = [[[UIApplication sharedApplication] windows] reverseObjectEnumerator];
            for (UIWindow *window in frontToBackWindows) {
                if (window.windowLevel == UIWindowLevelNormal) {
                    currentWindow = window;
                    break;
                }
            }
            [sheet showInView:currentWindow];
        }
            break;
            
        default:
            break;
    }
}

- (void)selectLocalImageWithSourceType:(UIImagePickerControllerSourceType)sourceType {
    [self.assetsSelectImagePicker showImagePickerControllerSourceType:sourceType onViewController:_rootViewController compled:^(UIImage *image, UIImage *thumbnailImage, NSString *url) {
        if (image) {
            if ([_delegate respondsToSelector:@selector(didSendPhoto:thumbnailImage:filePath:)]) {
                [_delegate didSendPhoto:image thumbnailImage:thumbnailImage filePath:url];
            }
        }
    }];
}

#pragma mark - Delegate
#pragma mark - UIActionSheetDelegate
- (void)actionSheet:(UIActionSheet *)actionSheet willDismissWithButtonIndex:(NSInteger)buttonIndex
{
    switch (_menuType) {
        case PHMAssetsMenuTypeSelectLocalCameraAndImage:
            switch (buttonIndex) {
                case 0: {
                    [self selectLocalImageWithSourceType:UIImagePickerControllerSourceTypeCamera];
                    break;
                }
                case 1: {
                    [self selectLocalImageWithSourceType:UIImagePickerControllerSourceTypePhotoLibrary];
                    break;
                }
            }
            break;
        case PHMAssetsMenuTypeMultiSelectLocalImage:
            switch (buttonIndex) {
                case 0: {
                    [self selectLocalImageWithSourceType:UIImagePickerControllerSourceTypeCamera];
                    break;
                }
                case 1: {
//                    UzysAssetsPickerController *assetsPickerController = [[UzysAssetsPickerController alloc] init];
//                    assetsPickerController.mulSelectionStyle = AssetsPickerMulSelectionMerchantStyle;
//                    assetsPickerController.delegate = (id<UzysAssetsPickerControllerDelegate>)self;
//                    
//                    assetsPickerController.maximumNumberOfSelectionMedia = 15;
//                    assetsPickerController.showCameraCell = NO;
//                    assetsPickerController.canPreview = YES;
//                    assetsPickerController.automaticallyAdjustsScrollViewInsets = NO;
//                    assetsPickerController.assetsFilter = [ALAssetsFilter allPhotos];
//                    
//                    UINavigationController *rootNav = [[UINavigationController alloc] initWithRootViewController:assetsPickerController];
//                    [_rootViewController presentViewController:rootNav animated:YES completion:nil];
//                    
                    break;
                }
            }
            break;
            
        default:
            break;
    }
    
    actionSheet = nil;
}
@end
