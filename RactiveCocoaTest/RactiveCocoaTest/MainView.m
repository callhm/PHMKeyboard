//
//  MainView.m
//  RactiveCocoaTest
//
//  Created by PHM on 8/31/16.
//  Copyright © 2016 PHM. All rights reserved.

#import "MainView.h"

@interface MainView ()
@property (nonatomic, strong) UIButton *reactiveBtn;
@property (nonatomic, strong) UITextField *reactiveTF;
@property (nonatomic, strong) UILabel *reactiveLB;
@property (nonatomic, strong) NSString *reactiveString;
@property (nonatomic, strong) RACSubject *updatedContentSignal;
@property (nonatomic ,strong) NSDate *time; //时间变量
@end

@implementation MainView
- (UITextField *)reactiveTF {
    if (!_reactiveTF) {
        UITextField *reactiveTF = [[UITextField alloc] init];
        reactiveTF.borderStyle = UITextBorderStyleRoundedRect;
        _reactiveTF = reactiveTF;
    }
    return _reactiveTF;
}

- (UILabel *)reactiveLB
{
    if (!_reactiveLB) {
        UILabel *reactiveLB = [[UILabel alloc] init];
        reactiveLB.textColor = [UIColor yellowColor];
        _reactiveLB = reactiveLB;
    }
    return _reactiveLB;
}

- (UIButton *)reactiveBtn {
    if (!_reactiveBtn) {
        UIButton *reactiveBtn = [[UIButton alloc] init];
        [reactiveBtn setBackgroundColor:[UIColor redColor]];
        [reactiveBtn setTitle:@"移动" forState:UIControlStateNormal];

        //此处利用RAC设置了button点击的回调方法
        __weak __typeof__(self) weakSelf = self;
        reactiveBtn.rac_command = [[RACCommand alloc] initWithSignalBlock:^RACSignal *(UIButton *input) {
            __typeof__(weakSelf) self = weakSelf;
            NSLog(@"点击了我:%@",input.currentTitle);
            self.reactiveString = input.currentTitle;
            
            //发送通知
            [(RACSubject *)self.updatedContentSignal sendNext:@"12345"];
            
            //返回一个空的信号量
            return [RACSignal empty];
        }];
        _reactiveBtn = reactiveBtn;
    }
    return _reactiveBtn;
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        [self addSubview:self.reactiveTF];
        [self addSubview:self.reactiveBtn];
        [self addSubview:self.reactiveLB];
        
        [_reactiveBtn mas_makeConstraints:^(MASConstraintMaker *make){
            make.center.equalTo(self);
            make.size.mas_equalTo(CGSizeMake(100, 40));
        }];
        
        [_reactiveTF mas_makeConstraints:^(MASConstraintMaker *make){
            make.centerX.equalTo(self);
            make.centerY.equalTo(self).with.offset(-50);
            make.size.mas_equalTo(CGSizeMake(100, 40));
        }];
        
        [_reactiveLB mas_makeConstraints:^(MASConstraintMaker *make){
            make.centerX.equalTo(self);
            make.centerY.equalTo(self).with.offset(-100);
            make.size.mas_equalTo(CGSizeMake(100, 40));
        }];
        
        [self varKVO];
        [self textFieldSignal];
        self.updatedContentSignal = [[RACSubject subject] setNameWithFormat:@"updatedContentSignal"];
        
        @weakify(self);
        [self.updatedContentSignal subscribeNext:^(id x) {
            @strongify(self);
            NSLog(@"%@",self.updatedContentSignal.name);
            NSLog(@"%@",x);
        }];
        
        RACSignal *repeatSignal = [[RACSignal interval:1 onScheduler:[RACScheduler mainThreadScheduler]] repeat];
        [repeatSignal subscribeNext: ^(NSDate* time){
            self.time = time;
        }];
        
        RACSignal *timeSignal = [self rac_valuesForKeyPath:@"time" observer:self];
        [timeSignal subscribeNext:^(NSDate* time) {
            NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
            [formatter setDateFormat:@"HH:mm:ss"];
            _reactiveLB.text = [formatter stringFromDate:time];
        }completed:^{

        }];
        
        [[RACObserve(self, reactiveString)
          filter:^BOOL(NSString *value) {
              return [value hasPrefix:@"A"];
          }]
         subscribeNext:^(NSString *value) {
             NSLog(@"%@",value);
         }];
        [RACDisposable disposableWithBlock:^{
            
            // block调用时刻：当信号发送完成或者发送错误，就会自动执行这个block,取消订阅信号。
            
            // 执行完Block后，当前信号就不在被订阅了。
            
            NSLog(@"信号被销毁");
            
        }];
       
        // 1.创建信号
        RACReplaySubject *replaySubject = [RACReplaySubject subject];
        // 2.发送信号
        [replaySubject sendNext:@"1"];
        [replaySubject sendNext:@"2"];
        // 3.订阅信号 First
        [replaySubject subscribeNext:^(id x) {
            NSLog(@"FirstSubscribeNext%@",x);
        }];
        // 3.订阅信号 Second
        [replaySubject subscribeNext:^(id x) {
            NSLog(@"SecondSubscribeNext%@",x);
        }];
        
        // 1.创建信号
        RACSubject *subject = [RACSubject subject];
        // 2.订阅信号 First
        [subject subscribeNext:^(id x) {
            // block调用时刻：当信号发出新值，就会调用.
            NSLog(@"FirstSubscribeNext%@",x);
        }];
        // 2.订阅信号 Second
        [subject subscribeNext:^(id x) {
            // block调用时刻：当信号发出新值，就会调用.
            NSLog(@"SecondSubscribeNext%@",x);
        }];
        // 3.发送信号
        [subject sendNext:@"1"];
        [subject sendNext:@"2"];
        
        
        
        
        __block int aNumber = 0;
        // Signal that will have the side effect of incrementing `aNumber` block
        // variable for each subscription before sending it.
        RACSignal *aSignal = [RACSignal createSignal:^ RACDisposable * (id<RACSubscriber> subscriber) {
            aNumber++;
            [subscriber sendNext:@(aNumber)];
            [subscriber sendCompleted];
            return nil;
        }];
        
        // This will print "subscriber one: 1"
        [aSignal subscribeNext:^(id x) {
            NSLog(@"subscriber one: %@", x);
        }];
        
        // This will print "subscriber two: 2"
        [aSignal subscribeNext:^(id x) {
            NSLog(@"subscriber two: %@", x);
        }];
        
        
        __block int missilesToLaunch = 0;
        
        // Signal that will have the side effect of changing `missilesToLaunch` on
        // subscription.
        RACSignal *processedSignal = [[RACSignal
                                       return:@"missiles"]
                                      map:^(id x) {
                                          missilesToLaunch++;
                                          return [NSString stringWithFormat:@"will launch %d %@", missilesToLaunch, x];
                                      }];
        
        // This will print "First will launch 1 missiles"
        [processedSignal subscribeNext:^(id x) {
            NSLog(@"First %@", x);
        }];
        
        // This will print "Second will launch 2 missiles"
        [processedSignal subscribeNext:^(id x) {
            NSLog(@"Second %@", x);
        }];
    }
    return self;
}

-(void)layoutSubviews {
    [super layoutSubviews];
    NSLog(@"22222");
    
    
}

- (void)updateConstraints {
    [super updateConstraints];
    NSLog(@"33333");
    
}

#pragma mark TextFielf添加信号量
- (void)textFieldSignal{
    RAC(self.reactiveLB, text) = self.reactiveTF.rac_textSignal;
}

#pragma mark 设置变量监听KVO
- (void)varKVO {
    [RACObserve(self, reactiveString) subscribeNext:^(id x) {
        NSLog(@"reactiveString:%@",x);
        if ([_reactiveBtn.currentTitle isEqualToString:@"移动"]) {
            [UIView animateWithDuration:0.5 animations:^{
                [self.reactiveTF mas_updateConstraints:^(MASConstraintMaker *make){
                    make.centerX.equalTo(self.mas_centerX).with.offset(100);
                }];
                [self layoutIfNeeded];
            } completion:^(BOOL finished) {
                if (finished) {
                    [self.reactiveBtn setTitle:@"返回" forState:UIControlStateNormal];
                }
            }];
        }else {
            [UIView animateWithDuration:0.5 delay:0 usingSpringWithDamping:0.7 initialSpringVelocity:0.1 options:UIViewAnimationOptionCurveLinear animations:^{
                [self.reactiveTF mas_updateConstraints:^(MASConstraintMaker *make){
                    make.centerX.equalTo(self);
                }];
                [self layoutIfNeeded];
            } completion:^(BOOL finished) {
                if (finished) {
                    [self.reactiveBtn setTitle:@"移动" forState:UIControlStateNormal];
                }
            }];
        }
    }];
}

#pragma mark RAC输出定义信号
-(void)racOutputSequenceSignal {
    RACSignal *letters = [@"A B C D E F G H I" componentsSeparatedByString:@" "].rac_sequence.signal;
    // Outputs
    [letters subscribeNext:^(NSString *x) {
        NSLog(@"%@", x);
    }];
}

@end
