//
//  PHMGotoAppStore.h
//  PHMAppHelpers
//
//  Created by PHM on 9/6/16.
//  Copyright © 2016 PHM. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
typedef NS_ENUM(NSInteger, PHMGotoAppStoreCommentChooseType) {
    PHMGotoAppStoreCommentChooseTypeAccept, //接受评论
    PHMGotoAppStoreCommentChooseTypeReject, //拒绝评论
};

@interface PHMGotoAppStore : NSObject<UIAlertViewDelegate>
@property (nonatomic, strong) NSString *appID;

/**
 * @brief 调转到App Store 评论
 *
 * @param type ： 类型
 */
- (void)gotoAppStoreComment;

/**
 * @brief 调转到App Store 更新
 *
 * @param type ： 类型
 */
- (void)gotoAppStoreUpdateApp:(NSString *)newAppVersion;

/**
 * @brief 获取网络时间 (获取网址为baidu)
 */
+ (NSDate *)getNetworkBaiduDate;
@end
