//
//  PHMGotoAppStore.m
//  PHMAppHelpers
//
//  Created by PHM on 9/6/16.
//  Copyright © 2016 PHM. All rights reserved.
//

#import "PHMGotoAppStore.h"

@implementation PHMGotoAppStore
#pragma mark 获取网络当前时间
+ (NSDate *)getNetworkBaiduDate {
    NSString *urlString = @"https://www.baidu.com";
    urlString = [urlString stringByAddingPercentEscapesUsingEncoding: NSUTF8StringEncoding];
    
    //初始化URLRequest
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
    [request setURL:[NSURL URLWithString: urlString]];
    [request setCachePolicy:NSURLRequestReloadIgnoringCacheData];
    [request setTimeoutInterval:2];
    [request setHTTPShouldHandleCookies:FALSE];
    [request setHTTPMethod:@"GET"];
    
    //设置URLResponse
    NSHTTPURLResponse *response;
    [NSURLConnection sendSynchronousRequest:request
                          returningResponse:&response error:nil];
    // 处理返回的数据
    NSString *date = [[response allHeaderFields] objectForKey:@"Date"];
    date = [date substringFromIndex:5];
    date = [date substringToIndex:[date length]-4];
    
    NSDateFormatter *dateFormatter=[[NSDateFormatter alloc] init];
    dateFormatter.locale = [NSLocale localeWithLocaleIdentifier:@"en_US"];
    NSTimeZone *timeZone = [NSTimeZone timeZoneWithName:@"UTC"];
    [dateFormatter setTimeZone:timeZone];
    [dateFormatter setDateFormat:@"dd MMM yyyy HH:mm:ss"];
    NSDate *netDate=[dateFormatter dateFromString:date];
    
    return netDate;
}

#pragma mark - 外部可用方法
#pragma mark - 评论APP 跳转到APP Store
-(void)gotoAppStoreComment{
    NSDictionary *infoDictionary = [[NSBundle mainBundle] infoDictionary];
    int appVersion = [infoDictionary[@"CFBundleShortVersionString"] intValue];
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    //用户上次操作时的APP版本号
    int udAppVersion = [[userDefaults objectForKey:@"PHMUserCommentAppVersion"] intValue];
    //用户上次操作时的时间戳
    int udTimestamp = [[userDefaults objectForKey:@"PHMUserCommentTimestamp"] intValue];
    //用户上次操作时的选项
    int udChoose = [[userDefaults objectForKey:@"PHMUserCommentChoose"] intValue];
    [self gotoAppStore];
    //有评论过并更新大版本APP 重新进入APP 评论区
    if ([userDefaults objectForKey:@"PHMUserCommentAppVersion"] && appVersion > udAppVersion) {
        [userDefaults removeObjectForKey:@"PHMUserCommentAppVersion"];
        [userDefaults removeObjectForKey:@"PHMUserCommentTimestamp"];
        [userDefaults removeObjectForKey:@"PHMUserCommentChoose"];
        [self gotoAppStore];
    }else{
        //第一次进入或没选择
        if(![userDefaults objectForKey:@"PHMUserCommentChoose"]){
            [self gotoAppStore];
        }else{
            NSDate* nowDate = [PHMGotoAppStore getNetworkBaiduDate];
            //能获取到网络时间
            if (nowDate) {
                NSTimeInterval nowInterval = [nowDate timeIntervalSince1970];
                //获取时间差
                NSTimeInterval timeDifferenceInterval=nowInterval - udTimestamp;
                switch (udChoose) {
                    case PHMGotoAppStoreCommentChooseTypeAccept:
                        //用户选择接受且过90天 再次提示
                        if ((uint)timeDifferenceInterval/86400>90) {
                            [self gotoAppStore];
                        }
                        break;
                    case PHMGotoAppStoreCommentChooseTypeReject:
                        //用户选择拒绝且过7天 再次提示
                        if ((uint)timeDifferenceInterval/86400>7) {
                            [self gotoAppStore];
                        }
                        break;
                    default:
                        if ((uint)timeDifferenceInterval/86400>3) {
                            [self gotoAppStore];
                        }
                        break;
                }
            }
        }
    }
}

#pragma mark 更新APP 跳转到APP Store
- (void)gotoAppStoreUpdateApp:(NSString *)newAppVersion{
    NSDictionary *infoDictionary = [[NSBundle mainBundle] infoDictionary];
    //APP 版本好不同
    if (![infoDictionary[@"CFBundleShortVersionString"] isEqualToString:newAppVersion]) {
        //用户上次操作时的时间戳
        NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
        int udTimestamp = [[userDefaults objectForKey:@"PHMUpdateAppTimestamp"] intValue];
        
        NSDate* nowDate = [PHMGotoAppStore getNetworkBaiduDate];
        //能获取到网络时间
        if (nowDate) {
            NSTimeInterval nowInterval = [nowDate timeIntervalSince1970];
            //获取时间差
            NSTimeInterval timeDifferenceInterval = nowInterval - udTimestamp;
            //没有更新到最新APP且跳出提示大于1天
            if ((uint)timeDifferenceInterval/86400 > 1) {
                if (![infoDictionary[@"CFBundleShortVersionString"] isEqualToString:newAppVersion]) {
                    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"发现新版本" message:nil delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"更新",nil];
                    alertView.tag = 1001;
                    [alertView show];
                }
            }
        }
    }
}

#pragma mark - 内部方法
#pragma mark - 评论跳转
- (void)gotoAppStore{
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"" message:@"APP评论" delegate:self cancelButtonTitle:@"拒绝" otherButtonTitles:@"好评", @"让我静静",nil];
    alertView.tag = 1001;
    [alertView show];
}


#pragma mark - Delegate
#pragma mark - UIAlertViewDelegate
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    if (alertView.tag == 1001) { //评论
        //存储当前APP版本号
        NSDictionary *infoDictionary = [[NSBundle mainBundle] infoDictionary];
        int appVersion = [infoDictionary[@"CFBundleShortVersionString"] intValue];
        [userDefaults setObject:[NSString stringWithFormat:@"%d",appVersion] forKey:@"PHMUserCommentAppVersion"];
        
        //存储操作时的时间戳
        NSDate* nowDate = [PHMGotoAppStore getNetworkBaiduDate];
        NSTimeInterval nowInterval = [nowDate timeIntervalSince1970];
        [userDefaults setObject:[NSString stringWithFormat:@"%f",nowInterval] forKey:@"PHMUserCommentTimestamp"];

        switch (buttonIndex) {
            case 0:
                 //存储操作选项
                [userDefaults setObject:[NSString stringWithFormat:@"%ld",(long)PHMGotoAppStoreCommentChooseTypeReject] forKey:@"PHMUserCommentChoose"];
                break;
            case 1:
            {
                 //存储操作选项
                [userDefaults setObject:[NSString stringWithFormat:@"%ld",(long)PHMGotoAppStoreCommentChooseTypeAccept] forKey:@"PHMUserCommentChoose"];
                //跳转App Store
                NSString *str = [NSString stringWithFormat:
                                 @"https://itunes.apple.com/cn/app/id%@?mt=8",
                                 self.appID ];
                [[UIApplication sharedApplication] openURL:[NSURL URLWithString:str]];
            }
                break;
                
            default:
                 //存储操作选项
                [userDefaults setObject:[NSString stringWithFormat:@"%ld",(long)PHMGotoAppStoreCommentChooseTypeReject] forKey:@"PHMUserCommentChoose"];
                break;
        }
    }else if(alertView.tag == 1000){//APP 更新
        //存储操作时的时间戳
        NSDate* nowDate = [PHMGotoAppStore getNetworkBaiduDate];
        NSTimeInterval nowInterval = [nowDate timeIntervalSince1970];
        [userDefaults setObject:[NSString stringWithFormat:@"%f",nowInterval] forKey:@"PHMUpdateAppTimestamp"];
        switch (buttonIndex) {
            case 0:
                
                break;
            case 1: {
                NSString *str = [NSString stringWithFormat:
                                 @"https://itunes.apple.com/cn/app/id%@?mt=8",
                                 self.appID ];
                [[UIApplication sharedApplication] openURL:[NSURL URLWithString:str]];
            }
                break;
                
            default:
                break;
        }
        
    }
}

@end
