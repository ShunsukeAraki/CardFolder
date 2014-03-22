//
//  MainViewController.m
//  CardFolder
//
//  Created by Shunsuke Araki on 2014/03/22.
//  Copyright (c) 2014年 Individual. All rights reserved.
//

#import "MainViewController.h"
#import "TabHeaderViewController.h"
#import "CardFolderListViewController.h"
#import "CardDetailViewController.h"
#import "CardView.h"
#import "CardData.h"

@interface MainViewController ()
<TabHeaderViewControllerDelegate, CardFolderListViewControllerDelegate>
@property (nonatomic) TabHeaderViewController *tabHeaderViewController;
@property (nonatomic) CardFolderListViewController *cardFolderListViewController;
@property (weak, nonatomic) IBOutlet UIView *oHeaderView;
@property (weak, nonatomic) IBOutlet UIView *oCardFolderView;
@property (nonatomic) id cardDidSelectObserver;
@end

@implementation MainViewController

#pragma mark - ViewLifeCycle
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
	{
		self.tabHeaderViewController = [[TabHeaderViewController alloc] init];
		self.tabHeaderViewController.delegate = self;
		[self addChildViewController:self.tabHeaderViewController];
		self.tabHeaderViewController.view.frame = self.oHeaderView.bounds;
		[self.oHeaderView addSubview:self.tabHeaderViewController.view];
		[self.tabHeaderViewController didMoveToParentViewController:self];
	}
	{
		self.cardFolderListViewController = [[CardFolderListViewController alloc] init];
		self.cardFolderListViewController.delegate = self;
		[self addChildViewController:self.cardFolderListViewController];
		self.cardFolderListViewController.view.frame = self.oCardFolderView.bounds;
		[self.oCardFolderView addSubview:self.cardFolderListViewController.view];
		[self.cardFolderListViewController didMoveToParentViewController:self];
		
	}
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewWillAppear:(BOOL)animated {
	[super viewWillAppear:animated];
	[self.navigationController setNavigationBarHidden:YES animated:YES];
	self.cardDidSelectObserver = [[NSNotificationCenter defaultCenter] addObserverForName:CardDidSelectNotification
																				   object:nil
																					queue:nil
																			   usingBlock:^(NSNotification *note)
	{
		CardData *card = note.object;
		CardDetailViewController *vc = [[CardDetailViewController alloc] init];
		vc.cardData = card;
		[self.navigationController pushViewController:vc animated:YES];
	}];
}

- (void)viewWillDisappear:(BOOL)animated {
	[super viewWillDisappear:animated];
	[[NSNotificationCenter defaultCenter] removeObserver:self.cardDidSelectObserver];
}

#pragma mark - TabHeaderViewControllerDelegate
- (void)tabHeaderViewController:(TabHeaderViewController *)header didSelectTabIndex:(NSUInteger)index {
	self.cardFolderListViewController.currentPage = index;
}

#pragma mark - CardFolderListViewControllerDelegate
- (void)cardFolderListViewController:(CardFolderListViewController *)folder didChangePageIndex:(NSUInteger)index {
	self.tabHeaderViewController.selectedTabIndex = index;
}
@end
