//
//  FollowTPView.m
//  MathsPlay
//
//  Created by qainfotech on 11/20/13.
//  Copyright (c) 2013 qainfotech. All rights reserved.
//

#import "FollowTPView.h"

@implementation FollowTPView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        self.backgroundColor = [UIColor yellowColor];
        self.textAlignment = NSTextAlignmentCenter;
        self.textColor = [UIColor blackColor];
        self.font = [UIFont fontWithName:@"ChalkboardSE-Bold" size:25.0];
        self.layer.borderWidth = 3.0;
        self.layer.borderColor = [[UIColor lightGrayColor]CGColor];
    }
    return self;
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
