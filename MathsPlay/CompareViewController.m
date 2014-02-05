//
//  CompareViewController.m
//  KidsLearningGame
//
//  Created by QA Infotech on 10/07/13.
//  Copyright (c) 2013 QAInfotech. All rights reserved.
//

#import "CompareViewController.h"

@interface CompareViewController ()
{
    AVAudioPlayer *startupAudio;
}
@end

@implementation CompareViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        
        //audio player start
        
        NSURL *url = [NSURL fileURLWithPath:[NSString stringWithFormat:@"%@/hifi.mp3", [[NSBundle mainBundle] resourcePath]]];
        startupAudio = [[AVAudioPlayer alloc] initWithContentsOfURL:url error:nil];
        startupAudio.numberOfLoops = 0;
        [startupAudio play];

    }
    return self;
}

- (void)viewDidLoad
{
    dic = [Util readPListData];
    totalattempts = 0;
    rightans = 0;
    wrongans = 0;
    levelString = [[dic objectForKey:@"level"]copy];
    
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
    
    backgroundImage = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 768, 1024)];
    //backgroundImage.backgroundColor = [UIColor colorWithRed:94/255.0 green:141/255.0 blue:141/255.0 alpha:1];
    backgroundImage.image = [UIImage imageNamed:@"comparebackground"];
    [self.view addSubview:backgroundImage];
    
    gameHeading = [[UILabel alloc]initWithFrame:CGRectMake(10, 10, 400, 60)];
    gameHeading.text = @"What would you like ?";
    gameHeading.backgroundColor = [UIColor clearColor];
    gameHeading.textAlignment = NSTextAlignmentCenter;
    gameHeading.textColor = [UIColor colorWithRed:0/255.0 green:206/255.0 blue:209/255.0 alpha:1.0];
    gameHeading.font = [UIFont fontWithName:@"MarkerFelt-Wide" size:28.0f];
    [self.view addSubview:gameHeading];
    
    numberBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [numberBtn setTitle:@"Number" forState:UIControlStateNormal];
    [numberBtn setShowsTouchWhenHighlighted:YES];
    [numberBtn setSelected:YES];
    numberBtn.userInteractionEnabled = NO;
    [numberBtn setReversesTitleShadowWhenHighlighted:YES];
    numberBtn.frame = CGRectMake(80, 90, 130, 50);
    [numberBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [numberBtn setTitleColor:[UIColor blackColor] forState:UIControlStateSelected];
    [numberBtn setBackgroundColor:[UIColor colorWithRed:30/255.0 green:144/255.0 blue:255/255.0 alpha:1.0]];
    [[numberBtn titleLabel] setFont:[UIFont fontWithName:@"Verdana-BoldItalic" size:18.0f]];
    numberBtn.layer.shadowColor = [UIColor whiteColor].CGColor;
    numberBtn.layer.shadowOpacity = 0.8;
    numberBtn.layer.shadowRadius = 12;
    numberBtn.layer.shadowOffset = CGSizeMake(12.0f, 12.0f);
    CALayer *btnLayer1 = [numberBtn layer];
    [btnLayer1 setCornerRadius:5.0f];
    [btnLayer1 setBorderWidth:1.0f];
    [btnLayer1 setBorderColor:[[UIColor blackColor] CGColor]];
    [numberBtn addTarget:self action:@selector(buttonClicked:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:numberBtn];
    
    objectBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [objectBtn setTitle:@"Object" forState:UIControlStateNormal];
    [objectBtn setShowsTouchWhenHighlighted:YES];
    objectBtn.frame = CGRectMake(250, 90, 130, 50);
    [objectBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [objectBtn setTitleColor:[UIColor blackColor] forState:UIControlStateSelected];
    [objectBtn setBackgroundColor:[UIColor colorWithRed:106/255.0 green:90/255.0 blue:205/255.0 alpha:1.0]];
    [[objectBtn titleLabel] setFont:[UIFont fontWithName:@"Verdana-BoldItalic" size:18.0f]];
    CALayer *btnLayer2 = [objectBtn layer];
    [btnLayer2 setCornerRadius:5.0f];
    [btnLayer2 setBorderWidth:1.0f];
    [btnLayer2 setBorderColor:[[UIColor blackColor] CGColor]];
    [objectBtn addTarget:self action:@selector(buttonClicked:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:objectBtn];
    
    if (![levelString isEqualToString:@"HARD"])
    {
        nextLevelBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [nextLevelBtn setImage:[UIImage imageNamed:@"nextnew2"] forState:UIControlStateNormal];
        [nextLevelBtn setFrame:CGRectMake(630, 10, 60, 60)];
        nextLevelBtn.backgroundColor = [UIColor clearColor];
        [nextLevelBtn addTarget:self action:@selector(buttonClicked:) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:nextLevelBtn];
        
        nextLevelLabel = [[UILabel alloc]initWithFrame:CGRectMake(623, 57, 80, 50)];
        nextLevelLabel.text = @"Next Level";
        nextLevelLabel.font = [UIFont boldSystemFontOfSize:15];
        nextLevelLabel.textColor = [UIColor whiteColor];
        nextLevelLabel.backgroundColor = [UIColor clearColor];
        [self.view addSubview:nextLevelLabel];
    }
    
    starEarnedLabel = [[UILabel alloc]initWithFrame:CGRectMake(60, 210, 260, 40)];
    starEarnedLabel.text = [NSString stringWithFormat:@"Stars earned by %@",[dic objectForKey:@"username"]];
    starEarnedLabel.font = [UIFont boldSystemFontOfSize:20];
    starEarnedLabel.textColor = [UIColor yellowColor];
    starEarnedLabel.backgroundColor = [UIColor clearColor];
    [self.view addSubview:starEarnedLabel];
   
    
    star1 = [[UIImageView alloc]initWithFrame:CGRectMake(55, 260, 30, 30)];
    star1.image = [UIImage imageNamed:@"star.png"];
    star1.alpha = .3;
    [self.view addSubview:star1];

    
    star2 = [[UIImageView alloc]initWithFrame:CGRectMake(90, 260, 35, 35)];
    star2.image = [UIImage imageNamed:@"star.png"];
    star2.alpha = .3;
    [self.view addSubview:star2];

    
    star3 = [[UIImageView alloc]initWithFrame:CGRectMake(130, 260, 40, 40)];
    star3.image = [UIImage imageNamed:@"star.png"];
    star3.alpha = .3;
    [self.view addSubview:star3];
 
    
    star4 = [[UIImageView alloc]initWithFrame:CGRectMake(175, 260, 45, 45)];
    star4.image = [UIImage imageNamed:@"star.png"];
    star4.alpha = .3;
    [self.view addSubview:star4];
 
    
    star5 = [[UIImageView alloc]initWithFrame:CGRectMake(225, 260, 50, 50)];
    star5.image = [UIImage imageNamed:@"star.png"];
    star5.alpha = .3;
    [self.view addSubview:star5];

    
    congratsLabelForFiveStars = [[UILabel alloc]initWithFrame:CGRectMake(25, 330, 380, 60)];
    congratsLabelForFiveStars.text = @"\t\t\t\t\t\t        Congratulations!!!! \nYou have earned maximum stars";
    congratsLabelForFiveStars.font = [UIFont boldSystemFontOfSize:18];
    congratsLabelForFiveStars.textColor = [UIColor cyanColor];
    congratsLabelForFiveStars.backgroundColor = [UIColor clearColor];
    [congratsLabelForFiveStars setHidden:YES];
    congratsLabelForFiveStars.lineBreakMode = NSLineBreakByWordWrapping;
    congratsLabelForFiveStars.numberOfLines=0;
    [self.view addSubview:congratsLabelForFiveStars];
    
    UIImageView *correctImageLogo = [[UIImageView alloc]initWithFrame:CGRectMake(620, 170, 40, 40)];
    correctImageLogo.image = [UIImage imageNamed:@"correct"];
    [self.view addSubview:correctImageLogo];
    
    numberOfCorrectAnsLabel = [[UILabel alloc]initWithFrame:CGRectMake(670, 175, 40, 40)];
    numberOfCorrectAnsLabel.textColor = [UIColor greenColor];
    numberOfCorrectAnsLabel.backgroundColor = [UIColor clearColor];
    numberOfCorrectAnsLabel.text = [NSString stringWithFormat:@"%d",rightans];
    numberOfCorrectAnsLabel.textAlignment = NSTextAlignmentCenter;
    numberOfCorrectAnsLabel.font = [UIFont fontWithName:@"GillSans-Bold" size:30.0];
    [self.view addSubview:numberOfCorrectAnsLabel];
    
    UIImageView *inCorrectImageLogo = [[UIImageView alloc]initWithFrame:CGRectMake(620, 250, 40, 40)];
    inCorrectImageLogo.image = [UIImage imageNamed:@"incorrect"];
    [self.view addSubview:inCorrectImageLogo];
    
    numberOfInCorrectAnsLabel = [[UILabel alloc]initWithFrame:CGRectMake(670, 255, 40, 40)];
    numberOfInCorrectAnsLabel.textColor = [UIColor redColor];
    numberOfInCorrectAnsLabel.backgroundColor = [UIColor clearColor];
    numberOfInCorrectAnsLabel.text = [NSString stringWithFormat:@"%d",wrongans];
    numberOfInCorrectAnsLabel.textAlignment = NSTextAlignmentCenter;
    numberOfInCorrectAnsLabel.font = [UIFont fontWithName:@"GillSans-Bold" size:30.0];
    [self.view addSubview:numberOfInCorrectAnsLabel];

    
    greaterBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    //[greaterBtn setImage:[UIImage imageNamed:@"greater.JPG"] forState:UIControlStateNormal];
    [greaterBtn setImage:[UIImage imageNamed:@"greaterthannew2"] forState:UIControlStateNormal];
    [greaterBtn setFrame:CGRectMake(345, 480, 80, 80)];
    [greaterBtn addTarget:self action:@selector(operationButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:greaterBtn];
    
    equalBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [equalBtn setImage:[UIImage imageNamed:@"equaltonew3"] forState:UIControlStateNormal];
    [equalBtn setFrame:CGRectMake(345, 580, 80, 80)];
    [equalBtn addTarget:self action:@selector(operationButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:equalBtn];
    
    lesserBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [lesserBtn setImage:[UIImage imageNamed:@"lesserthannew2"] forState:UIControlStateNormal];
    [lesserBtn setFrame:CGRectMake(345, 680, 80, 80)];
    [lesserBtn addTarget:self action:@selector(operationButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:lesserBtn];
    
    leftNumberLbl = [[UILabel alloc]initWithFrame:CGRectMake(40, 510, 200, 180)];
    leftNumberLbl.backgroundColor = [UIColor clearColor];
    leftNumberLbl.textAlignment = NSTextAlignmentCenter;
    leftNumberLbl.textColor = [UIColor colorWithRed:255/255.0 green:127/255.0 blue:80/255.0 alpha:1.0];
    leftNumberLbl.font = [UIFont fontWithName:@"MarkerFelt-Wide" size:100.0f];
    [self.view addSubview:leftNumberLbl];

    
    rightNumberLbl = [[UILabel alloc]initWithFrame:CGRectMake(510, 510, 200, 180)];
    rightNumberLbl.backgroundColor = [UIColor clearColor];
    rightNumberLbl.textAlignment = NSTextAlignmentCenter;
    rightNumberLbl.textColor = [UIColor colorWithRed:255/255.0 green:127/255.0 blue:80/255.0 alpha:1.0];
    rightNumberLbl.font = [UIFont fontWithName:@"MarkerFelt-Wide" size:100.0f];
    [self.view addSubview:rightNumberLbl];

    
    winAnsUrl = [NSURL fileURLWithPath:[NSString stringWithFormat:@"%@/win1.mp3", [[NSBundle mainBundle] resourcePath]]];
    winAudioPlayer = [[AVAudioPlayer alloc] initWithContentsOfURL:winAnsUrl error:nil];
    winAudioPlayer.numberOfLoops = 0;
    
    wrongAnsUrl = [NSURL fileURLWithPath:[NSString stringWithFormat:@"%@/fb.mp3", [[NSBundle mainBundle] resourcePath]]];
    wrongAudioPlayer = [[AVAudioPlayer alloc] initWithContentsOfURL:wrongAnsUrl error:nil];
    wrongAudioPlayer.numberOfLoops = 0;
    
    NSURL *url1 = [NSURL fileURLWithPath:[NSString stringWithFormat:@"%@/clap.mp3", [[NSBundle mainBundle] resourcePath]]];
    
    NSError *error1;
    audioPlayerClap = [[AVAudioPlayer alloc] initWithContentsOfURL:url1 error:&error1];
    audioPlayerClap.numberOfLoops = -1;
    
    
    [self startGame];
    [super viewDidLoad];

    
}

-(void)operationButtonClicked:(id)sender
{
    if (sender == greaterBtn)
    {
        if (leftNumberLbl.isHidden==NO)
        {
            if ([leftNumberLbl.text intValue]>[rightNumberLbl.text intValue])
            {
                rightans++;
                NSLog(@"correct");
        
                if (!(rightans==5 || rightans==10||rightans==15||rightans==20||rightans==25))
                {
                    [winAudioPlayer play];
                    self.view.userInteractionEnabled = NO;
                    [self performSelector:@selector(winMusicStop) withObject:nil afterDelay:1];
                    
                }
                
                if (rightans==5)
                {
                    [self zoomObject:1];
                    [audioPlayerClap play];
                    self.view.userInteractionEnabled = NO;
                    self.view.alpha = .8;
                    timerForWinningStage = [NSTimer scheduledTimerWithTimeInterval:3 target:self selector:@selector(cheersBeforeShowingNextQuestion) userInfo:nil repeats:NO];
                    
                    timerStopValue = 1;
                    star1.alpha = 1.0;
                }
                if (rightans==10)
                {
                    [self zoomObject:2];
                    [audioPlayerClap play];
                    self.view.userInteractionEnabled = NO;
                    self.view.alpha = .8;
                    timerForWinningStage = [NSTimer scheduledTimerWithTimeInterval:3 target:self selector:@selector(cheersBeforeShowingNextQuestion) userInfo:nil repeats:NO];
                    timerStopValue = 1;
                    star2.alpha = 1.0;
                }
                if (rightans==15)
                {
                    [self zoomObject:3];
                    [audioPlayerClap play];
                    self.view.userInteractionEnabled = NO;
                    self.view.alpha = .8;
                    timerForWinningStage = [NSTimer scheduledTimerWithTimeInterval:3 target:self selector:@selector(cheersBeforeShowingNextQuestion) userInfo:nil repeats:NO];
                    timerStopValue = 1;
                    star3.alpha = 1.0;
                }
                if (rightans==20)
                {
                    [self zoomObject:4];
                    [audioPlayerClap play];
                    self.view.userInteractionEnabled = NO;
                    self.view.alpha = .8;
                    timerForWinningStage = [NSTimer scheduledTimerWithTimeInterval:3 target:self selector:@selector(cheersBeforeShowingNextQuestion) userInfo:nil repeats:NO];
                    timerStopValue = 1;
                    star4.alpha = 1.0;
                }
                if (rightans==25)
                {
                    [self zoomObject:5];
                    [audioPlayerClap play];
                    self.view.userInteractionEnabled = NO;
                    self.view.alpha = .8;
                    timerForWinningStage = [NSTimer scheduledTimerWithTimeInterval:3 target:self selector:@selector(cheersBeforeShowingNextQuestion) userInfo:nil repeats:NO];
                    timerStopValue = 1;
                    [congratsLabelForFiveStars setHidden:NO];
                    star5.alpha = 1.0;
                }
                numberOfCorrectAnsLabel.text = [NSString stringWithFormat:@"%d",rightans];
                
                [UIView beginAnimations:nil context:NULL];
                [UIView setAnimationDuration:1];
                [UIView setAnimationDelegate:self];
                [UIView setAnimationDidStopSelector:@selector(zoomOut:)];
                CGAffineTransform transform = CGAffineTransformMakeScale(2.5f, 2.5f);
                rightAns.transform = transform;
                [UIView commitAnimations];
            }
            else
            {
                NSLog(@"wrong");
                wrongans++;
                
                [wrongAudioPlayer play];
                self.view.userInteractionEnabled = NO;
                [self performSelector:@selector(wrongMusicStop) withObject:nil afterDelay:1];
                
                 numberOfInCorrectAnsLabel.text = [NSString stringWithFormat:@"%d",wrongans];
                
                [UIView beginAnimations:nil context:NULL];
                [UIView setAnimationDuration:1];
                [UIView setAnimationDelegate:self];
                [UIView setAnimationDidStopSelector:@selector(zoomOut:)];
                CGAffineTransform transform = CGAffineTransformMakeScale(2.5f, 2.5f);
                wrongAns.transform = transform;
                [UIView commitAnimations];
            }
        }
        else
        {
            if (leftcounterobjects>rightcounterobjects)
            {
                rightans++;
                NSLog(@"correct");
                
                if (!(rightans==5 || rightans==10||rightans==15||rightans==20||rightans==25))
                {
                    [winAudioPlayer play];
                    self.view.userInteractionEnabled = NO;
                    [self performSelector:@selector(winMusicStop) withObject:nil afterDelay:1];
                }
                
                
                if (rightans==5)
                {
                    [self zoomObject:1];
                    [audioPlayerClap play];
                    self.view.userInteractionEnabled = NO;
                    self.view.alpha = .8;
                    timerForWinningStage = [NSTimer scheduledTimerWithTimeInterval:3 target:self selector:@selector(cheersBeforeShowingNextQuestion) userInfo:nil repeats:NO];
                    timerStopValue = 1;
                    star1.alpha = 1.0;
                }
                if (rightans==10)
                {
                    [self zoomObject:2];
                    [audioPlayerClap play];
                    self.view.userInteractionEnabled = NO;
                    self.view.alpha = .8;
                    timerForWinningStage = [NSTimer scheduledTimerWithTimeInterval:3 target:self selector:@selector(cheersBeforeShowingNextQuestion) userInfo:nil repeats:NO];
                    timerStopValue = 1;
                    star2.alpha = 1.0;
                }
                if (rightans==15)
                {
                    [self zoomObject:3];
                    [audioPlayerClap play];
                    self.view.userInteractionEnabled = NO;
                    self.view.alpha = .8;
                    timerForWinningStage = [NSTimer scheduledTimerWithTimeInterval:3 target:self selector:@selector(cheersBeforeShowingNextQuestion) userInfo:nil repeats:NO];
                    timerStopValue = 1;
                    star3.alpha = 1.0;
                }
                if (rightans==20)
                {
                    [self zoomObject:4];
                    [audioPlayerClap play];
                    self.view.userInteractionEnabled = NO;
                    self.view.alpha = .8;
                    timerForWinningStage = [NSTimer scheduledTimerWithTimeInterval:3 target:self selector:@selector(cheersBeforeShowingNextQuestion) userInfo:nil repeats:NO];
                    timerStopValue = 1;
                    star4.alpha = 1.0;
                }
                if (rightans==25)
                {
                    [self zoomObject:5];
                    [audioPlayerClap play];
                    self.view.userInteractionEnabled = NO;
                    self.view.alpha = .8;
                    timerForWinningStage = [NSTimer scheduledTimerWithTimeInterval:3 target:self selector:@selector(cheersBeforeShowingNextQuestion) userInfo:nil repeats:NO];
                    timerStopValue = 1;
                    star5.alpha = 1.0;
                    [congratsLabelForFiveStars setHidden:NO];
                }
                numberOfCorrectAnsLabel.text = [NSString stringWithFormat:@"%d",rightans];
                
                [UIView beginAnimations:nil context:NULL];
                [UIView setAnimationDuration:1];
                [UIView setAnimationDelegate:self];
                [UIView setAnimationDidStopSelector:@selector(zoomOut:)];
                CGAffineTransform transform = CGAffineTransformMakeScale(2.5f, 2.5f);
                rightAns.transform = transform;
                [UIView commitAnimations];
            }
            else
            {
                wrongans++;
                
                [wrongAudioPlayer play];
                self.view.userInteractionEnabled = NO;
                [self performSelector:@selector(wrongMusicStop) withObject:nil afterDelay:1];
                
                 numberOfInCorrectAnsLabel.text = [NSString stringWithFormat:@"%d",wrongans];
                
                [UIView beginAnimations:nil context:NULL];
                [UIView setAnimationDuration:1];
                [UIView setAnimationDelegate:self];
                [UIView setAnimationDidStopSelector:@selector(zoomOut:)];
                CGAffineTransform transform = CGAffineTransformMakeScale(2.5f, 2.5f);
                wrongAns.transform = transform;
                [UIView commitAnimations];
            }
        }
        
        totalattempts++;
    }
    else if (sender == equalBtn)
    {
        if (leftNumberLbl.isHidden==NO)
        {
            if ([leftNumberLbl.text intValue]==[rightNumberLbl.text intValue])
            {
                rightans++;
                NSLog(@"correct");
                
                if (!(rightans==5 || rightans==10||rightans==15||rightans==20||rightans==25))
                {
                    [winAudioPlayer play];
                    self.view.userInteractionEnabled = NO;
                    [self performSelector:@selector(winMusicStop) withObject:nil afterDelay:1];
                }
                
                
                if (rightans==5)
                {
                    [self zoomObject:1];
                    [audioPlayerClap play];
                    self.view.userInteractionEnabled = NO;
                    self.view.alpha = .8;
                    timerForWinningStage = [NSTimer scheduledTimerWithTimeInterval:3 target:self selector:@selector(cheersBeforeShowingNextQuestion) userInfo:nil repeats:NO];
                    timerStopValue = 1;
                    star1.alpha = 1.0;
                }
                if (rightans==10)
                {
                    [self zoomObject:2];
                    [audioPlayerClap play];
                    self.view.userInteractionEnabled = NO;
                    self.view.alpha = .8;
                    timerForWinningStage = [NSTimer scheduledTimerWithTimeInterval:3 target:self selector:@selector(cheersBeforeShowingNextQuestion) userInfo:nil repeats:NO];
                    timerStopValue = 1;
                    star2.alpha = 1.0;
                }
                if (rightans==15)
                {
                    [self zoomObject:3];
                    [audioPlayerClap play];
                    self.view.userInteractionEnabled = NO;
                    self.view.alpha = .8;
                    timerForWinningStage = [NSTimer scheduledTimerWithTimeInterval:3 target:self selector:@selector(cheersBeforeShowingNextQuestion) userInfo:nil repeats:NO];
                    timerStopValue = 1;
                    star3.alpha = 1.0;
                }
                if (rightans==20)
                {
                    [self zoomObject:4];
                    [audioPlayerClap play];
                    self.view.userInteractionEnabled = NO;
                    self.view.alpha = .8;
                    timerForWinningStage = [NSTimer scheduledTimerWithTimeInterval:3 target:self selector:@selector(cheersBeforeShowingNextQuestion) userInfo:nil repeats:NO];
                    timerStopValue = 1;
                    star4.alpha = 1.0;
                }
                if (rightans==25)
                {
                    [self zoomObject:5];
                    [audioPlayerClap play];
                    self.view.userInteractionEnabled = NO;
                    self.view.alpha = .8;
                    timerForWinningStage = [NSTimer scheduledTimerWithTimeInterval:3 target:self selector:@selector(cheersBeforeShowingNextQuestion) userInfo:nil repeats:NO];
                    timerStopValue = 1;
                    star5.alpha = 1.0;
                    [congratsLabelForFiveStars setHidden:NO];
                }
                numberOfCorrectAnsLabel.text = [NSString stringWithFormat:@"%d",rightans];
                
                [UIView beginAnimations:nil context:NULL];
                [UIView setAnimationDuration:1];
                [UIView setAnimationDelegate:self];
                [UIView setAnimationDidStopSelector:@selector(zoomOut:)];
                CGAffineTransform transform = CGAffineTransformMakeScale(2.5f, 2.5f);
                rightAns.transform = transform;
                [UIView commitAnimations];
            }
            else
            {
                NSLog(@"wrong");
                wrongans++;
                
                [wrongAudioPlayer play];
                self.view.userInteractionEnabled = NO;
                [self performSelector:@selector(wrongMusicStop) withObject:nil afterDelay:1];
                
                 numberOfInCorrectAnsLabel.text = [NSString stringWithFormat:@"%d",wrongans];
                
                [UIView beginAnimations:nil context:NULL];
                [UIView setAnimationDuration:1];
                [UIView setAnimationDelegate:self];
                [UIView setAnimationDidStopSelector:@selector(zoomOut:)];
                CGAffineTransform transform = CGAffineTransformMakeScale(2.5f, 2.5f);
                wrongAns.transform = transform;
                [UIView commitAnimations];
            }
        }
        else
        {
            if (leftcounterobjects==rightcounterobjects)
            {
                rightans++;
                NSLog(@"correct");
                
                if (!(rightans==5 || rightans==10||rightans==15||rightans==20||rightans==25))
                {
                    [winAudioPlayer play];
                    self.view.userInteractionEnabled = NO;
                    [self performSelector:@selector(winMusicStop) withObject:nil afterDelay:1];
                }
                if (rightans==5)
                {
                    [self zoomObject:1];
                    [audioPlayerClap play];
                    self.view.userInteractionEnabled = NO;
                    self.view.alpha = .8;
                    timerForWinningStage = [NSTimer scheduledTimerWithTimeInterval:3 target:self selector:@selector(cheersBeforeShowingNextQuestion) userInfo:nil repeats:NO];
                    timerStopValue = 1;
                    star1.alpha = 1.0;
                }
                if (rightans==10)
                {
                    [self zoomObject:2];
                    [audioPlayerClap play];
                    self.view.userInteractionEnabled = NO;
                    self.view.alpha = .8;
                    timerForWinningStage = [NSTimer scheduledTimerWithTimeInterval:3 target:self selector:@selector(cheersBeforeShowingNextQuestion) userInfo:nil repeats:NO];
                    timerStopValue = 1;
                    star2.alpha = 1.0;
                }
                if (rightans==15)
                {
                    [self zoomObject:3];
                    [audioPlayerClap play];
                    self.view.userInteractionEnabled = NO;
                    self.view.alpha = .8;
                    timerForWinningStage = [NSTimer scheduledTimerWithTimeInterval:3 target:self selector:@selector(cheersBeforeShowingNextQuestion) userInfo:nil repeats:NO];
                    timerStopValue = 1;
                    star3.alpha = 1.0;
                }
                if (rightans==20)
                {
                    [self zoomObject:4];
                    [audioPlayerClap play];
                    self.view.userInteractionEnabled = NO;
                    self.view.alpha = .8;
                    timerForWinningStage = [NSTimer scheduledTimerWithTimeInterval:3 target:self selector:@selector(cheersBeforeShowingNextQuestion) userInfo:nil repeats:NO];
                    timerStopValue = 1;
                    star4.alpha = 1.0;
                }
                if (rightans==25)
                {
                    [self zoomObject:5];
                    [audioPlayerClap play];
                    self.view.userInteractionEnabled = NO;
                    self.view.alpha = .8;
                    timerForWinningStage = [NSTimer scheduledTimerWithTimeInterval:3 target:self selector:@selector(cheersBeforeShowingNextQuestion) userInfo:nil repeats:NO];
                    timerStopValue = 1;
                    star5.alpha = 1.0;
                    [congratsLabelForFiveStars setHidden:NO];
                }
                numberOfCorrectAnsLabel.text = [NSString stringWithFormat:@"%d",rightans];
                
                [UIView beginAnimations:nil context:NULL];
                [UIView setAnimationDuration:1];
                [UIView setAnimationDelegate:self];
                [UIView setAnimationDidStopSelector:@selector(zoomOut:)];
                CGAffineTransform transform = CGAffineTransformMakeScale(2.5f, 2.5f);
                rightAns.transform = transform;
                [UIView commitAnimations];
            }
            else
            {
                wrongans++;
                
                [wrongAudioPlayer play];
                self.view.userInteractionEnabled = NO;
                [self performSelector:@selector(wrongMusicStop) withObject:nil afterDelay:1];
                
                 numberOfInCorrectAnsLabel.text = [NSString stringWithFormat:@"%d",wrongans];
                
                [UIView beginAnimations:nil context:NULL];
                [UIView setAnimationDuration:1];
                [UIView setAnimationDelegate:self];
                [UIView setAnimationDidStopSelector:@selector(zoomOut:)];
                CGAffineTransform transform = CGAffineTransformMakeScale(2.5f, 2.5f);
                wrongAns.transform = transform;
                [UIView commitAnimations];
            }
        }
        
        totalattempts++;
    }
    else if (sender == lesserBtn)
    {
        if (leftNumberLbl.isHidden==NO)
        {
            if ([leftNumberLbl.text intValue]<[rightNumberLbl.text intValue])
            {
                rightans++;
                NSLog(@"correct");
                
                if (!(rightans==5 || rightans==10||rightans==15||rightans==20||rightans==25))
                {
                    [winAudioPlayer play];
                    self.view.userInteractionEnabled = NO;
                    [self performSelector:@selector(winMusicStop) withObject:nil afterDelay:1];
                }
                
                
                if (rightans==5)
                {
                    [self zoomObject:1];
                    [audioPlayerClap play];
                    self.view.userInteractionEnabled = NO;
                    self.view.alpha = .8;
                    timerForWinningStage = [NSTimer scheduledTimerWithTimeInterval:3 target:self selector:@selector(cheersBeforeShowingNextQuestion) userInfo:nil repeats:NO];
                    timerStopValue = 1;
                    star1.alpha = 1.0;
                }
                if (rightans==10)
                {
                    [self zoomObject:2];
                    [audioPlayerClap play];
                    self.view.userInteractionEnabled = NO;
                    self.view.alpha = .8;
                    timerForWinningStage = [NSTimer scheduledTimerWithTimeInterval:3 target:self selector:@selector(cheersBeforeShowingNextQuestion) userInfo:nil repeats:NO];
                    timerStopValue = 1;
                    star2.alpha = 1.0;
                }
                if (rightans==15)
                {
                    [self zoomObject:3];
                    [audioPlayerClap play];
                    self.view.userInteractionEnabled = NO;
                    self.view.alpha = .8;
                    timerForWinningStage = [NSTimer scheduledTimerWithTimeInterval:3 target:self selector:@selector(cheersBeforeShowingNextQuestion) userInfo:nil repeats:NO];
                    timerStopValue = 1;
                    star3.alpha = 1.0;
                }
                if (rightans==20)
                {
                    [self zoomObject:4];
                    [audioPlayerClap play];
                    self.view.userInteractionEnabled = NO;
                    self.view.alpha = .8;
                    timerForWinningStage = [NSTimer scheduledTimerWithTimeInterval:3 target:self selector:@selector(cheersBeforeShowingNextQuestion) userInfo:nil repeats:NO];
                    timerStopValue = 1;
                    star4.alpha = 1.0;
                }
                if (rightans==25)
                {
                    [self zoomObject:5];
                    [audioPlayerClap play];
                    self.view.userInteractionEnabled = NO;
                    self.view.alpha = .8;
                    timerForWinningStage = [NSTimer scheduledTimerWithTimeInterval:3 target:self selector:@selector(cheersBeforeShowingNextQuestion) userInfo:nil repeats:NO];
                    timerStopValue = 1;
                    star5.alpha = 1.0;
                    [congratsLabelForFiveStars setHidden:NO];
                }
                numberOfCorrectAnsLabel.text = [NSString stringWithFormat:@"%d",rightans];
                
                [UIView beginAnimations:nil context:NULL];
                [UIView setAnimationDuration:1];
                [UIView setAnimationDelegate:self];
                [UIView setAnimationDidStopSelector:@selector(zoomOut:)];
                CGAffineTransform transform = CGAffineTransformMakeScale(2.5f, 2.5f);
                rightAns.transform = transform;
                [UIView commitAnimations];
            }
            else
            {
                NSLog(@"wrong");
                wrongans++;
                
                [wrongAudioPlayer play];
                self.view.userInteractionEnabled = NO;
                [self performSelector:@selector(wrongMusicStop) withObject:nil afterDelay:1];
                
                 numberOfInCorrectAnsLabel.text = [NSString stringWithFormat:@"%d",wrongans];
                
                [UIView beginAnimations:nil context:NULL];
                [UIView setAnimationDuration:1];
                [UIView setAnimationDelegate:self];
                [UIView setAnimationDidStopSelector:@selector(zoomOut:)];
                CGAffineTransform transform = CGAffineTransformMakeScale(2.5f, 2.5f);
                wrongAns.transform = transform;
                [UIView commitAnimations];
            }
        }
        else
        {
            if (leftcounterobjects<rightcounterobjects)
            {
                rightans++;
                NSLog(@"correct");
                
                if (!(rightans==5 || rightans==10||rightans==15||rightans==20||rightans==25))
                {
                    [winAudioPlayer play];
                    self.view.userInteractionEnabled = NO;
                    [self performSelector:@selector(winMusicStop) withObject:nil afterDelay:1];
                }
                
                
                if (rightans==5)
                {
                    [self zoomObject:1];
                    [audioPlayerClap play];
                    self.view.userInteractionEnabled = NO;
                    self.view.alpha = .8;
                    timerForWinningStage = [NSTimer scheduledTimerWithTimeInterval:3 target:self selector:@selector(cheersBeforeShowingNextQuestion) userInfo:nil repeats:NO];
                    timerStopValue = 1;
                    star1.alpha = 1.0;
                }
                if (rightans==10)
                {
                    [self zoomObject:2];
                    [audioPlayerClap play];
                    self.view.userInteractionEnabled = NO;
                    self.view.alpha = .8;
                    timerForWinningStage = [NSTimer scheduledTimerWithTimeInterval:3 target:self selector:@selector(cheersBeforeShowingNextQuestion) userInfo:nil repeats:NO];
                    timerStopValue = 1;
                    star2.alpha = 1.0;
                }
                if (rightans==15)
                {
                    [self zoomObject:3];
                    [audioPlayerClap play];
                    self.view.userInteractionEnabled = NO;
                    self.view.alpha = .8;
                    timerForWinningStage = [NSTimer scheduledTimerWithTimeInterval:3 target:self selector:@selector(cheersBeforeShowingNextQuestion) userInfo:nil repeats:NO];
                    timerStopValue = 1;
                    star3.alpha = 1.0;
                }
                if (rightans==20)
                {
                    [self zoomObject:4];
                    [audioPlayerClap play];
                    self.view.userInteractionEnabled = NO;
                    self.view.alpha = .8;
                    timerForWinningStage = [NSTimer scheduledTimerWithTimeInterval:3 target:self selector:@selector(cheersBeforeShowingNextQuestion) userInfo:nil repeats:NO];
                    timerStopValue = 1;
                    star4.alpha = 1.0;
                }
                if (rightans==25)
                {
                    [self zoomObject:5];
                    [audioPlayerClap play];
                    self.view.userInteractionEnabled = NO;
                    self.view.alpha = .8;
                    timerForWinningStage = [NSTimer scheduledTimerWithTimeInterval:3 target:self selector:@selector(cheersBeforeShowingNextQuestion) userInfo:nil repeats:NO];
                    timerStopValue = 1;
                    star5.alpha = 1.0;
                    [congratsLabelForFiveStars setHidden:NO];
                }
                numberOfCorrectAnsLabel.text = [NSString stringWithFormat:@"%d",rightans];
                
                [UIView beginAnimations:nil context:NULL];
                [UIView setAnimationDuration:1];
                [UIView setAnimationDelegate:self];
                [UIView setAnimationDidStopSelector:@selector(zoomOut:)];
                CGAffineTransform transform = CGAffineTransformMakeScale(2.5f, 2.5f);
                rightAns.transform = transform;
                [UIView commitAnimations];
            }
            else
            {
                wrongans++;
                self.view.userInteractionEnabled = NO;
                 numberOfInCorrectAnsLabel.text = [NSString stringWithFormat:@"%d",wrongans];
                
                [UIView beginAnimations:nil context:NULL];
                [UIView setAnimationDuration:1];
                [UIView setAnimationDelegate:self];
                [UIView setAnimationDidStopSelector:@selector(zoomOut:)];
                CGAffineTransform transform = CGAffineTransformMakeScale(2.5f, 2.5f);
                wrongAns.transform = transform;
                [UIView commitAnimations];
            }
        }
        
    }

}

-(void)buttonClicked:(id)sender
{
    if (sender==objectBtn)
    {
        [objectBtn setBackgroundColor:[UIColor colorWithRed:30/255.0 green:144/255.0 blue:255/255.0 alpha:1.0]];
        [numberBtn setBackgroundColor:[UIColor colorWithRed:106/255.0 green:90/255.0 blue:205/255.0 alpha:1.0]];
        objectBtn.userInteractionEnabled = NO;
        numberBtn.layer.shadowColor = [UIColor clearColor].CGColor;
        [numberBtn setSelected:NO];
        numberBtn.userInteractionEnabled = YES;
        objectBtn.layer.shadowColor = [UIColor whiteColor].CGColor;
        [objectBtn setSelected:YES];
        objectBtn.layer.shadowOpacity = 0.8;
        objectBtn.layer.shadowRadius = 12;
        objectBtn.layer.shadowOffset = CGSizeMake(12.0f, 12.0f);
        
        
        star1.alpha = .3;
        star2.alpha = .3;
        star3.alpha = .3;
        star4.alpha = .3;
        star5.alpha = .3;
        [congratsLabelForFiveStars setHidden:YES];
        [leftNumberLbl setHidden:YES];
        [rightNumberLbl setHidden:YES];
        totalattempts =0 ;
        rightans = 0;
        wrongans = 0;
        totalAttempts.text =[NSString stringWithFormat:@"TOTAL ATTEMPTS : %d",totalattempts];
        rightAns.text = [NSString stringWithFormat:@"RIGHT ANS : %d",rightans];
        wrongAns.text = [NSString stringWithFormat:@"WRONG ANS : %d",wrongans];
        percentCompleted.text = @"PERCENTAGE CORRECT :";
        
        
        [self makeObjects];
        [self makeObjectsHidden];
        [self startObjectGame];
        
    }
    else if (sender==numberBtn)
    {
        [numberBtn setBackgroundColor:[UIColor colorWithRed:30/255.0 green:144/255.0 blue:255/255.0 alpha:1.0]];
        [objectBtn setBackgroundColor:[UIColor colorWithRed:106/255.0 green:90/255.0 blue:205/255.0 alpha:1.0]];
        [leftNumberLbl setHidden:NO];
        [rightNumberLbl setHidden:NO];
        numberBtn.userInteractionEnabled = NO;
        objectBtn.layer.shadowColor = [UIColor clearColor].CGColor;
        [objectBtn setSelected:NO];
        objectBtn.userInteractionEnabled = YES;
        numberBtn.layer.shadowColor = [UIColor whiteColor].CGColor;
        [numberBtn setSelected:YES];
        numberBtn.layer.shadowOpacity = 0.8;
        numberBtn.layer.shadowRadius = 12;
        numberBtn.layer.shadowOffset = CGSizeMake(12.0f, 12.0f);
        
        star1.alpha = .3;
        star2.alpha = .3;
        star3.alpha = .3;
        star4.alpha = .3;
        star5.alpha = .3;
        totalattempts =0 ;
        rightans = 0;
        wrongans = 0;
        totalAttempts.text =[NSString stringWithFormat:@"TOTAL ATTEMPTS : %d",totalattempts];
        rightAns.text = [NSString stringWithFormat:@"RIGHT ANS : %d",rightans];
        wrongAns.text = [NSString stringWithFormat:@"WRONG ANS : %d",wrongans];
        percentCompleted.text = @"PERCENTAGE CORRECT :";
        
        [objectViewLeft removeFromSuperview];
        [objectViewRight removeFromSuperview];
    }
    else if (sender == nextLevelBtn)
    {
        totalattempts =0 ;
        rightans = 0;
        wrongans = 0;
        totalAttempts.text =[NSString stringWithFormat:@"TOTAL ATTEMPTS : %d",totalattempts];
        rightAns.text = [NSString stringWithFormat:@"RIGHT ANS : %d",rightans];
        wrongAns.text = [NSString stringWithFormat:@"WRONG ANS : %d",wrongans];
        percentCompleted.text = @"PERCENTAGE CORRECT :";
        
        if ([[dic objectForKey:@"level"]isEqualToString:@"EASY"])
        {
            [dic setObject:@"MEDIUM" forKey:@"level"];
            levelString = @"MEDIUM";
            if (leftNumberLbl.isHidden==NO)
            {
                [self startGame];
            }
            else
            {
                [self makeObjectsHidden];
                [self startObjectGame];
            }
            
        }
        else if ([[dic objectForKey:@"level"]isEqualToString:@"MEDIUM"])
        {
            [dic setObject:@"HARD" forKey:@"level"];
            levelString = @"HARD";
            [nextLevelBtn removeFromSuperview];
            [nextLevelLabel removeFromSuperview];
            if (leftNumberLbl.isHidden==NO)
            {
                [self startGame];
            }
            else
            {
                [self makeObjectsHidden];
                [self startObjectGame];
            }
        }
        
        
    }
    
}

-(void)startObjectGame
{
    if (ishighclass==YES)
    {
        // class 2
        if ([levelString isEqualToString:@"EASY"])
        {
            objectsatleft = [self getRandomNumber:6 to:12];
            objectsatright = [self getRandomNumber:6 to:12];
        }
        else if ([levelString isEqualToString:@"MEDIUM"])
        {
            objectsatleft = [self getRandomNumber:12 to:15];
            objectsatright = [self getRandomNumber:12 to:15];
        }
        else
        {
            objectsatleft = [self getRandomNumber:14 to:18];
            objectsatright = [self getRandomNumber:14 to:18];
        }
    }
    else
    {
        // class 1
        if ([levelString isEqualToString:@"EASY"])
        {
            objectsatleft = [self getRandomNumber:1 to:9];
            objectsatright = [self getRandomNumber:1 to:9];
        }
        else if ([levelString isEqualToString:@"MEDIUM"])
        {
            objectsatleft = [self getRandomNumber:6 to:12];
            objectsatright = [self getRandomNumber:6 to:12];
        }
        else
        {
            objectsatleft = [self getRandomNumber:7 to:18];
            objectsatright = [self getRandomNumber:7 to:18];
        }
    }
    
    switch (objectsatleft)
    {
        case 1:
            [leftLabel1 setHidden:NO];
            leftcounterobjects = 1;
            break;
        case 2:
            [leftLabel1 setHidden:NO];
            [leftLabel7 setHidden:NO];
            leftcounterobjects = 2;
            break;
        case 3:
            [leftLabel3 setHidden:NO];
            [leftLabel7 setHidden:NO];
            [leftLabel13 setHidden:NO];
            leftcounterobjects = 3;
            break;
        case 4:
            [leftLabel1 setHidden:NO];
            [leftLabel12 setHidden:NO];
            [leftLabel13 setHidden:NO];
            [leftLabel18 setHidden:NO];
            leftcounterobjects = 4;
            break;
        case 5:
            [leftLabel1 setHidden:NO];
            [leftLabel7 setHidden:NO];
            [leftLabel9 setHidden:NO];
            [leftLabel14 setHidden:NO];
            [leftLabel18 setHidden:NO];
            leftcounterobjects = 5;
            break;
        case 6:
            [leftLabel1 setHidden:NO];
            [leftLabel5 setHidden:NO];
            [leftLabel9 setHidden:NO];
            [leftLabel12 setHidden:NO];
            [leftLabel15 setHidden:NO];
            [leftLabel16 setHidden:NO];
            leftcounterobjects = 6;
            break;
        case 7:
            [leftLabel2 setHidden:NO];
            [leftLabel5 setHidden:NO];
            [leftLabel7 setHidden:NO];
            [leftLabel8 setHidden:NO];
            [leftLabel9 setHidden:NO];
            [leftLabel11 setHidden:NO];
            [leftLabel17 setHidden:NO];
            leftcounterobjects = 7;
            break;
        case 8:
            [leftLabel3 setHidden:NO];
            [leftLabel4 setHidden:NO];
            [leftLabel5 setHidden:NO];
            [leftLabel14 setHidden:NO];
            [leftLabel15 setHidden:NO];
            [leftLabel16 setHidden:NO];
            [leftLabel9 setHidden:NO];
            [leftLabel18 setHidden:NO];
            leftcounterobjects = 8;
            break;
        case 9:
            [leftLabel3 setHidden:NO];
            [leftLabel4 setHidden:NO];
            [leftLabel5 setHidden:NO];
            [leftLabel14 setHidden:NO];
            [leftLabel15 setHidden:NO];
            [leftLabel16 setHidden:NO];
            [leftLabel18 setHidden:NO];
            [leftLabel8 setHidden:NO];
            [leftLabel9 setHidden:NO];
            leftcounterobjects = 9;
            break;
        case 10:
            [leftLabel1 setHidden:NO];
            [leftLabel9 setHidden:NO];
            [leftLabel3 setHidden:NO];
            [leftLabel4 setHidden:NO];
            [leftLabel5 setHidden:NO];
            [leftLabel6 setHidden:NO];
            [leftLabel10 setHidden:NO];
            [leftLabel12 setHidden:NO];
            [leftLabel17 setHidden:NO];
            [leftLabel18 setHidden:NO];
            leftcounterobjects = 10;
            break;
        case 11:
            [leftLabel1 setHidden:NO];
            [leftLabel2 setHidden:NO];
            [leftLabel3 setHidden:NO];
            [leftLabel4 setHidden:NO];
            [leftLabel5 setHidden:NO];
            [leftLabel8 setHidden:NO];
            [leftLabel9 setHidden:NO];
            [leftLabel12 setHidden:NO];
            [leftLabel16 setHidden:NO];
            [leftLabel17 setHidden:NO];
            [leftLabel18 setHidden:NO];
            leftcounterobjects = 11;
            break;
        case 12:
            [leftLabel1 setHidden:NO];
            [leftLabel2 setHidden:NO];
            [leftLabel3 setHidden:NO];
            [leftLabel4 setHidden:NO];
            [leftLabel5 setHidden:NO];
            [leftLabel8 setHidden:NO];
            [leftLabel9 setHidden:NO];
            [leftLabel12 setHidden:NO];
            [leftLabel16 setHidden:NO];
            [leftLabel17 setHidden:NO];
            [leftLabel18 setHidden:NO];
            [leftLabel10 setHidden:NO];
            leftcounterobjects = 12;
            break;
        case 13:
            [leftLabel1 setHidden:NO];
            [leftLabel2 setHidden:NO];
            [leftLabel3 setHidden:NO];
            [leftLabel4 setHidden:NO];
            [leftLabel5 setHidden:NO];
            [leftLabel13 setHidden:NO];
            [leftLabel7 setHidden:NO];
            [leftLabel8 setHidden:NO];
            [leftLabel11 setHidden:NO];
            [leftLabel10 setHidden:NO];
            [leftLabel16 setHidden:NO];
            [leftLabel17 setHidden:NO];
            [leftLabel18 setHidden:NO];
            leftcounterobjects = 13;
            break;
        case 14:
            [leftLabel1 setHidden:NO];
            [leftLabel2 setHidden:NO];
            [leftLabel3 setHidden:NO];
            [leftLabel4 setHidden:NO];
            [leftLabel5 setHidden:NO];
            [leftLabel13 setHidden:NO];
            [leftLabel7 setHidden:NO];
            [leftLabel8 setHidden:NO];
            [leftLabel9 setHidden:NO];
            [leftLabel10 setHidden:NO];
            [leftLabel11 setHidden:NO];
            [leftLabel15 setHidden:NO];
            [leftLabel16 setHidden:NO];
            [leftLabel17 setHidden:NO];
            leftcounterobjects = 14;
            break;
        case 15:
            [leftLabel1 setHidden:NO];
            [leftLabel2 setHidden:NO];
            [leftLabel3 setHidden:NO];
            [leftLabel4 setHidden:NO];
            [leftLabel5 setHidden:NO];
            [leftLabel6 setHidden:NO];
            [leftLabel7 setHidden:NO];
            [leftLabel13 setHidden:NO];
            [leftLabel9 setHidden:NO];
            [leftLabel10 setHidden:NO];
            [leftLabel11 setHidden:NO];
            [leftLabel12 setHidden:NO];
            [leftLabel16 setHidden:NO];
            [leftLabel17 setHidden:NO];
            [leftLabel18 setHidden:NO];
            leftcounterobjects = 15;
            break;
        case 16:
            [leftLabel1 setHidden:NO];
            [leftLabel2 setHidden:NO];
            [leftLabel3 setHidden:NO];
            [leftLabel4 setHidden:NO];
            [leftLabel5 setHidden:NO];
            [leftLabel6 setHidden:NO];
            [leftLabel7 setHidden:NO];
            [leftLabel17 setHidden:NO];
            [leftLabel9 setHidden:NO];
            [leftLabel10 setHidden:NO];
            [leftLabel11 setHidden:NO];
            [leftLabel12 setHidden:NO];
            [leftLabel13 setHidden:NO];
            [leftLabel14 setHidden:NO];
            [leftLabel15 setHidden:NO];
            [leftLabel18 setHidden:NO];
            leftcounterobjects = 16;
            break;
        case 17:
            [leftLabel1 setHidden:NO];
            [leftLabel2 setHidden:NO];
            [leftLabel3 setHidden:NO];
            [leftLabel4 setHidden:NO];
            [leftLabel5 setHidden:NO];
            [leftLabel6 setHidden:NO];
            [leftLabel7 setHidden:NO];
            [leftLabel8 setHidden:NO];
            [leftLabel18 setHidden:NO];
            [leftLabel10 setHidden:NO];
            [leftLabel11 setHidden:NO];
            [leftLabel12 setHidden:NO];
            [leftLabel13 setHidden:NO];
            [leftLabel14 setHidden:NO];
            [leftLabel15 setHidden:NO];
            [leftLabel16 setHidden:NO];
            [leftLabel17 setHidden:NO];
            leftcounterobjects = 17;
            break;
        case 18:
            [leftLabel1 setHidden:NO];
            [leftLabel2 setHidden:NO];
            [leftLabel3 setHidden:NO];
            [leftLabel4 setHidden:NO];
            [leftLabel5 setHidden:NO];
            [leftLabel6 setHidden:NO];
            [leftLabel7 setHidden:NO];
            [leftLabel8 setHidden:NO];
            [leftLabel9 setHidden:NO];
            [leftLabel10 setHidden:NO];
            [leftLabel11 setHidden:NO];
            [leftLabel12 setHidden:NO];
            [leftLabel13 setHidden:NO];
            [leftLabel14 setHidden:NO];
            [leftLabel15 setHidden:NO];
            [leftLabel16 setHidden:NO];
            [leftLabel17 setHidden:NO];
            [leftLabel18 setHidden:NO];
            leftcounterobjects = 18;
            break;
            
        default:
            break;
    }
    
    switch (objectsatright)
    {
        case 1:
            [rightLabel1 setHidden:NO];
            rightcounterobjects = 1;
            break;
        case 2:
            [rightLabel1 setHidden:NO];
            [rightLabel18 setHidden:NO];
            rightcounterobjects = 2;
            break;
        case 3:
            [rightLabel8 setHidden:NO];
            [rightLabel2 setHidden:NO];
            [rightLabel17 setHidden:NO];
            rightcounterobjects = 3;
            break;
        case 4:
            [rightLabel1 setHidden:NO];
            [rightLabel4 setHidden:NO];
            [rightLabel17 setHidden:NO];
            [rightLabel18 setHidden:NO];
            rightcounterobjects = 4;
            break;
        case 5:
            [rightLabel1 setHidden:NO];
            [rightLabel3 setHidden:NO];
            [rightLabel6 setHidden:NO];
            [rightLabel14 setHidden:NO];
            [rightLabel15 setHidden:NO];
            rightcounterobjects = 5;
            break;
        case 6:
            [rightLabel1 setHidden:NO];
            [rightLabel3 setHidden:NO];
            [rightLabel8 setHidden:NO];
            [rightLabel13 setHidden:NO];
            [rightLabel17 setHidden:NO];
            [rightLabel18 setHidden:NO];
            rightcounterobjects = 6;
            break;
        case 7:
            [rightLabel1 setHidden:NO];
            [rightLabel2 setHidden:NO];
            [rightLabel5 setHidden:NO];
            [rightLabel8 setHidden:NO];
            [rightLabel9 setHidden:NO];
            [rightLabel17 setHidden:NO];
            [rightLabel18 setHidden:NO];
            rightcounterobjects = 7;
            break;
        case 8:
            [rightLabel1 setHidden:NO];
            [rightLabel2 setHidden:NO];
            [rightLabel5 setHidden:NO];
            [rightLabel6 setHidden:NO];
            [rightLabel9 setHidden:NO];
            [rightLabel16 setHidden:NO];
            [rightLabel17 setHidden:NO];
            [rightLabel18 setHidden:NO];
            rightcounterobjects = 8;
            break;
        case 9:
            [rightLabel11 setHidden:NO];
            [rightLabel2 setHidden:NO];
            [rightLabel3 setHidden:NO];
            [rightLabel7 setHidden:NO];
            [rightLabel15 setHidden:NO];
            [rightLabel12 setHidden:NO];
            [rightLabel17 setHidden:NO];
            [rightLabel18 setHidden:NO];
            [rightLabel9 setHidden:NO];
            rightcounterobjects = 9;
            break;
        case 10:
            [rightLabel1 setHidden:NO];
            [rightLabel2 setHidden:NO];
            [rightLabel18 setHidden:NO];
            [rightLabel17 setHidden:NO];
            [rightLabel15 setHidden:NO];
            [rightLabel6 setHidden:NO];
            [rightLabel7 setHidden:NO];
            [rightLabel8 setHidden:NO];
            [rightLabel12 setHidden:NO];
            [rightLabel10 setHidden:NO];
            rightcounterobjects = 10;
            break;
        case 11:
            [rightLabel1 setHidden:NO];
            [rightLabel2 setHidden:NO];
            [rightLabel3 setHidden:NO];
            [rightLabel7 setHidden:NO];
            [rightLabel5 setHidden:NO];
            [rightLabel6 setHidden:NO];
            [rightLabel17 setHidden:NO];
            [rightLabel18 setHidden:NO];
            [rightLabel15 setHidden:NO];
            [rightLabel10 setHidden:NO];
            [rightLabel11 setHidden:NO];
            rightcounterobjects = 11;
            break;
        case 12:
            [rightLabel1 setHidden:NO];
            [rightLabel2 setHidden:NO];
            [rightLabel5 setHidden:NO];
            [rightLabel6 setHidden:NO];
            [rightLabel15 setHidden:NO];
            [rightLabel16 setHidden:NO];
            [rightLabel18 setHidden:NO];
            [rightLabel8 setHidden:NO];
            [rightLabel9 setHidden:NO];
            [rightLabel10 setHidden:NO];
            [rightLabel11 setHidden:NO];
            [rightLabel13 setHidden:NO];
            rightcounterobjects = 12;
            break;
        case 13:
            [rightLabel1 setHidden:NO];
            [rightLabel2 setHidden:NO];
            [rightLabel18 setHidden:NO];
            [rightLabel4 setHidden:NO];
            [rightLabel5 setHidden:NO];
            [rightLabel6 setHidden:NO];
            [rightLabel17 setHidden:NO];
            [rightLabel8 setHidden:NO];
            [rightLabel9 setHidden:NO];
            [rightLabel10 setHidden:NO];
            [rightLabel11 setHidden:NO];
            [rightLabel12 setHidden:NO];
            [rightLabel13 setHidden:NO];
            rightcounterobjects = 13;
            break;
        case 14:
            [rightLabel1 setHidden:NO];
            [rightLabel18 setHidden:NO];
            [rightLabel17 setHidden:NO];
            [rightLabel4 setHidden:NO];
            [rightLabel5 setHidden:NO];
            [rightLabel6 setHidden:NO];
            [rightLabel7 setHidden:NO];
            [rightLabel8 setHidden:NO];
            [rightLabel9 setHidden:NO];
            [rightLabel10 setHidden:NO];
            [rightLabel11 setHidden:NO];
            [rightLabel12 setHidden:NO];
            [rightLabel13 setHidden:NO];
            [rightLabel14 setHidden:NO];
            rightcounterobjects = 14;
            break;
        case 15:
            [rightLabel1 setHidden:NO];
            [rightLabel2 setHidden:NO];
            [rightLabel3 setHidden:NO];
            [rightLabel4 setHidden:NO];
            [rightLabel5 setHidden:NO];
            [rightLabel6 setHidden:NO];
            [rightLabel18 setHidden:NO];
            [rightLabel17 setHidden:NO];
            [rightLabel9 setHidden:NO];
            [rightLabel10 setHidden:NO];
            [rightLabel11 setHidden:NO];
            [rightLabel12 setHidden:NO];
            [rightLabel13 setHidden:NO];
            [rightLabel14 setHidden:NO];
            [rightLabel15 setHidden:NO];
            rightcounterobjects = 15;
            break;
        case 16:
            [rightLabel1 setHidden:NO];
            [rightLabel2 setHidden:NO];
            [rightLabel3 setHidden:NO];
            [rightLabel4 setHidden:NO];
            [rightLabel5 setHidden:NO];
            [rightLabel6 setHidden:NO];
            [rightLabel7 setHidden:NO];
            [rightLabel8 setHidden:NO];
            [rightLabel17 setHidden:NO];
            [rightLabel18 setHidden:NO];
            [rightLabel11 setHidden:NO];
            [rightLabel12 setHidden:NO];
            [rightLabel13 setHidden:NO];
            [rightLabel14 setHidden:NO];
            [rightLabel15 setHidden:NO];
            [rightLabel16 setHidden:NO];
            rightcounterobjects = 16;
            break;
        case 17:
            [rightLabel1 setHidden:NO];
            [rightLabel2 setHidden:NO];
            [rightLabel3 setHidden:NO];
            [rightLabel4 setHidden:NO];
            [rightLabel5 setHidden:NO];
            [rightLabel6 setHidden:NO];
            [rightLabel7 setHidden:NO];
            [rightLabel8 setHidden:NO];
            [rightLabel9 setHidden:NO];
            [rightLabel18 setHidden:NO];
            [rightLabel11 setHidden:NO];
            [rightLabel12 setHidden:NO];
            [rightLabel13 setHidden:NO];
            [rightLabel14 setHidden:NO];
            [rightLabel15 setHidden:NO];
            [rightLabel16 setHidden:NO];
            [rightLabel17 setHidden:NO];
            rightcounterobjects = 17;
            break;
        case 18:
            [rightLabel1 setHidden:NO];
            [rightLabel2 setHidden:NO];
            [rightLabel3 setHidden:NO];
            [rightLabel4 setHidden:NO];
            [rightLabel5 setHidden:NO];
            [rightLabel6 setHidden:NO];
            [rightLabel7 setHidden:NO];
            [rightLabel8 setHidden:NO];
            [rightLabel9 setHidden:NO];
            [rightLabel10 setHidden:NO];
            [rightLabel11 setHidden:NO];
            [rightLabel12 setHidden:NO];
            [rightLabel13 setHidden:NO];
            [rightLabel14 setHidden:NO];
            [rightLabel15 setHidden:NO];
            [rightLabel16 setHidden:NO];
            [rightLabel17 setHidden:NO];
            [rightLabel18 setHidden:NO];
            rightcounterobjects = 18;
            break;
            
        default:
            break;
    }
    
}

-(void)startGame
{
    if (ishighclass == YES)
    {
        // class 2
        if ([levelString isEqualToString:@"EASY"])
        {
            int left_no =[self getRandomNumber:10 to:30];
            leftNumberLbl.text = [NSString stringWithFormat:@"%d",left_no];
            int right_no = [self getRandomNumber:10 to:30];
            rightNumberLbl.text = [NSString stringWithFormat:@"%d",right_no];
        }
        else if ([levelString isEqualToString:@"MEDIUM"])
        {
            int left_no =[self getRandomNumber:25 to:85];
            leftNumberLbl.text = [NSString stringWithFormat:@"%d",left_no];
            int right_no = [self getRandomNumber:25 to:85];
            rightNumberLbl.text = [NSString stringWithFormat:@"%d",right_no];
        }
        else
        {
            int left_no =[self getRandomNumber:90 to:199];
            leftNumberLbl.text = [NSString stringWithFormat:@"%d",left_no];
            int right_no = [self getRandomNumber:90 to:199];
            rightNumberLbl.text = [NSString stringWithFormat:@"%d",right_no];
        }
    }
    else
    {
        // class 1
        if ([levelString isEqualToString:@"EASY"])
        {
            int left_no =[self getRandomNumber:0 to:9];
            leftNumberLbl.text = [NSString stringWithFormat:@"%d",left_no];
            int right_no = [self getRandomNumber:0 to:9];
            rightNumberLbl.text = [NSString stringWithFormat:@"%d",right_no];
        }
        else if ([levelString isEqualToString:@"MEDIUM"])
        {
            int left_no =[self getRandomNumber:10 to:30];
            leftNumberLbl.text = [NSString stringWithFormat:@"%d",left_no];
            int right_no = [self getRandomNumber:10 to:30];
            rightNumberLbl.text = [NSString stringWithFormat:@"%d",right_no];
        }
        else
        {
            int left_no =[self getRandomNumber:30 to:99];
            leftNumberLbl.text = [NSString stringWithFormat:@"%d",left_no];
            int right_no = [self getRandomNumber:30 to:99];
            rightNumberLbl.text = [NSString stringWithFormat:@"%d",right_no];
        }
    }
    
    
}

-(void)makeObjects
{
    objectViewLeft = [[UIView alloc]initWithFrame:CGRectMake(5, 470, 315, 340)];
    objectViewLeft.backgroundColor = [UIColor clearColor];
    [self.view addSubview:objectViewLeft];
    
    
    leftLabel1 = [[UILabel alloc]initWithFrame:CGRectMake(0, 40, 70, 30)];
    leftLabel1.backgroundColor = [UIColor greenColor];
    [objectViewLeft addSubview:leftLabel1];
    
    leftLabel2 = [[UILabel alloc]initWithFrame:CGRectMake(80, 40, 70, 30)];
    leftLabel2.backgroundColor = [UIColor greenColor];
    [objectViewLeft addSubview:leftLabel2];
    
    leftLabel3 = [[UILabel alloc]initWithFrame:CGRectMake(160, 40, 70, 30)];
    leftLabel3.backgroundColor = [UIColor greenColor];
    [objectViewLeft addSubview:leftLabel3];
    
    leftLabel4 = [[UILabel alloc]initWithFrame:CGRectMake(240, 40, 70, 30)];
    leftLabel4.backgroundColor = [UIColor greenColor];
    [objectViewLeft addSubview:leftLabel4];
   
    leftLabel5 = [[UILabel alloc]initWithFrame:CGRectMake(0, 90, 70, 30)];
    leftLabel5.backgroundColor = [UIColor greenColor];
    [objectViewLeft addSubview:leftLabel5];
   
    leftLabel6 = [[UILabel alloc]initWithFrame:CGRectMake(80, 90, 70, 30)];
    leftLabel6.backgroundColor = [UIColor greenColor];
    [objectViewLeft addSubview:leftLabel6];
  
    leftLabel7 = [[UILabel alloc]initWithFrame:CGRectMake(160, 90, 70, 30)];
    leftLabel7.backgroundColor = [UIColor greenColor];
    [objectViewLeft addSubview:leftLabel7];
    
    leftLabel8 = [[UILabel alloc]initWithFrame:CGRectMake(240, 90, 70, 30)];
    leftLabel8.backgroundColor = [UIColor greenColor];
    [objectViewLeft addSubview:leftLabel8];
    
    leftLabel9 = [[UILabel alloc]initWithFrame:CGRectMake(0, 140, 70, 30)];
    leftLabel9.backgroundColor = [UIColor greenColor];
    [objectViewLeft addSubview:leftLabel9];
   
    leftLabel10 = [[UILabel alloc]initWithFrame:CGRectMake(80, 140, 70, 30)];
    leftLabel10.backgroundColor = [UIColor greenColor];
    [objectViewLeft addSubview:leftLabel10];
    
    leftLabel11 = [[UILabel alloc]initWithFrame:CGRectMake(160, 140, 70, 30)];
    leftLabel11.backgroundColor = [UIColor greenColor];
    [objectViewLeft addSubview:leftLabel11];
   
    leftLabel12 = [[UILabel alloc]initWithFrame:CGRectMake(240, 140, 70, 30)];
    leftLabel12.backgroundColor = [UIColor greenColor];
    [objectViewLeft addSubview:leftLabel12];
  
    leftLabel13 = [[UILabel alloc]initWithFrame:CGRectMake(0, 190, 70, 30)];
    leftLabel13.backgroundColor = [UIColor greenColor];
    [objectViewLeft addSubview:leftLabel13];
   
    leftLabel14 = [[UILabel alloc]initWithFrame:CGRectMake(80, 190, 70, 30)];
    leftLabel14.backgroundColor = [UIColor greenColor];
    [objectViewLeft addSubview:leftLabel14];
    
    leftLabel15 = [[UILabel alloc]initWithFrame:CGRectMake(160, 190, 70, 30)];
    leftLabel15.backgroundColor = [UIColor greenColor];
    [objectViewLeft addSubview:leftLabel15];
    
    leftLabel16 = [[UILabel alloc]initWithFrame:CGRectMake(240, 190, 70, 30)];
    leftLabel16.backgroundColor = [UIColor greenColor];
    [objectViewLeft addSubview:leftLabel16];
  
    leftLabel17 = [[UILabel alloc]initWithFrame:CGRectMake(80, 240, 70, 30)];
    leftLabel17.backgroundColor = [UIColor greenColor];
    [objectViewLeft addSubview:leftLabel17];
 
    leftLabel18 = [[UILabel alloc]initWithFrame:CGRectMake(160, 240, 70, 30)];
    leftLabel18.backgroundColor = [UIColor greenColor];
    [objectViewLeft addSubview:leftLabel18];
   
    
    
    objectViewRight = [[UIView alloc]initWithFrame:CGRectMake(450, 470, 315, 340)];
    objectViewRight.backgroundColor = [UIColor clearColor];
    [self.view addSubview:objectViewRight];
 
    
    rightLabel1 = [[UILabel alloc]initWithFrame:CGRectMake(0, 40, 70, 30)];
    rightLabel1.backgroundColor = [UIColor colorWithRed:255/255.0 green:127/255.0 blue:80/255.0 alpha:1.0];
    [objectViewRight addSubview:rightLabel1];
  
    rightLabel2 = [[UILabel alloc]initWithFrame:CGRectMake(80, 40, 70, 30)];
    rightLabel2.backgroundColor = [UIColor colorWithRed:255/255.0 green:127/255.0 blue:80/255.0 alpha:1.0];
    [objectViewRight addSubview:rightLabel2];
   
    rightLabel3 = [[UILabel alloc]initWithFrame:CGRectMake(160, 40, 70, 30)];
    rightLabel3.backgroundColor = [UIColor colorWithRed:255/255.0 green:127/255.0 blue:80/255.0 alpha:1.0];
    [objectViewRight addSubview:rightLabel3];

    rightLabel4 = [[UILabel alloc]initWithFrame:CGRectMake(240, 40, 70, 30)];
    rightLabel4.backgroundColor = [UIColor colorWithRed:255/255.0 green:127/255.0 blue:80/255.0 alpha:1.0];
    [objectViewRight addSubview:rightLabel4];
 
    rightLabel5 = [[UILabel alloc]initWithFrame:CGRectMake(0, 90, 70, 30)];
    rightLabel5.backgroundColor = [UIColor colorWithRed:255/255.0 green:127/255.0 blue:80/255.0 alpha:1.0];
    [objectViewRight addSubview:rightLabel5];
  
    rightLabel6 = [[UILabel alloc]initWithFrame:CGRectMake(80, 90, 70, 30)];
    rightLabel6.backgroundColor = [UIColor colorWithRed:255/255.0 green:127/255.0 blue:80/255.0 alpha:1.0];
    [objectViewRight addSubview:rightLabel6];
   
    rightLabel7 = [[UILabel alloc]initWithFrame:CGRectMake(160, 90, 70, 30)];
    rightLabel7.backgroundColor = [UIColor colorWithRed:255/255.0 green:127/255.0 blue:80/255.0 alpha:1.0];
    [objectViewRight addSubview:rightLabel7];
   
    rightLabel8 = [[UILabel alloc]initWithFrame:CGRectMake(240, 90, 70, 30)];
    rightLabel8.backgroundColor = [UIColor colorWithRed:255/255.0 green:127/255.0 blue:80/255.0 alpha:1.0];
    [objectViewRight addSubview:rightLabel8];

    rightLabel9 = [[UILabel alloc]initWithFrame:CGRectMake(0, 140, 70, 30)];
    rightLabel9.backgroundColor = [UIColor colorWithRed:255/255.0 green:127/255.0 blue:80/255.0 alpha:1.0];
    [objectViewRight addSubview:rightLabel9];

    rightLabel10 = [[UILabel alloc]initWithFrame:CGRectMake(80, 140, 70, 30)];
    rightLabel10.backgroundColor = [UIColor colorWithRed:255/255.0 green:127/255.0 blue:80/255.0 alpha:1.0];
    [objectViewRight addSubview:rightLabel10];

    rightLabel11 = [[UILabel alloc]initWithFrame:CGRectMake(160, 140, 70, 30)];
    rightLabel11.backgroundColor = [UIColor colorWithRed:255/255.0 green:127/255.0 blue:80/255.0 alpha:1.0];
    [objectViewRight addSubview:rightLabel11];

    rightLabel12 = [[UILabel alloc]initWithFrame:CGRectMake(240, 140, 70, 30)];
    rightLabel12.backgroundColor = [UIColor colorWithRed:255/255.0 green:127/255.0 blue:80/255.0 alpha:1.0];
    [objectViewRight addSubview:rightLabel12];

    rightLabel13 = [[UILabel alloc]initWithFrame:CGRectMake(0, 190, 70, 30)];
    rightLabel13.backgroundColor = [UIColor colorWithRed:255/255.0 green:127/255.0 blue:80/255.0 alpha:1.0];
    [objectViewRight addSubview:rightLabel13];

    rightLabel14 = [[UILabel alloc]initWithFrame:CGRectMake(80, 190, 70, 30)];
    rightLabel14.backgroundColor = [UIColor colorWithRed:255/255.0 green:127/255.0 blue:80/255.0 alpha:1.0];
    [objectViewRight addSubview:rightLabel14];

    rightLabel15 = [[UILabel alloc]initWithFrame:CGRectMake(160, 190, 70, 30)];
    rightLabel15.backgroundColor = [UIColor colorWithRed:255/255.0 green:127/255.0 blue:80/255.0 alpha:1.0];
    [objectViewRight addSubview:rightLabel15];

    rightLabel16 = [[UILabel alloc]initWithFrame:CGRectMake(240, 190, 70, 30)];
    rightLabel16.backgroundColor = [UIColor colorWithRed:255/255.0 green:127/255.0 blue:80/255.0 alpha:1.0];
    [objectViewRight addSubview:rightLabel16];

    rightLabel17 = [[UILabel alloc]initWithFrame:CGRectMake(80, 240, 70, 30)];
    rightLabel17.backgroundColor = [UIColor colorWithRed:255/255.0 green:127/255.0 blue:80/255.0 alpha:1.0];
    [objectViewRight addSubview:rightLabel17];

    rightLabel18 = [[UILabel alloc]initWithFrame:CGRectMake(160, 240, 70, 30)];
    rightLabel18.backgroundColor = [UIColor colorWithRed:255/255.0 green:127/255.0 blue:80/255.0 alpha:1.0];
    [objectViewRight addSubview:rightLabel18];

    
    
    
}

-(void)makeObjectsHidden
{
    [leftLabel1 setHidden:YES];
    [leftLabel2 setHidden:YES];
    [leftLabel3 setHidden:YES];
    [leftLabel4 setHidden:YES];
    [leftLabel5 setHidden:YES];
    [leftLabel6 setHidden:YES];
    [leftLabel7 setHidden:YES];
    [leftLabel8 setHidden:YES];
    [leftLabel9 setHidden:YES];
    [leftLabel10 setHidden:YES];
    [leftLabel11 setHidden:YES];
    [leftLabel12 setHidden:YES];
    [leftLabel13 setHidden:YES];
    [leftLabel14 setHidden:YES];
    [leftLabel15 setHidden:YES];
    [leftLabel16 setHidden:YES];
    [leftLabel17 setHidden:YES];
    [leftLabel18 setHidden:YES];
    
    
    [rightLabel1 setHidden:YES];
    [rightLabel2 setHidden:YES];
    [rightLabel3 setHidden:YES];
    [rightLabel4 setHidden:YES];
    [rightLabel5 setHidden:YES];
    [rightLabel6 setHidden:YES];
    [rightLabel7 setHidden:YES];
    [rightLabel8 setHidden:YES];
    [rightLabel9 setHidden:YES];
    [rightLabel10 setHidden:YES];
    [rightLabel11 setHidden:YES];
    [rightLabel12 setHidden:YES];
    [rightLabel13 setHidden:YES];
    [rightLabel14 setHidden:YES];
    [rightLabel15 setHidden:YES];
    [rightLabel16 setHidden:YES];
    [rightLabel17 setHidden:YES];
    [rightLabel18 setHidden:YES];
}

-(void)zoomOut:(id)sender
{
    // UIImageView *image = sender;
	[UIView beginAnimations:nil context:NULL];
	[UIView setAnimationDuration:1];
	[UIView setAnimationDelegate:self];
	CGAffineTransform transform = CGAffineTransformMakeScale(1.0f, 1.0f);
	star1.transform = transform;
    star2.transform = transform;
    star3.transform = transform;
    star4.transform = transform;
    star5.transform = transform;
    rightAns.transform = transform;
    wrongAns.transform = transform;
	[UIView commitAnimations];
}

-(void)zoomObject:(int)_numberOfObjects
{
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationDuration:1];
    [UIView setAnimationDelegate:self];
    [UIView setAnimationDidStopSelector:@selector(zoomOut:)];
    CGAffineTransform transform = CGAffineTransformMakeScale(3.5f, 3.5f);
    star1.transform = transform;
    if (_numberOfObjects >1)
    {
        star2.transform = transform;
    }
    if (_numberOfObjects >2)
    {
        star3.transform = transform;
    }
    if (_numberOfObjects>3)
    {
        star4.transform = transform;
    }
    if (_numberOfObjects>4)
    {
        star5.transform = transform;
    }    
    [UIView commitAnimations];
}

-(void)winMusicStop
{
    if (leftNumberLbl.isHidden==NO)
    {
        [self startGame];
    }
    else
    {
        [self makeObjectsHidden];
        [self startObjectGame];
    }
    
    self.view.userInteractionEnabled = YES;
    [winAudioPlayer stop];
    [winAudioPlayer setCurrentTime:0];
    //[winAudioPlayer release];
    //winAudioPlayer = nil;
}

-(void)wrongMusicStop
{
    
    if (leftNumberLbl.isHidden==NO)
    {
        [self startGame];
    }
    else
    {
        [self makeObjectsHidden];
        [self startObjectGame];
    }
    
    self.view.userInteractionEnabled = YES;
    [wrongAudioPlayer stop];
    [wrongAudioPlayer setCurrentTime:0];
    //[wrongAudioPlayer release];
    //wrongAudioPlayer = nil;
}

-(void)cheersBeforeShowingNextQuestion
{
    if (leftNumberLbl.isHidden==NO)
    {
        [self startGame];
    }
    else
    {
        [self makeObjectsHidden];
        [self startObjectGame];
    }
    
    self.view.userInteractionEnabled = YES;
    self.view.alpha = 1;
    timerStopValue = 0;
    [audioPlayerClap stop];
}

-(int)getRandomNumber:(int)from to:(int)to
{
    
    return (int)from + arc4random() % (to-from+1);
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)viewWillDisappear:(BOOL)animated
{
    [Util writeToPlist:dic];
        if (timerStopValue ==1)
        {
            [audioPlayerClap stop];
            self.view.userInteractionEnabled = YES;
            self.view.alpha = 1;
        }
        [self.navigationController popViewControllerAnimated:NO];
}

@end