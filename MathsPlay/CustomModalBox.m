//
//  CustomModalBox.m
//  KidsLearningGame
//
//  Created by qainfotech on 03/10/13.
//  Copyright (c) 2013 QAInfotech. All rights reserved.
//

#import "CustomModalBox.h"
#define QUESTION_TEXT_COLOR [UIColor blackColor]
#define MODAL_BACKGROUND_COLOR [UIColor colorWithRed:85/255.0 green:192/255.0 blue:247/255.0 alpha:1]
#define BORDER_COLOR [UIColor whiteColor].CGColor
#define BUTTON_BACKGROUND_COLOR [UIColor yellowColor]
@implementation CustomModalBox
@synthesize delegate;
@synthesize yesButton;
@synthesize noButton;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.frame=frame;
        self.backgroundColor=MODAL_BACKGROUND_COLOR;
        self.layer.cornerRadius=10.0;
        self.layer.borderWidth=5.0;
        self.layer.borderColor=BORDER_COLOR;
        
        questionlabel=nil;
        questionlabel=[[UILabel alloc]initWithFrame:CGRectMake(5, 20, self.frame.size.width, 150)];
        questionlabel.backgroundColor=[UIColor clearColor];
        questionlabel.textColor=QUESTION_TEXT_COLOR;
        questionlabel.font=[UIFont fontWithName:@"NoteWorthy" size:25];
        questionlabel.textAlignment=NSTextAlignmentCenter;
        questionlabel.numberOfLines=0;
        [self addSubview:questionlabel];
    
        yesButton=[UIButton buttonWithType:UIButtonTypeCustom];
        yesButton.frame=CGRectMake(self.frame.origin.x+50, 200, 90, 60) ;
        yesButton.backgroundColor=BUTTON_BACKGROUND_COLOR;
        yesButton.layer.cornerRadius=10.0;
        yesButton.layer.borderWidth=5.0;
        yesButton.layer.borderColor=BORDER_COLOR;
        [yesButton setImage:[UIImage imageNamed:@"correct_black"] forState:UIControlStateNormal];
        yesButton.tag=1;
        yesButton.showsTouchWhenHighlighted=YES;

        [yesButton addTarget:self action:@selector(buttonClicked:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:yesButton];
        
    
        noButton=[UIButton buttonWithType:UIButtonTypeCustom];
        noButton.frame=CGRectMake(self.frame.size.width-150, 200, 90, 60) ;
        noButton.backgroundColor=BUTTON_BACKGROUND_COLOR;
        noButton.layer.cornerRadius=10.0;
        noButton.layer.borderWidth=5.0;
        noButton.layer.borderColor=BORDER_COLOR;
        
        [noButton setImage:[UIImage imageNamed:@"cross_black"] forState:UIControlStateNormal];
        noButton.tag=2;
        noButton.showsTouchWhenHighlighted=YES;
         [noButton addTarget:self action:@selector(buttonClicked:) forControlEvents:UIControlEventTouchUpInside];
       [self addSubview:noButton];     
        
    }
    return self;
}


-(void)setQuestion:(NSString *)question
{
    questionlabel.text=question;
}

-(void)setQuestionLabelColor:(UIColor *)color
{

    [questionlabel setTextColor:color];
}
-(void)show
{
    [self setHidden:NO];
}


-(void)hide
{
    [self setHidden:YES];
}

-(void)buttonClicked:(UIButton *)sender
{
    if (sender.tag==1) {
        [[self delegate]answerClicked:YES];
    }
    if (sender.tag==2) {
        [[self delegate]answerClicked:NO];
    }

}

@end
