//
//  DragBubblesViewController.m
//  KidsLearningGame
//
//  Created by QA Infotech on 10/07/13.
//  Copyright (c) 2013 QAInfotech. All rights reserved.
//


//images sources http://wall.alphacoders.com/
#import "DragBubblesViewController.h"

@interface DragBubblesViewController ()
{
    NSUInteger fishescatched;
    NSUInteger negativeX1,negativeX2,negativeX3,negativeX4,negativeX5,negativeX6;
    BOOL isFish1MovementRight,isFish2MovementRight,isFish3MovementRight,isFish4MovementRight,isFish5MovementRight,isFish6MovementRight;
    BOOL isFirstTimeRun1,isFirstTimeRun2,isFirstTimeRun3,isFirstTimeRun4,isFirstTimeRun5,isFirstTimeRun6;
    AVAudioPlayer *startupAudio;
}
@end

@implementation DragBubblesViewController
static float alph = 0.7;
@synthesize bubbleNumber;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        
        self.title = @"Catch Your Fish";
        //audio player start
        
        NSURL *url = [NSURL fileURLWithPath:[NSString stringWithFormat:@"%@/hifi.mp3", [[NSBundle mainBundle] resourcePath]]];
        startupAudio = [[AVAudioPlayer alloc] initWithContentsOfURL:url error:nil];
        startupAudio.numberOfLoops = 0;
        [startupAudio play];
    }
    return self;
}

-(void)viewWillDisappear:(BOOL)animated
{
    if (timerStopValue ==1)
    {
        [timerForLabelMarquee invalidate];
        [timerForWinningStage invalidate];
        [audioPlayerClap stop];
    }
    [self.navigationController popToRootViewControllerAnimated:NO];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    
    //self.view.backgroundColor = [UIColor colorWithRed:77/255.0 green:77/255.0 blue:77/255.0 alpha:1];
    
    self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"ocean7.jpg"]];

    
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
    
    dic = [Util readPListData];
    
    avatarImage = [[UIImageView alloc]initWithFrame:CGRectMake(25, 20, 140, 130)];
    NSData *imageData = [dic objectForKey:@"avatarImage"];
    
    avatarImage.image = [UIImage imageWithData:imageData];
    [self.view addSubview:avatarImage];
    
    greetingsLabel = [[UILabel alloc]initWithFrame:CGRectMake(250, 50, 250, 30)];
    greetingsLabel.text = [NSString stringWithFormat:@"Hi  %@",[dic objectForKey:@"username"]];
    greetingsLabel.textAlignment = NSTextAlignmentCenter;
    greetingsLabel.textColor = [UIColor whiteColor];
    greetingsLabel.font = [UIFont fontWithName:@"Noteworthy-Bold" size:31.0];
    greetingsLabel.backgroundColor = [UIColor clearColor];
    [self.view addSubview:greetingsLabel];
    
    journeyLabel = [[UILabel alloc]initWithFrame:CGRectMake(250, 100, 250, 60)];
    journeyLabel.text = [NSString stringWithFormat:@"Fishes Catched : %d",fishescatched];
    journeyLabel.textAlignment = NSTextAlignmentCenter;
    journeyLabel.textColor = [UIColor yellowColor];
    journeyLabel.font = [Util themeFontWithSize:25.0];
    journeyLabel.backgroundColor = [UIColor clearColor];
    [self.view addSubview:journeyLabel];
    
    nextLevelButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [nextLevelButton setImage:[UIImage imageNamed:@"next_icon.gif"] forState:UIControlStateNormal];
    nextLevelButton.frame = CGRectMake(660, 50, 80, 60);
    [nextLevelButton addTarget:self action:@selector(nextLevelButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
    
    if (![[dic objectForKey:@"level"] isEqualToString:@"HARD"])
    {
        [self.view addSubview:nextLevelButton];
    }
    
    messageLabel = [[UILabel alloc]initWithFrame:CGRectMake(85, 130, 600, 60)];
    messageLabel.textAlignment = NSTextAlignmentCenter;
    messageLabel.textColor = [UIColor colorWithRed:238/255.0 green:43/255.0 blue:123/255.0 alpha:1.0];
    [messageLabel setHidden:YES];
    messageLabel.font = [UIFont fontWithName:@"Chalkduster" size:29.0f];
    messageLabel.layer.shadowColor = [greetingsLabel.textColor CGColor];
    messageLabel.layer.shadowOffset = CGSizeMake(0.0, 0.0);
    messageLabel.layer.shadowRadius = 20.0;
    messageLabel.layer.shadowOpacity = 0.5;
    messageLabel.layer.masksToBounds = NO;
    messageLabel.backgroundColor = [UIColor clearColor];
    [self.view addSubview:messageLabel];
    
    
    numberLabel1 = [[UILabel alloc]initWithFrame:CGRectMake(0, 330, 130, 100)];
    numberLabel1.text = @"1";
    numberLabel1.textAlignment = NSTextAlignmentCenter;
    numberLabel1.textColor = [UIColor colorWithRed:255/255.0 green:75/255.0 blue:51/255.0 alpha:1.0];
    numberLabel1.font = [UIFont fontWithName:@"MarkerFelt-Wide" size:49.0f];
    numberLabel1.layer.shadowColor = [instructionLabel.textColor CGColor];
    numberLabel1.layer.shadowOffset = CGSizeMake(0.0, 0.0);
    numberLabel1.layer.shadowRadius = 20.0;
    numberLabel1.layer.shadowOpacity = 0.5;
    numberLabel1.layer.masksToBounds = NO;
    numberLabel1.backgroundColor = [UIColor clearColor];
    [self.view addSubview:numberLabel1];

    
    numberLabel2 = [[UILabel alloc]initWithFrame:CGRectMake(130, 330, 130, 100)];
    numberLabel2.text = @"1";
    numberLabel2.textAlignment = NSTextAlignmentCenter;
    numberLabel2.textColor = [UIColor colorWithRed:255/255.0 green:75/255.0 blue:51/255.0 alpha:1.0];
    numberLabel2.font = [UIFont fontWithName:@"MarkerFelt-Wide" size:49.0f];
    numberLabel2.layer.shadowColor = [instructionLabel.textColor CGColor];
    numberLabel2.layer.shadowOffset = CGSizeMake(0.0, 0.0);
    numberLabel2.layer.shadowRadius = 20.0;
    numberLabel2.layer.shadowOpacity = 0.5;
    numberLabel2.layer.masksToBounds = NO;
    numberLabel2.backgroundColor = [UIColor clearColor];
    [self.view addSubview:numberLabel2];

    
    numberLabel3 = [[UILabel alloc]initWithFrame:CGRectMake(260, 330, 130, 100)];
    numberLabel3.text = @"1";
    numberLabel3.textAlignment = NSTextAlignmentCenter;
    numberLabel3.textColor = [UIColor colorWithRed:255/255.0 green:75/255.0 blue:51/255.0 alpha:1.0];
    numberLabel3.font = [UIFont fontWithName:@"MarkerFelt-Wide" size:49.0f];
    numberLabel3.layer.shadowColor = [instructionLabel.textColor CGColor];
    numberLabel3.layer.shadowOffset = CGSizeMake(0.0, 0.0);
    numberLabel3.layer.shadowRadius = 20.0;
    numberLabel3.layer.shadowOpacity = 0.5;
    numberLabel3.layer.masksToBounds = NO;
    numberLabel3.backgroundColor = [UIColor clearColor];
    [self.view addSubview:numberLabel3];

    
    numberLabel4 = [[UILabel alloc]initWithFrame:CGRectMake(390, 330, 130, 100)];
    numberLabel4.text = @"1";
    numberLabel4.textAlignment = NSTextAlignmentCenter;
    numberLabel4.textColor = [UIColor colorWithRed:255/255.0 green:75/255.0 blue:51/255.0 alpha:1.0];
    numberLabel4.font = [UIFont fontWithName:@"MarkerFelt-Wide" size:49.0f];
    numberLabel4.layer.shadowColor = [instructionLabel.textColor CGColor];
    numberLabel4.layer.shadowOffset = CGSizeMake(0.0, 0.0);
    numberLabel4.layer.shadowRadius = 20.0;
    numberLabel4.layer.shadowOpacity = 0.5;
    numberLabel4.layer.masksToBounds = NO;
    numberLabel4.backgroundColor = [UIColor clearColor];
    [self.view addSubview:numberLabel4];

    
    numberLabel5 = [[UILabel alloc]initWithFrame:CGRectMake(520, 330, 130, 100)];
    numberLabel5.text = @"1";
    numberLabel5.textAlignment = NSTextAlignmentCenter;
    numberLabel5.textColor = [UIColor colorWithRed:255/255.0 green:75/255.0 blue:51/255.0 alpha:1.0];
    numberLabel5.font = [UIFont fontWithName:@"MarkerFelt-Wide" size:49.0f];
    numberLabel5.layer.shadowColor = [instructionLabel.textColor CGColor];
    numberLabel5.layer.shadowOffset = CGSizeMake(0.0, 0.0);
    numberLabel5.layer.shadowRadius = 20.0;
    numberLabel5.layer.shadowOpacity = 0.5;
    numberLabel5.layer.masksToBounds = NO;
    numberLabel5.backgroundColor = [UIColor clearColor];
    [self.view addSubview:numberLabel5];

    
    numberLabel6 = [[UILabel alloc]initWithFrame:CGRectMake(650, 330, 130, 100)];
    numberLabel6.text = @"1";
    numberLabel6.textAlignment = NSTextAlignmentCenter;
    numberLabel6.textColor = [UIColor colorWithRed:255/255.0 green:75/255.0 blue:51/255.0 alpha:1.0];
    numberLabel6.font = [UIFont fontWithName:@"MarkerFelt-Wide" size:49.0f];
    numberLabel6.layer.shadowColor = [instructionLabel.textColor CGColor];
    numberLabel6.layer.shadowOffset = CGSizeMake(0.0, 0.0);
    numberLabel6.layer.shadowRadius = 20.0;
    numberLabel6.layer.shadowOpacity = 0.5;
    numberLabel6.layer.masksToBounds = NO;
    numberLabel6.backgroundColor = [UIColor clearColor];
    [self.view addSubview:numberLabel6];

    
    orangeImage1 = [[UIImageView alloc]initWithFrame:CGRectMake(0, 300, 130, 140)];
    orangeImage1.image = [UIImage imageNamed:@"bottle"];
    [orangeImage1 setHidden:YES];
    [self.view addSubview:orangeImage1];

    
    orangeImage2 = [[UIImageView alloc]initWithFrame:CGRectMake(130, 300, 130, 140)];
    orangeImage2.image = [UIImage imageNamed:@"bottle"];
    [orangeImage2 setHidden:YES];
    [self.view addSubview:orangeImage2];

    
    orangeImage3 = [[UIImageView alloc]initWithFrame:CGRectMake(260, 300, 130, 140)];
    orangeImage3.image = [UIImage imageNamed:@"bottle"];
    [orangeImage3 setHidden:YES];
    [self.view addSubview:orangeImage3];

    
    orangeImage4 = [[UIImageView alloc]initWithFrame:CGRectMake(390, 300, 130, 140)];
    orangeImage4.image = [UIImage imageNamed:@"bottle"];
    [orangeImage4 setHidden:YES];
    [self.view addSubview:orangeImage4];

    
    orangeImage5 = [[UIImageView alloc]initWithFrame:CGRectMake(520, 300, 130, 140)];
    orangeImage5.image = [UIImage imageNamed:@"bottle"];
    [orangeImage5 setHidden:YES];
    [self.view addSubview:orangeImage5];

    
    orangeImage6 = [[UIImageView alloc]initWithFrame:CGRectMake(650, 300, 130, 140)];
    orangeImage6.image = [UIImage imageNamed:@"bottle"];
    [orangeImage6 setHidden:YES];
    [self.view addSubview:orangeImage6];

    
    optionView1 = [[UIView alloc]initWithFrame:CGRectMake(520, 460, 130, 100)];
    optionView1.backgroundColor = [UIColor clearColor];
    optionImage1 = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 130, 100)];
    optionImage1.image = [UIImage imageNamed:@"fish1"];
    [optionView1 addSubview:optionImage1];
    optionLabel1 = [[UILabel alloc]initWithFrame:CGRectMake(27, 20, 70, 70)];
    optionLabel1.font = [UIFont fontWithName:@"Helvetica-Bold" size:31.0];
    optionLabel1.backgroundColor = [UIColor clearColor];
    optionLabel1.textAlignment = NSTextAlignmentCenter;
    [optionView1 addSubview:optionLabel1];
    [self.view addSubview:optionView1];

    
    optionView2 = [[UIView alloc]initWithFrame:CGRectMake(495, 597, 130, 100)];
    optionView2.backgroundColor = [UIColor clearColor];
    optionImage2 = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 130, 100)];
    optionImage2.image = [UIImage imageNamed:@"fish1"];
    [optionView2 addSubview:optionImage2];
    optionLabel2 = [[UILabel alloc]initWithFrame:CGRectMake(27, 20, 70, 70)];
    optionLabel2.font = [UIFont fontWithName:@"Helvetica-Bold" size:31.0];
    optionLabel2.backgroundColor = [UIColor clearColor];
    optionLabel2.textAlignment = NSTextAlignmentCenter;
    [optionView2 addSubview:optionLabel2];
    [self.view addSubview:optionView2];

    
    optionView3 = [[UIView alloc]initWithFrame:CGRectMake(650, 530, 130, 100)];
    optionView3.backgroundColor = [UIColor clearColor];
    optionImage3 = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 130, 100)];
    optionImage3.image = [UIImage imageNamed:@"fish1"];
    [optionView3 addSubview:optionImage3];
    optionLabel3 = [[UILabel alloc]initWithFrame:CGRectMake(27, 20, 70, 70)];
    optionLabel3.font = [UIFont fontWithName:@"Helvetica-Bold" size:31.0];
    optionLabel3.backgroundColor = [UIColor clearColor];
    optionLabel3.textAlignment = NSTextAlignmentCenter;
    [optionView3 addSubview:optionLabel3];
    [self.view addSubview:optionView3];

    
    optionView4 = [[UIView alloc]initWithFrame:CGRectMake(595, 660, 130, 100)];
    optionView4.backgroundColor = [UIColor clearColor];
    optionImage4 = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 130, 100)];
    optionImage4.image = [UIImage imageNamed:@"fish1"];
    [optionView4 addSubview:optionImage4];
    optionLabel4 = [[UILabel alloc]initWithFrame:CGRectMake(27, 20, 70, 70)];
    optionLabel4.font = [UIFont fontWithName:@"Helvetica-Bold" size:31.0];
    optionLabel4.backgroundColor = [UIColor clearColor];
    optionLabel4.textAlignment = NSTextAlignmentCenter;
    [optionView4 addSubview:optionLabel4];
    [self.view addSubview:optionView4];

    
    optionView5 = [[UIView alloc]initWithFrame:CGRectMake(640, 730, 130, 100)];
    optionView5.backgroundColor = [UIColor clearColor];
    optionImage5 = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 130, 100)];
    optionImage5.image = [UIImage imageNamed:@"fish1"];
    [optionView5 addSubview:optionImage5];
    optionLabel5 = [[UILabel alloc]initWithFrame:CGRectMake(27, 20, 70, 70)];
    optionLabel5.font = [UIFont fontWithName:@"Helvetica-Bold" size:31.0];
    optionLabel5.backgroundColor = [UIColor clearColor];
    optionLabel5.textAlignment = NSTextAlignmentCenter;
    [optionView5 addSubview:optionLabel5];
    [self.view addSubview:optionView5];

    
    optionView6 = [[UIView alloc]initWithFrame:CGRectMake(450, 795, 130, 100)];
    optionView6.backgroundColor = [UIColor clearColor];
    optionImage6 = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 130, 100)];
    optionImage6.image = [UIImage imageNamed:@"fish1"];
    [optionView6 addSubview:optionImage6];
    optionLabel6 = [[UILabel alloc]initWithFrame:CGRectMake(27, 20, 70, 70)];
    optionLabel6.font = [UIFont fontWithName:@"Helvetica-Bold" size:31.0];
    optionLabel6.backgroundColor = [UIColor clearColor];
    optionLabel6.textAlignment = NSTextAlignmentCenter;
    [optionView6 addSubview:optionLabel6];
    [self.view addSubview:optionView6];
    
    [self setConstants];
    
    [self setTimerForFishMovement];
    
    [self showRandomValues];
     
}


- (void) setConstants {
    optionframe1value = 1;
    optionframe2value = 1;
    optionframe3value = 1;
    optionframe4value = 1;
    optionframe5value = 1;
    optionframe6value = 1;
    fishescatched = 0;
    isFish1MovementRight = NO;
    isFish2MovementRight = NO;
    negativeX1 = 1;
    negativeX2 = 1;
    negativeX3 = 1;
    negativeX4 = 1;
    negativeX5 = 1;
    negativeX6 = 1;
    isFirstTimeRun1 = NO; isFirstTimeRun2 = NO; isFirstTimeRun3 = NO; isFirstTimeRun4 = NO; isFirstTimeRun5 = NO; isFirstTimeRun6 = NO;
}


- (void)setTimerForFishMovement {

    fish1 = [NSTimer scheduledTimerWithTimeInterval:0.03 target:self selector:@selector(moveFishLeft1) userInfo:nil repeats:YES];
    fish2 = [NSTimer scheduledTimerWithTimeInterval:0.03 target:self selector:@selector(moveFishLeft2) userInfo:nil repeats:YES];
    fish3 = [NSTimer scheduledTimerWithTimeInterval:0.03 target:self selector:@selector(moveFishLeft3) userInfo:nil repeats:YES];
    fish4 = [NSTimer scheduledTimerWithTimeInterval:0.03 target:self selector:@selector(moveFishLeft4) userInfo:nil repeats:YES];
    fish5 = [NSTimer scheduledTimerWithTimeInterval:0.03 target:self selector:@selector(moveFishLeft5) userInfo:nil repeats:YES];
    fish6 = [NSTimer scheduledTimerWithTimeInterval:0.03 target:self selector:@selector(moveFishLeft6) userInfo:nil repeats:YES];
    
}


- (void)moveFishLeft1 {
    
    if (!isFish1MovementRight) {
        
        negativeX1+=2;
        if (!isFirstTimeRun1) {
            optionView1.frame = CGRectMake(520-negativeX1, 460, 130, 100);
        } else {
            optionView1.frame = CGRectMake(630-negativeX1, 460, 130, 100);
        }
        if (optionView1.frame.origin.x<=2) {
            optionImage1.image = [UIImage imageNamed:@"fish1_right"];
            isFish1MovementRight = YES;
            negativeX1 = 2;
        }
    }
    else if (isFish1MovementRight) {
        isFirstTimeRun1 = YES;
        negativeX1 += 2;
        optionView1.frame = CGRectMake(5 + negativeX1, 460, 130, 100);
        if (optionView1.frame.origin.x>630) {
            optionImage1.image = [UIImage imageNamed:@"fish1"];
            isFish1MovementRight = NO;
            negativeX1 = 2;
        }
    }
    
}
- (void)moveFishLeft2 {
    
    if (!isFish2MovementRight) {
        
        negativeX2+=2;
        if (!isFirstTimeRun2) {
            optionView2.frame = CGRectMake(495-negativeX2, 597, 130, 100);
        } else {
            optionView2.frame = CGRectMake(630-negativeX2, 597, 130, 100);
        }
        
        if (optionView2.frame.origin.x<=2) {
            isFirstTimeRun2 = YES;
            optionImage2.image = [UIImage imageNamed:@"fish1_right"];
            isFish2MovementRight = YES;
            negativeX2 = 2;
        }
    }
    else if (isFish2MovementRight) {
        
        negativeX2 += 2;
        optionView2.frame = CGRectMake(5 + negativeX2, 597, 130, 100);
        if (optionView2.frame.origin.x>630) {
            optionImage2.image = [UIImage imageNamed:@"fish1"];
            isFish2MovementRight = NO;
            negativeX2 = 2;
        }
    }
    
}
- (void)moveFishLeft3 {
    
    if (!isFish3MovementRight) {
        
        negativeX3+=2;
        if (!isFirstTimeRun3) {
            optionView3.frame = CGRectMake(650-negativeX3, 530, 130, 100);
        } else {
            optionView3.frame = CGRectMake(630-negativeX3, 530, 130, 100);
        }
        if (optionView3.frame.origin.x<=2) {
            optionImage3.image = [UIImage imageNamed:@"fish1_right"];
            isFish3MovementRight = YES;
            negativeX3 = 2;
        }
    }
    else if (isFish3MovementRight) {
        isFirstTimeRun3 = YES;
        negativeX3 += 2;
        optionView3.frame = CGRectMake(5 + negativeX3, 530, 130, 100);
        if (optionView3.frame.origin.x>630) {
            optionImage3.image = [UIImage imageNamed:@"fish1"];
            isFish3MovementRight = NO;
            negativeX3 = 2;
        }
    }
    
}
- (void)moveFishLeft4 {
    
    if (!isFish4MovementRight) {
        
        negativeX4+=2;
        if (!isFirstTimeRun4) {
            optionView4.frame = CGRectMake(595-negativeX4, 660, 130, 100);
        } else {
            optionView4.frame = CGRectMake(630-negativeX4, 660, 130, 100);
        }
        if (optionView4.frame.origin.x<=2) {
            optionImage4.image = [UIImage imageNamed:@"fish1_right"];
            isFish4MovementRight = YES;
            negativeX4 = 2;
        }
    }
    else if (isFish4MovementRight) {
        isFirstTimeRun4 = YES;
        negativeX4 += 2;
        optionView4.frame = CGRectMake(5 + negativeX4, 660, 130, 100);
        if (optionView4.frame.origin.x>630) {
            optionImage4.image = [UIImage imageNamed:@"fish1"];
            isFish4MovementRight = NO;
            negativeX4 = 2;
        }
    }
    
}
- (void)moveFishLeft5 {
    
    if (!isFish5MovementRight) {
        
        negativeX5+=2;
        if (!isFirstTimeRun5) {
            optionView5.frame = CGRectMake(640-negativeX5, 730, 130, 100);
        } else {
            optionView5.frame = CGRectMake(630-negativeX5, 730, 130, 100);
        }
        if (optionView5.frame.origin.x<=2) {
            optionImage5.image = [UIImage imageNamed:@"fish1_right"];
            isFish5MovementRight = YES;
            negativeX5 = 2;
        }
    }
    else if (isFish5MovementRight) {
        isFirstTimeRun5 = YES;
        negativeX5 += 2;
        optionView5.frame = CGRectMake(5 + negativeX5, 730, 130, 100);
        if (optionView5.frame.origin.x>630) {
            optionImage5.image = [UIImage imageNamed:@"fish1"];
            isFish5MovementRight = NO;
            negativeX5 = 2;
        }
    }
    
}
- (void)moveFishLeft6 {
    
    if (!isFish6MovementRight) {
        
        negativeX6+=2;
        if (!isFirstTimeRun6) {
            optionView6.frame = CGRectMake(450-negativeX6, 795, 130, 100);
        } else {
            optionView6.frame = CGRectMake(630-negativeX6, 795, 130, 100);
        }
        if (optionView6.frame.origin.x<=2) {
            optionImage6.image = [UIImage imageNamed:@"fish1_right"];
            isFish6MovementRight = YES;
            negativeX6 = 2;
        }
    }
    else if (isFish6MovementRight) {
        isFirstTimeRun6 = YES;
        negativeX6 += 2;
        optionView6.frame = CGRectMake(5 + negativeX6, 795, 130, 100);
        if (optionView6.frame.origin.x>630) {
            optionImage6.image = [UIImage imageNamed:@"fish1"];
            isFish6MovementRight = NO;
            negativeX6 = 2;
        }
    }
    
}


- (void)showRandomValues
{
    dic = [Util readPListData];
    
    if (ishighclass == YES)
    {
        // class 2
        if ([[dic objectForKey:@"level"] isEqualToString:@"EASY"])
        {
            if ([bubbleNumber isEqualToString:@"0"])
            {
                randomnumber = [self getRandomNumber:15 to:30];
            }
            else
            {
                randomnumber = [self getRandomNumber:15 to:30];
            }
            
        }
        else if ([[dic objectForKey:@"level"] isEqualToString:@"MEDIUM"])
        {
            if ([bubbleNumber isEqualToString:@"0"])
            {
                randomnumber = [self getRandomNumber:31 to:80];
            }
            else
            {
                randomnumber = [self getRandomNumber:31 to:80];
            }
            
        }
        else
        {
            if ([bubbleNumber isEqualToString:@"0"])
            {
                randomnumber = [self getRandomNumber:81 to:190];
            }
            else
            {
                randomnumber = [self getRandomNumber:81 to:190];
            }
            
            numberLabel1.font = [UIFont fontWithName:@"MarkerFelt-Wide" size:40.0f];
            numberLabel2.font = [UIFont fontWithName:@"MarkerFelt-Wide" size:40.0f];
            numberLabel3.font = [UIFont fontWithName:@"MarkerFelt-Wide" size:40.0f];
            numberLabel4.font = [UIFont fontWithName:@"MarkerFelt-Wide" size:40.0f];
            numberLabel5.font = [UIFont fontWithName:@"MarkerFelt-Wide" size:40.0f];
            numberLabel6.font = [UIFont fontWithName:@"MarkerFelt-Wide" size:40.0f];
        }
    }
    else
    {
        // class 1
        if ([[dic objectForKey:@"level"] isEqualToString:@"EASY"])
        {
            if ([bubbleNumber isEqualToString:@"0"])
            {
                randomnumber = [self getRandomNumber:0 to:20];
            }
            else
            {
                randomnumber = [self getRandomNumber:6 to:20];
            }
            
        }
        else if ([[dic objectForKey:@"level"] isEqualToString:@"MEDIUM"])
        {
            if ([bubbleNumber isEqualToString:@"0"])
            {
                randomnumber = [self getRandomNumber:21 to:50];
            }
            else
            {
                randomnumber = [self getRandomNumber:21 to:50];
            }
            
        }
        else
        {
            if ([bubbleNumber isEqualToString:@"0"])
            {
                randomnumber = [self getRandomNumber:51 to:100];
            }
            else
            {
                randomnumber = [self getRandomNumber:51 to:100];
            }
            
            numberLabel1.font = [UIFont fontWithName:@"MarkerFelt-Wide" size:40.0f];
            numberLabel2.font = [UIFont fontWithName:@"MarkerFelt-Wide" size:40.0f];
            numberLabel3.font = [UIFont fontWithName:@"MarkerFelt-Wide" size:40.0f];
            numberLabel4.font = [UIFont fontWithName:@"MarkerFelt-Wide" size:40.0f];
            numberLabel5.font = [UIFont fontWithName:@"MarkerFelt-Wide" size:40.0f];
            numberLabel6.font = [UIFont fontWithName:@"MarkerFelt-Wide" size:40.0f];
        }
    }
    
    
    if ([bubbleNumber isEqualToString:@"0"]) // simple counting
    {
        value2 = randomnumber+1;
        value3 = value2+1;
        value4 = value3+1;
        value5 = value4+1;
        value6 = value5+1;
    }
    else // reverse counting
    {
        value2 = randomnumber-1;
        value3 = value2-1;
        value4 = value3-1;
        value5 = value4-1;
        value6 = value5-1;
        
    }
    
    numberLabel1.text = [NSString stringWithFormat:@"%d",randomnumber];
    numberLabel2.text = [NSString stringWithFormat:@"%d",value2];
    numberLabel3.text = [NSString stringWithFormat:@"%d",value3];
    numberLabel4.text = [NSString stringWithFormat:@"%d",value4];
    numberLabel5.text = [NSString stringWithFormat:@"%d",value5];
    numberLabel6.text = [NSString stringWithFormat:@"%d",value6];
    
    NSArray *labelArray = [NSArray arrayWithObjects:numberLabel1,numberLabel2,numberLabel3,numberLabel4,numberLabel5,numberLabel6, nil];
    
    NSArray *imageArray = [NSArray arrayWithObjects:orangeImage1,orangeImage2,orangeImage3,orangeImage4,orangeImage5,orangeImage6, nil];
    
    NSArray *optionLabelArray = [NSArray arrayWithObjects:optionLabel1,optionLabel2,optionLabel3,optionLabel4,optionLabel5,optionLabel6, nil];
    
    NSMutableArray *remainingLabelArray=[[NSMutableArray alloc]initWithCapacity:2];
    
    number1hide = [self getRandomNumber:0 to:5];
    number2hide = [self getRandomNumber:0 to:5];
    while (number1hide == number2hide)
    {
        number2hide = [self getRandomNumber:0 to:5];
    }
    number3hide = [self getRandomNumber:0 to:5];
    while (number3hide == number1hide ||number3hide == number2hide)
    {
        number3hide = [self getRandomNumber:0 to:5];
    }
    label1Hide = [labelArray objectAtIndex:number1hide];
    label2Hide = [labelArray objectAtIndex:number2hide];
    label3Hide = [labelArray objectAtIndex:number3hide];
    [label1Hide setHidden:YES];
    [label2Hide setHidden:YES];
    [label3Hide setHidden:YES];
    image1Show = [imageArray objectAtIndex:number1hide];
    image2Show = [imageArray objectAtIndex:number2hide];
    image3Show = [imageArray objectAtIndex:number3hide];
    [image1Show setHidden:NO];
    [image2Show setHidden:NO];
    [image3Show setHidden:NO];
    
    UILabel *optionLbl1 = [optionLabelArray objectAtIndex:number1hide];
    UILabel *optionLbl2 = [optionLabelArray objectAtIndex:number2hide];
    UILabel *optionLbl3 = [optionLabelArray objectAtIndex:number3hide];
    
    [optionLbl1 setText:[NSString stringWithFormat:@"%@",label1Hide.text]];
    [optionLbl2 setText:[NSString stringWithFormat:@"%@",label2Hide.text]];
    [optionLbl3 setText:[NSString stringWithFormat:@"%@",label3Hide.text]];
    int i =0;
    
    while ((i <[optionLabelArray count]))
    {
        if (!([optionLbl1 isEqual:[optionLabelArray objectAtIndex:i]]||[optionLbl2 isEqual:[optionLabelArray objectAtIndex:i]]||[optionLbl3 isEqual:[optionLabelArray objectAtIndex:i]]))
        {
            [remainingLabelArray addObject:[optionLabelArray objectAtIndex:i]];
        }
        i++;
    }
    UILabel *remainingLabel1 = [remainingLabelArray objectAtIndex:0];
    UILabel *remainingLabel2 = [remainingLabelArray objectAtIndex:1];
    UILabel *remainingLabel3 = [remainingLabelArray objectAtIndex:2];
    if ([bubbleNumber isEqualToString:@"0"])
    {
        [remainingLabel1 setText:[NSString stringWithFormat:@"%d",randomnumber-1]];
        [remainingLabel2 setText:[NSString stringWithFormat:@"%d",value6+1]];
        [remainingLabel3 setText:[NSString stringWithFormat:@"%d",value6+2]];
    }
    else
    {
        [remainingLabel1 setText:[NSString stringWithFormat:@"%d",randomnumber+1]];
        [remainingLabel2 setText:[NSString stringWithFormat:@"%d",value6-1]];
        [remainingLabel3 setText:[NSString stringWithFormat:@"%d",value6-2]];
    }
    
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    
    // TAKE A BOOL VAR AND CHECK ND UNCHECK IT ON SCREEN CLICK


    [optionView1.layer removeAllAnimations];
    [optionView2.layer removeAllAnimations];
    [optionView3.layer removeAllAnimations];
    [optionView4.layer removeAllAnimations];
    [optionView5.layer removeAllAnimations];
    [optionView6.layer removeAllAnimations];
    
	// We only support single touches, so anyObject retrieves just that touch from touches
	touch = [touches anyObject];
	if ([touch tapCount] == 1)
    {
        // Only move the placard view if the touch was in the placard view
        if ([touch view] == optionView1||[touch view] == optionView2||[touch view] == optionView3||[touch view] == optionView4||[touch view] == optionView5||[touch view] == optionView6)
        {
            if ([touch view]==optionView1)
            {
                if (optionframe1value ==1)
                {
                    [fish1 invalidate];
                    fish1 = nil;
                    originalFrameOfOptionView1 = [touch view].frame;
                    //optionframe1value++;
                    
                }
            }
            else if ([touch view]==optionView2)
            {
                if (optionframe2value ==1)
                {
                    [fish2 invalidate];
                    originalFrameOfOptionView2 = [touch view].frame;
                    //optionframe2value++;
                }
            }
            else if ([touch view]==optionView3)
            {
                if (optionframe3value ==1)
                {
                    [fish3 invalidate];
                    originalFrameOfOptionView3 = [touch view].frame;
                    
                    //optionframe3value++;
                }
            }
            else if ([touch view]==optionView4)
            {
                if (optionframe4value ==1)
                {
                    [fish4 invalidate];
                    originalFrameOfOptionView4 = [touch view].frame;
                    //optionframe4value++;
                }
            }
            else if ([touch view]==optionView5)
            {
                if (optionframe5value ==1)
                {
                    [fish5 invalidate];
                    originalFrameOfOptionView5 = [touch view].frame;
                    //optionframe5value++;
                }
            }
            else if ([touch view]==optionView6)
            {
                if (optionframe6value ==1)
                {
                    [fish6 invalidate];
                    originalFrameOfOptionView6 = [touch view].frame;
                    //optionframe6value++;
                }
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
	if ([touch tapCount] == 1) {
        if ([touch view] == optionView1||[touch view] == optionView2||[touch view] == optionView3||[touch view] == optionView4||[touch view] == optionView5||[touch view] == optionView6)
        {
            CGPoint location = [touch locationInView:self.view];
            [touch view].center = location;
            return;
        }
    }
	
}


- (void)touchedViewCall:(UITouch *)touch_ {
    
    if ([touch_ view]==optionView1) {
        if ([fish1 isValid]) {
            [fish1 invalidate];
            fish1 = nil;
        }
        fish1 = [NSTimer scheduledTimerWithTimeInterval:0.03 target:self selector:@selector(moveFishLeft1) userInfo:nil repeats:YES];
        
    } else if ([touch_ view]==optionView2) {
        if ([fish2 isValid]) {
            [fish2 invalidate];
            fish2 = nil;
        }
        fish2 = [NSTimer scheduledTimerWithTimeInterval:0.03 target:self selector:@selector(moveFishLeft2) userInfo:nil repeats:YES];
        
    } else if ([touch_ view]==optionView3) {
        if ([fish3 isValid]) {
            [fish3 invalidate];
            fish3 = nil;
        }
        fish3 = [NSTimer scheduledTimerWithTimeInterval:0.03 target:self selector:@selector(moveFishLeft3) userInfo:nil repeats:YES];
        
    } else if ([touch_ view]==optionView4) {
        if ([fish4 isValid]) {
            [fish4 invalidate];
            fish4 = nil;
        }
        fish4 = [NSTimer scheduledTimerWithTimeInterval:0.03 target:self selector:@selector(moveFishLeft4) userInfo:nil repeats:YES];
        
    } else if ([touch_ view]==optionView5) {
        if ([fish5 isValid]) {
            [fish5 invalidate];
            fish5 = nil;
        }
        fish5 = [NSTimer scheduledTimerWithTimeInterval:0.03 target:self selector:@selector(moveFishLeft5) userInfo:nil repeats:YES];
        
    } else if ([touch_ view]==optionView6) {
        if ([fish6 isValid]) {
            [fish6 invalidate];
            fish6 = nil;
        }
        fish6 = [NSTimer scheduledTimerWithTimeInterval:0.03 target:self selector:@selector(moveFishLeft6) userInfo:nil repeats:YES];
        
    }
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event {
    
            touch = [touches anyObject];
            // If the touch was in the placardView, bounce it back to the center
            if ([touch view] == optionView1||[touch view] == optionView2||[touch view] == optionView3||[touch view] == optionView4||[touch view] == optionView5||[touch view] == optionView6)
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
                CGRect myRect = label1Hide.frame;
                BOOL isInside = CGRectContainsPoint(myRect, touchPoint);
                
                CGRect myRect2 = label2Hide.frame;
                BOOL isInside2 = CGRectContainsPoint(myRect2, touchPoint);
                
                CGRect myRect3 = label3Hide.frame;
                BOOL isInside3 = CGRectContainsPoint(myRect3, touchPoint);
  
                if(isInside)
                {
                    NSArray *subviewArray = [touch view].subviews;
                    
                    if ([[(UILabel*)[subviewArray objectAtIndex:1] text] isEqualToString:label1Hide.text] )
                    {
                        rect1 = label1Hide.frame;
                        rect1 = CGRectMake(rect1.origin.x+15, rect1.origin.y+15, 80, 80);
                        [touch view].frame = rect1;
                        for (UIView *subview in [[touch view] subviews]) {
                            subview.frame = CGRectMake(8, 5, 80, 80);

                        }
                        
                            if ([touch view]==optionView1) {
                                if ([fish1 isValid]) {
                                    [fish1 invalidate];
                                    fish1 = nil;
                                }
                                
                            } else if ([touch view]==optionView2) {
                                if ([fish2 isValid]) {
                                    [fish2 invalidate];
                                    fish2 = nil;
                                }
                                
                            } else if ([touch view]==optionView3) {
                                if ([fish3 isValid]) {
                                    [fish3 invalidate];
                                    fish3 = nil;
                                }
                                
                            } else if ([touch view]==optionView4) {
                                if ([fish4 isValid]) {
                                    [fish4 invalidate];
                                    fish4 = nil;
                                }
          
                            } else if ([touch view]==optionView5) {
                                if ([fish5 isValid]) {
                                    [fish5 invalidate];
                                    fish5 = nil;
                                }
              
                            } else if ([touch view]==optionView6) {
                                if ([fish6 isValid]) {
                                    [fish6 invalidate];
                                    fish6 = nil;
                                }
                                
                            }
                        //hurray sound
                        journeyLabel.text = [NSString stringWithFormat:@"Fishes Catched : %d",++fishescatched];
                        [messageLabel setText:@"Well Done !!"];
                        messageLabel.textColor = [UIColor colorWithRed:238/255.0 green:43/255.0 blue:123/255.0 alpha:1.0];
                        [messageLabel setAlpha:1];
                        [messageLabel setHidden:NO];
                        [self performSelector:@selector(zoomOut) withObject:nil afterDelay:2.0];
                        winAnsUrl = [NSURL fileURLWithPath:[NSString stringWithFormat:@"%@/win1.mp3", [[NSBundle mainBundle] resourcePath]]];
                        winAudioPlayer = [[AVAudioPlayer alloc] initWithContentsOfURL:winAnsUrl error:nil];
                        winAudioPlayer.numberOfLoops = 0;
                        [winAudioPlayer play];
                        [self performSelector:@selector(winMusicStop) withObject:nil afterDelay:1];
      
                    }
                    else
                    {
                        [messageLabel setText:@"Try Again !!"];
                        messageLabel.textColor = [UIColor redColor];
                        [messageLabel setAlpha:1];
                        [messageLabel setHidden:NO];
                        [self performSelector:@selector(zoomOut) withObject:nil afterDelay:2.0];
                        wrongAnsUrl = [NSURL fileURLWithPath:[NSString stringWithFormat:@"%@/fb.mp3", [[NSBundle mainBundle] resourcePath]]];
                        wrongAudioPlayer = [[AVAudioPlayer alloc] initWithContentsOfURL:wrongAnsUrl error:nil];
                        wrongAudioPlayer.numberOfLoops = 0;
                        [wrongAudioPlayer play];
                        [self performSelector:@selector(wrongMusicStop) withObject:nil afterDelay:1];
                        [self touchedViewCall:touch];
                        
                    }
                    
                } // isInside
                else if (isInside2)
                {
                    NSArray *subviewArray = [touch view].subviews;
                    
                    if ([[(UILabel *)[subviewArray objectAtIndex:1] text] isEqualToString:label2Hide.text] )
                    {
                        rect2 = label2Hide.frame;
                        rect2 = CGRectMake(rect2.origin.x+15, rect2.origin.y+15, 80, 80);
                        [touch view].frame = rect2;
                        for (UIView *subview in [[touch view] subviews]) {
                            subview.frame = CGRectMake(8, 5, 80, 80);
                            
                        }
                        
                        if ([touch view]==optionView1) {
                            if ([fish1 isValid]) {
                                [fish1 invalidate];
                                fish1 = nil;
                            }
                            
                        } else if ([touch view]==optionView2) {
                            if ([fish2 isValid]) {
                                [fish2 invalidate];
                                fish2 = nil;
                            }
                            
                        } else if ([touch view]==optionView3) {
                            if ([fish3 isValid]) {
                                [fish3 invalidate];
                                fish3 = nil;
                            }
                            
                        } else if ([touch view]==optionView4) {
                            if ([fish4 isValid]) {
                                [fish4 invalidate];
                                fish4 = nil;
                            }
                            
                        } else if ([touch view]==optionView5) {
                            if ([fish5 isValid]) {
                                [fish5 invalidate];
                                fish5 = nil;
                            }
                            
                        } else if ([touch view]==optionView6) {
                            if ([fish6 isValid]) {
                                [fish6 invalidate];
                                fish6 = nil;
                            }
                            
                        }
                        //hurray sound
                        journeyLabel.text = [NSString stringWithFormat:@"Fishes Catched : %d",++fishescatched];
                        [self performSelector:@selector(zoomOut) withObject:nil afterDelay:2.0];
                        [messageLabel setText:@"Well Done !!"];
                        messageLabel.textColor = [UIColor colorWithRed:238/255.0 green:43/255.0 blue:123/255.0 alpha:1.0];
                        [messageLabel setAlpha:1];
                        [messageLabel setHidden:NO];
                        
                        winAnsUrl = [NSURL fileURLWithPath:[NSString stringWithFormat:@"%@/win1.mp3", [[NSBundle mainBundle] resourcePath]]];
                        winAudioPlayer = [[AVAudioPlayer alloc] initWithContentsOfURL:winAnsUrl error:nil];
                        winAudioPlayer.numberOfLoops = 0;
                        
                        [winAudioPlayer play];
                        [self performSelector:@selector(winMusicStop) withObject:nil afterDelay:1];
                    }
                    else
                    {
                        [messageLabel setText:@"Try Again !!"];
                        messageLabel.textColor = [UIColor redColor];
                        [messageLabel setAlpha:1];
                        [messageLabel setHidden:NO];

                        [self performSelector:@selector(zoomOut) withObject:nil afterDelay:2.0];
                        
                        wrongAnsUrl = [NSURL fileURLWithPath:[NSString stringWithFormat:@"%@/fb.mp3", [[NSBundle mainBundle] resourcePath]]];
                        wrongAudioPlayer = [[AVAudioPlayer alloc] initWithContentsOfURL:wrongAnsUrl error:nil];
                        wrongAudioPlayer.numberOfLoops = 0;
                        
                        [wrongAudioPlayer play];
                        [self performSelector:@selector(wrongMusicStop) withObject:nil afterDelay:1];
                        [self touchedViewCall:touch];
                        
                    }
                    
                } // if inside2
                else if (isInside3)
                {
                    NSArray *subviewArray = [touch view].subviews;
                    
                    if ([[(UILabel *)[subviewArray objectAtIndex:1] text] isEqualToString:label3Hide.text] )
                    {
                        rect3 = label3Hide.frame;
                        rect3 = CGRectMake(rect3.origin.x+15, rect3.origin.y+15, 80, 80);
                        [touch view].frame = rect3;
                        for (UIView *subview in [[touch view] subviews]) {
                            subview.frame = CGRectMake(8, 5, 80, 80);
                            
                        }
                        
                        if ([touch view]==optionView1) {
                            if ([fish1 isValid]) {
                                [fish1 invalidate];
                                fish1 = nil;
                            }
                            
                        } else if ([touch view]==optionView2) {
                            if ([fish2 isValid]) {
                                [fish2 invalidate];
                                fish2 = nil;
                            }
                            
                        } else if ([touch view]==optionView3) {
                            if ([fish3 isValid]) {
                                [fish3 invalidate];
                                fish3 = nil;
                            }
                            
                        } else if ([touch view]==optionView4) {
                            if ([fish4 isValid]) {
                                [fish4 invalidate];
                                fish4 = nil;
                            }
                            
                        } else if ([touch view]==optionView5) {
                            if ([fish5 isValid]) {
                                [fish5 invalidate];
                                fish5 = nil;
                            }
                            
                        } else if ([touch view]==optionView6) {
                            if ([fish6 isValid]) {
                                [fish6 invalidate];
                                fish6 = nil;
                            }
                            
                        }
                        //hurray sound
                        journeyLabel.text = [NSString stringWithFormat:@"Fishes Catched : %d",++fishescatched];
                        [self performSelector:@selector(zoomOut) withObject:nil afterDelay:2.0];
                        [messageLabel setText:@"Well Done !!"];
                        messageLabel.textColor = [UIColor colorWithRed:238/255.0 green:43/255.0 blue:123/255.0 alpha:1.0];
                        [messageLabel setAlpha:1];
                        [messageLabel setHidden:NO];
                        
                        winAnsUrl = [NSURL fileURLWithPath:[NSString stringWithFormat:@"%@/win1.mp3", [[NSBundle mainBundle] resourcePath]]];
                        winAudioPlayer = [[AVAudioPlayer alloc] initWithContentsOfURL:winAnsUrl error:nil];
                        winAudioPlayer.numberOfLoops = 0;
                        
                        [winAudioPlayer play];
                        [self performSelector:@selector(winMusicStop) withObject:nil afterDelay:1];
                    }
                    else
                    {
                        [messageLabel setText:@"Try Again !!"];
                        messageLabel.textColor = [UIColor redColor];
                        [messageLabel setAlpha:1];
                        [messageLabel setHidden:NO];
                        [self performSelector:@selector(zoomOut) withObject:nil afterDelay:2.0];
                        wrongAnsUrl = [NSURL fileURLWithPath:[NSString stringWithFormat:@"%@/fb.mp3", [[NSBundle mainBundle] resourcePath]]];
                        wrongAudioPlayer = [[AVAudioPlayer alloc] initWithContentsOfURL:wrongAnsUrl error:nil];
                        wrongAudioPlayer.numberOfLoops = 0;
                        
                        [wrongAudioPlayer play];
                        [self performSelector:@selector(wrongMusicStop) withObject:nil afterDelay:1];
                        [self touchedViewCall:touch];
              
                    }//else ended
                    
                }
                else
                {
                    [self touchedViewCall:touch];
                }
                
            }
}


-(void)winMusicStop
{
    dic = [Util readPListData];
    [winAudioPlayer stop];
    [winAudioPlayer setCurrentTime:0];
    winAudioPlayer = nil;
    
    if ((optionView1.frame.origin.x == rect1.origin.x||optionView2.frame.origin.x == rect1.origin.x||optionView3.frame.origin.x == rect1.origin.x||optionView4.frame.origin.x == rect1.origin.x||optionView5.frame.origin.x == rect1.origin.x||optionView6.frame.origin.x == rect1.origin.x) &&(optionView1.frame.origin.x == rect2.origin.x||optionView2.frame.origin.x == rect2.origin.x||optionView3.frame.origin.x == rect2.origin.x||optionView4.frame.origin.x == rect2.origin.x||optionView5.frame.origin.x == rect2.origin.x||optionView6.frame.origin.x == rect2.origin.x)&&(optionView1.frame.origin.x == rect3.origin.x||optionView2.frame.origin.x == rect3.origin.x||optionView3.frame.origin.x == rect3.origin.x||optionView4.frame.origin.x == rect3.origin.x||optionView5.frame.origin.x == rect3.origin.x||optionView6.frame.origin.x == rect3.origin.x))
    {
        NSLog( @"game over");
        if (![[dic objectForKey:@"level"] isEqualToString:@"HARD"])
        {
            nextLevelButton.userInteractionEnabled = NO;
        }
        [orangeImage1 setHidden:YES];
        [orangeImage2 setHidden:YES];
        [orangeImage3 setHidden:YES];
        [orangeImage4 setHidden:YES];
        [orangeImage5 setHidden:YES];
        [orangeImage6 setHidden:YES];
        
        rect1.origin.x = 0;
        rect2.origin.x = 0;
        rect3.origin.x = 0;
        
        cheers = [[UILabel alloc]initWithFrame:CGRectMake(50, 330, 680, 600)];
        cheers.backgroundColor = [UIColor clearColor];
        cheers.tag=1;
        cheers.text = @"Woooohooooo";
        cheers.alpha = alph;
        cheers.textColor = [UIColor greenColor];
        cheers.textAlignment = NSTextAlignmentCenter;
        cheers.font = [UIFont fontWithName:@"MarkerFelt-Wide" size:40];
        [self.view addSubview:cheers];
        
        [self performSelector:@selector(restartGame) withObject:nil afterDelay:3.0];
        
        timerForLabelMarquee=[NSTimer scheduledTimerWithTimeInterval:0.4
                                                              target:self
                                                            selector:@selector(glowMarquee)
                                                            userInfo:nil
                                                             repeats:YES];
        NSURL *url1 = [NSURL fileURLWithPath:[NSString stringWithFormat:@"%@/clap.mp3", [[NSBundle mainBundle] resourcePath]]];
        
        NSError *error1;
        audioPlayerClap = [[AVAudioPlayer alloc] initWithContentsOfURL:url1 error:&error1];
        audioPlayerClap.numberOfLoops = -1;
        [audioPlayerClap play];
        timerForWinningStage = [NSTimer scheduledTimerWithTimeInterval:3 target:self selector:@selector(cheersBeforeShowingNextQuestion) userInfo:nil repeats:NO];
        timerStopValue = 1;
        
        if ([fish1 isValid]) {
            [fish1 invalidate];
            fish1 = nil;
        }
        
        if ([fish2 isValid]) {
            [fish2 invalidate];
            fish2 = nil;
        }
        
        if ([fish3 isValid]) {
            [fish3 invalidate];
            fish3 = nil;
        }
        
        if ([fish4 isValid]) {
            [fish4 invalidate];
            fish4 = nil;
        }
        
        if ([fish5 isValid]) {
            [fish5 invalidate];
            fish5 = nil;
        }
        
        if ([fish6 isValid]) {
            [fish6 invalidate];
            fish6 = nil;
        }
        
    }
    
}

-(void)glowMarquee
{
    timerStopValue = 1; //if 1 den stop on back btn press
    alph = (alph == 1) ? 0.7 : 1; // Switch value of alph
    [UIView beginAnimations:@"alpha" context:NULL];
    [UIView setAnimationDuration:0.4];
    cheers.alpha = alph;
    [UIView commitAnimations];
}

-(void)cheersBeforeShowingNextQuestion
{
    
    dic = [Util readPListData];
    timerStopValue = 0;
    [timerForLabelMarquee invalidate];
    [audioPlayerClap stop];
    [cheers removeFromSuperview];
    if (![[dic objectForKey:@"level"] isEqualToString:@"HARD"])
    {
        nextLevelButton.userInteractionEnabled = YES;
    }
    
}


- (void)restartGame
{    
    [label1Hide setHidden:NO];
    [label2Hide setHidden:NO];
    [label3Hide setHidden:NO];
    
    [image1Show setHidden:YES];
    [image2Show setHidden:YES];
    [image3Show setHidden:YES];
    
   // [self setConstants];
    [self setTimerForFishMovement];
    [self showRandomValues];
}

-(void)wrongMusicStop
{
    [wrongAudioPlayer stop];
    [wrongAudioPlayer setCurrentTime:0];
    wrongAudioPlayer = nil;
    
}

-(void)zoomOut
{
    [messageLabel setHidden:YES];
}

-(void)nextLevelButtonClicked:(id)sender
{
    dic = [Util readPListData];
    if ([[dic objectForKey:@"level"] isEqualToString:@"EASY"])
    {
        [dic setObject:@"MEDIUM" forKey:@"level"];
    }
    else if ([[dic objectForKey:@"level"] isEqualToString:@"MEDIUM"])
    {
        [dic setObject:@"HARD" forKey:@"level"];
        nextLevelButton.userInteractionEnabled = NO;
        [nextLevelButton setHidden:YES];
    }
    
    [Util writeToPlist:dic];
    
    optionframe1value = 1;
    optionframe2value = 1;
    optionframe3value = 1;
    optionframe4value = 1;
    optionframe5value = 1;
    optionframe6value = 1;
    
    [orangeImage1 setHidden:YES];
    [orangeImage2 setHidden:YES];
    [orangeImage3 setHidden:YES];
    [orangeImage4 setHidden:YES];
    [orangeImage5 setHidden:YES];
    [orangeImage6 setHidden:YES];
    
    [optionView1 setFrame:CGRectMake(95, 500, 70, 70)];
    [optionView2 setFrame:CGRectMake(195, 600, 70, 70)];
    [optionView3 setFrame:CGRectMake(395, 550, 70, 70)];
    [optionView4 setFrame:CGRectMake(95, 700, 70, 70)];
    [optionView5 setFrame:CGRectMake(495, 720, 70, 70)];
    [optionView6 setFrame:CGRectMake(295, 720, 70, 70)];
    
    [label1Hide setHidden:NO];
    [label2Hide setHidden:NO];
    [label3Hide setHidden:NO];
    
    [image1Show setHidden:YES];
    [image2Show setHidden:YES];
    [image3Show setHidden:YES];
    
    label1Hide = nil;
    label2Hide = nil;
    label3Hide = nil;
    image1Show = nil;
    image2Show = nil;
    image3Show = nil;
    
    rect1.origin.x = 0;
    rect2.origin.x = 0;
    rect3.origin.x = 0;
    
    
    [self showRandomValues];
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
