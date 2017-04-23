//
//  PhotoAlbumDetCollectionViewController.m
//  TestCoreRenFilter
//
//  Created by WangYanbin on 2017/4/17.
//  Copyright © 2017年 WangYanbin. All rights reserved.
//

#import "PhotoAlbumDetCollectionViewController.h"
#import "PhotoAlbumManger.h"
#import "PhotoAlbumLayout.h"
#import "PhotoCollectionViewCell.h"
#import "PhotoDisplayViewController.h"

@interface PhotoAlbumDetCollectionViewController ()<UICollectionViewDelegate,UICollectionViewDataSource>
{
    NSArray<PHAsset *> *_dataSouce;
}
@property (nonatomic, strong) PHAssetCollection *assetCollection;

@end

@implementation PhotoAlbumDetCollectionViewController

static NSString * const reuseIdentifier = @"Cell";

- (instancetype)initWithCollectionViewLayout:(UICollectionViewLayout *)layout model:(PhotoAlbum *)model
{
    if (self = [super initWithCollectionViewLayout:layout])
    {
        self.model = model;
    }
    
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    CGRect frame = self.collectionView.frame;
    frame.origin.y+=44;
    self.collectionView.frame = frame;
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self initSource];
}

- (BOOL)prefersStatusBarHidden
{
    return YES;
}
- (void)initSource
{
    [self.collectionView registerClass:[PhotoCollectionViewCell class] forCellWithReuseIdentifier:reuseIdentifier];
    self.title = self.model.albumName;
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.assetCollection = self.model.assetCollection;
    _dataSouce = [[PhotoAlbumManger sharedManager] getAssetsInAssetCollection:self.assetCollection ascending:YES];
}

#pragma mark <UICollectionViewDataSource>

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return [_dataSouce count];
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    PhotoAlbumLayout *lay = (PhotoAlbumLayout *)collectionViewLayout;
    return CGSizeMake([lay cellWidth],[lay cellWidth]);
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    PhotoCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:reuseIdentifier forIndexPath:indexPath];
    PHAsset *asset = _dataSouce[indexPath.row];
    __block UIImage *bImage = nil;
    CGSize size = cell.frame.size;
    size.width *= 3;
    size.height *= 3;
    [[PhotoAlbumManger sharedManager] requestImageForAsset:asset size:size resizeMode:PHImageRequestOptionsResizeModeFast completion:^(UIImage *image, NSDictionary *info)
    {
        bImage = image;
    }];
    [cell setImage:bImage];
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    PHAsset *asset = _dataSouce[indexPath.row];
    
    [[PhotoAlbumManger sharedManager] requestImageForAsset:asset size:PHImageManagerMaximumSize resizeMode:PHImageRequestOptionsResizeModeFast completion:^(UIImage *image, NSDictionary *info)
    {
        PhotoDisplayViewController *vc = [[PhotoDisplayViewController alloc] initWithImage:image];
        [self.navigationController pushViewController:vc animated:YES];
    }];
    
}


@end
