//
//  HMAView.m
//  MathsPlay
//
//  Created by qainfotech on 11/27/13.
//  Copyright (c) 2013 qainfotech. All rights reserved.
//

#import "HMAView.h"

@implementation HMAView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

+ (UILabel *)createLabelWithFrame:(CGRect)rect
{
    UILabel *label = [[UILabel alloc]initWithFrame:rect];
    label.font = [UIFont fontWithName:@"Markerfelt-Thin" size:50.0];
    label.backgroundColor = [UIColor clearColor];
    return label;
}


+ (UIButton *)createButtonWithFrame:(CGRect)rect
{
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    //button.backgroundColor = [UIColor colorWithRed:147/255.0 green:112/255.0 blue:219/255.0 alpha:1.0];
    button.layer.cornerRadius = 10.0;
    button.titleLabel.font = [UIFont fontWithName:@"Markerfelt-Thin" size:50.0];
    [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [button setFrame:rect];
    return button;
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
