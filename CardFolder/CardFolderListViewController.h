//
//  CardFolderListViewController.h
//  CardFolder
//
//  Created by Shunsuke Araki on 2014/03/22.
//  Copyright (c) 2014年 Individual. All rights reserved.
//

#import <UIKit/UIKit.h>

@class CardFolderListViewController;
@protocol CardFolderListViewControllerDelegate <NSObject>
- (void)cardFolderListViewController:(CardFolderListViewController *)folder didChangePageIndex:(NSUInteger)index;
@end

@interface CardFolderListViewController : UIViewController
@property (weak, nonatomic) id<CardFolderListViewControllerDelegate> delegate;
@property (nonatomic) NSUInteger currentPage;
@end
