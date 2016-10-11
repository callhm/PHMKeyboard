//
//  ViewController.m
//  JavaScriptCoreTest
//
//  Created by PHM on 9/8/16.
//  Copyright © 2016 PHM. All rights reserved.
//

#import "ViewController.h"
#import <JavaScriptCore/JavaScriptCore.h>
@interface ViewController ()
@property (nonatomic, strong) JSContext *jsContext;
@end

@implementation ViewController
#pragma mark - Getter and Setter
#pragma mark -
- (JSContext *)jsContext
{
    if (!_jsContext) {
        JSContext *jsContext = [[JSContext alloc] init];
        jsContext.name = @"JSContextTest";
        
        
        
        
        _jsContext = jsContext;
    }
    return _jsContext;
}
#pragma mark - Override
#pragma mark -

#pragma mark - UIViewController Plifecycle
#pragma mark -
- (void)viewDidLoad {
    [super viewDidLoad];
    
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
}

#pragma mark - Init View
#pragma mark -

#pragma mark - Request and Sent Data
#pragma mark -

#pragma mark - Event Processing
#pragma mark - Notification Event Processing

#pragma mark - User Operation Event Processing

#pragma mark - Common Event Processing
#pragma mark 加载JS
-(void)loadJS:(NSString *)fileName {
    NSBundle *bundle = [NSBundle mainBundle];
    NSString *filePath = [bundle pathForResource:fileName ofType:@"js"];
    NSString *js = [NSString stringWithContentsOfFile:filePath encoding:NSUTF8StringEncoding error:nil];
    [
}


#pragma mark - Delegate and DataSource
#pragma mark -

#pragma mark - ***备用方法 暂时弃用***
#pragma mark -

@end
