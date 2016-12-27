//
//  PHMKeyboardView.m
//  Pods
//
//  Created by PHM on 26/12/2016.
//  Copyright © 2016 PHM. All rights reserved.
//

#import "PHMKeyboardView.h"
#import "PHMKeyboardStyle.h"
#import "PHMKeyboardButton.h"
#import "PHMKeyboardDefaultStyle.h"
@interface PHMKeyboardView ()
@property (nonatomic, strong) Class<PHMKeyboardStyle> styleClass;

@end
@implementation PHMKeyboardView
//设置模版UI
- (void)setStyleClass:(Class)styleClass {
    if (styleClass) {
        _styleClass = styleClass;
    } else {
        _styleClass = [PHMKeyboardDefaultStyle class];
    }
}


+ (instancetype)keyboardWithDelegate:(id<PHMKeyboardViewDelegate>)delegate{
    return [self keyboardWithDelegate:delegate styleClass:nil];
}

//创建自定义UI自定义键盘
+ (instancetype)keyboardWithDelegate:(id<PHMKeyboardViewDelegate>)delegate styleClass:(Class)styleClass{
    return [[self alloc] initKeyboardWithDelegate:delegate styleClass:styleClass];
}

- (instancetype)initKeyboardWithDelegate:(id<PHMKeyboardViewDelegate>)delegate styleClass:(Class)styleClass;
{
    self = [super init];
    if (self) {
        self.styleClass =styleClass;
        self.backgroundColor = [self.styleClass keyboardBGColor];
        self.delegate = delegate;
        
        NSMutableArray *numberButtons = [NSMutableArray array];
        for (int i = 0; i < [self.styleClass keyboardButtonTitle].count; i++) {
            PHMKeyboardButton *numberButton = [self createButton:i];
            [self addSubview:numberButton];
            [numberButtons addObject:numberButton];
        }
        self.buttons = numberButtons;
    }
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    NSArray *array = [self.styleClass keyboardButtonPosition];
    CGFloat sep = [self.styleClass separator];
    NSInteger section = [self.styleClass keyboardStyle].vertical;
    NSInteger row = [self.styleClass keyboardStyle].horizontal;
    CGSize buttonSize = CGSizeMake((CGRectGetWidth(self.bounds) - sep * (section - 1)) / section, (CGRectGetHeight(self.bounds) - sep * (row - 1)) / row);
    NSInteger btntag = 0;
    for (int i = 0; i < row; i++) {
        for (int j = 0; j < section; j++) {
            if (CGPointFromString(array[i][j]).x >0 && CGPointFromString(array[i][j]).y >0) {
                PHMKeyboardButton *keyboardButton = self.buttons[btntag];
                keyboardButton.frame = CGRectMake(j*(buttonSize.width+sep),
                                                  i*(buttonSize.height+sep),
                                                  buttonSize.width*CGPointFromString(array[i][j]).x+(CGPointFromString(array[i][j]).x-1)*sep,
                                                  buttonSize.height*CGPointFromString(array[i][j]).y+(CGPointFromString(array[i][j]).y-1)*sep);
                btntag++;
                if (btntag == [self.styleClass keyboardButtonTitle].count) {
                    return;
                }
            }
        }
    }
}

- (void)buttonAction:(id)sender {
    UIButton *btn = (UIButton *)sender;
    if ([self.delegate respondsToSelector:@selector(keyboardView:button:text:)]) {
        [self.delegate keyboardView:self button:btn text:btn.titleLabel.text];
    }
}

#pragma mark - Create PadButton
-(PHMKeyboardButton *)createButton:(NSInteger)number {
    PHMKeyboardButton *keyboardButton = [PHMKeyboardButton buttonWithNormalBGColor:[self.styleClass keyboardButtonBackgroundColor] highlightedBGColor:[self.styleClass keyboardButtonHighlightedColor]];
    keyboardButton.tag = number;
    [keyboardButton addTarget:self action:@selector(buttonAction:) forControlEvents:UIControlEventTouchUpInside];
    [keyboardButton setTitleColor:[self.styleClass keyboardButtonTextColor] forState:UIControlStateNormal];
    keyboardButton.titleLabel.font = [self.styleClass keyboardButtonFont];
    keyboardButton.titleLabel.lineBreakMode = NSLineBreakByWordWrapping;
    keyboardButton.titleLabel.textAlignment = NSTextAlignmentCenter;
    [keyboardButton setTitle:[self.styleClass keyboardButtonTitle][number] forState:UIControlStateNormal];
    return keyboardButton;
}
@end
