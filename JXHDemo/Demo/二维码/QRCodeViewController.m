//
//  QRCodeViewController.m
//  QRCodeDemo
//
#import "QRCodeViewController.h"
#import <AVFoundation/AVFoundation.h>

#define kLineMinY [UIScreen mainScreen].bounds.size.height * 0.3
#define kLineMaxY [UIScreen mainScreen].bounds.size.height * 0.3 + 200
static const float kReaderViewWidth = 200;
static const float kReaderViewHeight = 200;

@interface QRCodeViewController () <AVCaptureMetadataOutputObjectsDelegate>

@property (nonatomic, strong) AVCaptureSession *qrSession;//回话
@property (nonatomic, strong) AVCaptureVideoPreviewLayer *qrVideoPreviewLayer;//读取
@property (nonatomic, strong) UIImageView *line;//交互线
@property (nonatomic, strong) NSTimer *lineTimer;//交互线控制

@end

@implementation QRCodeViewController

/**
 *  视图加载
 */
- (void)viewDidLoad
{
    [super viewDidLoad];
    // 背景色
    self.view.backgroundColor = [UIColor whiteColor];
    // 初始化扫描界面
    [self initUI];
    // 绘制装饰图片
    [self setOverlayPickerView];
    // 开始扫描
    [self startQRCodeReading];
    // 初始化标题视图
    [self initTitleView];
    // 返回按钮
    [self createBackBtn];
}

/**
 *  撤销处理
 */
- (void)dealloc
{
    if (_qrSession) {
        [_qrSession stopRunning];
        _qrSession = nil;
    }
    if (_qrVideoPreviewLayer) {
        _qrVideoPreviewLayer = nil;
    }
    if (_line) {
        _line = nil;
    }
    if (_lineTimer)
    {
        [_lineTimer invalidate];
        _lineTimer = nil;
    }
}

/**
 *  标题视图
 */
- (void)initTitleView
{
    UIView *bgView = [[UIView alloc] initWithFrame:CGRectMake(0,0,ApplicationW, 64)];
    bgView.backgroundColor = RGBColor(18, 96, 150);
    [self.view addSubview:bgView];
    
    UILabel *titleLab = [[UILabel alloc] initWithFrame:CGRectMake((ApplicationW - 80) / 2.0, 28, 80, 20)];
    titleLab.text = @"二维码";
    titleLab.shadowColor = [UIColor lightGrayColor];
    titleLab.shadowOffset = CGSizeMake(0, - 1);
    titleLab.font = [UIFont boldSystemFontOfSize:18.0];
    titleLab.textColor = [UIColor whiteColor];
    titleLab.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:titleLab];
}

/**
 *  返回按钮，返回后取消扫描
 */
- (void)createBackBtn
{
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn setFrame:CGRectMake(20, 28, 60, 24)];
    [btn setImage:[UIImage imageNamed:@"bar_back"] forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(cancleQRCodeReading) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn];
}

/**
 *  初始化扫描界面
 */
- (void)initUI
{
    // 摄像头捕捉设备对象
    AVCaptureDevice *device = [AVCaptureDevice defaultDeviceWithMediaType:AVMediaTypeVideo];
    // 摄像头判断
    NSError *error = nil;
    // 摄像头捕捉设备输入对象
    AVCaptureDeviceInput *input = [AVCaptureDeviceInput deviceInputWithDevice:device error:&error];
    // 设备初始化失败
    if (error)
    {
        NSLog(@"没有摄像头-%@", error.localizedDescription);
        return;
    }
    //设置输出(Metadata元数据)
    AVCaptureMetadataOutput *output = [[AVCaptureMetadataOutput alloc] init];
    //设置输出的代理
    //使用主线程队列，相应比较同步，使用其他队列，相应不同步，容易让用户产生不好的体验
    [output setMetadataObjectsDelegate:self queue:dispatch_get_main_queue()];
    [output setRectOfInterest:[self getReaderViewBoundsWithSize:CGSizeMake(kReaderViewWidth, kReaderViewHeight)]];
    //拍摄会话
    AVCaptureSession *session = [[AVCaptureSession alloc] init];
    // 读取质量，质量越高，可读取小尺寸的二维码
    if ([session canSetSessionPreset:AVCaptureSessionPreset1920x1080])
    {
        [session setSessionPreset:AVCaptureSessionPreset1920x1080];
    }
    else if ([session canSetSessionPreset:AVCaptureSessionPreset1280x720])
    {
        [session setSessionPreset:AVCaptureSessionPreset1280x720];
    }
    else
    {
        [session setSessionPreset:AVCaptureSessionPresetPhoto];
    }
    
    if ([session canAddInput:input])
    {
        [session addInput:input];
    }
    
    if ([session canAddOutput:output])
    {
        [session addOutput:output];
    }
    //设置输出的格式
    //一定要先设置会话的输出为output之后，再指定输出的元数据类型
    [output setMetadataObjectTypes:@[AVMetadataObjectTypeQRCode]];
    //设置预览图层
    AVCaptureVideoPreviewLayer *preview = [AVCaptureVideoPreviewLayer layerWithSession:session];
    //设置preview图层的属性
    //preview.borderColor = [UIColor redColor].CGColor;
    //preview.borderWidth = 1.5;
    [preview setVideoGravity:AVLayerVideoGravityResizeAspectFill];
    //设置preview图层的大小
    preview.frame = self.view.layer.bounds;
    //[preview setFrame:CGRectMake(0, 0, ApplicationW, ApplicationH)];
    //将图层添加到视图的图层
    [self.view.layer insertSublayer:preview atIndex:0];
    //[self.view.layer addSublayer:preview];
    self.qrVideoPreviewLayer = preview;
    self.qrSession = session;
}

/**
 *  二维码视图尺寸设置
 */
- (CGRect)getReaderViewBoundsWithSize:(CGSize)asize
{
    return CGRectMake(kLineMinY / ApplicationH, ((ApplicationW - asize.width) / 2.0) / ApplicationW, asize.height / ApplicationH, asize.width / ApplicationW);
}


- (void)setOverlayPickerView
{
    // 1.画中间的基准线
    _line = [[UIImageView alloc] initWithFrame:CGRectMake((ApplicationW - 300) / 2.0, kLineMinY, 300, 12 * 300 / 320.0)];
    [_line setImage:[UIImage imageNamed:@"QRCodeLine"]];
    [self.view addSubview:_line];
    
    // 2.1最上部view
    UIView* upView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, ApplicationW, kLineMinY)];//80
    upView.alpha = 0.3;
    upView.backgroundColor = [UIColor blackColor];
    [self.view addSubview:upView];
    
    // 2.2左侧的view
    UIView *leftView = [[UIView alloc] initWithFrame:CGRectMake(0, kLineMinY, (ApplicationW - kReaderViewWidth) / 2.0, kReaderViewHeight)];
    leftView.alpha = 0.3;
    leftView.backgroundColor = [UIColor blackColor];
    [self.view addSubview:leftView];
    
    // 2.3右侧的view
    UIView *rightView = [[UIView alloc] initWithFrame:CGRectMake(ApplicationW - CGRectGetMaxX(leftView.frame), kLineMinY, CGRectGetMaxX(leftView.frame), kReaderViewHeight)];
    rightView.alpha = 0.3;
    rightView.backgroundColor = [UIColor blackColor];
    [self.view addSubview:rightView];
    
    CGFloat space_h = ApplicationH - kLineMaxY;
    
    // 2.4底部view
    UIView *downView = [[UIView alloc] initWithFrame:CGRectMake(0, kLineMaxY, ApplicationW, space_h)];
    downView.alpha = 0.3;
    downView.backgroundColor = [UIColor blackColor];
    [self.view addSubview:downView];
    
    // 3.四个边角
    UIImage *cornerImage = [UIImage imageNamed:@"QRCodeTopLeft"];
    
    // 3.1左上角
    UIImageView *leftView_image = [[UIImageView alloc] initWithFrame:CGRectMake(CGRectGetMaxX(leftView.frame) - cornerImage.size.width / 2.0, CGRectGetMaxY(upView.frame) - cornerImage.size.height / 2.0, cornerImage.size.width, cornerImage.size.height)];
    leftView_image.image = cornerImage;
    [self.view addSubview:leftView_image];
    
    cornerImage = [UIImage imageNamed:@"QRCodeTopRight"];
    // 3.2右上角
    UIImageView *rightView_image = [[UIImageView alloc] initWithFrame:CGRectMake(CGRectGetMinX(rightView.frame) - cornerImage.size.width / 2.0, CGRectGetMaxY(upView.frame) - cornerImage.size.height / 2.0, cornerImage.size.width, cornerImage.size.height)];
    rightView_image.image = cornerImage;
    [self.view addSubview:rightView_image];
    
    cornerImage = [UIImage imageNamed:@"QRCodebottomLeft"];
    // 3.3左下角
    UIImageView *downView_image = [[UIImageView alloc] initWithFrame:CGRectMake(CGRectGetMaxX(leftView.frame) - cornerImage.size.width / 2.0, CGRectGetMinY(downView.frame) - cornerImage.size.height / 2.0, cornerImage.size.width, cornerImage.size.height)];
    downView_image.image = cornerImage;
    [self.view addSubview:downView_image];
    
    cornerImage = [UIImage imageNamed:@"QRCodebottomRight"];
    // 3.4右下角
    UIImageView *downViewRight_image = [[UIImageView alloc] initWithFrame:CGRectMake(CGRectGetMinX(rightView.frame) - cornerImage.size.width / 2.0, CGRectGetMinY(downView.frame) - cornerImage.size.height / 2.0, cornerImage.size.width, cornerImage.size.height)];
    downViewRight_image.image = cornerImage;
    [self.view addSubview:downViewRight_image];
    
    // 4.说明label
    UILabel *labIntroudction = [[UILabel alloc] init];
    labIntroudction.backgroundColor = [UIColor clearColor];
    labIntroudction.frame = CGRectMake(CGRectGetMaxX(leftView.frame), CGRectGetMinY(downView.frame) + 25, kReaderViewWidth, 20);
    labIntroudction.textAlignment = NSTextAlignmentCenter;
    labIntroudction.font = [UIFont boldSystemFontOfSize:13.0];
    labIntroudction.textColor = [UIColor whiteColor];
    labIntroudction.text = @"将二维码置于框内,即可自动扫描";
    [self.view addSubview:labIntroudction];
    
    UIView *scanCropView = [[UIView alloc] initWithFrame:CGRectMake(CGRectGetMaxX(leftView.frame) - 1,kLineMinY,self.view.frame.size.width - 2 * CGRectGetMaxX(leftView.frame) + 2, kReaderViewHeight + 2)];
    scanCropView.layer.borderColor = [UIColor greenColor].CGColor;
    scanCropView.layer.borderWidth = 2.0;
    [self.view addSubview:scanCropView];
}

#pragma mark 输出代理方法
/**
 *  此方法是在识别到QRCode，并且完成转换
 *  如果QRCode的内容越大，转换需要的时间就越长
 */
- (void)captureOutput:(AVCaptureOutput *)captureOutput didOutputMetadataObjects:(NSArray *)metadataObjects fromConnection:(AVCaptureConnection *)connection
{
    //扫描结果
    if (metadataObjects.count > 0)
    {
        // 扫描到结果则取消扫描界面
        [self cancleQRCodeReading];
        // 扫描结果对象
        AVMetadataMachineReadableCodeObject *obj = metadataObjects[0];
        // 扫描成功
        if (obj.stringValue && ![obj.stringValue isEqualToString:@""] && obj.stringValue.length > 0)
        {
            NSLog(@"扫描结果：%@", obj.stringValue);
                if (self.QRCodeSuncessBlock) {
                    self.QRCodeSuncessBlock(self,obj.stringValue);
                }
        }
        else
        {
            if (self.QRCodeFailBlock) {
                self.QRCodeFailBlock(self);
            }
        }
    }
    else
    {
        if (self.QRCodeFailBlock) {
            self.QRCodeFailBlock(self);
        }
    }
}

#pragma mark 交互事件
/**
 *  开始扫描
 */
- (void)startQRCodeReading
{
    _lineTimer = [NSTimer scheduledTimerWithTimeInterval:1.0 / 20 target:self selector:@selector(animationLine) userInfo:nil repeats:YES];
    [self.qrSession startRunning];
    NSLog(@"start reading");
}
/**
 *  停止扫描
 */
- (void)stopQRCodeReading
{
    if (_lineTimer)
    {
        [_lineTimer invalidate];
        _lineTimer = nil;
    }
    
    [self.qrSession stopRunning];
    
    NSLog(@"stop reading");
}
/**
 *  取消扫描
 */
- (void)cancleQRCodeReading
{
    [self stopQRCodeReading];
    
    if (self.QRCodeCancleBlock)
    {
        self.QRCodeCancleBlock(self);
    }
    NSLog(@"cancle reading");
}


#pragma mark 上下滚动交互线
/**
 *  上下滚动交互线
 */
- (void)animationLine
{
    __block CGRect frame = _line.frame;
    
    static BOOL flag = YES;
    
    if (flag)
    {
        frame.origin.y = kLineMinY;
        flag = NO;
        
        [UIView animateWithDuration:1.0 / 20 animations:^{
            
            frame.origin.y += 5;
            _line.frame = frame;
            
        } completion:nil];
    }
    else
    {
        if (_line.frame.origin.y >= kLineMinY)
        {
            if (_line.frame.origin.y >= kLineMaxY - 12)
            {
                frame.origin.y = kLineMinY;
                _line.frame = frame;
                
                flag = YES;
            }
            else
            {
                [UIView animateWithDuration:1.0 / 20 animations:^{
                    
                    frame.origin.y += 5;
                    _line.frame = frame;
                    
                } completion:nil];
            }
        }
        else
        {
            flag = !flag;
        }
    }
    
}

@end