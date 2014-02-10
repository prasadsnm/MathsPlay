//
//  RulesCustomButton.m
//  MathsPlay
//
//  Created by qainfotech on 26/12/13.
//  Copyright (c) 2013 qainfotech. All rights reserved.
//

#import "RulesCustomButton.h"

@implementation RulesCustomButton

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        self=[UIButton buttonWithType:UIButtonTypeCustom];
        [self setImage:[UIImage imageNamed:@"rules"] forState:UIControlStateNormal];
        self.tag=100011;
        self.frame=frame;
        self.showsTouchWhenHighlighted=YES;

    }
    return self;
}

@end
