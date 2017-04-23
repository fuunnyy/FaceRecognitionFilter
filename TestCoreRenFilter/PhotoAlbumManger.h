//
//  PhotoAlbumManger.h
//  TestCoreRenFilter
//
//  Created by WangYanbin on 2017/4/17.
//  Copyright © 2017年 WangYanbin. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "PhotoAlbum.h"

@interface PhotoAlbumManger : NSObject

+ (instancetype)sharedManager;

- (NSArray <PhotoAlbum *> *)getPhotoAlbums;

- (NSArray<PHAsset *> *)getAllAssetInPhotoAblumWithAscending:(BOOL)ascending;

- (NSArray<PHAsset *> *)getAssetsInAssetCollection:(PHAssetCollection *)assetCollection ascending:(BOOL)ascending;

- (void)requestImageForAsset:(PHAsset *)asset size:(CGSize)size resizeMode:(PHImageRequestOptionsResizeMode)resizeMode completion:(void (^)(UIImage *image, NSDictionary *info))completion;

- (void)requestImageForAsset:(PHAsset *)asset scale:(CGFloat)scale resizeMode:(PHImageRequestOptionsResizeMode)resizeMode completion:(void (^)(UIImage *image))completion;

- (BOOL)judgeAssetisInLocalAblum:(PHAsset *)asset ;


@end
