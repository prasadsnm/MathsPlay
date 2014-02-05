//
//  DropDownAlert.m
//  MathsPlay
//
//  Created by qainfotech on 04/02/14.
//  Copyright (c) 2014 qainfotech. All rights reserved.
//

#import "DropDownAlert.h"

@implementation DropDownAlert

- (id)initWithFrame:(CGRect)frame message:(NSString *)message
{
    self = [super initWithFrame:frame];
    if (self) {
        
        self.textLabel=[[UILabel alloc]initWithFrame:CGRectMake(frame.origin.x, 0, frame.size.width, frame.size.height)];
        self.textLabel.text=message;
        self.textLabel.backgroundColor=[UIColor yellowColor];
        self.textLabel.textAlignment=NSTextAlignmentCenter;
        [self addSubview: self.textLabel];
    }
    return self;
}



- (void)show{
    [UIView animateWithDuration:1 animations:^{
        self.transform=CGAffineTransformMakeTranslation(0, 100);;
    } completion:^(BOOL finish){
    }];
}


-(void)hide
{
    [UIView animateWithDuration:1 animations:^{
        self.transform=CGAffineTransformMakeTranslation(0, -100);;
    } completion:^(BOOL finish){
        
    }];
}
@end
