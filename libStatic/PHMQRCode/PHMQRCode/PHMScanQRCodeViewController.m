//
//  PHMScanQRCodeViewController.m
//  PHMScanQRCode
//
//  Created by PHM on 9/6/16.
//  Copyright © 2016 PHM. All rights reserved.
//

#import "PHMScanQRCodeViewController.h"
#import "PHMScanQRCodeView.h"
@interface PHMScanQRCodeViewController ()<AVCaptureMetadataOutputObjectsDelegate>
@property (nonatomic, strong) AVCaptureSession *session; //扫描会话
@property (nonatomic, assign) CGRect scanRect;
@property (nonatomic, strong) PHMScanQRCodeView *scanQRCodeView;
@end

@implementation PHMScanQRCodeViewController


#pragma mark - Getter and Setter
#pragma mark -

#pragma mark - Override
#pragma mark -

#pragma mark - UIViewController Plifecycle
#pragma mark -
- (instancetype)init
{
    self = [super init];
    if (self) {
        _scanRect = CGRectMake(([UIScreen mainScreen].bounds.size.width-200)/2, ([UIScreen mainScreen].bounds.size.height-200)/2, 200, 200);
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    //相机访问是否受限
    self.view.backgroundColor = [UIColor whiteColor];
    [self videoAuthorization];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark - Init View
#pragma mark -

#pragma mark - Request and Sent Data
#pragma mark -

#pragma mark - Event Processing
#pragma mark - Notification Event Processing

#pragma mark - User Operation Event Processing

#pragma mark - Common Event Processing
#pragma mark 验证相机是否可用
-(void)videoAuthorization{
    AVAuthorizationStatus authorizationStatus = [AVCaptureDevice authorizationStatusForMediaType:AVMediaTypeVideo];
    switch (authorizationStatus) {
        case AVAuthorizationStatusNotDetermined: {//第一次做出选择
            [AVCaptureDevice requestAccessForMediaType:AVMediaTypeVideo completionHandler: ^(BOOL granted) {
                if (granted) {
                    [self startCapture];
                } else {
                    //用户拒绝访问
                }
            }];
            break;
        }
        case AVAuthorizationStatusAuthorized: {
            [self startCapture];
            break;
        }
        case AVAuthorizationStatusRestricted:{//家长限制 访问受限
            
        }
        case AVAuthorizationStatusDenied: {//用户拒绝访问
            
            break;
        }
        default: {
            break;
        }
    }
}

#pragma mark 创建会话
- (void)startCapture {
    AVCaptureDevice *device = [AVCaptureDevice defaultDeviceWithMediaType:AVMediaTypeVideo];
    NSError *error;
    AVCaptureDeviceInput *deviceInput = [AVCaptureDeviceInput deviceInputWithDevice:device error:&error];
    AVCaptureMetadataOutput *deviceOutput = [[AVCaptureMetadataOutput alloc] init];
    [deviceOutput  setMetadataObjectsDelegate:self queue:dispatch_get_main_queue()];
    if (deviceInput) {
        //创建会话
         _session = [[AVCaptureSession alloc] init];
        //高质量采集率
        [_session setSessionPreset:AVCaptureSessionPresetHigh];
        [_session addInput:deviceInput];
        [_session addOutput:deviceOutput];
        
        //设置扫描支持的格式
        [deviceOutput setMetadataObjectTypes:@[AVMetadataObjectTypeQRCode]];//要写在add session后
        AVCaptureVideoPreviewLayer *previewLayer = [[AVCaptureVideoPreviewLayer alloc] initWithSession:_session];
        previewLayer.videoGravity = AVLayerVideoGravityResizeAspectFill;
        previewLayer.frame = self.view.frame;
        [self.view.layer insertSublayer:previewLayer atIndex:0];

        __weak typeof(self) weakSelf = self;
        [[NSNotificationCenter defaultCenter] addObserverForName:AVCaptureInputPortFormatDescriptionDidChangeNotification
                                                          object:nil
                                                           queue:[NSOperationQueue currentQueue]
                                                      usingBlock: ^(NSNotification *_Nonnull note) {
                                                          __typeof(weakSelf) self = weakSelf;
                                                          deviceOutput.rectOfInterest = [previewLayer metadataOutputRectOfInterestForRect:self.scanRect];//指定扫描区域
                                                      }];
        
        PHMScanQRCodeView *scanView = [[PHMScanQRCodeView alloc] initWithFrame:self.view.frame scanRect:self.scanRect];
        [self.view addSubview:scanView];
        [_session startRunning];
    }else{
        NSLog(@"%@",error);
    }
}

#pragma mark 停止会话
- (void)stopCapture {
    // 停止会话
    [_session stopRunning];
    _session = nil;
}

#pragma mark 打开照明
- (void)openSystemLight:(BOOL)isOpen {
    AVCaptureDevice *device = [AVCaptureDevice defaultDeviceWithMediaType:AVMediaTypeVideo];
    if ([device hasTorch]) {
        [device lockForConfiguration:nil];
        if (isOpen) {
            [device setTorchMode:AVCaptureTorchModeOn];
        } else {
            [device setTorchMode:AVCaptureTorchModeOff];
        }
        [device unlockForConfiguration];
    }
}

#pragma mark - Delegate and DataSource
#pragma mark -
- (void)captureOutput:(AVCaptureOutput *)captureOutput didOutputMetadataObjects:(NSArray *)metadataObjects fromConnection:(AVCaptureConnection *)connection {
    AVMetadataMachineReadableCodeObject *metadataObject = metadataObjects.firstObject;
    if ([metadataObject.type isEqualToString:AVMetadataObjectTypeQRCode]) {
        self.isQRCodeCaptured = YES;
        NSLog(@"%@", metadataObject.stringValue);
    }
}

#pragma mark - ***备用方法 暂时弃用***
#pragma mark -


@end
