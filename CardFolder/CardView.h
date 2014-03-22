//
//  CardView.h
//  CardFolder
//
//  Created by Shunsuke Araki on 2014/03/22.
//  Copyright (c) 2014年 Individual. All rights reserved.
//

#import <UIKit/UIKit.h>

extern NSString * const CardDidSelectNotification;

@class CardData;

@interface CardView : UIView
- (instancetype)initWithFrame:(CGRect)frame card:(CardData *)card;
@end
