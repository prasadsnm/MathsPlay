//
//  RadioButton.m
//  MathsPlay
//
//  Created by qainfotech on 29/01/14.
//  Copyright (c) 2014 qainfotech. All rights reserved.
//

#import "RadioButton.h"

@implementation RadioButton
@synthesize delegate=_delegate;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setFrame:frame];
        [self setImage:[UIImage imageNamed:@"unchecked"] forState:UIControlStateNormal];
        [self setImage:[UIImage imageNamed:@"checked"] forState:UIControlStateSelected];
        [self addTarget:self action:@selector(onTouchDown:) forControlEvents:UIControlEventTouchDown];
    }
    return self;
}

-(void) onTouchDown:(UIButton *)sender
{
    [self setSelected:!self.selected];
    [_delegate didSelectedOption:sender.tag];
}

@end
