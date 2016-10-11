
//
//  PHMCustomPadDefaultView.m
//  PHMCustomPad
//
//  Created by PHM on 9/12/16.
//  Copyright © 2016 PHM. All rights reserved.
//

#import "PHMCustomPadDefaultView.h"
#import "PHMCustomPadStyle.h"
#import "PHMCustomPadButton.h"
#import "PHMCustomPadDefaultStyle.h"
@interface PHMCustomPadDefaultView ()
@property (nonatomic, strong) Class<PHMCustomPadStyle> styleClass;

@end

@implementation PHMCustomPadDefaultView
- (void)setStyleClass:(Class)styleClass {
    if (styleClass) {
        _styleClass = styleClass;
    } else {
        _styleClass = [PHMCustomPadDefaultStyle class];
    }
}

+ (instancetype)customPadWithDelegate:(id<PHMCustomPadDefaultViewDelegate>)delegate{
    return [self customPadWithDelegate:delegate StyleClass:nil];
}

+ (instancetype)customPadWithDelegate:(id<PHMCustomPadDefaultViewDelegate>)delegate StyleClass:(Class)styleClass{
    return [[self alloc] initCustomPadWithDelegate:delegate StyleClass:styleClass];
}

- (instancetype)initCustomPadWithDelegate:(id<PHMCustomPadDefaultViewDelegate>)delegate StyleClass:(Class)styleClass;
{
    self = [super init];
    if (self) {
        self.styleClass =styleClass;

        self.frame = [self.styleClass customPadStyleRect];
        self.autoresizingMask = UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleHeight;
        self.backgroundColor = [self.styleClass customPadBGColor];
        self.delegate = delegate;


        NSMutableArray *numberButtons = [NSMutableArray array];
        for (int i = 0; i < [self.styleClass customPadButtonTitle].count; i++) {
            PHMCustomPadButton *numberButton = [self createButton:i];
            [self addSubview:numberButton];
            [numberButtons addObject:numberButton];
        }
        self.buttons = numberButtons;
    }
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    NSArray *array = [self.styleClass customPadButtonPosition];
    CGFloat sep = [self.styleClass separator];
    NSInteger section = [self.styleClass customPadStyle].horizontal;
    NSInteger row = [self.styleClass customPadStyle].vertical;
    CGSize buttonSize = CGSizeMake((CGRectGetWidth(self.bounds) - sep * (section - 1)) / section, (CGRectGetHeight(self.bounds) - sep * (row - 1)) / row);
    NSInteger btntag = 0;
    for (int i = 0; i < section; i++) {
        for (int j = 0; j < row; j++) {
            if (CGPointFromString(array[i][j]).x >0 && CGPointFromString(array[i][j]).y >0) {
                PHMCustomPadButton *customPadButton = self.buttons[btntag];
                customPadButton.frame = CGRectMake(j*(buttonSize.width+sep), i*(buttonSize.height+sep), buttonSize.width*CGPointFromString(array[i][j]).x, buttonSize.height*CGPointFromString(array[i][j]).y);
                btntag++;
            }
        }
    }
}

- (void)buttonAction:(id)sender {
    UIButton *btn = (UIButton *)sender;
    if ([self.delegate respondsToSelector:@selector(customPad:buttonAction:text:)]) {
        [self.delegate customPad:self buttonAction:btn text:btn.titleLabel.text];
    }
}

#pragma mark - Create PadButton
-(PHMCustomPadButton *)createButton:(NSInteger)number {
    PHMCustomPadButton *customPadButton = [PHMCustomPadButton buttonWithNormalBGColor:[self.styleClass customPadButtonBackgroundColor] highlightedBGColor:[self.styleClass customPadButtonHighlightedColor]];
    customPadButton.tag = number;
    [customPadButton addTarget:self action:@selector(buttonAction:) forControlEvents:UIControlEventTouchUpInside];
    [customPadButton setTitleColor:[self.styleClass customPadButtonTextColor] forState:UIControlStateNormal];
    customPadButton.titleLabel.font = [self.styleClass customPadButtonFont];
    customPadButton.titleLabel.lineBreakMode = NSLineBreakByWordWrapping;
    customPadButton.titleLabel.textAlignment = NSTextAlignmentCenter;
    [customPadButton setTitle:[self.styleClass customPadButtonTitle][number] forState:UIControlStateNormal];
    return customPadButton;
}
@end
