//
//  ZLThumbnailViewController.h
//  多选相册照片
//
//  Created by long on 15/11/30.
//  Copyright © 2015年 long. All rights reserved.
//

#import <UIKit/UIKit.h>

@class ZLAlbumListModel;

@interface ZLThumbnailViewController : UIViewController

@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;
@property (strong, nonatomic)  UIView *bottomView;
@property (strong, nonatomic)  UIButton *btnEdit;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *verLeftSpace;
@property (strong, nonatomic) IBOutlet UIButton *btnPreView;
@property (strong, nonatomic)  UIButton *btnOriginalPhoto;
@property (strong, nonatomic)  UILabel *labPhotosBytes;
@property (strong, nonatomic) IBOutlet UIButton *btnDone;

//相册model
@property (nonatomic, strong) ZLAlbumListModel *albumListModel;

@end
