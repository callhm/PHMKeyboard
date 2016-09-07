//
//  MainViewController.m
//  RactiveCocoaTest
//
//  Created by PHM on 8/31/16.
//  Copyright © 2016 PHM. All rights reserved.
//

#import "MainViewController.h"
#import "MainView.h"
@interface MainViewController ()
@property (nonatomic, strong) MainView *mainView;
@end

@implementation MainViewController

- (MainView *)mainView {
    if (!_mainView) {
        MainView *mainView = [[MainView alloc] init];
        _mainView = mainView;
    }
    return _mainView;
}

#pragma mark - UIViewController Plifecycle
- (void)loadView {
    NSLog(@"1");
   self.view = self.mainView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    NSLog(@"2");
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    NSLog(@"3");

}

- (void)viewWillLayoutSubviews {
    [super viewWillLayoutSubviews];
    NSLog(@"4");

}

- (void)viewDidLayoutSubviews {
    [super viewDidLayoutSubviews];
    NSLog(@"6");

}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    NSLog(@"7");

}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    NSLog(@"8");

}

- (void)viewDidDisappear:(BOOL)animated {
    [super viewDidDisappear:animated];
    NSLog(@"9");

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    NSLog(@"10");

}

-(void)dealloc{
    NSLog(@"11");

}

- (void)updateViewConstraints {
    [super updateViewConstraints];
    NSLog(@"5");
    
}
@end
