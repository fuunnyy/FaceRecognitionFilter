//
//  PhotoDisplayViewController.m
//  TestCoreRenFilter
//
//  Created by WangYanbin on 2017/4/17.
//  Copyright © 2017年 WangYanbin. All rights reserved.
//

#import "PhotoDisplayViewController.h"
#import "FiltersViewController.h"

@interface PhotoDisplayViewController ()
{
    UIScrollView  *_scrollView;
    UIToolbar     *_toolBar;
    UIImageView   *_imageView;
    BOOL          _oldBounces;
    MBProgressHUD *_HUD;
}

@end

@implementation PhotoDisplayViewController

- (id)initWithImage:(UIImage *)image
{
    if (self = [super init])
    {
        self.image = image;
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.view.backgroundColor =[UIColor blackColor];
    
    [self initScrollView];
    
    _imageView = [[UIImageView alloc] initWithFrame:self.view.bounds];
    _imageView.tag = 888;
    [_scrollView addSubview:_imageView];
    
    _imageView.image = self.image;
    _imageView.contentMode = UIViewContentModeScaleAspectFit;
    _imageView.userInteractionEnabled = YES;
    
    UITapGestureRecognizer *tapGes = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tap:)];
    tapGes.numberOfTapsRequired = 1;
    [_imageView addGestureRecognizer:tapGes];
    
    UITapGestureRecognizer* t = [[UITapGestureRecognizer alloc] initWithTarget:self
                                                                        action:@selector(doubleClicked:)];
    t.numberOfTapsRequired = 2;
    [_imageView addGestureRecognizer:t];
    
    [self initToolBar];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
}

- (void)initToolBar
{
    _toolBar = [[UIToolbar alloc] initWithFrame:CGRectMake(0, HEIGHT - 44, WIDTH, 44)];
    UIBarButtonItem *bbiEdit = [[UIBarButtonItem alloc] initWithTitle:@"编辑" style:UIBarButtonItemStyleDone target:self action:@selector(editImage:)];
//    UIBarButtonItem *bbiShare = [[UIBarButtonItem alloc] initWithTitle:@"分享" style:UIBarButtonItemStyleDone target:self action:@selector(shareImage:)];
    
    _toolBar.items = [NSArray arrayWithObjects:bbiEdit,nil];
    _toolBar.hidden = NO;
    [self.view addSubview:_toolBar];
}

- (void)editImage:(id)sender
{
    CIImage* ciimage = [CIImage imageWithCGImage:_imageView.image.CGImage];
    NSDictionary* opts = [NSDictionary dictionaryWithObject:
                          CIDetectorAccuracyHigh forKey:CIDetectorAccuracy];
    CIDetector* detector = [CIDetector detectorOfType:CIDetectorTypeFace
                                              context:nil options:opts];
    NSArray* features = [detector featuresInImage:ciimage];
    if (features.count == 0)
    {
        _HUD = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
        _HUD.mode = MBProgressHUDModeAnnularDeterminate;
        _HUD.label.text = @"未识别到人脸！！请返回重试。";
        dispatch_async(dispatch_get_global_queue( DISPATCH_QUEUE_PRIORITY_LOW, 0), ^{
            sleep(2.0);
            dispatch_async(dispatch_get_main_queue(), ^{
                [MBProgressHUD hideHUDForView:self.view animated:YES];
                [self.navigationController popViewControllerAnimated:YES];
            });
        });

    }
    else
    {
        FiltersViewController *beautyVC = [[FiltersViewController alloc] initWithImage:self.image];
        [self.navigationController pushViewController:beautyVC animated:YES];
    }
}

- (void)shareImage:(id)sender
{
//    FWBeautyViewController *beautyVC = [[FWBeautyViewController alloc] initWithImage:self.image];
//    [self.navigationController pushViewController:beautyVC animated:YES];
}

- (void)image:(UIImage *)image didFinishSavingWithError:(NSError *)error contextInfo:(void *)contextInfo
{
    _HUD = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    _HUD.mode = MBProgressHUDModeAnnularDeterminate;
    if(error != NULL)
    {
        _HUD.label.text = @"保存失败";
    }
    else
    {
        _HUD.label.text = @"保存成功";
    }
    dispatch_async(dispatch_get_global_queue( DISPATCH_QUEUE_PRIORITY_LOW, 0), ^{
        sleep(2.0);
        dispatch_async(dispatch_get_main_queue(), ^{
            [MBProgressHUD hideHUDForView:self.view animated:YES];
        });
    });
    
}
- (void)initScrollView
{
    _scrollView = [[UIScrollView alloc] initWithFrame:self.view.bounds];
    _scrollView.maximumZoomScale = 5;
    _scrollView.minimumZoomScale = 1;
    _scrollView.bouncesZoom = NO;
    _scrollView.delegate = self;
    
    [self.view addSubview:_scrollView];
}

- (void)scrollViewWillBeginZooming:(UIScrollView *)scrollView withView:(UIView *)view
{
    _oldBounces = scrollView.bounces;
    scrollView.bounces = NO;
}

- (void)scrollViewDidEndZooming:(UIScrollView *)scrollView withView:(UIView *)view atScale:(CGFloat)scale
{
    scrollView.bounces =_oldBounces;
    
}

- (UIView *)viewForZoomingInScrollView:(UIScrollView *)scrollView
{
    return [scrollView viewWithTag:888];
}


- (BOOL)prefersStatusBarHidden
{
    return YES;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)tap:(UITapGestureRecognizer *)gesture
{
    if (self.navigationController.navigationBarHidden)
    {
        [self.navigationController setNavigationBarHidden:NO animated:YES];
        [UIView animateWithDuration:10.0 animations:^{
            _toolBar.frame = CGRectMake(0, HEIGHT, WIDTH, 44);
        } completion:^(BOOL finished) {
            _toolBar.frame = CGRectMake(0, HEIGHT - 44, WIDTH, 44);
        }];
        
    }
    
    else
    {
        [self.navigationController setNavigationBarHidden:YES animated:YES];
        [UIView animateWithDuration:UINavigationControllerHideShowBarDuration animations:^{
            _toolBar.frame = CGRectMake(0, HEIGHT - 44, WIDTH, 44);
        } completion:^(BOOL finished) {
            _toolBar.frame = CGRectMake(0, HEIGHT, WIDTH, 44);
        }];
        
    }
}

- (void)doubleClicked:(UIGestureRecognizer *)gesture
{
    UIView* v = gesture.view;
    
    UIScrollView* sv = (UIScrollView*)v.superview;
    if (sv.zoomScale < 1) {
        [sv setZoomScale:1 animated:YES];
        CGPoint pt = CGPointMake((v.bounds.size.width - sv.bounds.size.width)/2.0,0);
        [sv setContentOffset:pt animated:NO];
    }
    else if (sv.zoomScale < sv.maximumZoomScale){
        [sv setZoomScale:sv.maximumZoomScale animated:YES];
        CGRect frm=sv.frame;
        frm.size.height+=_toolBar.frame.size.height;
        sv.frame=frm;
        _toolBar.hidden=TRUE;
    }
    else
    {   [sv setZoomScale:sv.minimumZoomScale animated:YES];
        _toolBar.hidden=FALSE;
        CGRect frm=sv.frame;
        frm.size.height-=_toolBar.frame.size.height;
        sv.frame=frm;
    }
    
}

@end
