//
//  PhotoAlbumDetCollectionViewController.h
//  TestCoreRenFilter
//
//  Created by WangYanbin on 2017/4/17.
//  Copyright © 2017年 WangYanbin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Photos/Photos.h>
#import "PhotoAlbum.h"

@interface PhotoAlbumDetCollectionViewController : UICollectionViewController

@property (nonatomic, strong) PhotoAlbum *model;

- (instancetype)initWithCollectionViewLayout:(UICollectionViewLayout *)layout model:(PhotoAlbum *)model;

@end
