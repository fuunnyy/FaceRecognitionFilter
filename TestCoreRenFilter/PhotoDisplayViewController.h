//
//  PhotoDisplayViewController.h
//  TestCoreRenFilter
//
//  Created by WangYanbin on 2017/4/17.
//  Copyright © 2017年 WangYanbin. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PhotoDisplayViewController : UIViewController<UIScrollViewDelegate>

@property (nonatomic, strong) UIImage *image;

- (id)initWithImage:(UIImage *)image;


@end
