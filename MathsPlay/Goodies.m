//
//  Goodies.m
//  MathsPlay
//
//  Created by qainfotech on 12/12/13.
//  Copyright (c) 2013 qainfotech. All rights reserved.
//

#import "Goodies.h"
#define WIDTH 30
#define HEIGHT 30


@implementation Goodies

- (id)initWithFrame:(CGRect)frame Count:(int)count giftimage:(NSString *)imageName
{
    self = [super initWithFrame:frame];
    if (self)
    {
        int xvalue=10;
        self.frame=CGRectMake(0, 10,((WIDTH+5)*count), HEIGHT);
        for (int index=0; index<count; index++)
        {
            UIImageView * giftImaeView =[[UIImageView alloc]initWithFrame:CGRectMake(xvalue, 0, WIDTH, HEIGHT)];
                giftImaeView.backgroundColor=[UIColor clearColor];
            [self addSubview:giftImaeView];
            [giftImaeView setImage:[UIImage imageNamed:imageName]];
            
            NSLog(@"%d",xvalue);
            xvalue=xvalue+WIDTH+5;
        }
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
