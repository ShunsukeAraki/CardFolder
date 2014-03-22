//
//  CardFolderListViewController.m
//  CardFolder
//
//  Created by Shunsuke Araki on 2014/03/22.
//  Copyright (c) 2014年 Individual. All rights reserved.
//

#import "CardFolderListViewController.h"
#import "CardFolderViewController.h"
#import "CardData.h"

@interface CardFolderListViewController ()
<UIScrollViewDelegate>
@property (weak, nonatomic) IBOutlet UIScrollView *oScrollView;
@property (weak, nonatomic) IBOutlet UIPageControl *oPageControl;

@end

@implementation CardFolderListViewController

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
	[self createCardFolder];
	self.currentPage = 0;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Property
- (void)setCurrentPage:(NSUInteger)currentPage {
	_currentPage = currentPage;
	self.oPageControl.currentPage = currentPage;
	[self.oScrollView setContentOffset:CGPointMake(CGRectGetWidth(self.oScrollView.frame) * currentPage, 0) animated:YES];
}

#pragma mark - Private
- (void)createCardFolder {
	static const NSUInteger MAX_TAB = 3;
	[self.oScrollView.subviews enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
		[obj removeFromSuperview];
	}];
	for (int i=0; i<MAX_TAB; i++) {
		NSArray *cards = [self createDummyCard];
		CardFolderViewController *vc = [[CardFolderViewController alloc] initWithCards:cards];
		[self addChildViewController:vc];
		vc.view.frame = CGRectOffset(self.oScrollView.frame, CGRectGetWidth(self.oScrollView.frame) * i, 0);
		[self.oScrollView addSubview:vc.view];
		[vc didMoveToParentViewController:self];
	}
	self.oScrollView.contentSize = CGSizeMake(CGRectGetWidth(self.oScrollView.frame) * MAX_TAB, CGRectGetHeight(self.oScrollView.frame));
	self.oPageControl.numberOfPages = MAX_TAB;
}

- (NSArray *)createDummyCard {
	NSUInteger count = arc4random() % 20;
	NSArray *names = @[@"RED", @"BLUE", @"YELLOW", @"GREEN", @"ORANGE", @"GRAY", @"PURPLE"];
	NSArray *colors = @[[UIColor redColor], [UIColor blueColor], [UIColor yellowColor], [UIColor greenColor], [UIColor orangeColor], [UIColor grayColor], [UIColor purpleColor]];
	NSMutableArray *cards = @[].mutableCopy;
	for (int i=0; i<count; i++) {
		CardData *card = [[CardData alloc] init];
		card.identifier = [[NSUUID UUID] UUIDString];
		int rand = arc4random()%names.count;
		card.name = names[rand];
		card.backgroundColor = colors[rand];
		[cards addObject:card];
	}
	return cards;
}

#pragma mark - UIScrollViewDelegate
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
	NSInteger page = (NSInteger)(scrollView.contentOffset.x / CGRectGetWidth(scrollView.frame));
	self.currentPage = page;
	[self.delegate cardFolderListViewController:self didChangePageIndex:page];
}
@end
