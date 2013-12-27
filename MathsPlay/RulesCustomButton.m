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
        [self addTarget:self action:@selector(buttonActionMethod:) forControlEvents:UIControlEventTouchUpInside];

    }
    return self;
}


-(void)buttonActionMethod:(UIButton *)sender
{

    UIViewController *modal=[[UIViewController alloc]init];
    modal.view.backgroundColor=[UIColor colorWithRed:132/255.0 green:240/255.0 blue:88/255.0 alpha:1];
    modal.modalTransitionStyle=UIModalTransitionStyleCrossDissolve;
    modal.modalPresentationStyle=[UIModalPresentationFormSheet;
    
    [super.super presentViewController:modal animated:YES completion:NULL]
    //[super.super.view presentViewController:modal animated:YES completion:NULL];

}

@end
