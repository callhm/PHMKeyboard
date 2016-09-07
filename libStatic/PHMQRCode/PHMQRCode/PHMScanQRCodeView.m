//
//  PHMScanQRCodeView.m
//  PHMScanQRCode
//
//  Created by PHM on 9/6/16.
//  Copyright © 2016 PHM. All rights reserved.
//

#import "PHMScanQRCodeView.h"

@interface PHMScanQRCodeView ()
@property (nonatomic, assign) CGRect scanRect;
@end

@implementation PHMScanQRCodeView
- (instancetype)initWithFrame:(CGRect)frame scanRect:(CGRect)rect
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
        _scanRect = rect;
    }
    return self;
}

// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    [[[UIColor blackColor] colorWithAlphaComponent:0.5] setFill];
    
    CGMutablePathRef screenPath = CGPathCreateMutable();
    CGPathAddRect(screenPath, NULL, self.bounds);
    
    CGMutablePathRef scanPath = CGPathCreateMutable();
    CGPathAddRect(scanPath, NULL, self.scanRect);
    
    CGMutablePathRef path = CGPathCreateMutable();
    CGPathAddPath(path, NULL, screenPath);
    CGPathAddPath(path, NULL, scanPath);
    
    CGContextAddPath(ctx, path);
    CGContextDrawPath(ctx, kCGPathEOFill);
    
    CGPathRelease(screenPath);
    CGPathRelease(scanPath);
    CGPathRelease(path);
}
@end
