//
//  AddViewController.m
//  KidsLearningGame
//
//  Created by QA Infotech on 21/08/13.
//  Copyright (c) 2013 QAInfotech. All rights reserved.
//

#import "AddViewController.h"
#import <QuartzCore/QuartzCore.h>
@interface AddViewController ()

@end

@implementation AddViewController

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
    
    level = [[[Util readPListData] objectForKey:@"level"]copy];
    
    self.view.backgroundColor = [UIColor colorWithRed:33/255.0 green:32/255.0 blue:33/255.0 alpha:0.9];
    self.title = @"AGAINST  THE  CLOCK";
    countdown = 120;
    hintNumber = 2;
    [self randomQuestion];
    [self optionsForRandomQuestions];
    
    startButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [startButton setFrame:CGRectMake(325, 400, 120, 50)];
    [startButton setBackgroundColor:[UIColor scrollViewTexturedBackgroundColor]];
    [startButton setTitleColor:[UIColor cyanColor] forState:UIControlStateNormal];
    [startButton setTitle:@"Play !!" forState:UIControlStateNormal];
    [startButton addTarget:self action:@selector(playClicked:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:startButton];
    
    UILabel *findNumberLabel = [[UILabel alloc]initWithFrame:CGRectMake(100, 25, 60, 50)];
    findNumberLabel.text = @"MAKE";
    findNumberLabel.textColor = [UIColor yellowColor];
    findNumberLabel.font = [UIFont fontWithName:@"Helvetica" size:20];
    findNumberLabel.backgroundColor = [UIColor clearColor];
    [self.view addSubview:findNumberLabel];
    
    UILabel *timerLabel = [[UILabel alloc]initWithFrame:CGRectMake(620, 25, 80, 50)];
    timerLabel.text = @"CLOCK";
    timerLabel.font = [UIFont fontWithName:@"Helvetica" size:20];
    timerLabel.textColor = [UIColor yellowColor];
    timerLabel.backgroundColor = [UIColor clearColor];
    [self.view addSubview:timerLabel];
    
    timeUpdateLabel = [[UILabel alloc]initWithFrame:CGRectMake(615, 55, 180, 100)];
    timeUpdateLabel.text = @"120";
    timeUpdateLabel.font = [UIFont fontWithName:@"Helvetica" size:50];
    timeUpdateLabel.textColor = [UIColor yellowColor];
    timeUpdateLabel.backgroundColor = [UIColor clearColor];
    [self.view addSubview:timeUpdateLabel];
    
    questionLabel = [[UILabel alloc]initWithFrame:CGRectMake(40, 60, 180, 100)];
    questionLabel.backgroundColor = [UIColor clearColor];
    questionLabel.textAlignment = NSTextAlignmentCenter;
    questionLabel.font = [UIFont fontWithName:@"BradleyHandITCTT-Bold" size:70];
    questionLabel.text = [NSString stringWithFormat:@"%@",[questionArr objectAtIndex:0]];
    [questionLabel setHidden:YES];
    questionLabel.textColor = [UIColor redColor];
    [self.view addSubview:questionLabel];
    
    UIImageView *correctImageLogo = [[UIImageView alloc]initWithFrame:CGRectMake(330, 40, 30, 30)];
    correctImageLogo.image = [UIImage imageNamed:@"correct"];
    [self.view addSubview:correctImageLogo];
    
    UIImageView *inCorrectImageLogo = [[UIImageView alloc]initWithFrame:CGRectMake(330, 100, 30, 30)];
    inCorrectImageLogo.image = [UIImage imageNamed:@"incorrect"];
    [self.view addSubview:inCorrectImageLogo];
    
    correctAnsLabel = [[UILabel alloc]initWithFrame:CGRectMake(370, 40, 30, 30)];
    correctAnsLabel.backgroundColor = [UIColor clearColor];
    correctAnsLabel.textAlignment = NSTextAlignmentCenter;
    correctAnsLabel.font = [UIFont fontWithName:@"BradleyHandITCTT-Bold" size:40];
    correctAnsLabel.text = @"0";
    correctAnsLabel.textColor = [UIColor cyanColor];
    [self.view addSubview:correctAnsLabel];
    
    inCorrectAnsLabel = [[UILabel alloc]initWithFrame:CGRectMake(370, 100, 30, 30)];
    inCorrectAnsLabel.backgroundColor = [UIColor clearColor];
    inCorrectAnsLabel.textAlignment = NSTextAlignmentCenter;
    inCorrectAnsLabel.font = [UIFont fontWithName:@"BradleyHandITCTT-Bold" size:40];
    inCorrectAnsLabel.text = @"0";
    inCorrectAnsLabel.textColor = [UIColor cyanColor];
    [self.view addSubview:inCorrectAnsLabel];
    
    [self makeArrayOfCircles];
    
    /* Rotating circles with angles  */
    
    float curAngle = 0;
    float incAngle = ( 360.0/(views.count) )*3.14/180.0;
    CGPoint circleCenter = CGPointMake(380, 560); /* given center */
    float circleRadius = 300; /* given radius */
    for (UIView *view in views)
    {
        CGPoint viewCenter;
        viewCenter.x = circleCenter.x + cos(curAngle)*circleRadius;
        viewCenter.y = circleCenter.y + sin(curAngle)*circleRadius;
        view.center = viewCenter;
        [self.view addSubview:view];
        
        curAngle += incAngle;
    }
    
    ansboxOne = [[UIView alloc]initWithFrame:CGRectMake(180, 520, 120, 100)];
    ansboxOne.backgroundColor = [UIColor clearColor];
    ansboxOne.layer.cornerRadius = 10.0;
    ansboxOne.layer.borderWidth = 1.0;
    ansboxOne.layer.borderColor = [[UIColor yellowColor]CGColor];
    [self.view addSubview:ansboxOne];
    
    UIImageView *addOrSubImage = [[UIImageView alloc]initWithFrame:CGRectMake(330, 520, 100, 100)];
    addOrSubImage.image = [UIImage imageNamed:@"add"];
    [self.view addSubview:addOrSubImage];
    
    ansboxTwo = [[UIView alloc]initWithFrame:CGRectMake(460, 520, 120, 100)];
    ansboxTwo.backgroundColor = [UIColor clearColor];
    ansboxTwo.layer.cornerRadius = 10.0;
    ansboxTwo.layer.borderWidth = 1.0;
    ansboxTwo.layer.borderColor = [[UIColor yellowColor]CGColor];
    [self.view addSubview:ansboxTwo];
    
}

- (void)makeArrayOfCircles {
    
    /* Making of circle */
    views = [[NSMutableArray alloc]initWithCapacity:0];
    
    if (![level isEqualToString:@"HARD"]) {
        for (NSInteger i = 0; i<16; i++)
        {
            circle = nil;
            circle = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 80, 80)];
            circle.tag = i+1;
            circle.backgroundColor = [UIColor clearColor];
            UIImageView *circleImage = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 80, 80)];
            circleImage.image = [UIImage imageNamed:@"circle"];
            [circle addSubview:circleImage];
            UILabel *labelInsideCircle = [[UILabel alloc]initWithFrame:CGRectMake(10, 10, 40, 40)];
            labelInsideCircle.backgroundColor = [UIColor clearColor];
            labelInsideCircle.textColor = [UIColor greenColor];
            labelInsideCircle.font = [UIFont fontWithName:@"Copperplate-Bold" size:30.0];
            labelInsideCircle.center = circleImage.center;
            NSInteger int_ = [self getRandomNumber:0 to:(arrOfOptions.count-1)];
            labelInsideCircle.text = [NSString stringWithFormat:@"%@",[arrOfOptions objectAtIndex:int_]];
            labelInsideCircle.textAlignment = NSTextAlignmentCenter;
            [arrOfOptions removeObjectAtIndex:int_];
            [circle addSubview:labelInsideCircle];
            [views addObject:circle];

        }
    } else {
        for (NSInteger i = 0; i<16; i++)
        {
            circle = nil;
            circle = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 90, 90)];
            circle.tag = i+1;
            circle.backgroundColor = [UIColor clearColor];
            UIImageView *circleImage = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 90, 90)];
            circleImage.image = [UIImage imageNamed:@"circle"];
            [circle addSubview:circleImage];
            UILabel *labelInsideCircle = [[UILabel alloc]initWithFrame:CGRectMake(10, 10, 55, 55)];
            labelInsideCircle.backgroundColor = [UIColor clearColor];
            labelInsideCircle.textColor = [UIColor greenColor];
            labelInsideCircle.font = [UIFont fontWithName:@"Copperplate-Bold" size:28.0];
            labelInsideCircle.center = circleImage.center;
            NSInteger int_ = [self getRandomNumber:0 to:(arrOfOptions.count-1)];
            labelInsideCircle.text = [NSString stringWithFormat:@"%@",[arrOfOptions objectAtIndex:int_]];
            labelInsideCircle.textAlignment = NSTextAlignmentCenter;
            [arrOfOptions removeObjectAtIndex:int_];
            [circle addSubview:labelInsideCircle];
            [views addObject:circle];

        }
    }
}


- (void)playClicked:(UIButton *)btn
{
    if ([btn.currentTitle isEqualToString:@"Play !!"]) {
        [btn setHidden:NO];
        [btn setTitle:@"HINT #2" forState:UIControlStateNormal];
        [questionLabel setHidden:NO];
        clockTimer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(clockTime) userInfo:nil repeats:YES];
        
    } else { // hint btn clicked
        
        hintNumber--;
        if (hintNumber == 1) {
            [btn setTitle:@"HINT #1" forState:UIControlStateNormal];
        } else if (hintNumber == 0) {
            [btn setHidden:YES];
        }
        
        for (NSInteger i =0; i<views.count; i++) {
            UIView *firstCircleView = [views objectAtIndex:i];
            UIView *secondCircleView;
            for (NSInteger j = 0; j<views.count; j++) {
                if (i!=j)
                {
                    UILabel *firstCircleLabel, *secondCircleLabel;
                    secondCircleView = [views objectAtIndex:j];
                    for (id firstLabel in firstCircleView.subviews) {
                        if ([firstLabel isKindOfClass:[UILabel class]]) {
                            firstCircleLabel = (UILabel *)firstLabel;
                        }
                    }
                    for (id secondLabel in secondCircleView.subviews) {
                        if ([secondLabel isKindOfClass:[UILabel class]]) {
                            secondCircleLabel = (UILabel *)secondLabel;
                        }
                    }
                    
                    if ([questionLabel.text integerValue] == ([firstCircleLabel.text integerValue] + [secondCircleLabel.text integerValue])) {
                        // animation to grow first and second circle views for 1 second
                        [UIView beginAnimations:nil context:nil];
                        [UIView setAnimationDuration:1];
                        [UIView setAnimationDelegate:self];
                        CGAffineTransform transform = CGAffineTransformMakeScale(1.3f, 1.3f);
                        firstCircleView.transform = transform;
                        secondCircleView.transform = transform;
                        [UIView commitAnimations];
                        
                        i = views.count;
                        j = views.count;
                        
                        [self performSelector:@selector(stopHintCirclesFromGrowing:) withObject:firstCircleView afterDelay:1];
                        [self performSelector:@selector(stopHintCirclesFromGrowing2:) withObject:secondCircleView afterDelay:1];
                    }
                    
                    
                }
                
            } // j loop
        } // i loop
    } // hint : else condition
    
    
}

- (void)stopHintCirclesFromGrowing:(UIView *)circleView
{
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:1];
    [UIView setAnimationDelegate:self];
    CGAffineTransform transform = CGAffineTransformMakeScale(1.0f, 1.0f);
    circleView.transform = transform;
    [UIView commitAnimations];
}

- (void)stopHintCirclesFromGrowing2:(UIView *)circleView2
{
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:1];
    [UIView setAnimationDelegate:self];
    CGAffineTransform transform = CGAffineTransformMakeScale(1.0f, 1.0f);
    circleView2.transform = transform;
    [UIView commitAnimations];
}

- (void)clockTime
{
    if (countdown==0) {
        [clockTimer invalidate];
        clockTimer = nil;
        UIAlertView *gameOver = [[UIAlertView alloc]initWithTitle:@"OOPS !!" message:@"You couldn't complete 8 questions on time" delegate:self cancelButtonTitle:@"Play Again" otherButtonTitles:@"Go Home", nil];
        gameOver.tag = 1000;
        [gameOver show];
        
    } else {
        countdown--;
        timeUpdateLabel.text = [NSString stringWithFormat:@"%d",countdown];
    }
    
}

#pragma mark TOUCH EVENT
- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
	// We only support single touches, so anyObject retrieves just that touch from touches
	touch = [touches anyObject];
	if ([touch tapCount] == 1)
    {
        // Only move the circular view if the touch was in the circular view
        
        if (touch.view.tag>0 && touch.view.tag<17) {
            // Animate the first touch
            selectedOptionFrame = touch.view.frame;
            CGPoint touchPoint = [touch locationInView:self.view];
            [self animateFirstTouchAtPoint:touchPoint];
        }
        else
        {
            return;
        }
    }
	
}

- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event {
	
	touch = [touches anyObject];
	
	// If the touch was in the circularView, move the circularView to its location
	if (touch.view.tag>0 && touch.view.tag<17) {
		CGPoint location = [touch locationInView:self.view];
        [touch view].center = location;
		return;
	}
}


- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    
    touch = [touches anyObject];
    
	if (touch.view.tag>0 && touch.view.tag<17) {
        
#define GROW_ANIMATION_DURATION_SECONDS 0.15
        
        CGPoint touchPoint = [touch locationInView:self.view];
        NSValue *touchPointValue = [NSValue valueWithCGPoint:touchPoint];
        [UIView beginAnimations:nil context:(__bridge void *)(touchPointValue)];
        [UIView setAnimationDuration:GROW_ANIMATION_DURATION_SECONDS];
        [UIView setAnimationDelegate:self];
        CGAffineTransform transform = CGAffineTransformMakeScale(1.0f, 1.0f);
        [touch view].transform = transform;
        [UIView commitAnimations];
        
        
        CGRect myFirstRect = CGRectMake(170, 510, 130, 110);
        CGRect mySecondRect = CGRectMake(450, 510, 130, 110);
        
        if(CGRectContainsPoint(myFirstRect, touchPoint)) // first box was chosen
        {
            if (isFirstRectFilled) {
                touch.view.frame = selectedOptionFrame;
            }
            else
            {
                numberOfCircleDragged++;
                isFirstRectFilled = YES; // first box was filled
                firstCircle = touch.view;
                firstOptionFrame = selectedOptionFrame;
                [touch view].center = ansboxOne.center;
                if (numberOfCircleDragged == 2) { // both the circles are filled; so restart the game
                    // check if correct ans or not
                    NSInteger firstValue=0,secondValue=0;
                    for (id subview_ in firstCircle.subviews) {
                        if ([subview_ isKindOfClass:[UILabel class]]) {
                            UILabel *lbl = (UILabel *)subview_;
                            firstValue = [lbl.text integerValue];
                        }
                    }
                    for (id subview2_ in secondCircle.subviews) {
                        if ([subview2_ isKindOfClass:[UILabel class]]) {
                            UILabel *lbl = (UILabel *)subview2_;
                            secondValue = [lbl.text integerValue];
                        }
                    }
                    if([[questionArr objectAtIndex:numberOfQuestionsAttempted]integerValue] == (int)firstValue  + (int)secondValue)
                    {
                        // user has chosen correct options
                        correctAns++;
                        correctAnsLabel.text = [NSString stringWithFormat:@"%d",correctAns];
                        winAnsUrl = [NSURL fileURLWithPath:[NSString stringWithFormat:@"%@/win1.mp3", [[NSBundle mainBundle] resourcePath]]];
                        winAudioPlayer = [[AVAudioPlayer alloc] initWithContentsOfURL:winAnsUrl error:nil];
                        winAudioPlayer.numberOfLoops = 0;
                        [winAudioPlayer play];
                        [self performSelector:@selector(winMusicStop) withObject:nil afterDelay:1];
                    } else {
                        wrongAns++;
                        inCorrectAnsLabel.text = [NSString stringWithFormat:@"%d",wrongAns];
                        wrongAnsUrl = [NSURL fileURLWithPath:[NSString stringWithFormat:@"%@/fb.mp3", [[NSBundle mainBundle] resourcePath]]];
                        wrongAudioPlayer = [[AVAudioPlayer alloc] initWithContentsOfURL:wrongAnsUrl error:nil];
                        wrongAudioPlayer.numberOfLoops = 0;
                        
                        [wrongAudioPlayer play];
                        [self performSelector:@selector(wrongMusicStop) withObject:nil afterDelay:1];
                    }
                    numberOfQuestionsAttempted++;
                    // now restart the game if no. of questions attempted is less than 8
                    if (numberOfQuestionsAttempted<8) // dere are total of 8 questions from 0 to 7
                    {
                        // first reset the necessary variables
                        isFirstRectFilled = NO;
                        isSecondRectFilled = NO;
                        numberOfCircleDragged = 0;
                        firstCircle.frame = firstOptionFrame;
                        secondCircle.frame = secondOptionFrame;
                        questionLabel.text = [NSString stringWithFormat:@"%@",[questionArr objectAtIndex:numberOfQuestionsAttempted]];
                    } else {
                        firstCircle.frame = firstOptionFrame;
                        secondCircle.frame = secondOptionFrame;
                        questionLabel.text = @"0";
                        [clockTimer invalidate];
                        
                        // CHECK IF 7 out of 8 are correct or not
                        if (correctAns>6) { // 7 or 8 correct ans
                            UIAlertView *gameOver = [[UIAlertView alloc]initWithTitle:@"WOW !!" message:@"You have done it before time" delegate:self cancelButtonTitle:@"Play Again" otherButtonTitles:@"Change Level",@"Go Home", nil];
                            gameOver.tag = 1001;
                            [gameOver show];
                        } else {
                            UIAlertView *gameOver = [[UIAlertView alloc]initWithTitle:@"Level Failed !!" message:@"You need to get atleast 7 correct answers" delegate:self cancelButtonTitle:@"Play Again" otherButtonTitles:@"Go Home", nil];
                            gameOver.tag = 1000;
                            [gameOver show];
                        }
                        
                        
                    }
                    
                    
                }
            }
            
        }
        else if (CGRectContainsPoint(mySecondRect, touchPoint)) // second box was chosen
        {
            if (isSecondRectFilled) {
                touch.view.frame = selectedOptionFrame;
            }
            else{
                numberOfCircleDragged++;
                isSecondRectFilled = YES; // first box was filled
                secondCircle = touch.view;
                secondOptionFrame = selectedOptionFrame;
                [touch view].center = ansboxTwo.center;
                if (numberOfCircleDragged == 2) { // both the circles are filled; so restart the game
                    // check if correct ans or not
                    NSInteger firstValue=0, secondValue=0;
                    for (id subview_ in firstCircle.subviews) {
                        if ([subview_ isKindOfClass:[UILabel class]]) {
                            UILabel *lbl = (UILabel *)subview_;
                            firstValue = [lbl.text integerValue];
                        }
                    }
                    for (id subview2_ in secondCircle.subviews) {
                        if ([subview2_ isKindOfClass:[UILabel class]]) {
                            UILabel *lbl = (UILabel *)subview2_;
                            secondValue = [lbl.text integerValue];
                        }
                    }
                    if([[questionArr objectAtIndex:numberOfQuestionsAttempted]integerValue] == firstValue + secondValue)
                    {
                        // user has chosen correct options
                        correctAns++;
                        correctAnsLabel.text = [NSString stringWithFormat:@"%d",correctAns];
                        winAnsUrl = [NSURL fileURLWithPath:[NSString stringWithFormat:@"%@/win1.mp3", [[NSBundle mainBundle] resourcePath]]];
                        winAudioPlayer = [[AVAudioPlayer alloc] initWithContentsOfURL:winAnsUrl error:nil];
                        winAudioPlayer.numberOfLoops = 0;
                        [winAudioPlayer play];
                        [self performSelector:@selector(winMusicStop) withObject:nil afterDelay:1];
                    } else {
                        wrongAns++;
                        inCorrectAnsLabel.text = [NSString stringWithFormat:@"%d",wrongAns];
                        wrongAnsUrl = [NSURL fileURLWithPath:[NSString stringWithFormat:@"%@/fb.mp3", [[NSBundle mainBundle] resourcePath]]];
                        wrongAudioPlayer = [[AVAudioPlayer alloc] initWithContentsOfURL:wrongAnsUrl error:nil];
                        wrongAudioPlayer.numberOfLoops = 0;
                        
                        [wrongAudioPlayer play];
                        [self performSelector:@selector(wrongMusicStop) withObject:nil afterDelay:1];
                    }
                    numberOfQuestionsAttempted++;
                    // now restart the game if no. of questions attempted is less than 8
                    if (numberOfQuestionsAttempted<8) // dere are total of 8 questions from 0 to 7
                    {
                        // first reset the necessary variables
                        isFirstRectFilled = NO;
                        isSecondRectFilled = NO;
                        numberOfCircleDragged = 0;
                        firstCircle.frame = firstOptionFrame;
                        secondCircle.frame = secondOptionFrame;
                        questionLabel.text = [NSString stringWithFormat:@"%@",[questionArr objectAtIndex:numberOfQuestionsAttempted]];
                    } else {
                        firstCircle.frame = firstOptionFrame;
                        secondCircle.frame = secondOptionFrame;
                        questionLabel.text = @"0";
                        [clockTimer invalidate];
                        // CHECK IF 7 out of 8 are correct or not
                        if (correctAns>6) { // 7 or 8 correct ans
                            UIAlertView *gameOver = [[UIAlertView alloc]initWithTitle:@"WOW !!" message:@"You have done it before time" delegate:self cancelButtonTitle:@"Play Again" otherButtonTitles:@"Change Level",@"Go Home", nil];
                            gameOver.tag = 1001;
                            [gameOver show];
                          
                        } else {
                            UIAlertView *gameOver = [[UIAlertView alloc]initWithTitle:@"Level Failed !!" message:@"You need to get atleast 7 correct answers" delegate:self cancelButtonTitle:@"Play Again" otherButtonTitles:@"Go Home", nil];
                            gameOver.tag = 1000;
                            [gameOver show];
                           
                        }
                    }
                    
                    
                }
            }
        }
        else
        {
            // not properly dragged
            touch.view.frame = selectedOptionFrame;
            
        }
	}
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    
    if (alertView.tag == 1000) { // 0=play again 1=go home
        if (buttonIndex==0) {
            
            [self restartTheGame];
            
        } else {
            [self.navigationController popViewControllerAnimated:YES];
        }
        return;
    } else if (alertView.tag == 1001) { // 0=play again 1=change level 2=go home
        if (buttonIndex==0) {
            
            [self restartTheGame];
            
        } else if (buttonIndex==1) {
            
            NSMutableDictionary *plistDic = [Util readPListData];
            if ([level isEqualToString:@"EASY"]) {
                
                level = @"MEDIUM";
                [plistDic setObject:@"MEDIUM" forKey:@"level"];
                [Util writeToPlist:plistDic];
                [self restartTheGame];
                
            } else if ([level isEqualToString:@"MEDIUM"]) {
                
                level = @"HARD";
                [plistDic setObject:@"HARD" forKey:@"level"];
                [Util writeToPlist:plistDic];
                [self restartTheGame];
                
            } else {
                
                UIAlertView *allLevelsCleared = [[UIAlertView alloc]initWithTitle:@"FINALLY !!" message:@"You have completed all the levels" delegate:self cancelButtonTitle:@"Play Again" otherButtonTitles:@"Go Home", nil];
                allLevelsCleared.tag = 1000;
                [allLevelsCleared show];
             
            }
            
        } else {
            
            [self.navigationController popViewControllerAnimated:YES];
            
        }
    }
}

- (void)restartTheGame {
    
    isFirstRectFilled = NO;
    isSecondRectFilled = NO;
    numberOfCircleDragged = 0;
    numberOfQuestionsAttempted = 0;
    correctAns = 0;
    wrongAns = 0;
    countdown = 120;
    hintNumber = 2;
    correctAnsLabel.text = @"0";
    inCorrectAnsLabel.text = @"0";
    timeUpdateLabel.text = @"120";
    [startButton setTitle:@"Play !!" forState:UIControlStateNormal];
    [self randomQuestion];
    questionLabel.text = [NSString stringWithFormat:@"%@",[questionArr objectAtIndex:0]];
    [self optionsForRandomQuestions];
    [self playClicked:startButton];
    
}


- (void)winMusicStop
{
    [winAudioPlayer stop];
    [winAudioPlayer setCurrentTime:0];
    winAudioPlayer = nil;
}

-(void)wrongMusicStop
{
    [wrongAudioPlayer stop];
    [wrongAudioPlayer setCurrentTime:0];
    wrongAudioPlayer = nil;
    
}

- (void)animateFirstTouchAtPoint:(CGPoint)touchPoint
{
	
	
#define GROW_ANIMATION_DURATION_SECONDS 0.15
	
	NSValue *touchPointValue = [NSValue valueWithCGPoint:touchPoint];
	[UIView beginAnimations:nil context:(__bridge void *)(touchPointValue)];
	[UIView setAnimationDuration:GROW_ANIMATION_DURATION_SECONDS];
	[UIView setAnimationDelegate:self];
	CGAffineTransform transform = CGAffineTransformMakeScale(1.3f, 1.3f);
	[touch view].transform = transform;
	[UIView commitAnimations];
}


/*
 * generates 8 random numbers and stored inside mutable array ; the nos 'll be shown as question(find) to the users
 */
- (void)randomQuestion
{
    questionArr =[[NSMutableArray alloc]initWithCapacity:0];
    if ([level isEqualToString:@"EASY"]) {
        for (NSInteger i = 0; i<8; i++)
        {
            NSNumber *num = [NSNumber numberWithInt:[self getRandomNumber:10 to:61]];
            while ([questionArr containsObject:num]) {
                num = [NSNumber numberWithInt:[self getRandomNumber:10 to:61]];
            }
            [questionArr addObject:num];
            
        }
    } else if ([level isEqualToString:@"MEDIUM"]) {
        for (NSInteger i = 0; i<8; i++)
        {
            NSNumber *num = [NSNumber numberWithInt:[self getRandomNumber:60 to:120]];
            while ([questionArr containsObject:num]) {
                num = [NSNumber numberWithInt:[self getRandomNumber:60 to:120]];
            }
            [questionArr addObject:num];
            
        }
    } else {
        for (NSInteger i = 0; i<8; i++)
        {
            NSNumber *num = [NSNumber numberWithInt:[self getRandomNumber:120 to:999]];
            while ([questionArr containsObject:num]) {
                num = [NSNumber numberWithInt:[self getRandomNumber:120 to:999]];
            }
            [questionArr addObject:num];
            
        }
    }
    
    
}


/*
 * generates 16 random numbers and stored inside mutable array ; the nos 'll be shown as options to the users
 */
- (void)optionsForRandomQuestions
{
    arrOfOptions = [[NSMutableArray alloc]initWithCapacity:0];
    for (NSInteger i = 0; i<questionArr.count; i++)
    {
        NSInteger num = [[questionArr objectAtIndex:i]integerValue];
        NSInteger numMinusOne = num - 1;
        NSInteger firstPartOfNum = [self getRandomNumber:1 to:numMinusOne];
        NSInteger secondPartOfNum = num - firstPartOfNum;
        [arrOfOptions addObject:[NSNumber numberWithInt:firstPartOfNum]];
        [arrOfOptions addObject:[NSNumber numberWithInt:secondPartOfNum]];
    }
}


- (int)getRandomNumber:(int)from to:(int)to
{
    
    return (int)from + arc4random() % (to-from+1);
    
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    if ([clockTimer isValid]) {
        [clockTimer invalidate];
    }
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
@end
