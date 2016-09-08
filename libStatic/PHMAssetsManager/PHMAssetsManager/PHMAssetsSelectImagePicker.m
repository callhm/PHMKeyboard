//
//  PHMAssetsSelectImagePicker.m
//  PHMAssetsManager
//
//  Created by PHM on 9/7/16.
//  Copyright © 2016 PHM. All rights reserved.
//

#import "PHMAssetsSelectImagePicker.h"
#import <ImageIO/ImageIO.h>
@interface PHMAssetsSelectImagePicker ()<UIImagePickerControllerDelegate, UINavigationControllerDelegate>

@end

@implementation PHMAssetsSelectImagePicker
- (void)dealloc{
    _didFinishTakePhotoCompled = nil;
}

#pragma mark imagePicker 并返回选区图片
- (void)showImagePickerControllerSourceType:(UIImagePickerControllerSourceType)sourceType
                           onViewController:(UIViewController *)viewController
                                    compled:(didFinishTakeImageCompledBlock)compled {
    self.didFinishTakePhotoCompled = compled;

    if (![UIImagePickerController isSourceTypeAvailable:sourceType]) {
        compled(nil,nil,nil);
        return;
    }
    
    UIImagePickerController *imagePickerController = [[UIImagePickerController alloc] init];
    imagePickerController.editing = YES;
    imagePickerController.delegate = self;
    imagePickerController.sourceType = sourceType;
    if (sourceType == UIImagePickerControllerSourceTypePhotoLibrary) {
        imagePickerController.allowsEditing = YES;
    }
    
    //设置NavigationBar
    [imagePickerController.navigationBar setTintColor:[UIColor whiteColor]];
    //[imagePickerController.navigationBar setBackgroundImage:[UIImage imageNamed:@"bg_navigation"] forBarMetrics:UIBarMetricsDefault];
    imagePickerController.navigationController.navigationBar.translucent = NO;
    [[self getWindowRC] presentViewController:imagePickerController animated:YES completion:NULL];
}

#pragma mark 获取Window rootController
- (UIViewController *)getWindowRC {
    UIWindow * window = [[UIApplication sharedApplication] keyWindow];
    if (window.windowLevel != UIWindowLevelNormal)
    {
        NSArray *windows = [[UIApplication sharedApplication] windows];
        for(UIWindow * tmpWin in windows)
        {
            if (tmpWin.windowLevel == UIWindowLevelNormal)
            {
                window = tmpWin;
                break;
            }
        }
    }
    return window.rootViewController;
}

#pragma mark 获取当前屏幕显示的ViewController
- (UIViewController *)getCurrentVC {
    UIWindow * window = [[UIApplication sharedApplication] keyWindow];
    if (window.windowLevel != UIWindowLevelNormal)
    {
        NSArray *windows = [[UIApplication sharedApplication] windows];
        for(UIWindow * tmpWin in windows)
        {
            if (tmpWin.windowLevel == UIWindowLevelNormal)
            {
                window = tmpWin;
                break;
            }
        }
    }
    
    UIViewController *result = nil;
    UIView *frontView = [[window subviews] objectAtIndex:0];
    id nextResponder = [frontView nextResponder];
    if ([nextResponder isKindOfClass:[UIViewController class]])
        result = nextResponder;
    else
        result = window.rootViewController;
    return result;
}

#pragma mark - Delegate and DataSource
#pragma mark - UIActionSheetDelegate
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info {
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        UIImage *saveImage = info[UIImagePickerControllerOriginalImage];
        NSDateFormatter* formatter = [[NSDateFormatter alloc]init];
        [formatter setDateFormat:@"YYYYMMddhhmmss"];
        NSString *date = [formatter stringFromDate:[NSDate date]];
        NSString *filePach = [NSString stringWithFormat:@"%@/tmp/%@.jpg", NSHomeDirectory(), date];
        NSData  *imageData = UIImageJPEGRepresentation(saveImage, 1);
        [imageData writeToFile:filePach atomically:YES];
        dispatch_async(dispatch_get_main_queue(), ^{
            if (_didFinishTakePhotoCompled) {
                if (picker.allowsEditing) {
                    UIImage *image = info[UIImagePickerControllerEditedImage];
                    NSData *data = UIImageJPEGRepresentation(image, 0.5);
                    UIImage *thumbImage = MyCreateThumbnailImageFromData(data, 80);
                    _didFinishTakePhotoCompled(image,thumbImage,filePach);
                }else{
                    UIImage *image = info[UIImagePickerControllerOriginalImage];
                    NSData *data = UIImageJPEGRepresentation(image, 0.5);
                    UIImage *thumbImage = MyCreateThumbnailImageFromData(data, 80);
                    _didFinishTakePhotoCompled(image,thumbImage,filePach);
                }
            }
            [self dismissPickerViewController:picker];
        });
    });
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker {
    [self dismissPickerViewController:picker];
}

- (void)dismissPickerViewController:(UIImagePickerController *)picker {
    [picker dismissViewControllerAnimated:YES completion:^{
        _didFinishTakePhotoCompled = nil;
    }];
}

#pragma mark 获取缩略图
UIImage* MyCreateThumbnailImageFromData (NSData * data, int imageSize){
    CGImageRef        myThumbnailImage = NULL;
    CGImageSourceRef  myImageSource;
    CFDictionaryRef   myOptions = NULL;
    CFStringRef       myKeys[3];
    CFTypeRef         myValues[3];
    CFNumberRef       thumbnailSize;
    
    // Create an image source from NSData; no options.
    myImageSource = CGImageSourceCreateWithData((__bridge CFDataRef)data,
                                                NULL);
    // Make sure the image source exists before continuing.
    if (myImageSource == NULL){
        fprintf(stderr, "Image source is NULL.");
        return  NULL;
    }
    
    // Package the integer as a  CFNumber object. Using CFTypes allows you
    // to more easily create the options dictionary later.
    thumbnailSize = CFNumberCreate(NULL, kCFNumberIntType, &imageSize);
    
    // Set up the thumbnail options.
    myKeys[0] = kCGImageSourceCreateThumbnailWithTransform;
    myValues[0] = (CFTypeRef)kCFBooleanTrue;
    myKeys[1] = kCGImageSourceCreateThumbnailFromImageIfAbsent;
    myValues[1] = (CFTypeRef)kCFBooleanTrue;
    myKeys[2] = kCGImageSourceThumbnailMaxPixelSize;
    myValues[2] = thumbnailSize;
    
    myOptions = CFDictionaryCreate(NULL, (const void **) myKeys,
                                   (const void **) myValues, 2,
                                   &kCFTypeDictionaryKeyCallBacks,
                                   & kCFTypeDictionaryValueCallBacks);
    
    // Create the thumbnail image using the specified options.
    myThumbnailImage = CGImageSourceCreateThumbnailAtIndex(myImageSource,
                                                           0,
                                                           myOptions);
    
    UIImage* scaled = [UIImage imageWithCGImage:myThumbnailImage];
    
    // Release the options dictionary and the image source
    // when you no longer need them.
    
    CFRelease(thumbnailSize);
    CFRelease(myOptions);
    CFRelease(myImageSource);
    CFRelease(myThumbnailImage);
    // Make sure the thumbnail image exists before continuing.
    if (myThumbnailImage == NULL){
        fprintf(stderr, "Thumbnail image not created from image source.");
        return NULL;
    }
    
    return scaled;
}
@end
