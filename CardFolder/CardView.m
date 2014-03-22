//
//  CardView.m
//  CardFolder
//
//  Created by Shunsuke Araki on 2014/03/22.
//  Copyright (c) 2014年 Individual. All rights reserved.
//

#import "CardView.h"
#import "CardData.h"

NSString * const CardDidSelectNotification = @"CardDidSelectNotification";

@interface CardView()
@property (weak, nonatomic) IBOutlet UILabel *oNameLabel;
@property (nonatomic) CardData *card;
@property (nonatomic) CGPoint moveStartPoint;
@end

@implementation CardView

- (instancetype)initWithFrame:(CGRect)frame card:(CardData *)card {
	self = [super initWithFrame:frame];
	if (self) {
		UIView *nibView = [[NSBundle mainBundle] loadNibNamed:@"CardView" owner:self options:nil][0];
		[self addSubview:nibView];
		nibView.layer.cornerRadius = 20;
		nibView.layer.borderColor = [UIColor blackColor].CGColor;
		nibView.layer.borderWidth = 1.0f;
		self.card = card;
		self.oNameLabel.text = card.name;
		nibView.backgroundColor = card.backgroundColor;
		UILongPressGestureRecognizer *longPressGesture = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(longPressAction:)];
		[nibView addGestureRecognizer:longPressGesture];
		UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapAction:)];
		[nibView addGestureRecognizer:tapGesture];
	}
	return self;
}

- (void)longPressAction:(UILongPressGestureRecognizer *)recognizer {
	if (recognizer.state == UIGestureRecognizerStateBegan) {
		self.moveStartPoint = [recognizer locationInView:self];
		self.layer.zPosition = 1;
		self.transform = CGAffineTransformTranslate(self.transform, 0, -15);
	} else if (recognizer.state == UIGestureRecognizerStateEnded) {
		self.layer.zPosition = 0;
		[UIView animateWithDuration:0.2 animations:^{
			[UIView setAnimationCurve:UIViewAnimationCurveEaseOut];
			self.transform = CGAffineTransformIdentity;
		}];
	} else {
		CGPoint p = [recognizer locationInView:self];
		self.transform = CGAffineTransformTranslate(self.transform, 0, p.y - self.moveStartPoint.y - 15);
	}
}

- (void)tapAction:(UITapGestureRecognizer *)recognizer {
	[[NSNotificationCenter defaultCenter] postNotificationName:CardDidSelectNotification object:self.card];
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
