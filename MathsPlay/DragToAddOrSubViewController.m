//
//  DragToAddOrSubViewController.m
//  KidsLearningGame
//
//  Created by QA Infotech on 11/07/13.
//  Copyright (c) 2013 QAInfotech. All rights reserved.
//

#import "DragToAddOrSubViewController.h"
#define GREEN_COLOR [UIColor colorWithRed:120/255.0 green:192/255.0  blue:42/255.0  alpha:1]

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
 
    
    UIButton * helpButton=[UIButton buttonWithType:UIButtonTypeCustom];
    [helpButton setImage:[UIImage imageNamed:@"rules"] forState:UIControlStateNormal];
    helpButton.tag=100011;
    [helpButton addTarget:self action:@selector(buttonActionMethod:) forControlEvents:UIControlEventTouchUpInside];
    helpButton.frame=CGRectMake(self.view.frame.size.width-100 ,20, 90, 50);
    helpButton.showsTouchWhenHighlighted=YES;
    [self.view addSubview:helpButton];
    
    //http://all-free-download.com/free-vector/vector-background/free_vector_cartoon_natural_278578_download.html
    UIGraphicsBeginImageContext(CGSizeMake(self.view.frame.size.width, self.view.frame.size.height));
    [[UIImage imageNamed:@"background-4"] drawInRect:self.view.bounds];
    UIImage *image =UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    [self.view setBackgroundColor:[UIColor colorWithPatternImage:image]];
    
    UIView *LeftContainerView=[[UIView alloc]initWithFrame:CGRectMake(-5, 20, 200,200)];
    LeftContainerView.backgroundColor=[UIColor yellowColor];
    LeftContainerView.layer.cornerRadius=7.0;
    LeftContainerView.layer.borderWidth=1.5;
    LeftContainerView.layer.borderColor=[UIColor whiteColor].CGColor;
    UIBezierPath *shadowPath = [UIBezierPath bezierPathWithRect:LeftContainerView.bounds];
    //   rightView.layer.masksToBounds = NO;
    LeftContainerView.layer.shadowColor = [UIColor whiteColor].CGColor;
    LeftContainerView.layer.shadowOffset = CGSizeMake(0.0f, 20.0f);
    LeftContainerView.layer.shadowRadius=10.0;
    LeftContainerView.layer.shadowOpacity = 0.5f;
    LeftContainerView.layer.shadowPath = shadowPath.CGPath;
    [self.view addSubview:LeftContainerView];
    
    
    
    levelTag = [[UILabel alloc]initWithFrame:CGRectMake(20, 0, 150, 30)];
    levelTag.text = [NSString stringWithFormat:@"LEVEL : %@",[[Util readPListData]objectForKey:@"level"]];
    levelTag.font = [UIFont fontWithName:@"Futura" size:15];
    levelTag.textColor = [UIColor whiteColor];
    levelTag.layer.cornerRadius=5.0;
    levelTag.textAlignment=NSTextAlignmentCenter;
    levelTag.backgroundColor = GREEN_COLOR;
    [LeftContainerView  addSubview:levelTag];

    numberOfCorrectAnsLabel = [[UILabel alloc]initWithFrame:CGRectMake(30, 50,LeftContainerView.frame.size.width, 30)];
    numberOfCorrectAnsLabel.textColor = [UIColor blackColor];
    numberOfCorrectAnsLabel.backgroundColor = [UIColor clearColor];
    numberOfCorrectAnsLabel.text = [NSString stringWithFormat:@"Correct : %d",correctAnsCount];
    numberOfCorrectAnsLabel.textAlignment = NSTextAlignmentLeft;
    numberOfCorrectAnsLabel.font = [UIFont fontWithName:@"Futura" size:20.0];
    [LeftContainerView addSubview:numberOfCorrectAnsLabel];
    
    
    numberOfInCorrectAnsLabel = [[UILabel alloc]initWithFrame:CGRectMake(30, 100, LeftContainerView.frame.size.width, 30)];
    numberOfInCorrectAnsLabel.textColor = [UIColor redColor];
    numberOfInCorrectAnsLabel.backgroundColor = [UIColor clearColor];
    numberOfInCorrectAnsLabel.text = [NSString stringWithFormat:@"Wrong : %d",wrongAnsCount];
    numberOfInCorrectAnsLabel.textAlignment = NSTextAlignmentLeft;
    numberOfInCorrectAnsLabel.font = [UIFont fontWithName:@"Futura" size:20.0];
    [LeftContainerView addSubview:numberOfInCorrectAnsLabel];

    
    
    
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
    
    UILabel *usernameLabel = [[UILabel alloc]initWithFrame:CGRectMake(250, 10, 300, 40)];
    usernameLabel.textColor = [UIColor whiteColor];
    usernameLabel.font=[UIFont fontWithName:@"Futura" size:20];
    usernameLabel.backgroundColor =[UIColor clearColor];
    usernameLabel.textAlignment=NSTextAlignmentCenter;
    
    usernameLabel.text = [NSString stringWithFormat:@"Hi   %@",[[Util readPListData]objectForKey:@"username"]];
    [self.view addSubview:usernameLabel];
    
     if (![[[Util readPListData]objectForKey:@"level"] isEqualToString:@"HARD"])
    {
        nextLevelBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [nextLevelBtn setTitle:@"SKIP LEVEL" forState:UIControlStateNormal];
        [nextLevelBtn setFrame:CGRectMake(20, LeftContainerView.frame.size.height-30, 150, 30)];
        nextLevelBtn.layer.cornerRadius=5.0;
        nextLevelBtn.titleLabel.font= [UIFont fontWithName:@"Futura" size:15];
        nextLevelBtn.backgroundColor = GREEN_COLOR;
        [nextLevelBtn addTarget:self action:@selector(nextLevel:) forControlEvents:UIControlEventTouchUpInside];
        [LeftContainerView addSubview:nextLevelBtn];

    }
    
    
    hangmanImage = [[UIImageView alloc]initWithFrame:CGRectMake(250, 250, 50, 50)];
    hangmanImage.image = [UIImage imageNamed:@"aaa"];
    [self.view addSubview:hangmanImage];
    
    firstNumberLabel = [[UILabel alloc]initWithFrame:CGRectMake(30, 450, 150, 100)];
    firstNumberLabel.textColor = [UIColor orangeColor];
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
    secondNumberLabel.textColor = [UIColor orangeColor];
    secondNumberLabel.textAlignment = NSTextAlignmentCenter;
    secondNumberLabel.font = [UIFont fontWithName:@"GillSans-Bold" size:100.0];
    [self.view addSubview:secondNumberLabel];

    
    UIImageView *equalImage = [[UIImageView alloc]initWithFrame:CGRectMake(410, 465, 70, 70)];
    equalImage.image = [UIImage imageNamed:@"equalto"];
    [self.view addSubview:equalImage];

    
    ansBoxView = [[UIView alloc]initWithFrame:CGRectMake(490, 440, 250, 120)];
    ansBoxView.backgroundColor = [UIColor lightTextColor];
    ansBoxView.layer.borderWidth = 1.0;
    ansBoxView.layer.borderColor = [[UIColor orangeColor]CGColor];
    ansBoxView.layer.cornerRadius = 9.0;
    [self.view addSubview:ansBoxView];

    
    UITapGestureRecognizer *recognizer=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(handleTap:)];
    recognizer.numberOfTapsRequired=1;
    ansBoxView.userInteractionEnabled=YES;
    [ansBoxView addGestureRecognizer:recognizer];

    
    
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
    NSString *rules;
    
    optionViewArray = [[NSArray alloc]initWithObjects:optionView1,optionView2,optionView3,optionView4, nil];
    if ([self.addOrSub isEqualToString:@"add"])
    {
        [self showRandomAddValues];
        rules=@"a)Drag the correct answer to the answer area.\n\nb)If answer is correct an art is revealed.\n\nc)complete the hidden image by giving correct answer";

    }
    else
    {
        [self showRandomSubValues];
        rules=@"a)Choose correct operator.(>,=,<)\n\nb)On completing 5 question correctly you earn a star.\n\nc)Try to earn maximum stars to clear different level.";

    }

    
    
    
}


-(void)handleTap:(UITapGestureRecognizer *)recognizer {
    [self DisplayWarning];
}

#pragma mark Rules Method
-(void)buttonActionMethod:(UIButton *)sender
{
    MODAL_FOR_RULES;
    HEADER_TITLE;
    SPIRAL_VIEW;
    INSTRUCTION_LABEL_WITHOUT_TEXT;
    instructionLabel.text=@"a)Choose correct operator.(>,=,<)\n\nb)On completing 5 question correctly you earn a star.\n\nc)Try to earn maximum stars to clear different level.";
    FOOTER_TITLE;
}
-(void)handleTapOnModal:(UITapGestureRecognizer *)recognizer
{
    [self dismissViewControllerAnimated:YES completion:NULL];
}



#pragma mark Random Value Code

-(void)showRandomAddValues
{
    self.view.userInteractionEnabled = YES;
    
    numberOfCorrectAnsLabel.text = [NSString stringWithFormat:@"Correct : %d",correctAnsCount];
    numberOfInCorrectAnsLabel.text = [NSString stringWithFormat:@"Wrong : %d",wrongAnsCount];
    
    optionView1.frame = CGRectMake(90, 760, 110, 100);
    optionView2.frame = CGRectMake(255, 670, 110, 100);
    optionView3.frame = CGRectMake(375, 820, 110, 100);
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
    
    numberOfCorrectAnsLabel.text = [NSString stringWithFormat:@"Correct : %d",correctAnsCount];
    numberOfInCorrectAnsLabel.text = [NSString stringWithFormat:@"Wrong : %d",wrongAnsCount];
    
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
    levelTag.text = [NSString stringWithFormat:@"LEVEL : %@",[[Util readPListData]objectForKey:@"level"]];
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
                [self DisplayCorrectAnswerMessage];
                NSString *imageName = [NSString stringWithFormat:@"bodypart%d",correctAnsCount];
                hangmanImage.image = [UIImage imageNamed:imageName];
                hangmanImage.frame = CGRectMake(hangmanImage.frame.origin.x, hangmanImage.frame.origin.y,hangmanImage.frame.size.width+correctAnsCount*2, hangmanImage.frame.size.height + correctAnsCount*2);
            }
            else
            {
                // wrong ans
                wrongOrRightValue = 0;
                
                
                [self DisplayCorrectAnswer];
                
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

-(void)DisplayWarning
{
    UILabel *warningLabel=[[UILabel alloc]initWithFrame:CGRectMake(220, 320, 330, 100)];
    warningLabel.backgroundColor=[UIColor yellowColor];
    warningLabel.textColor=[UIColor blackColor];
    warningLabel.layer.cornerRadius=10.0;
   // warningLabel.layer.borderWidth=1.0;
    warningLabel.textAlignment=NSTextAlignmentCenter;
    warningLabel.font=[UIFont fontWithName:@"Futura" size:25];
    [self.view addSubview:warningLabel];
    [warningLabel setHidden:NO];
    warningLabel.numberOfLines=0;
    warningLabel.text=@"Drag bubble in answer area";
    
    dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, 1.2 * NSEC_PER_SEC);
    dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
        [warningLabel setHidden:YES];
        [warningLabel removeFromSuperview];
    });
}
-(void)DisplayCorrectAnswer
{
    UILabel *answerLabel=[[UILabel alloc]initWithFrame:CGRectMake(220, 320, 330, 100)];
    answerLabel.backgroundColor=[UIColor redColor];
    answerLabel.textColor=[UIColor whiteColor];
    answerLabel.layer.cornerRadius=10.0;
  //  answerLabel.layer.borderWidth=1.0;
    answerLabel.textAlignment=NSTextAlignmentCenter;
    answerLabel.font=[UIFont fontWithName:@"Futura" size:30];
    [self.view addSubview:answerLabel];
    [answerLabel setHidden:NO];
    answerLabel.text=[NSString stringWithFormat:@"Correct Answer is: %d",ans];

     dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, 1.0 * NSEC_PER_SEC);
    dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
        [answerLabel setHidden:YES];
        [answerLabel removeFromSuperview];
    });
    
}

-(void)DisplayCorrectAnswerMessage
{
    UILabel *correctAnswerLabel=[[UILabel alloc]initWithFrame:CGRectMake(220, 320, 330, 100)];
    correctAnswerLabel.backgroundColor=GREEN_COLOR;
    correctAnswerLabel.textColor=[UIColor whiteColor];
    correctAnswerLabel.layer.cornerRadius=10.0;
   // correctAnswerLabel.layer.borderWidth=1.0;
    correctAnswerLabel.textAlignment=NSTextAlignmentCenter;
    correctAnswerLabel.font=[UIFont fontWithName:@"Futura" size:30];
    [self.view addSubview:correctAnswerLabel];
    [correctAnswerLabel setHidden:NO];
    correctAnswerLabel.text=@"Well Done !!";
    
    dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, 1.0 * NSEC_PER_SEC);
    dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
        [correctAnswerLabel setHidden:YES];
        [correctAnswerLabel removeFromSuperview];
    });
    
    
}

@end
