//
//  CircularProgressView.m
//  MathsPlay
//
//  Created by qainfotech on 06/02/14.
//  Copyright (c) 2014 qainfotech. All rights reserved.
//

#import "CircularProgressView.h"

@implementation CircularProgressView
@synthesize progress,strokeWidth,fillColor,fillBackgroundColor;
- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self commonInitialization];
    }
    return self;
}


- (id)init
{
    self = [super initWithFrame:CGRectMake(0, 0, 30, 30)];
    if (self) {
        [self commonInitialization];
    }
    return self;
}
- (void)commonInitialization
{
	[self setOpaque:NO];
	[self setBackgroundColor:[UIColor clearColor]];
	
	progress = 0;
	strokeWidth = 1;
	fillColor = [UIColor darkGrayColor] ;
	fillBackgroundColor = [UIColor clearColor];
}

- (void)setProgress:(CGFloat)updatedProgress {
	progress = updatedProgress;
	[self setNeedsDisplay];
}

- (void)drawRect:(CGRect)rect
{
	CGFloat circleRadius = (self.bounds.size.width / 2) - (self.strokeWidth * 2);
	CGPoint circleCenter = CGPointMake(self.frame.size.width/2,self.frame.size.height/2);
	CGRect circleRect = CGRectMake(circleCenter.x - circleRadius, circleCenter.y - circleRadius,
								   2 * circleRadius, 2 * circleRadius);
    
	CGContextRef context = UIGraphicsGetCurrentContext();
	CGContextSaveGState(context);
    
	// Draw circle filled with background color.
	
	CGContextSetFillColorWithColor(context, self.fillBackgroundColor.CGColor);
	CGContextAddEllipseInRect(context, circleRect);
	CGContextFillPath(context);
	
	// Draw stroked circle to delineate "pie" shape.
	
	CGContextSetStrokeColorWithColor(context, self.fillColor.CGColor);
	CGContextSetLineWidth(context, self.strokeWidth);
	CGContextAddEllipseInRect(context, circleRect);
	CGContextStrokePath(context);
	
	// Draw filled wedge (clockwise from 12 o'clock) to indicate progress
	
	progress = MIN(MAX(0.0, progress), 1.0);
	
	CGFloat startAngle = -M_PI_2;
	CGFloat endAngle = startAngle + (progress * 2 * M_PI);
    
    CGContextSetFillColorWithColor(context, self.fillColor.CGColor);
    CGContextMoveToPoint(context, circleCenter.x, circleCenter.x);
    CGContextAddLineToPoint(context, CGRectGetMidX(circleRect), CGRectGetMinY(circleRect));
    CGContextAddArc(context, circleCenter.x, circleCenter.y, circleRadius, startAngle, endAngle, NO);
    CGContextClosePath(context);
 
    
    CAKeyframeAnimation *animatePosition = [CAKeyframeAnimation animationWithKeyPath:@"position"];
    animatePosition.duration = 1.0;
    animatePosition.repeatCount = CGFLOAT_MAX;
    CGContextFillPath(context);
    CGContextRestoreGState(context);

   }

@end
