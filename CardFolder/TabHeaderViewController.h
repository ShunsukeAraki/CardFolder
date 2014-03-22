//
//  TabHeaderViewController.h
//  CardFolder
//
//  Created by Shunsuke Araki on 2014/03/22.
//  Copyright (c) 2014年 Individual. All rights reserved.
//

#import <UIKit/UIKit.h>

@class TabHeaderViewController;
@protocol TabHeaderViewControllerDelegate <NSObject>
- (void)tabHeaderViewController:(TabHeaderViewController *)header didSelectTabIndex:(NSUInteger)index;
@end

@interface TabHeaderViewController : UIViewController
@property (weak, nonatomic) id<TabHeaderViewControllerDelegate> delegate;
@property (nonatomic) NSUInteger selectedTabIndex;
@end
