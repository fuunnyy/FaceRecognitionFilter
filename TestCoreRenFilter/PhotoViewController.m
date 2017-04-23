//
//  PhotoViewController.m
//  TestCoreRenFilter
//
//  Created by WangYanbin on 2017/4/17.
//  Copyright © 2017年 WangYanbin. All rights reserved.
//

#import "PhotoViewController.h"
#import "PhotoAlbumTableViewController.h"

@interface PhotoViewController ()

@end

@implementation PhotoViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn setTitle:@"获取照片" forState:UIControlStateNormal];
    btn.bounds = CGRectMake(0, 0, 200, 40);
    btn.center = self.view.center;
    [btn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn];
}
//获取到手机中的图片
- (void)btnClick:(UIButton *)sender
{
    PhotoAlbumTableViewController *photoVC = [[PhotoAlbumTableViewController alloc] init];
    [self.navigationController pushViewController:photoVC animated:YES];
}

@end
