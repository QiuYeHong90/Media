//
//  ViewController.m
//  Media
//
//  Created by mac on 16/5/21.
//  Copyright © 2016年 mac. All rights reserved.
//
#import "People.h"
#import "MJExtension.h"
#import "ViewController.h"
#import <MediaPlayer/MediaPlayer.h>

typedef enum {
    SexMale,
    SexFemale
} Sex;
@interface ViewController ()<UIScrollViewDelegate>
@property (copy, nonatomic) NSString *name;
@property (copy, nonatomic) NSString *icon;
@property (assign, nonatomic) unsigned int age;
@property (copy, nonatomic) NSString *height;
@property (strong, nonatomic) NSNumber *money;
@property (assign, nonatomic) Sex sex;
@property (assign, nonatomic, getter=isGay) BOOL gay;
@property (nonatomic) CGPoint center;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
   
    self.scrollView = [[UIScrollView alloc]initWithFrame:self.view.frame];
   
    
    
    self.scrollView.scrollEnabled = YES;
    self.scrollView.backgroundColor = [UIColor redColor];
    [self.view addSubview:self.scrollView];
    
    self.imageView = [[UIImageView alloc]init];
    self.imageView.backgroundColor = [UIColor whiteColor];
    self.imageView.image = [UIImage imageNamed:@"login_introduce_bg3-586h.jpg"];
    [self.scrollView addSubview: self.imageView];
    self.imageView.contentMode = UIViewContentModeScaleAspectFit;

    self.imageView.frame=CGRectMake(0, 0, self.imageView.image.size.width, self.imageView.image.size.height);
    self.scrollView.contentSize=self.imageView.image.size;
    
    self.scrollView.delegate = self;
    self.scrollView.maximumZoomScale = 4.0;
    self.scrollView.minimumZoomScale = 0.2;
    self.scrollView.zoomScale =CGRectGetWidth(self.scrollView.frame)/self.imageView.image.size.width;
    
    
    //如果不加这句的话
    
    //那么正常拖动是可以的，但是如果zoom了 就会有问题
    
    //zoom发生后会把frame变成当前显示大小[imageview默认大小 屏幕显示大小 如是全屏则就是全屏大小] zoom变化导致frame同步改变了image的size 大小为frame大小
    
    //image 的size改变后导致self.scrollView.contentSize 变成了frame的大小  从而contentSize变小了 无法实现正常拖动。
    
    //然后根据zoom缩放比例变化。而不是根据实际图片大小。这么导致zoom后就无法拖动了[因为frame大小]
    
    
    
}

- (void)scrollViewWillBeginZooming:(UIScrollView *)scrollView withView:(nullable UIView *)view
{
    
    _center = view.center;
}
- (void)scrollViewDidEndZooming:(UIScrollView *)scrollView withView:(nullable UIView *)view atScale:(CGFloat)scale
{
//    view.center = _center;
    [self positionWithScroll:scrollView];
}
-(void)scrollViewDidZoom:(UIScrollView *)scrollView
{
    [self positionWithScroll:scrollView];
    
}

-(void)positionWithScroll:(UIScrollView*)scrollView
{
    UIImageView * imgView = (UIImageView*)scrollView.subviews[0];
    if (CGRectGetHeight(imgView.frame)>CGRectGetHeight(scrollView.frame)) {
        //如果放大后的图片尺寸高度大于scroll的高度则让其偏移量为零,并且 是对称图形
        CGRect rect = imgView.frame;
        rect.origin.y = 0;
        imgView.frame = rect;
         scrollView.contentOffset=CGPointMake(0, 0);
    }else{
        //否则将是中心对称图形  如果是多个scrollView 的话就不是这样了
        
        
        
    }

    imgView.center =CGPointMake(CGRectGetWidth(scrollView.bounds)/2,CGRectGetHeight(scrollView.bounds)/2);
}

- (UIView *)viewForZoomingInScrollView:(UIScrollView *)scrollView
//返回需要zoom的view
{

   
    return scrollView.subviews[0];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    self.scrollView=nil;
    self.imageView=nil;
}





- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType
{
    NSLog(@"request.URL.absoluteString==%@",request.URL.absoluteString);
    return 1;
}
- (void)webView:(UIWebView *)webView didFailLoadWithError:(nullable NSError *)error
{
    NSLog(@"%@",error);
}


@end
