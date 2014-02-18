//
//  HelpMeAdditionViewController.m
//  MathsPlay
//
//  Created by qainfotech on 11/27/13.
//  Copyright (c) 2013 qainfotech. All rights reserved.
//

#import "HelpMeAdditionViewController.h"
#import "HMAView.h"
#import "HMAModel.h"
#import <AVFoundation/AVFoundation.h>

@interface HelpMeAdditionViewController ()
{
    AVAudioPlayer *audioPlayer, *winAudioPlayer;
    UILabel *winOrLoseMessage;
    NSString *usernameString;
    UIImageView *boy1,*boy2,*boy3;
    
}
@end

@implementation HelpMeAdditionViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    
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
    
    self.title = @"Kill The Bug !!!";
    self.view.backgroundColor = [UIColor colorWithRed:85/255.0 green:192/255.0 blue:247/255.0 alpha:1];
    
    optionButtonArray = [[NSMutableArray alloc]initWithCapacity:0];
    
    // game conditions and initializations
    
    numberOfCorrectAns = 0;
    usernameString = [[Util readPListData]objectForKey:@"username"];
        //audio player start
    NSURL *url = [NSURL fileURLWithPath:[NSString stringWithFormat:@"%@/insect.mp3", [[NSBundle mainBundle] resourcePath]]];
    NSError *error;
    audioPlayer = [[AVAudioPlayer alloc] initWithContentsOfURL:url error:&error];
    audioPlayer.numberOfLoops = -1;
    [audioPlayer play];
    
    levelString = [[Util readPListData]objectForKey:@"level"];
    [self createQuestionViews];
    [self createOptionViews];
    
    if ([levelString isEqualToString:@"EASY"]) {
        [self generateEasyQuestions];
    }
    [self generateOptionTitles];
    
    boy1 = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"sleepy"]];
    boy1.frame = CGRectMake(580, 350, 150, 150);
    [self.view addSubview:boy1];
    
    boy2 = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"sleepy"]];
    boy2.frame = CGRectMake(580, 450, 150, 150);
    [self.view addSubview:boy2];
    
    boy3 = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"sleepy"]];
    boy3.frame = CGRectMake(580, 550, 150, 150);
    [self.view addSubview:boy3];
    
    bugImage = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"spider2"]];
    bugImage.frame = CGRectMake(10, 410, 100, 50);
    [self.view addSubview:bugImage];
    spiderLineView = [[UIView alloc]initWithFrame:CGRectMake(0, 435, 25, 2)];
    spiderLineView.backgroundColor = [UIColor blackColor];
    [self.view addSubview:spiderLineView];
    
    bugKilledLabel = [HMAView createLabelWithFrame:CGRectMake(50, 800, 600, 50)];
    bugKilledLabel.text = [NSString stringWithFormat:@"Bugs Killed By %@: %d/15",usernameString,numberOfCorrectAns];
    [self.view addSubview:bugKilledLabel];
    
    winOrLoseMessage = [[UILabel alloc]initWithFrame:CGRectMake(250, 450, 350, 80)];
    winOrLoseMessage.backgroundColor = [UIColor clearColor];
    winOrLoseMessage.textColor = [UIColor darkGrayColor];
    winOrLoseMessage.font=[UIFont fontWithName:@"Markerfelt-Thin" size:50.0];
    [winOrLoseMessage setHidden:YES];
    [self.view addSubview:winOrLoseMessage];
    
    bugMoveTimer = [NSTimer scheduledTimerWithTimeInterval:.05 target:self selector:@selector(bugMovement) userInfo:nil repeats:YES];
}

#pragma mark Question And Option Views

- (void)createQuestionViews
{
    firstNumberLabel = [HMAView createLabelWithFrame:CGRectMake(55, 70, 100, 50)];
    firstNumberLabel.textColor = [UIColor yellowColor];
    [self.view addSubview:firstNumberLabel];
    
    operatorLabel1 = [HMAView createLabelWithFrame:CGRectMake(165, 70, 50, 50)];
    operatorLabel1.text = @"+";
    [self.view addSubview:operatorLabel1];
    
    secondNumberLabel = [HMAView createLabelWithFrame:CGRectMake(225, 70, 100, 50)];
    secondNumberLabel.textColor = [UIColor yellowColor];
    [self.view addSubview:secondNumberLabel];
    
    equalToLabel = [HMAView createLabelWithFrame:CGRectMake(335, 70, 50, 50)];
    equalToLabel.text = @"=";
    [self.view addSubview:equalToLabel];
    
    answerLabel = [HMAView createLabelWithFrame:CGRectMake(395, 60, 100, 65)];
    answerLabel.backgroundColor = [UIColor colorWithRed:255/255.0 green:127/255.0 blue:80/255.0 alpha:1.0];
    answerLabel.layer.borderWidth= 2.0;
    answerLabel.layer.borderColor = [[UIColor whiteColor]CGColor];
    answerLabel.layer.cornerRadius = 8.0;
    answerLabel.textAlignment = NSTextAlignmentCenter;
    answerLabel.textColor = [UIColor whiteColor];
    answerLabel.text=@"?";
    [self.view addSubview:answerLabel];
    
    operatorLabel2 = [HMAView createLabelWithFrame:CGRectMake(545, 70, 50, 50)];
    operatorLabel2.text = @"+";
    [self.view addSubview:operatorLabel2];
    
    thirdNumberLabel = [HMAView createLabelWithFrame:CGRectMake(645, 70, 100, 50)];
    thirdNumberLabel.textColor = [UIColor yellowColor];
    [self.view addSubview:thirdNumberLabel];
}


- (void)createOptionViews
{
    UIButton *firstOption = [HMAView createButtonWithFrame:CGRectMake(75, 220, 100, 60)];
    [firstOption addTarget:self action:@selector(optionButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:firstOption];
    UIButton *secondOption = [HMAView createButtonWithFrame:CGRectMake(245, 220, 100, 60)];
    [secondOption addTarget:self action:@selector(optionButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:secondOption];
    UIButton *thirdOption = [HMAView createButtonWithFrame:CGRectMake(415, 220, 100, 60)];
    [thirdOption addTarget:self action:@selector(optionButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:thirdOption];
    UIButton *fourthOption = [HMAView createButtonWithFrame:CGRectMake(585, 220, 100, 60)];
    [fourthOption addTarget:self action:@selector(optionButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:fourthOption];
    
    [optionButtonArray addObject:firstOption];
    [optionButtonArray addObject:secondOption];
    [optionButtonArray addObject:thirdOption];
    [optionButtonArray addObject:fourthOption];
    
}

#pragma mark Option Event Button

- (void)optionButtonClicked:(UIButton *)button
{
    if ([button.titleLabel.text integerValue] == ansValue) {
        // correct ans
    
        [bugMoveTimer invalidate];
        self.view.userInteractionEnabled = NO;
        [button setBackgroundColor:[UIColor greenColor]];
        [button setTitle:@"" forState:UIControlStateNormal];
        answerLabel.text = [NSString stringWithFormat:@"%d",ansValue];
        numberOfCorrectAns++;
        bugKilledLabel.text = [NSString stringWithFormat:@"Bugs Killed By %@: %d/15",usernameString,numberOfCorrectAns];
        
        
        // show hidden message
        winOrLoseMessage.text = @"You Saved Me !!";
        [winOrLoseMessage setHidden:NO];
   
        [self fadein];
        
        [audioPlayer stop];
        
        //audio player start
        NSURL *url = [NSURL fileURLWithPath:[NSString stringWithFormat:@"%@/clap.mp3", [[NSBundle mainBundle] resourcePath]]];
        NSError *error;
        winAudioPlayer = [[AVAudioPlayer alloc] initWithContentsOfURL:url error:&error];
        winAudioPlayer.numberOfLoops = 0;
        [winAudioPlayer play];
        
        UIImageView *sword = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"sword"]];
        sword.frame = CGRectMake(bugImage.frame.origin.x-10, 330, 100, 100);
        [self.view addSubview:sword];
        axeFallTimer = [NSTimer scheduledTimerWithTimeInterval:0.01 target:self selector:@selector(axeFallEvent:) userInfo:sword repeats:YES];
        bugFallTimer = [NSTimer scheduledTimerWithTimeInterval:.005 target:self selector:@selector(bugFallEvent:) userInfo:sword repeats:YES];

    }
    else
    {
        // wrong ans
        [button setBackgroundColor:[UIColor redColor]];
        [self wrongAnswer];
        
    }
}

-(void)wrongAnswer
{
    [audioPlayer stop];
    
    //audio player start
    NSURL *url = [NSURL fileURLWithPath:[NSString stringWithFormat:@"%@/lose2.mp3", [[NSBundle mainBundle] resourcePath]]];
    NSError *error;
    winAudioPlayer = [[AVAudioPlayer alloc] initWithContentsOfURL:url error:&error];
    winAudioPlayer.numberOfLoops = 0;
    [winAudioPlayer play];
    [spiderLineView setHidden:YES];
    
    self.view.userInteractionEnabled = NO;
    [bugMoveTimer invalidate];
    bugImage.frame = CGRectMake(600, 550, bugImage.frame.size.width+50, bugImage.frame.size.height+50);
    [self performSelector:@selector(hideChild) withObject:nil afterDelay:1];

}

- (void)hideChild {
    
    [winAudioPlayer stop];
    // initialize global objects and show next question.....
    answerLabel.text = @"";
    self.view.userInteractionEnabled = YES;
    [self generateEasyQuestions];
    [self generateOptionTitles];
    [spiderLineView setHidden:NO];
    
    [audioPlayer play];
    
    // bug re-position
    bugImage.frame = CGRectMake(10, 410, 100, 50);
    spiderLineView.frame = CGRectMake(0, 435, 25, 2);
    bugMoveTimer = [NSTimer scheduledTimerWithTimeInterval:.05 target:self selector:@selector(bugMovement) userInfo:nil repeats:YES];
}


#pragma mark Animation

-(void) fadein
{
    winOrLoseMessage.alpha = 0;
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationCurve:UIViewAnimationCurveLinear];
    
    //don't forget to add delegate.....
    [UIView setAnimationDelegate:self];
    
    [UIView setAnimationDuration:2];
    winOrLoseMessage.alpha = 1;
    
    //also call this before commit animations......
    [UIView setAnimationDidStopSelector:@selector(animationDidStop:finished:context:)];
    [UIView commitAnimations];
}



-(void)animationDidStop:(NSString *)animationID finished:(NSNumber *)finished    context:(void *)context
{
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:2];
    winOrLoseMessage.alpha = 0;
    [UIView commitAnimations];
    [winOrLoseMessage setHidden:YES];
}

#pragma NSTimer Events


- (void)axeFallEvent:(NSTimer *)timer
{
    UIImageView *sword = [timer userInfo];
    sword.frame = CGRectMake(sword.frame.origin.x, sword.frame.origin.y+2, 100, 100);
    if (sword.frame.origin.y>365) {
        [axeFallTimer invalidate];
    }
}

- (void)bugMovement
{
    
    if (spiderLineView.frame.size.width>boy1.frame.origin.x) {
        [self wrongAnswer];
        
    }
    
    spiderLineView.frame = CGRectMake(spiderLineView.frame.origin.x, 435, spiderLineView.frame.size.width+1, 2);
    bugImage.frame = CGRectMake(bugImage.frame.origin.x+1, bugImage.frame.origin.y, bugImage.frame.size.width, bugImage.frame.size.height);
}


- (void)bugFallEvent:(NSTimer *)timer
{
    if (bugImage.frame.origin.y+bugImage.frame.size.height>1024) {
        //[spiderLineView setHidden:YES];
        UIImageView *sword = [timer userInfo];
        [sword removeFromSuperview];
        [bugFallTimer invalidate];
        [winAudioPlayer stop];
        
        // initialize global objects and show next question.....
        answerLabel.text = @"";
        self.view.userInteractionEnabled = YES;
        [self generateEasyQuestions];
        [self generateOptionTitles];
        
        [audioPlayer play];
        
        // bug re-position
        bugImage.frame = CGRectMake(10, 410, 100, 50);
        spiderLineView.frame = CGRectMake(0, 435, 25, 2);
        bugMoveTimer = [NSTimer scheduledTimerWithTimeInterval:.05 target:self selector:@selector(bugMovement) userInfo:nil repeats:YES];
    }
    bugImage.frame = CGRectMake(bugImage.frame.origin.x, bugImage.frame.origin.y+1, bugImage.frame.size.width, bugImage.frame.size.height);
}

#pragma mark Question And Option Text Generation

- (void)generateEasyQuestions
{
    firstNumberLabel.text = [NSString stringWithFormat:@"%d",[HMAModel getRandomNumber:10 to:35]];
    secondNumberLabel.text = [NSString stringWithFormat:@"%d",[HMAModel getRandomNumber:10 to:35]];
    NSInteger additionOfTwoNumbers = [firstNumberLabel.text integerValue] + [secondNumberLabel.text integerValue];
    thirdNumberLabel.text = [NSString stringWithFormat:@"%d",[HMAModel getRandomNumber:6 to:additionOfTwoNumbers - 5]];
    ansValue = additionOfTwoNumbers - [thirdNumberLabel.text integerValue];
    
}


- (void)generateOptionTitles
{
    NSMutableArray *tempArray = [[NSMutableArray alloc]initWithArray:optionButtonArray];
    
    NSInteger randomInteger = [HMAModel getRandomNumber:0 to:3];
    UIButton *answerButton = [tempArray objectAtIndex:randomInteger];
    [answerButton setTitle:[NSString stringWithFormat:@"%d",ansValue] forState:UIControlStateNormal];
    answerButton.backgroundColor = [UIColor colorWithRed:147/255.0 green:112/255.0 blue:219/255.0 alpha:1.0];
    
    [tempArray removeObjectAtIndex:randomInteger];
    randomInteger = [HMAModel getRandomNumber:0 to:2];
    UIButton *falseButton1 = [tempArray objectAtIndex:randomInteger];
    [falseButton1 setTitle:[NSString stringWithFormat:@"%d",ansValue + [HMAModel getRandomNumber:1 to:4]] forState:UIControlStateNormal];
    falseButton1.backgroundColor = [UIColor colorWithRed:147/255.0 green:112/255.0 blue:219/255.0 alpha:1.0];
    
    [tempArray removeObjectAtIndex:randomInteger];
    randomInteger = [HMAModel getRandomNumber:0 to:1];
    UIButton *falseButton2 = [tempArray objectAtIndex:randomInteger];
    [falseButton2 setTitle:[NSString stringWithFormat:@"%d",ansValue - [HMAModel getRandomNumber:1 to:4]] forState:UIControlStateNormal];
    falseButton2.backgroundColor = [UIColor colorWithRed:147/255.0 green:112/255.0 blue:219/255.0 alpha:1.0];
    
    [tempArray removeObjectAtIndex:randomInteger];
    UIButton *falseButton3 = [tempArray objectAtIndex:0];
    [falseButton3 setTitle:[NSString stringWithFormat:@"%d",ansValue + 10  ] forState:UIControlStateNormal];
    falseButton3.backgroundColor = [UIColor colorWithRed:147/255.0 green:112/255.0 blue:219/255.0 alpha:1.0];
    
    tempArray =nil;
}


- (void)viewWillDisappear:(BOOL)animated {
    
    [audioPlayer stop];
    [winAudioPlayer stop];
    if([bugMoveTimer isValid]) {
        [bugMoveTimer invalidate];
    }
    if([bugFallTimer isValid]) {
        [bugFallTimer invalidate];
    }
    if([axeFallTimer isValid]) {
        [axeFallTimer invalidate];
    }
    [super viewWillDisappear:animated];
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
