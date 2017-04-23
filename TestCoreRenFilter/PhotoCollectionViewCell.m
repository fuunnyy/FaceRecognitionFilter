//
//  PhotoCollectionViewCell.m
//  TestCoreRenFilter
//
//  Created by WangYanbin on 2017/4/17.
//  Copyright © 2017年 WangYanbin. All rights reserved.
//

#import "PhotoCollectionViewCell.h"

@interface PhotoCollectionViewCell ()

@property (nonatomic, strong) UIImageView *imageView;

@end

@implementation PhotoCollectionViewCell

- (void)setImage:(UIImage *)image
{
    self.imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, (WIDTH - 3 * 5)/4, (WIDTH - 3 * 5)/4)];
    self.imageView.image = image;
    self.imageView.contentMode = UIViewContentModeScaleAspectFill;
    self.imageView.clipsToBounds = YES;
    
    [self.contentView addSubview:self.imageView];
}

@end
