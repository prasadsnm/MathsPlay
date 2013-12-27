//
//  DivisibiltyCheckViewController.m
//  KidsLearningGame
//
//  Created by qainfotech on 01/10/13.
//  Copyright (c) 2013 QAInfotech. All rights reserved.
//

#import "DivisibiltyCheckViewController.h"

@interface DivisibiltyCheckViewController ()
{
    int correctCount;
    int giftCount;
    int totalGiftObject;

}
@end

@implementation DivisibiltyCheckViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        correctCount=0;
        giftCount=0;
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    totalGiftObject=0;
    SET_USERNAME_AS_TITLE
    if (NSFoundationVersionNumber <= NSFoundationVersionNumber_iOS_6_1) {
        self.navigationController.navigationBar.tintColor = [UIColor colorWithRed:65/255.0 green:105/255.0 blue:225/255.0 alpha:1.0];
    }
    else
    {
        self.navigationController.navigationBar.tintColor = [UIColor greenColor];
    }
    
    
  
    
    self.navigationController.navigationBar.translucent = NO;
    // set bar title color
    self.navigationController.navigationBar.titleTextAttributes = @{UITextAttributeTextColor : [UIColor whiteColor]};
    // set  button color
    [[UIBarButtonItem appearanceWhenContainedIn:[UINavigationBar class], nil] setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIColor greenColor], UITextAttributeTextColor,nil] forState:UIControlStateNormal];
    
    // preview screen at the beginning of game.
    UIView *shadow=[[UIView alloc]initWithFrame:self.view.bounds];
    shadow.backgroundColor=[UIColor darkGrayColor];
    shadow.alpha=0.9 ;
    
    // ant preview on dim preview.
    UIImageView  *antPreview=nil;
    antPreview=[[UIImageView alloc]initWithFrame:CGRectMake(350,300, 50, 50)];
    antPreview.image=[UIImage imageNamed:@"ant_black"];
    [shadow addSubview:antPreview];
    
    
    
    //info level for instruction.
    UILabel *infoLabel=nil;
    infoLabel=[[UILabel alloc]initWithFrame:CGRectMake(5, 350, shadow.frame.size.width, 100)];
    infoLabel.backgroundColor=[UIColor clearColor];
    infoLabel.text=@"Help the ant to Climb up the building by giving correct answers \n Enjoy!!";
    infoLabel.textColor=[UIColor whiteColor];
    infoLabel.font=[UIFont fontWithName:@"Lucida Grande" size:25];
    infoLabel.textAlignment=NSTextAlignmentCenter;
    infoLabel.numberOfLines=0;
    [shadow addSubview:infoLabel];

    
    UIButton *letsPlaybutton=[UIButton buttonWithType:UIButtonTypeCustom];
    letsPlaybutton.frame=CGRectMake(0, 0, 90, 60) ;
    letsPlaybutton.center=shadow.center;
    letsPlaybutton.backgroundColor=[UIColor clearColor];
    letsPlaybutton.layer.cornerRadius=10.0;
    letsPlaybutton.layer.borderWidth=5.0;
    letsPlaybutton.layer.borderColor=[UIColor whiteColor].CGColor;
    letsPlaybutton.showsTouchWhenHighlighted=YES;
    [letsPlaybutton setTitle:@"Lets Play" forState:UIControlStateNormal];
    [letsPlaybutton addTarget:self action:@selector(startMethod:) forControlEvents:UIControlEventTouchUpInside];
    [shadow addSubview:letsPlaybutton];

    
    
    
    //background image of building .
    UIImageView *background=[[UIImageView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)];
    background.image=[UIImage imageNamed:@"background"];
    [background setContentMode:UIViewContentModeScaleToFill];
    [self.view addSubview:background];
    
    [self displayQuestion];
    
    //label equal to height of building.
    builiding=nil;
    builiding=[[UILabel alloc]initWithFrame:CGRectMake(200, 205, 50, 750)];
    builiding.layer.cornerRadius=10.0;
    builiding.layer.borderWidth=2.0;
    builiding.layer.borderColor=[UIColor clearColor].CGColor;
    builiding.backgroundColor=[UIColor clearColor];
    [background addSubview:builiding];
    

    //view for ant
    ant=nil;
    ant=[[UIImageView alloc]init];
    ant.frame=CGRectMake(0, 0, 50, 50);
    ant.image=[UIImage imageNamed:@"ant_black"];
   [builiding addSubview:ant];
    
    
    //Custom modal to show question.
    modal=nil;
    modal=[[CustomModalBox alloc]initWithFrame:CGRectMake(0, 0, 400, 300)];
    modal.center=self.view.center;
    modal.delegate=self;
    [modal setQuestion:@"1st question is here...."];
    [self.view addSubview:modal];
    [modal hide];
    [self.view addSubview:shadow];
    
}


//after instruction
-(void)startMethod:(UIButton *)sender
{
    [sender.superview removeFromSuperview];
    [self initialAnimation];
}

//falling ant
-(void)initialAnimation
{
    
    [UIView animateWithDuration:2.0 delay:0.5 options:UIViewAnimationOptionCurveEaseInOut animations:^{
        [modal hide];
        ant.frame=CGRectMake(0, builiding.frame.size.height-50, 50, 50);
    } completion:^(BOOL finished) {
        [self displayQuestion];
 
    }];


}

//on any answer clicked
-(void)answerClicked:(BOOL)answer
{
    
    if ((dividend%divisor==0) && answer) {
        [self correctAnswer];
        
    }
    else if((dividend%divisor!=0) && !answer)
    {
        [self correctAnswer];
    }
    else
    {
        [self incorrectAnswer];
    }
}

-(void)correctAnswer{
    correctCount++;
    
    if (correctCount % 5==0) {
            [self refreshGiftWithCount:++totalGiftObject];
        
    }
    
    if (!(ant.frame.origin.y<=0))  //relative coordinate (0 means end of y axis)
    {
        [UIView animateWithDuration:2.0 delay:0.5 options:UIViewAnimationOptionCurveEaseInOut animations:^{
            [modal hide];
            [self winMusicStart];
            ant.frame=CGRectMake(ant.frame.origin.x, ant.frame.origin.y-50, ant.frame.size.width, ant.frame.size.height);
            
        } completion:^(BOOL finished) {
            
            if ((ant.frame.origin.y<=0)) {
                [modal show];
                [modal setQuestion:@" You Win !!"];
                [modal.yesButton setHidden:YES];
                [modal.noButton setHidden:YES];
            }
            else
            {
                [self displayQuestion];
                
            }
            
        }];
        
    }
    else
    {
        [modal setQuestion:@" You Win !!"];
        [modal.yesButton setHidden:YES];
        [modal.noButton setHidden:YES];
    }
   
}

-(void)incorrectAnswer
{
    
    if (!(ant.frame.origin.y>builiding.frame.size.height)) {
        
        [UIView animateWithDuration:2.0 delay:0.5 options:UIViewAnimationOptionCurveEaseInOut animations:^{
            ant.frame=CGRectMake(ant.frame.origin.x, ant.frame.origin.y+100, ant.frame.size.width, ant.frame.size.height);
            [modal hide];
            
        } completion:^(BOOL finished) {
            
            
            
            // check whether slipped more then initial position
            if ((ant.frame.origin.y>=builiding.frame.size.height)) {
                [modal show];
                [modal setQuestion:@"Oops \n You Loose !!"];
                [modal.yesButton setHidden:YES];
                [modal.noButton setHidden:YES];
                
                
                // after decrement checking whether slipped less than  initial position
            }
            else
            {
                [self displayQuestion];
            }
        }];
        
    }
    else
    {
        // [modal hide];
        [modal setQuestion:@"Oops \n You Loose !!"];
        [modal.yesButton setHidden:YES];
        [modal.noButton setHidden:YES];
    }
}


//get random no in range.
- (int)getRandomNumber:(int)from to:(int)to
{
    return (int)from + arc4random() % (to-from+1);
}

//display next question
-(void)displayQuestion
{
    dividend=[self getRandomNumber:1 to:10000];
    divisor=[self getRandomNumber:2 to:11];
   [ modal setQuestion:[NSString stringWithFormat:@"Question \n%i is divisible by %i ?",dividend,divisor]];
    [modal show];

}


//music after win 
-(void)winMusicStart
{
    __autoreleasing NSError *error=nil;
  NSURL * winAnsUrl = [NSURL fileURLWithPath:[NSString stringWithFormat:@"%@/win1.mp3", [[NSBundle mainBundle] resourcePath]]];
  AVAudioPlayer   *winAudioPlayer = [[AVAudioPlayer alloc] initWithContentsOfURL:winAnsUrl error:&error];
    winAudioPlayer.numberOfLoops = 0;
    [winAudioPlayer play];
    //[self performSelector:@selector(winMusicStop) withObject:nil afterDelay:1];


}



-(void)refreshGiftWithCount:(int)count
{
    for (Goodies *gift in self.view.subviews) {
        if ([gift isKindOfClass:[Goodies class]] && gift.tag==5555) {
            [gift removeFromSuperview];
        }
    }
    
    Goodies  *goodies=[[Goodies alloc]initWithFrame:CGRectZero Count:count giftimage:@"gift-box"];
    goodies.tag=5555;
    [self.view addSubview:goodies];
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
