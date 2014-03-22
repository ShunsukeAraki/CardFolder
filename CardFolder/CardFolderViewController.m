//
//  CardFolderViewController.m
//  CardFolder
//
//  Created by Shunsuke Araki on 2014/03/22.
//  Copyright (c) 2014年 Individual. All rights reserved.
//

#import "CardFolderViewController.h"
#import "CardView.h"
#import "CardData.h"

@interface CardFolderViewController ()
@property (weak, nonatomic) IBOutlet UIScrollView *oScrollView;
@property (nonatomic) NSArray *cards;
@end

@implementation CardFolderViewController

#pragma mark - ViewLifeCycle
- (instancetype)initWithCards:(NSArray *)cards {
	self = [super init];
	if (self) {
		_cards = cards;
	}
	return self;
}

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
	[self createCardView];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Private
- (void)createCardView {
	[self.oScrollView.subviews enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
		[obj removeFromSuperview];
	}];
	__block CGFloat y = 0.0f;
	[self.cards enumerateObjectsUsingBlock:^(CardData *card, NSUInteger idx, BOOL *stop) {
		CGRect frame = CGRectMake(0, y, CGRectGetWidth(self.oScrollView.frame), 250.0f);
		CardView *cardView = [[CardView alloc] initWithFrame:frame card:card];
		[self.oScrollView addSubview:cardView];
		y += 100.0f;
	}];
	self.oScrollView.contentSize = CGSizeMake(CGRectGetWidth(self.oScrollView.frame), y + 150.0f);
}
@end
