//
//  PhotoAlbumTableViewController.m
//  TestCoreRenFilter
//
//  Created by WangYanbin on 2017/4/17.
//  Copyright © 2017年 WangYanbin. All rights reserved.
//

#import "PhotoAlbumTableViewController.h"
#import "PhotoAlbumManger.h"
#import "UIButton+TextAndImageHorizontalDisplay.h"
#import "PhotoAlbumDetCollectionViewController.h"
#import "PhotoAlbumLayout.h"

@interface PhotoAlbumTableViewController ()
{
    NSMutableArray<PhotoAlbum *> *mArr;
}

@end

@implementation PhotoAlbumTableViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.title = @"相册";
    
    mArr= [[[PhotoAlbumManger sharedManager] getPhotoAlbums] mutableCopy];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [mArr count];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 100;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellID = @"cellID";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if (!cell)
    {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellID];
    }
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    PhotoAlbum *album = mArr[indexPath.row];
    cell.textLabel.text =album.albumName;
    cell.detailTextLabel.text = [NSString stringWithFormat:@"%ld张",album.albumImageCount];
    cell.detailTextLabel.textColor = [UIColor grayColor];
    __block UIImage *img = nil;
    [[PhotoAlbumManger sharedManager] requestImageForAsset:album.firstImageAsset size:CGSizeMake(60 * 3, 60 * 3) resizeMode:PHImageRequestOptionsResizeModeExact completion:^(UIImage *image, NSDictionary *info)
     {
        img = image;
    }];
    cell.imageView.image = img;
    cell.imageView.contentMode = UIViewContentModeScaleAspectFill;
    cell.imageView.clipsToBounds = YES;
    return cell;
}

- (BOOL)prefersStatusBarHidden
{
    return YES;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    PhotoAlbum *model = [mArr objectAtIndex:indexPath.row];
    PhotoAlbumLayout *layout = [[PhotoAlbumLayout alloc] init];
    layout.minimumInteritemSpacing = 1.5;
    layout.minimumLineSpacing = 5.0;
    PhotoAlbumDetCollectionViewController *vc = [[PhotoAlbumDetCollectionViewController alloc] initWithCollectionViewLayout:layout model:model];
    [self.navigationController pushViewController:vc animated:YES];
}

@end
