//
//  MPCustomAlert.m
//  MathsPlay
//
//  Created by qainfotech on 11/22/13.
//  Copyright (c) 2013 qainfotech. All rights reserved.
//

#import "MPCustomAlert.h"

#define MODAL_BACKGROUND_COLOR [UIColor colorWithRed:85/255.0 green:192/255.0 blue:247/255.0 alpha:1]
#define BORDER_COLOR [UIColor whiteColor].CGColor
#define BUTTON_BACKGROUND_COLOR [UIColor yellowColor]

@implementation MPCustomAlert

@synthesize alertdelegate;

- (id)initWithFrame:(CGRect)frame message:(NSString *)_message andDelegate:(id<MPCustomAlertDelegate>)delegateObject titleA:(NSString *)titleA titleB:(NSString *)titleB
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        
        self.alertdelegate = delegateObject;
        
        self.backgroundColor=MODAL_BACKGROUND_COLOR;
        self.layer.cornerRadius=10.0;
        self.layer.borderWidth=5.0;
        self.layer.borderColor=BORDER_COLOR;
        
        UILabel *messageLabel = [[UILabel alloc]initWithFrame:CGRectMake(25,30,350,150)];
        messageLabel.text = _message;
        messageLabel.font = [UIFont fontWithName:@"NoteWorthy" size:35];
        messageLabel.textAlignment=NSTextAlignmentCenter;
        messageLabel.numberOfLines=0;
        messageLabel.lineBreakMode = NSLineBreakByWordWrapping;
        [self addSubview:messageLabel];
        
        UIButton *myHome = [UIButton buttonWithType:UIButtonTypeCustom];
        myHome.frame=CGRectMake(30, 200, 150, 60) ;
        myHome.backgroundColor=InstaGreen;
        myHome.layer.cornerRadius=10.0;
        myHome.layer.borderWidth=1.0;
        myHome.layer.borderColor=BORDER_COLOR;
        [myHome setTitle:titleA forState:UIControlStateNormal];
        [myHome setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        myHome.tag=1;
        myHome.showsTouchWhenHighlighted=YES;
        [myHome addTarget:self action:@selector(buttonClicked:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:myHome];
        
        UIButton *playAgain = [UIButton buttonWithType:UIButtonTypeCustom];
        playAgain.frame=CGRectMake(210, 200, 170, 60) ;
        playAgain.backgroundColor=InstaGreen;
        playAgain.layer.cornerRadius=10.0;
        playAgain.layer.borderWidth=1.0;
        playAgain.layer.borderColor=BORDER_COLOR;
        [playAgain setTitle:titleB forState:UIControlStateNormal];
        [playAgain setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        playAgain.tag=2;
        playAgain.showsTouchWhenHighlighted=YES;
        [playAgain addTarget:self action:@selector(buttonClicked:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:playAgain];
                
    }
    return self;
}


-(void)buttonClicked:(UIButton *)sender
{
    if (sender.tag==1) {
        [self.alertdelegate customAlertClicked:1];
    }
    if (sender.tag==2) {
        [self.alertdelegate customAlertClicked:2];
    }    
    [self removeFromSuperview];
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
