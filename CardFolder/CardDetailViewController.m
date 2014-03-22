//
//  CardDetailViewController.m
//  CardFolder
//
//  Created by Shunsuke Araki on 2014/03/22.
//  Copyright (c) 2014年 Individual. All rights reserved.
//

#import "CardDetailViewController.h"
#import "CardData.h"

@interface CardDetailViewController ()
@property (weak, nonatomic) IBOutlet UILabel *oNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *oIdentifierLabel;

@end

@implementation CardDetailViewController

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
	self.oNameLabel.text = self.cardData.name;
	self.oIdentifierLabel.text = self.cardData.identifier;
	self.view.backgroundColor = self.cardData.backgroundColor;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewWillAppear:(BOOL)animated {
	[super viewWillAppear:animated];
	[self.navigationController setNavigationBarHidden:NO animated:YES];
}
@end
