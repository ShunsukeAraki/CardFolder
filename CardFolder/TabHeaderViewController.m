//
//  TabHeaderViewController.m
//  CardFolder
//
//  Created by Shunsuke Araki on 2014/03/22.
//  Copyright (c) 2014年 Individual. All rights reserved.
//

#import "TabHeaderViewController.h"

@interface TabHeaderViewController ()
@property (nonatomic) IBOutletCollection(UIButton) NSArray *oTabButtons;

@end

@implementation TabHeaderViewController

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
	self.selectedTabIndex = 0;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Propery
- (void)setSelectedTabIndex:(NSUInteger)selectedTabIndex {
	_selectedTabIndex = selectedTabIndex;
	[self.oTabButtons enumerateObjectsUsingBlock:^(UIButton *button, NSUInteger idx, BOOL *stop) {
		button.enabled = (idx != selectedTabIndex);
	}];
}

#pragma mark - IBAction
- (IBAction)tabSelectAction:(UIButton *)sender {
	NSInteger index = sender.tag-1;
	[self.delegate tabHeaderViewController:self didSelectTabIndex:index];
	self.selectedTabIndex = index;
}

@end
