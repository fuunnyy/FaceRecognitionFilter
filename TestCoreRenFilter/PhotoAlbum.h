//
//  PhotoAlbum.h
//  TestCoreRenFilter
//
//  Created by WangYanbin on 2017/4/17.
//  Copyright © 2017年 WangYanbin. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <Photos/Photos.h>

@interface PhotoAlbum : NSObject

@property (nonatomic, copy)   NSString *albumName; //相册名字
@property (nonatomic, assign) NSUInteger albumImageCount; //该相册内相片数量
@property (nonatomic, strong) PHAsset *firstImageAsset; //相册第一张图片缩略图
@property (nonatomic, strong) PHAssetCollection *assetCollection; //相册集，通过该属性获取该相册集下所有照片

@end
