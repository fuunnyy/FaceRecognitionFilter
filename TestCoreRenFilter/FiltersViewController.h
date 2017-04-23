//
//  FiltersViewController.h
//  TestCoreRenFilter
//
//  Created by WangYanbin on 2017/4/18.
//  Copyright © 2017年 WangYanbin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FWEffectBar.h"

@interface FiltersViewController : UIViewController<FWEffectBarDelegate>

@property (nonatomic, strong) UIImage *image;

- (instancetype)initWithImage:(UIImage *)image;

@end
