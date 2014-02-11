//
//  DragToAddOrSubViewController.m
//  KidsLearningGame
//
//  Created by QA Infotech on 11/07/13.
//  Copyright (c) 2013 QAInfotech. All rights reserved.
//

#import "DragToAddOrSubViewController.h"

@interface DragToAddOrSubViewController ()
{
    AVAudioPlayer *startupAudio;
}
@end

@implementation DragToAddOrSubViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
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
    [super viewDidLoad];
	self.view.backgroundColor = [UIColor darkGrayColor];
    
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
    
    UILabel *usernameLabel = [[UILabel alloc]initWithFrame:CGRectMake(100, 10, 600, 40)];
    usernameLabel.textColor = [UIColor colorWithRed:0/255.0 green:171/255.0 blue:189/255.0 alpha:1.0];
    usernameLabel.backgroundColor = [UIColor clearColor];
    usernameLabel.text = [NSString stringWithFormat:@"HI   %@",[[Util readPListData]objectForKey:@"username"]];
    usernameLabel.textAlignment = NSTextAlignmentCenter;
    usernameLabel.font = [UIFont fontWithName:@"BradleyHandITCTT-Bold" size:40.0];
    [self.view addSubview:usernameLabel];
    
    currentLevelLabel = [[UILabel alloc]initWithFrame:CGRectMake(400, 100, 300, 40)];
    currentLevelLabel.textColor = [UIColor colorWithRed:255/225.0 green:236/255.0 blue:146/255.0 alpha:1.0];
    currentLevelLabel.backgroundColor = [UIColor clearColor];
    currentLevelLabel.text = [NSString stringWithFormat:@"Its - %@ Level",[[Util readPListData]objectForKey:@"level"]];
    currentLevelLabel.textAlignment = NSTextAlignmentCenter;
    currentLevelLabel.font = [UIFont fontWithName:@"BradleyHandITCTT-Bold" size:30.0];
    [self.view addSubview:currentLevelLabel];

    
    if (![[[Util readPListData]objectForKey:@"level"] isEqualToString:@"HARD"])
    {
        UIButton *nextLevelButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [nextLevelButton setFrame:CGRectMake(440, 170, 150, 45)];
        nextLevelButton.layer.borderWidth = 1.0;
        nextLevelButton.layer.borderColor = [[UIColor colorWithRed:255/225.0 green:236/255.0 blue:146/255.0 alpha:1.0]CGColor];
        [nextLevelButton setTitleColor:[UIColor colorWithRed:255/225.0 green:236/255.0 blue:146/255.0 alpha:1.0] forState:UIControlStateNormal];
        [nextLevelButton addTarget:self action:@selector(nextLevel:) forControlEvents:UIControlEventTouchUpInside];
        [nextLevelButton setTitle:@"Next Level" forState:UIControlStateNormal];
        [self.view addSubview:nextLevelButton];
    }
    
    UIImageView *correctImageLogo = [[UIImageView alloc]initWithFrame:CGRectMake(40, 100, 40, 40)];
    correctImageLogo.image = [UIImage imageNamed:@"correct"];
    [self.view addSubview:correctImageLogo];

    
    numberOfCorrectAnsLabel = [[UILabel alloc]initWithFrame:CGRectMake(90, 105, 40, 40)];
    numberOfCorrectAnsLabel.textColor = [UIColor greenColor];
    numberOfCorrectAnsLabel.backgroundColor = [UIColor clearColor];
    numberOfCorrectAnsLabel.text = [NSString stringWithFormat:@"%d",correctAnsCount];
    numberOfCorrectAnsLabel.textAlignment = NSTextAlignmentCenter;
    numberOfCorrectAnsLabel.font = [UIFont fontWithName:@"GillSans-Bold" size:30.0];
    [self.view addSubview:numberOfCorrectAnsLabel];

    
    smileLogo = [[UIImageView alloc]initWithFrame:CGRectMake(150, 100, 40, 40)];
    smileLogo.image = [UIImage imageNamed:@"smile"];
    [self.view addSubview:smileLogo];

    
    UIImageView *inCorrectImageLogo = [[UIImageView alloc]initWithFrame:CGRectMake(40, 180, 40, 40)];
    inCorrectImageLogo.image = [UIImage imageNamed:@"incorrect"];
    [self.view addSubview:inCorrectImageLogo];

    
    numberOfInCorrectAnsLabel = [[UILabel alloc]initWithFrame:CGRectMake(90, 185, 40, 40)];
    numberOfInCorrectAnsLabel.textColor = [UIColor redColor];
    numberOfInCorrectAnsLabel.backgroundColor = [UIColor clearColor];
    numberOfInCorrectAnsLabel.text = [NSString stringWithFormat:@"%d",wrongAnsCount];
    numberOfInCorrectAnsLabel.textAlignment = NSTextAlignmentCenter;
    numberOfInCorrectAnsLabel.font = [UIFont fontWithName:@"GillSans-Bold" size:30.0];
    [self.view addSubview:numberOfInCorrectAnsLabel];

    
    sadLogo = [[UIImageView alloc]initWithFrame:CGRectMake(150, 180, 40, 40)];
    sadLogo.image = [UIImage imageNamed:@"sad"];
    [self.view addSubview:sadLogo];
    
    
    hangmanImage = [[UIImageView alloc]initWithFrame:CGRectMake(250, 250, 50, 50)];
    hangmanImage.image = [UIImage imageNamed:@""];
    [self.view addSubview:hangmanImage];
    
    firstNumberLabel = [[UILabel alloc]initWithFrame:CGRectMake(30, 450, 150, 100)];
    firstNumberLabel.textColor = [UIColor yellowColor];
    firstNumberLabel.backgroundColor = [UIColor clearColor];
    firstNumberLabel.textAlignment = NSTextAlignmentCenter;
    firstNumberLabel.font = [UIFont fontWithName:@"GillSans-Bold" size:100.0];
    [self.view addSubview:firstNumberLabel];

    
    UIImageView *operatorImage = [[UIImageView alloc]initWithFrame:CGRectMake(185, 465, 70, 70)];
    
    if ([self.addOrSub isEqualToString:@"add"])
    {
        operatorImage.image = [UIImage imageNamed:@"add"];
    }
    else
    {
        operatorImage.image = [UIImage imageNamed:@"minus"];
    }
    
    [self.view addSubview:operatorImage];

    
    secondNumberLabel = [[UILabel alloc]initWithFrame:CGRectMake(260, 450, 150, 100)];
    secondNumberLabel.backgroundColor = [UIColor clearColor];
    secondNumberLabel.textColor = [UIColor yellowColor];
    secondNumberLabel.textAlignment = NSTextAlignmentCenter;
    secondNumberLabel.font = [UIFont fontWithName:@"GillSans-Bold" size:100.0];
    [self.view addSubview:secondNumberLabel];

    
    UIImageView *equalImage = [[UIImageView alloc]initWithFrame:CGRectMake(420, 477, 50, 50)];
    equalImage.image = [UIImage imageNamed:@"equal"];
    [self.view addSubview:equalImage];

    
    ansBoxView = [[UIView alloc]initWithFrame:CGRectMake(490, 440, 250, 120)];
    ansBoxView.backgroundColor = [UIColor lightTextColor];
    ansBoxView.layer.borderWidth = 1.0;
    ansBoxView.layer.borderColor = [[UIColor orangeColor]CGColor];
    ansBoxView.layer.cornerRadius = 9.0;
    [self.view addSubview:ansBoxView];

    
    #pragma mark ORANGE BUBBLE CODE
    
    optionView1 = [[UIView alloc]init];
    optionView1.backgroundColor = [UIColor clearColor];
    UIImageView *optionImage1 = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 110, 100)];
    optionImage1.image = [UIImage imageNamed:@"orangebubble"];
    [optionView1 addSubview:optionImage1];

    optionLabel1 = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 110, 100)];
    optionLabel1.font = [UIFont fontWithName:@"MarkerFelt-Wide" size:31.0];
    optionLabel1.backgroundColor = [UIColor clearColor];
    optionLabel1.textAlignment = NSTextAlignmentCenter;
    [optionView1 addSubview:optionLabel1];

    [self.view addSubview:optionView1];

     
    optionView2 = [[UIView alloc]init];
    optionView2.backgroundColor = [UIColor clearColor];
    UIImageView * optionImage2 = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 110, 100)];
    optionImage2.image = [UIImage imageNamed:@"orangebubble"];
    [optionView2 addSubview:optionImage2];

    optionLabel2 = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 110, 100)];
    optionLabel2.font = [UIFont fontWithName:@"MarkerFelt-Wide" size:31.0];
    optionLabel2.backgroundColor = [UIColor clearColor];
    optionLabel2.textAlignment = NSTextAlignmentCenter;
    [optionView2 addSubview:optionLabel2];

    [self.view addSubview:optionView2];

    
    optionView3 = [[UIView alloc]init];
    optionView3.backgroundColor = [UIColor clearColor];
    UIImageView * optionImage3 = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 110, 100)];
    optionImage3.image = [UIImage imageNamed:@"orangebubble"];
    [optionView3 addSubview:optionImage3];

    optionLabel3 = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 110, 100)];
    optionLabel3.font = [UIFont fontWithName:@"MarkerFelt-Wide" size:31.0];
    optionLabel3.backgroundColor = [UIColor clearColor];
    optionLabel3.textAlignment = NSTextAlignmentCenter;
    [optionView3 addSubview:optionLabel3];

    [self.view addSubview:optionView3];

    
    optionView4 = [[UIView alloc]init];
    optionView4.backgroundColor = [UIColor clearColor];
    UIImageView * optionImage4 = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 110, 100)];
    optionImage4.image = [UIImage imageNamed:@"orangebubble"];
    [optionView4 addSubview:optionImage4];

    optionLabel4 = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 110, 100)];
    optionLabel4.font = [UIFont fontWithName:@"MarkerFelt-Wide" size:31.0];
    optionLabel4.backgroundColor = [UIColor clearColor];
    optionLabel4.textAlignment = NSTextAlignmentCenter;
    [optionView4 addSubview:optionLabel4];

    [self.view addSubview:optionView4];

    
    optionViewArray = [[NSArray alloc]initWithObjects:optionView1,optionView2,optionView3,optionView4, nil];
    if ([self.addOrSub isEqualToString:@"add"])
    {
        [self showRandomAddValues];
    }
    else
    {
        [self showRandomSubValues];
    }

}

#pragma mark Random Value Code

-(void)showRandomAddValues
{
    self.view.userInteractionEnabled = YES;
    numberOfCorrectAnsLabel.text = [NSString stringWithFormat:@"%d",correctAnsCount];
    numberOfInCorrectAnsLabel.text = [NSString stringWithFormat:@"%d",wrongAnsCount];
    
    optionView1.frame = CGRectMake(105, 760, 110, 100);
    optionView2.frame = CGRectMake(255, 620, 110, 100);
    optionView3.frame = CGRectMake(375, 800, 110, 100);
    optionView4.frame = CGRectMake(595, 720, 110, 100);
    int firstNo;
    int secondNo;
    
    if (ishighclass == YES)
    {
        
        // class 2
        if ([[[Util readPListData]objectForKey:@"level"]isEqualToString:@"EASY"])
        {
            firstNo = [self getRandomNumber:11 to:20];
            secondNo = [self getRandomNumber:11 to:20];
        }
        else if ([[[Util readPListData]objectForKey:@"level"]isEqualToString:@"MEDIUM"])
        {
            firstNo = [self getRandomNumber:15 to:30];
            secondNo = [self getRandomNumber:15 to:30];
        }
        else
        {
            firstNo = [self getRandomNumber:30 to:50];
            secondNo = [self getRandomNumber:30 to:50];
        }
    }
    else
    {
        // class 1
        if ([[[Util readPListData]objectForKey:@"level"]isEqualToString:@"EASY"])
        {
            firstNo = [self getRandomNumber:0 to:9];
            secondNo = [self getRandomNumber:1 to:9];
        }
        else if ([[[Util readPListData]objectForKey:@"level"]isEqualToString:@"MEDIUM"])
        {
            firstNo = [self getRandomNumber:11 to:20];
            secondNo = [self getRandomNumber:0 to:9];
        }
        else
        {
            firstNo = [self getRandomNumber:10 to:30];
            secondNo = [self getRandomNumber:10 to:30];
        }
    }
    
    
        ans = firstNo + secondNo;
        firstNumberLabel.text = [NSString stringWithFormat:@"%d",firstNo];
        secondNumberLabel.text = [NSString stringWithFormat:@"%d",secondNo];
        
        // finding a randow view and pasting the right ans to that view
        int randomRightAnsView = [self getRandomNumber:0 to:3];
        UIView *rightAnsBubbleView = optionViewArray[randomRightAnsView];
        for (id _subview in rightAnsBubbleView.subviews)
        {
            if ([_subview isKindOfClass:[UILabel class]])
            {
                UILabel *optionLabel = (UILabel *)_subview;
                optionLabel.text = [NSString stringWithFormat:@"%d",ans];
            }
        }
        
        // first wrong ans - right ans + 10
        int random1 = [self getRandomNumber:0 to:3];
        while (random1 == randomRightAnsView)
        {
            random1 = [self getRandomNumber:0 to:3];
        }
        int wrongAns1 = ans + 10;
        UIView *wrongAnsBubbleView1 = optionViewArray[random1];
        for (id _subview in wrongAnsBubbleView1.subviews)
        {
            if ([_subview isKindOfClass:[UILabel class]])
            {
                UILabel *optionLabel = (UILabel *)_subview;
                optionLabel.text = [NSString stringWithFormat:@"%d",wrongAns1];
            }
        }
        
        // second wrong ans - right ans + random value from 0-3
        int random2 = [self getRandomNumber:0 to:3];
        while (random2 == randomRightAnsView || random2 == random1)
        {
            random2 = [self getRandomNumber:0 to:3];
        }
        int wrongAns2 = ans + [self getRandomNumber:1 to:5];
        UIView *wrongAnsBubbleView2 = optionViewArray[random2];
        for (id _subview in wrongAnsBubbleView2.subviews)
        {
            if ([_subview isKindOfClass:[UILabel class]])
            {
                UILabel *optionLabel = (UILabel *)_subview;
                optionLabel.text = [NSString stringWithFormat:@"%d",wrongAns2];
            }
        }
        
        // third wrong ans = right ans -10 OR right ans + random value from 4-9
        int random3 = [self getRandomNumber:0 to:3];
        while (random3 == randomRightAnsView || random3 == random1 || random3 == random2)
        {
            random3 = [self getRandomNumber:0 to:3];
        }
        int wrongAns3=0;
        if (ans>10)
        {
            wrongAns3 = ans - 10;
        }
        else
        {
            wrongAns3 = ans + [self getRandomNumber:4 to:9];
        }
        UIView *wrongAnsBubbleView3 = optionViewArray[random3];
        for (id _subview in wrongAnsBubbleView3.subviews)
        {
            if ([_subview isKindOfClass:[UILabel class]])
            {
                UILabel *optionLabel = (UILabel *)_subview;
                optionLabel.text = [NSString stringWithFormat:@"%d",wrongAns3];
            }
        }
}


-(void)showRandomSubValues
{
    
    self.view.userInteractionEnabled = YES;
    
    numberOfCorrectAnsLabel.text = [NSString stringWithFormat:@"%d",correctAnsCount];
    numberOfInCorrectAnsLabel.text = [NSString stringWithFormat:@"%d",wrongAnsCount];
    
    optionView1.frame = CGRectMake(105, 740, 110, 100);
    optionView2.frame = CGRectMake(255, 600, 110, 100);
    optionView3.frame = CGRectMake(375, 780, 110, 100);
    optionView4.frame = CGRectMake(595, 700, 110, 100);
    int firstNo;
    int secondNo;
    
    if ([[[Util readPListData]objectForKey:@"level"]isEqualToString:@"EASY"])
    {
        firstNo = [self getRandomNumber:1 to:9];
        secondNo = [self getRandomNumber:0 to:firstNo];
    }
    else if ([[[Util readPListData]objectForKey:@"level"]isEqualToString:@"MEDIUM"])
    {
        firstNo = [self getRandomNumber:11 to:20];
        secondNo = [self getRandomNumber:0 to:9];
    }
    else
    {
        firstNo = [self getRandomNumber:10 to:30];
        secondNo = [self getRandomNumber:10 to:firstNo];
    }
    ans = firstNo - secondNo;
    firstNumberLabel.text = [NSString stringWithFormat:@"%d",firstNo];
    secondNumberLabel.text = [NSString stringWithFormat:@"%d",secondNo];
    
    // finding a randow view and pasting the right ans to that view
    int randomRightAnsView = [self getRandomNumber:0 to:3];
    UIView *rightAnsBubbleView = optionViewArray[randomRightAnsView];
    for (id _subview in rightAnsBubbleView.subviews)
    {
        if ([_subview isKindOfClass:[UILabel class]])
        {
            UILabel *optionLabel = (UILabel *)_subview;
            optionLabel.text = [NSString stringWithFormat:@"%d",ans];
        }
    }
    
    // first wrong ans - right ans + 10
    int random1 = [self getRandomNumber:0 to:3];
    while (random1 == randomRightAnsView)
    {
        random1 = [self getRandomNumber:0 to:3];
    }
    int wrongAns1 = ans + 10;
    UIView *wrongAnsBubbleView1 = optionViewArray[random1];
    for (id _subview in wrongAnsBubbleView1.subviews)
    {
        if ([_subview isKindOfClass:[UILabel class]])
        {
            UILabel *optionLabel = (UILabel *)_subview;
            optionLabel.text = [NSString stringWithFormat:@"%d",wrongAns1];
        }
    }
    
    // second wrong ans - right ans + random value from 0-3
    int random2 = [self getRandomNumber:0 to:3];
    while (random2 == randomRightAnsView || random2 == random1)
    {
        random2 = [self getRandomNumber:0 to:3];
    }
    int wrongAns2 = ans + [self getRandomNumber:1 to:5];
    UIView *wrongAnsBubbleView2 = optionViewArray[random2];
    for (id _subview in wrongAnsBubbleView2.subviews)
    {
        if ([_subview isKindOfClass:[UILabel class]])
        {
            UILabel *optionLabel = (UILabel *)_subview;
            optionLabel.text = [NSString stringWithFormat:@"%d",wrongAns2];
        }
    }
    
    // third wrong ans = right ans -10 OR right ans + random value from 4-9
    int random3 = [self getRandomNumber:0 to:3];
    while (random3 == randomRightAnsView || random3 == random1 || random3 == random2)
    {
        random3 = [self getRandomNumber:0 to:3];
    }
    int wrongAns3=0;
    if (ans>10)
    {
        wrongAns3 = ans - 10;
    }
    else
    {
        wrongAns3 = ans + [self getRandomNumber:4 to:9];
    }
    UIView *wrongAnsBubbleView3 = optionViewArray[random3];
    for (id _subview in wrongAnsBubbleView3.subviews)
    {
        if ([_subview isKindOfClass:[UILabel class]])
        {
            UILabel *optionLabel = (UILabel *)_subview;
            optionLabel.text = [NSString stringWithFormat:@"%d",wrongAns3];
        }
    }
} 

-(void)nextLevel:(UIButton *)sender
{
    NSMutableDictionary *plistDict = [Util readPListData];
    if ([[plistDict objectForKey:@"level"]isEqualToString:@"EASY"])
    {
        [plistDict setObject:@"MEDIUM" forKey:@"level"];
    }
    else if ([[plistDict objectForKey:@"level"]isEqualToString:@"MEDIUM"])
    {
        [plistDict setObject:@"HARD" forKey:@"level"];
        [sender removeFromSuperview];
    }
    [Util writeToPlist:plistDict];
    currentLevelLabel.text = [NSString stringWithFormat:@"Its - %@ Level",[[Util readPListData]objectForKey:@"level"]];
    if ([self.addOrSub isEqualToString:@"add"])
    {
        [self showRandomAddValues];
    }
    else
    {
        [self showRandomSubValues];
    }
    
}

#pragma mark TOUCH EVENT
- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
	
	// We only support single touches, so anyObject retrieves just that touch from touches
	touch = [touches anyObject];
	if ([touch tapCount] == 1)
    {
        // Only move the placard view if the touch was in the placard view
        if ([touch view] == optionView1||[touch view] == optionView2||[touch view] == optionView3||[touch view] == optionView4)
        {
            if ([touch view]==optionView1)
            {
                originalFrameOfOptionView1 = [touch view].frame;
               
            }
            else if ([touch view]==optionView2)
            {
                 originalFrameOfOptionView2 = [touch view].frame;
                  
            }
            else if ([touch view]==optionView3)
            {
                 originalFrameOfOptionView3 = [touch view].frame;
              
            }
            else if ([touch view]==optionView4)
            {
                originalFrameOfOptionView4 = [touch view].frame;
               
            }    
            // Animate the first touch
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
	
	// If the touch was in the placardView, move the placardView to its location
	if ([touch view] == optionView1||[touch view] == optionView2||[touch view] == optionView3||[touch view] == optionView4)
    {
		CGPoint location = [touch locationInView:self.view];
        [touch view].center = location;
		return;
	}
}


- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{

        touch = [touches anyObject];
    
	// If the touch was in the placardView, bounce it back to the center
	if ([touch view] == optionView1||[touch view] == optionView2||[touch view] == optionView3||[touch view] == optionView4)
    {
#define GROW_ANIMATION_DURATION_SECONDS 0.15
        CGPoint touchPoint = [touch locationInView:self.view];
        NSValue *touchPointValue = [NSValue valueWithCGPoint:touchPoint];
        [UIView beginAnimations:nil context:(__bridge void *)(touchPointValue)];
        [UIView setAnimationDuration:GROW_ANIMATION_DURATION_SECONDS];
        [UIView setAnimationDelegate:self];
        //[UIView setAnimationDidStopSelector:@selector(growAnimationDidStop:finished:context:)];
        CGAffineTransform transform = CGAffineTransformMakeScale(1.0f, 1.0f);
        [touch view].transform = transform;
        [UIView commitAnimations];
        
        //first compare the frame of option with the given question label or given but hidden question label . If the draggable frame lies within the given frame then drop it dere and then after dropping it , compare the title of draggable one with the visible or hidden one
        CGRect myRect = CGRectMake(450, 400, 310, 170);
        BOOL isInside = CGRectContainsPoint(myRect, touchPoint);
        
        if(isInside)
        {
            self.view.userInteractionEnabled = NO;
            NSArray *subviewArray = [touch view].subviews;
            UIImageView *orangeImage = (UIImageView*)[subviewArray objectAtIndex:0];
            
            if ([[(UILabel*)[subviewArray objectAtIndex:1] text]intValue] == ans)
            {
                // correct ans
                wrongOrRightValue = 1;
                NSValue *touchPointValue = [NSValue valueWithCGPoint:touchPoint];
                [UIView beginAnimations:nil context:(__bridge void *)(touchPointValue)];
                [UIView setAnimationDuration:0.15];
                [UIView setAnimationDelegate:self];
                //[UIView setAnimationDidStopSelector:@selector(growAnimationDidStop:finished:context:)];
                CGAffineTransform transform = CGAffineTransformMakeScale(2.5f, 2.5f);
                smileLogo.transform = transform;
                [UIView commitAnimations];
                
                [touch view].center = ansBoxView.center;
                correctAnsCount++;
                NSString *imageName = [NSString stringWithFormat:@"bodypart%d",correctAnsCount];
                hangmanImage.image = [UIImage imageNamed:imageName];
                hangmanImage.frame = CGRectMake(hangmanImage.frame.origin.x, hangmanImage.frame.origin.y,hangmanImage.frame.size.width+correctAnsCount*2, hangmanImage.frame.size.height + correctAnsCount*2);
            }
            else
            {
                // wrong ans
                wrongOrRightValue = 0;
                
                
                UILabel *answerLabel=[[UILabel alloc]initWithFrame:CGRectMake(490, 350, 250, 60)];
                answerLabel.backgroundColor=[UIColor whiteColor];
                answerLabel.textColor=[UIColor redColor];
                answerLabel.layer.cornerRadius=5.0;
                answerLabel.layer.borderWidth=1.0;
                answerLabel.textAlignment=NSTextAlignmentCenter;
                answerLabel.font=[UIFont boldSystemFontOfSize:18];
                [self.view addSubview:answerLabel];
                [answerLabel setHidden:NO];
                answerLabel.text=[NSString stringWithFormat:@"Correct Answer is: %d",ans];
                

                dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, 1.0 * NSEC_PER_SEC);
                dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
                    [answerLabel setHidden:YES];
                });
                
                NSValue *touchPointValue = [NSValue valueWithCGPoint:touchPoint];
                [UIView beginAnimations:nil context:(__bridge void *)(touchPointValue)];
                [UIView setAnimationDuration:0.15];
                [UIView setAnimationDelegate:self];
                //[UIView setAnimationDidStopSelector:@selector(growAnimationDidStop:finished:context:)];
                CGAffineTransform transform = CGAffineTransformMakeScale(2.5f, 2.5f);
                sadLogo.transform = transform;
                [UIView commitAnimations];
                
                //orangeImage.image = [UIImage imageNamed:@"wrong"];
                touch.view.center = ansBoxView.center;
                wrongAnsCount++;
                
            }
            [self performSelector:@selector(showNextQuestion:) withObject:orangeImage afterDelay:1.0];
                
            return;
        }
        else
        {
            // not properly dragged
            if ([touch view]==optionView1)
            {
                [touch view].frame = originalFrameOfOptionView1;
            }
            else if ([touch view]==optionView2)
            {
                [touch view].frame = originalFrameOfOptionView2;
            }
            else if ([touch view]==optionView3)
            {
                [touch view].frame = originalFrameOfOptionView3;
            }
            else if ([touch view]==optionView4)
            {
                [touch view].frame = originalFrameOfOptionView4;
            }
        }
        
		return;
	}
}

-(void)showNextQuestion:(UIImageView *)_redBubbleImage
{
    CGPoint touchPoint;
    if (wrongOrRightValue ==1) // correct ans
    {
        touchPoint = smileLogo.center;
    }
    else
    {
        touchPoint = sadLogo.center;
    }
    
    NSValue *touchPointValue = [NSValue valueWithCGPoint:touchPoint];
    [UIView beginAnimations:nil context:(__bridge void *)(touchPointValue)];
    [UIView setAnimationDuration:GROW_ANIMATION_DURATION_SECONDS];
    [UIView setAnimationDelegate:self];
    //[UIView setAnimationDidStopSelector:@selector(growAnimationDidStop:finished:context:)];
    CGAffineTransform transform = CGAffineTransformMakeScale(1.0f, 1.0f);
    
    if (wrongOrRightValue ==1) // correct ans
    {
        smileLogo.transform = transform;
    }
    else
    {
        sadLogo.transform = transform;
    }
    
    [UIView commitAnimations];
    _redBubbleImage.image = [UIImage imageNamed:@"orangebubble"];
    if ([self.addOrSub isEqualToString:@"add"])
    {
        [self showRandomAddValues];
    }
    else
    {
        [self showRandomSubValues];
    }
    
}

- (void)animateFirstTouchAtPoint:(CGPoint)touchPoint
{
	
	
#define GROW_ANIMATION_DURATION_SECONDS 0.15
	
	NSValue *touchPointValue = [NSValue valueWithCGPoint:touchPoint];
	[UIView beginAnimations:nil context:(__bridge void *)(touchPointValue)];
	[UIView setAnimationDuration:GROW_ANIMATION_DURATION_SECONDS];
	[UIView setAnimationDelegate:self];
	//[UIView setAnimationDidStopSelector:@selector(growAnimationDidStop:finished:context:)];
	CGAffineTransform transform = CGAffineTransformMakeScale(1.3f, 1.3f);
	[touch view].transform = transform;
	[UIView commitAnimations];
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

@end
