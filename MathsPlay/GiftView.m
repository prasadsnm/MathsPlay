//
//  GiftView.m
//  MathsPlay
//
//  Created by qainfotech on 06/12/13.
//  Copyright (c) 2013 qainfotech. All rights reserved.
//

#import "GiftView.h"

@interface GiftView()

{
    UIImageView *giftImaeView;
    UILabel *giftCountLabel;
}

@end

@implementation GiftView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        giftImaeView =[[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 30, 30)];
        giftImaeView.backgroundColor=[UIColor clearColor];
        giftCountLabel =[[UILabel alloc]initWithFrame:CGRectMake(giftImaeView.frame.size.width+5, giftImaeView.frame.origin.y, 30, 30)];
        giftCountLabel.backgroundColor=[UIColor clearColor];
        giftCountLabel.textAlignment=NSTextAlignmentLeft;
        giftCountLabel.textColor=[UIColor whiteColor];
        [self addSubview:giftImaeView];
        [self addSubview:giftCountLabel];
    }
    return self;
}

-(void)setGiftImage:(UIImage *)giftImage
{
    [giftImaeView setImage:giftImage];
}

// transformation is applied in completion block to avoid race around condition of the label.
-(void)setGiftCount:(NSString *)countText
{
    [UIView animateWithDuration:1.0 delay:0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
        [giftCountLabel setText:[NSString stringWithFormat:@"X %@",countText]];
    } completion:^(BOOL finished) {
            CAKeyframeAnimation *centerZoom = [CAKeyframeAnimation animationWithKeyPath:@"transform"];
            centerZoom.duration = 1.0f;
            centerZoom.values = @[[NSValue valueWithCATransform3D:CATransform3DMakeScale(1, 1, 1)],[NSValue valueWithCATransform3D:CATransform3DMakeScale(2.0, 2.0, 1)],[NSValue valueWithCATransform3D:CATransform3DMakeScale(1, 1, 1)],[NSValue valueWithCATransform3D:CATransform3DMakeScale(1.2, 1.2, 1)],[NSValue valueWithCATransform3D:CATransform3DMakeScale(1, 1, 1)]];
            centerZoom.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionLinear];
            [self.layer addAnimation:centerZoom forKey:@"buttonScale"];
    }];

}


@end
