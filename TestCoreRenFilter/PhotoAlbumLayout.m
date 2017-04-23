//
//  PhotoAlbumLayout.m
//  TestCoreRenFilter
//
//  Created by WangYanbin on 2017/4/17.
//  Copyright © 2017年 WangYanbin. All rights reserved.
//

#import "PhotoAlbumLayout.h"

@interface PhotoAlbumLayout ()

@property NSInteger countOfRow;

@end

@implementation PhotoAlbumLayout

- (void)prepareLayout
{
    [super prepareLayout];
    
    self.countOfRow = ceilf([self.collectionView numberOfItemsInSection:0] / 4.0);
}

- (UICollectionViewLayoutAttributes *)layoutAttributesForItemAtIndexPath:(NSIndexPath *)indexPath
{
    UICollectionViewLayoutAttributes *attris = [UICollectionViewLayoutAttributes layoutAttributesForCellWithIndexPath:indexPath];
    NSInteger currentRow = indexPath.item / 4;
    CGRect frame = CGRectMake( (indexPath.item % 4) * ([self cellWidth] + 5),currentRow * ([self cellWidth] + 65), [self cellWidth], [self cellWidth]);
    attris.frame = frame;
    attris.zIndex = 1;
    return attris;
}

- (CGFloat)cellWidth
{
    return (WIDTH - 3 * 5) / 4;
}

- (CGSize)collectionViewContentSize
{
    return CGSizeMake(WIDTH, self.countOfRow * ([self cellWidth] + 5) + 44);
}

@end
