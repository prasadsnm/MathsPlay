//
//  ButterflyCatchViewController.m
//  MathsPlay
//
//  Created by qainfotech on 11/12/13.
//  Copyright (c) 2013 qainfotech. All rights reserved.
//

#import "ButterflyCatchViewController.h"

@interface ButterflyCatchViewController ()
{
    NSUInteger fishescatched;
    NSUInteger negativeX1,negativeX2,negativeX3,negativeX4,negativeX5,negativeX6;
    BOOL isFish1MovementRight,isFish2MovementRight,isFish3MovementRight,isFish4MovementRight,isFish5MovementRight,isFish6MovementRight;
    BOOL isFirstTimeRun1,isFirstTimeRun2,isFirstTimeRun3,isFirstTimeRun4,isFirstTimeRun5,isFirstTimeRun6;
    NSString *flipFlopButterfly1,*flipFlopButterfly2,*flipFlopButterfly3,*flipFlopButterfly4,*flipFlopButterfly5,*flipFlopButterfly6;
    AVAudioPlayer *startupAudio;
}
@end

@implementation ButterflyCatchViewController
@synthesize bubbleNumber;
static float alph = 0.7;
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
       
        self.title = @"Catch Your Butterfly";
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

    flipFlopButterfly1 = @"1";flipFlopButterfly2 = @"1";flipFlopButterfly3 = @"1";flipFlopButterfly4 = @"1";flipFlopButterfly5 = @"1";flipFlopButterfly6 = @"1";
    self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"btrflyback.jpg"]];
    
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
    
    avatarImage = [[UIImageView alloc]initWithFrame:CGRectMake(110, 20, 140, 130)];
    NSData *imageData = [dic objectForKey:@"avatarImage"];
    
    avatarImage.image = [UIImage imageWithData:imageData];
    [self.view addSubview:avatarImage];
    
    greetingsLabel = [[UILabel alloc]initWithFrame:CGRectMake(250, 25, 250, 30)];
    greetingsLabel.text = [NSString stringWithFormat:@"Hi  %@",[dic objectForKey:@"username"]];
    greetingsLabel.textAlignment = NSTextAlignmentCenter;
    greetingsLabel.textColor = [UIColor whiteColor];
    greetingsLabel.font = [UIFont fontWithName:@"Noteworthy-Bold" size:31.0];
    greetingsLabel.backgroundColor = [UIColor clearColor];
    [self.view addSubview:greetingsLabel];
    
    journeyLabel = [[UILabel alloc]initWithFrame:CGRectMake(55, 140, 250, 60)];
    journeyLabel.text = [NSString stringWithFormat:@"Butterflies Catched : %d",fishescatched];
    journeyLabel.textAlignment = NSTextAlignmentCenter;
    journeyLabel.textColor = [UIColor colorWithRed:0/255.0 green:0/255.0 blue:139/255.0 alpha:1.0];
    journeyLabel.font = [Util themeFontWithSize:25.0];
    journeyLabel.backgroundColor = [UIColor clearColor];
    [self.view addSubview:journeyLabel];
    
    nextLevelButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [nextLevelButton setImage:[UIImage imageNamed:@"next_icon.gif"] forState:UIControlStateNormal];
    nextLevelButton.frame = CGRectMake(660, 90, 80, 60);
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
    
    
    numberLabel1 = [[UILabel alloc]initWithFrame:CGRectMake(0, 730, 120, 100)];
    numberLabel1.text = @"1";
    numberLabel1.textAlignment = NSTextAlignmentCenter;
    numberLabel1.textColor = [UIColor colorWithRed:255/255.0 green:75/255.0 blue:51/255.0 alpha:1.0];
    numberLabel1.font = [UIFont fontWithName:@"MarkerFelt-Wide" size:49.0f];
    numberLabel1.layer.shadowOffset = CGSizeMake(0.0, 0.0);
    numberLabel1.layer.shadowRadius = 20.0;
    numberLabel1.layer.shadowOpacity = 0.5;
    numberLabel1.layer.masksToBounds = NO;
    numberLabel1.backgroundColor = [UIColor clearColor];
    [self.view addSubview:numberLabel1];
    
    
    numberLabel2 = [[UILabel alloc]initWithFrame:CGRectMake(130, 730, 120, 100)];
    numberLabel2.text = @"1";
    numberLabel2.textAlignment = NSTextAlignmentCenter;
    numberLabel2.textColor = [UIColor colorWithRed:255/255.0 green:75/255.0 blue:51/255.0 alpha:1.0];
    numberLabel2.font = [UIFont fontWithName:@"MarkerFelt-Wide" size:49.0f];
    numberLabel2.layer.shadowOffset = CGSizeMake(0.0, 0.0);
    numberLabel2.layer.shadowRadius = 20.0;
    numberLabel2.layer.shadowOpacity = 0.5;
    numberLabel2.layer.masksToBounds = NO;
    numberLabel2.backgroundColor = [UIColor clearColor];
    [self.view addSubview:numberLabel2];
    
    
    numberLabel3 = [[UILabel alloc]initWithFrame:CGRectMake(260, 730, 120, 100)];
    numberLabel3.text = @"1";
    numberLabel3.textAlignment = NSTextAlignmentCenter;
    numberLabel3.textColor = [UIColor colorWithRed:255/255.0 green:75/255.0 blue:51/255.0 alpha:1.0];
    numberLabel3.font = [UIFont fontWithName:@"MarkerFelt-Wide" size:49.0f];
    numberLabel3.layer.shadowOffset = CGSizeMake(0.0, 0.0);
    numberLabel3.layer.shadowRadius = 20.0;
    numberLabel3.layer.shadowOpacity = 0.5;
    numberLabel3.layer.masksToBounds = NO;
    numberLabel3.backgroundColor = [UIColor clearColor];
    [self.view addSubview:numberLabel3];
    
    
    numberLabel4 = [[UILabel alloc]initWithFrame:CGRectMake(390, 730, 120, 100)];
    numberLabel4.text = @"1";
    numberLabel4.textAlignment = NSTextAlignmentCenter;
    numberLabel4.textColor = [UIColor colorWithRed:255/255.0 green:75/255.0 blue:51/255.0 alpha:1.0];
    numberLabel4.font = [UIFont fontWithName:@"MarkerFelt-Wide" size:49.0f];
    numberLabel4.layer.shadowOffset = CGSizeMake(0.0, 0.0);
    numberLabel4.layer.shadowRadius = 20.0;
    numberLabel4.layer.shadowOpacity = 0.5;
    numberLabel4.layer.masksToBounds = NO;
    numberLabel4.backgroundColor = [UIColor clearColor];
    [self.view addSubview:numberLabel4];
    
    
    numberLabel5 = [[UILabel alloc]initWithFrame:CGRectMake(520, 730, 120, 100)];
    numberLabel5.text = @"1";
    numberLabel5.textAlignment = NSTextAlignmentCenter;
    numberLabel5.textColor = [UIColor colorWithRed:255/255.0 green:75/255.0 blue:51/255.0 alpha:1.0];
    numberLabel5.font = [UIFont fontWithName:@"MarkerFelt-Wide" size:49.0f];
    numberLabel5.layer.shadowOffset = CGSizeMake(0.0, 0.0);
    numberLabel5.layer.shadowRadius = 20.0;
    numberLabel5.layer.shadowOpacity = 0.5;
    numberLabel5.layer.masksToBounds = NO;
    numberLabel5.backgroundColor = [UIColor clearColor];
    [self.view addSubview:numberLabel5];
    
    
    numberLabel6 = [[UILabel alloc]initWithFrame:CGRectMake(650, 730, 120, 100)];
    numberLabel6.text = @"1";
    numberLabel6.textAlignment = NSTextAlignmentCenter;
    numberLabel6.textColor = [UIColor colorWithRed:255/255.0 green:75/255.0 blue:51/255.0 alpha:1.0];
    numberLabel6.font = [UIFont fontWithName:@"MarkerFelt-Wide" size:49.0f];
    numberLabel6.layer.shadowOffset = CGSizeMake(0.0, 0.0);
    numberLabel6.layer.shadowRadius = 20.0;
    numberLabel6.layer.shadowOpacity = 0.5;
    numberLabel6.layer.masksToBounds = NO;
    numberLabel6.backgroundColor = [UIColor clearColor];
    [self.view addSubview:numberLabel6];
    
    
    orangeImage1 = [[UIImageView alloc]initWithFrame:CGRectMake(0, 700, 130, 140)];
    orangeImage1.image = [UIImage imageNamed:@"flower"];
    [orangeImage1 setHidden:YES];
    [self.view addSubview:orangeImage1];
    
    
    orangeImage2 = [[UIImageView alloc]initWithFrame:CGRectMake(130, 700, 130, 140)];
    orangeImage2.image = [UIImage imageNamed:@"flower"];
    [orangeImage2 setHidden:YES];
    [self.view addSubview:orangeImage2];
    
    
    orangeImage3 = [[UIImageView alloc]initWithFrame:CGRectMake(260, 700, 130, 140)];
    orangeImage3.image = [UIImage imageNamed:@"flower"];
    [orangeImage3 setHidden:YES];
    [self.view addSubview:orangeImage3];
    
    
    orangeImage4 = [[UIImageView alloc]initWithFrame:CGRectMake(390, 700, 130, 140)];
    orangeImage4.image = [UIImage imageNamed:@"flower"];
    [orangeImage4 setHidden:YES];
    [self.view addSubview:orangeImage4];
    
    
    orangeImage5 = [[UIImageView alloc]initWithFrame:CGRectMake(520, 700, 130, 140)];
    orangeImage5.image = [UIImage imageNamed:@"flower"];
    [orangeImage5 setHidden:YES];
    [self.view addSubview:orangeImage5];
    
    
    orangeImage6 = [[UIImageView alloc]initWithFrame:CGRectMake(650, 700, 130, 140)];
    orangeImage6.image = [UIImage imageNamed:@"flower"];
    [orangeImage6 setHidden:YES];
    [self.view addSubview:orangeImage6];
    
    
    optionView1 = [[UIView alloc]initWithFrame:CGRectMake(520, 60, 130, 100)];
    optionView1.backgroundColor = [UIColor clearColor];
    optionImage1 = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 130, 100)];
    optionImage1.image = [UIImage imageNamed:@"butterfly"];
    [optionView1 addSubview:optionImage1];
    optionLabel1 = [[UILabel alloc]initWithFrame:CGRectMake(35, 20, 70, 70)];
    optionLabel1.font = [UIFont fontWithName:@"Helvetica-Bold" size:31.0];
    optionLabel1.backgroundColor = [UIColor clearColor];
    optionLabel1.textAlignment = NSTextAlignmentCenter;
    optionLabel1.textColor = [UIColor whiteColor];
    [optionView1 addSubview:optionLabel1];
    [self.view addSubview:optionView1];
    
    
    optionView2 = [[UIView alloc]initWithFrame:CGRectMake(495, 397, 130, 100)];
    optionView2.backgroundColor = [UIColor clearColor];
    optionImage2 = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 130, 100)];
    optionImage2.image = [UIImage imageNamed:@"butterfly"];
    [optionView2 addSubview:optionImage2];
    optionLabel2 = [[UILabel alloc]initWithFrame:CGRectMake(35, 20, 70, 70)];
    optionLabel2.font = [UIFont fontWithName:@"Helvetica-Bold" size:31.0];
    optionLabel2.backgroundColor = [UIColor clearColor];
    optionLabel2.textAlignment = NSTextAlignmentCenter;
    optionLabel2.textColor = [UIColor whiteColor];
    [optionView2 addSubview:optionLabel2];
    [self.view addSubview:optionView2];
    
    
    optionView3 = [[UIView alloc]initWithFrame:CGRectMake(650, 330, 130, 100)];
    optionView3.backgroundColor = [UIColor clearColor];
    optionImage3 = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 130, 100)];
    optionImage3.image = [UIImage imageNamed:@"butterfly"];
    [optionView3 addSubview:optionImage3];
    optionLabel3 = [[UILabel alloc]initWithFrame:CGRectMake(35, 20, 70, 70)];
    optionLabel3.font = [UIFont fontWithName:@"Helvetica-Bold" size:31.0];
    optionLabel3.backgroundColor = [UIColor clearColor];
    optionLabel3.textAlignment = NSTextAlignmentCenter;
    optionLabel3.textColor = [UIColor whiteColor];
    [optionView3 addSubview:optionLabel3];
    [self.view addSubview:optionView3];
    
    
    optionView4 = [[UIView alloc]initWithFrame:CGRectMake(595, 460, 130, 100)];
    optionView4.backgroundColor = [UIColor clearColor];
    optionImage4 = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 130, 100)];
    optionImage4.image = [UIImage imageNamed:@"butterfly"];
    [optionView4 addSubview:optionImage4];
    optionLabel4 = [[UILabel alloc]initWithFrame:CGRectMake(35, 20, 70, 70)];
    optionLabel4.font = [UIFont fontWithName:@"Helvetica-Bold" size:31.0];
    optionLabel4.backgroundColor = [UIColor clearColor];
    optionLabel4.textAlignment = NSTextAlignmentCenter;
    optionLabel4.textColor = [UIColor whiteColor];
    [optionView4 addSubview:optionLabel4];
    [self.view addSubview:optionView4];
    
    
    optionView5 = [[UIView alloc]initWithFrame:CGRectMake(640, 430, 130, 100)];
    optionView5.backgroundColor = [UIColor clearColor];
    optionImage5 = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 130, 100)];
    optionImage5.image = [UIImage imageNamed:@"butterfly"];
    [optionView5 addSubview:optionImage5];
    optionLabel5 = [[UILabel alloc]initWithFrame:CGRectMake(35, 20, 70, 70)];
    optionLabel5.font = [UIFont fontWithName:@"Helvetica-Bold" size:31.0];
    optionLabel5.backgroundColor = [UIColor clearColor];
    optionLabel5.textAlignment = NSTextAlignmentCenter;
    optionLabel5.textColor = [UIColor whiteColor];
    [optionView5 addSubview:optionLabel5];
    [self.view addSubview:optionView5];
    
    
    optionView6 = [[UIView alloc]initWithFrame:CGRectMake(450, 595, 130, 100)];
    optionView6.backgroundColor = [UIColor clearColor];
    optionImage6 = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 130, 100)];
    optionImage6.image = [UIImage imageNamed:@"butterfly"];
    [optionView6 addSubview:optionImage6];
    optionLabel6 = [[UILabel alloc]initWithFrame:CGRectMake(35, 20, 70, 70)];
    optionLabel6.font = [UIFont fontWithName:@"Helvetica-Bold" size:31.0];
    optionLabel6.backgroundColor = [UIColor clearColor];
    optionLabel6.textAlignment = NSTextAlignmentCenter;
    optionLabel6.textColor = [UIColor whiteColor];
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
    
    butterfly1 = [NSTimer scheduledTimerWithTimeInterval:0.1 target:self selector:@selector(moveFish1) userInfo:nil repeats:YES];
    butterfly2 = [NSTimer scheduledTimerWithTimeInterval:0.1 target:self selector:@selector(moveFish2) userInfo:nil repeats:YES];
    butterfly3 = [NSTimer scheduledTimerWithTimeInterval:0.1 target:self selector:@selector(moveFish3) userInfo:nil repeats:YES];
    butterfly4 = [NSTimer scheduledTimerWithTimeInterval:0.1 target:self selector:@selector(moveFish4) userInfo:nil repeats:YES];
    butterfly5 = [NSTimer scheduledTimerWithTimeInterval:0.1 target:self selector:@selector(moveFish5) userInfo:nil repeats:YES];
    butterfly6 = [NSTimer scheduledTimerWithTimeInterval:0.1 target:self selector:@selector(moveFish6) userInfo:nil repeats:YES];
    
}


- (void)butterflyFlipFlop1:(int)direction
{
    if (direction==0) // i.e left side
    {
        if ([flipFlopButterfly1 isEqualToString:@"1"])
        {
            optionImage1.image = [UIImage imageNamed:@"butterflyflip"];
            flipFlopButterfly1 = @"2";
        }
        else if ([flipFlopButterfly1 isEqualToString:@"2"])
        {
            optionImage1.image = [UIImage imageNamed:@"butterfly"];
            flipFlopButterfly1 = @"3";
        }
        else if ([flipFlopButterfly1 isEqualToString:@"3"])
        {
            optionImage1.image = [UIImage imageNamed:@"butterfly"];
            flipFlopButterfly1 = @"4";
        }
        else if ([flipFlopButterfly1 isEqualToString:@"4"])
        {
            optionImage1.image = [UIImage imageNamed:@"butterfly"];
            flipFlopButterfly1 = @"1";
        }
    }
    else if (direction==1) // i.e right side
    {
       
        if ([flipFlopButterfly1 isEqualToString:@"1"])
        {
            optionImage1.image = [UIImage imageNamed:@"butterflyflipright"];
            flipFlopButterfly1 = @"2";
        }
        else if ([flipFlopButterfly1 isEqualToString:@"2"])
        {
            optionImage1.image = [UIImage imageNamed:@"butterflyright"];
            flipFlopButterfly1 = @"3";
        }
        else if ([flipFlopButterfly1 isEqualToString:@"3"])
        {
            optionImage1.image = [UIImage imageNamed:@"butterflyright"];
            flipFlopButterfly1 = @"4";
        }
        else if ([flipFlopButterfly1 isEqualToString:@"4"])
        {
            optionImage1.image = [UIImage imageNamed:@"butterflyright"];
            flipFlopButterfly1 = @"1";
        }
    }
}
- (void)butterflyFlipFlop2:(int)direction
{
    if (direction==0) //left side
    {
        if ([flipFlopButterfly2 isEqualToString:@"1"])
        {
            optionImage2.image = [UIImage imageNamed:@"butterflyflip"];
            flipFlopButterfly2 = @"2";
        }
        else if ([flipFlopButterfly2 isEqualToString:@"2"])
        {
            optionImage2.image = [UIImage imageNamed:@"butterfly"];
            flipFlopButterfly2 = @"3";
        }
        else if ([flipFlopButterfly2 isEqualToString:@"3"])
        {
            optionImage2.image = [UIImage imageNamed:@"butterfly"];
            flipFlopButterfly2 = @"4";
        }
        else if ([flipFlopButterfly2 isEqualToString:@"4"])
        {
            optionImage2.image = [UIImage imageNamed:@"butterfly"];
            flipFlopButterfly2 = @"1";
        }
    }
    else
    {
        if ([flipFlopButterfly2 isEqualToString:@"1"])
        {
            optionImage2.image = [UIImage imageNamed:@"butterflyflipright"];
            flipFlopButterfly2 = @"2";
        }
        else if ([flipFlopButterfly2 isEqualToString:@"2"])
        {
            optionImage2.image = [UIImage imageNamed:@"butterflyright"];
            flipFlopButterfly2 = @"3";
        }
        else if ([flipFlopButterfly2 isEqualToString:@"3"])
        {
            optionImage2.image = [UIImage imageNamed:@"butterflyright"];
            flipFlopButterfly2 = @"4";
        }
        else if ([flipFlopButterfly2 isEqualToString:@"4"])
        {
            optionImage2.image = [UIImage imageNamed:@"butterflyright"];
            flipFlopButterfly2 = @"1";
        }
    }
    
}
- (void)butterflyFlipFlop3:(int)direction
{
    
    if (direction==0)
    {
        if ([flipFlopButterfly3 isEqualToString:@"1"])
        {
            optionImage3.image = [UIImage imageNamed:@"butterflyflip"];
            flipFlopButterfly3 = @"2";
        }
        else if ([flipFlopButterfly3 isEqualToString:@"2"])
        {
            optionImage3.image = [UIImage imageNamed:@"butterfly"];
            flipFlopButterfly3 = @"3";
        }
        else if ([flipFlopButterfly3 isEqualToString:@"3"])
        {
            optionImage3.image = [UIImage imageNamed:@"butterfly"];
            flipFlopButterfly3 = @"4";
        }
        else if ([flipFlopButterfly3 isEqualToString:@"4"])
        {
            optionImage3.image = [UIImage imageNamed:@"butterfly"];
            flipFlopButterfly3 = @"1";
        }
    }
    else
    {
        if ([flipFlopButterfly3 isEqualToString:@"1"])
        {
            optionImage3.image = [UIImage imageNamed:@"butterflyflipright"];
            flipFlopButterfly3 = @"2";
        }
        else if ([flipFlopButterfly3 isEqualToString:@"2"])
        {
            optionImage3.image = [UIImage imageNamed:@"butterflyright"];
            flipFlopButterfly3 = @"3";
        }
        else if ([flipFlopButterfly3 isEqualToString:@"3"])
        {
            optionImage3.image = [UIImage imageNamed:@"butterflyright"];
            flipFlopButterfly3 = @"4";
        }
        else if ([flipFlopButterfly3 isEqualToString:@"4"])
        {
            optionImage3.image = [UIImage imageNamed:@"butterflyright"];
            flipFlopButterfly3 = @"1";
        }
    }
    
}
- (void)butterflyFlipFlop4:(int)direction
{
    if (direction==0)
    {
        if ([flipFlopButterfly4 isEqualToString:@"1"])
        {
            optionImage4.image = [UIImage imageNamed:@"butterflyflip"];
            flipFlopButterfly4 = @"2";
        }
        else if ([flipFlopButterfly4 isEqualToString:@"2"])
        {
            optionImage4.image = [UIImage imageNamed:@"butterfly"];
            flipFlopButterfly4 = @"3";
        }
        else if ([flipFlopButterfly4 isEqualToString:@"3"])
        {
            optionImage4.image = [UIImage imageNamed:@"butterfly"];
            flipFlopButterfly4 = @"4";
        }
        else if ([flipFlopButterfly4 isEqualToString:@"4"])
        {
            optionImage4.image = [UIImage imageNamed:@"butterfly"];
            flipFlopButterfly4 = @"1";
        }
    }
    else
    {
        if ([flipFlopButterfly4 isEqualToString:@"1"])
        {
            optionImage4.image = [UIImage imageNamed:@"butterflyflipright"];
            flipFlopButterfly4 = @"2";
        }
        else if ([flipFlopButterfly4 isEqualToString:@"2"])
        {
            optionImage4.image = [UIImage imageNamed:@"butterflyright"];
            flipFlopButterfly4 = @"3";
        }
        else if ([flipFlopButterfly4 isEqualToString:@"3"])
        {
            optionImage4.image = [UIImage imageNamed:@"butterflyright"];
            flipFlopButterfly4 = @"4";
        }
        else if ([flipFlopButterfly4 isEqualToString:@"4"])
        {
            optionImage4.image = [UIImage imageNamed:@"butterflyright"];
            flipFlopButterfly4 = @"1";
        }
    }
    
}
- (void)butterflyFlipFlop5:(int)direction
{
    if (direction==0)
    {
        if ([flipFlopButterfly5 isEqualToString:@"1"])
        {
            optionImage5.image = [UIImage imageNamed:@"butterflyflip"];
            flipFlopButterfly5 = @"2";
        }
        else if ([flipFlopButterfly5 isEqualToString:@"2"])
        {
            optionImage5.image = [UIImage imageNamed:@"butterfly"];
            flipFlopButterfly5 = @"3";
        }
        else if ([flipFlopButterfly5 isEqualToString:@"3"])
        {
            optionImage5.image = [UIImage imageNamed:@"butterfly"];
            flipFlopButterfly5 = @"4";
        }
        else if ([flipFlopButterfly5 isEqualToString:@"4"])
        {
            optionImage5.image = [UIImage imageNamed:@"butterfly"];
            flipFlopButterfly5 = @"1";
        }
    }
    else
    {
        if ([flipFlopButterfly5 isEqualToString:@"1"])
        {
            optionImage5.image = [UIImage imageNamed:@"butterflyflipright"];
            flipFlopButterfly5 = @"2";
        }
        else if ([flipFlopButterfly5 isEqualToString:@"2"])
        {
            optionImage5.image = [UIImage imageNamed:@"butterflyright"];
            flipFlopButterfly5 = @"3";
        }
        else if ([flipFlopButterfly5 isEqualToString:@"3"])
        {
            optionImage5.image = [UIImage imageNamed:@"butterflyright"];
            flipFlopButterfly5 = @"4";
        }
        else if ([flipFlopButterfly5 isEqualToString:@"4"])
        {
            optionImage5.image = [UIImage imageNamed:@"butterflyright"];
            flipFlopButterfly5 = @"1";
        }
    }
    
}
- (void)butterflyFlipFlop6:(int)direction
{
    if (direction==0)
    {
        if ([flipFlopButterfly6 isEqualToString:@"1"])
        {
            optionImage6.image = [UIImage imageNamed:@"butterflyflip"];
            flipFlopButterfly6 = @"2";
        }
        else if ([flipFlopButterfly6 isEqualToString:@"2"])
        {
            optionImage6.image = [UIImage imageNamed:@"butterfly"];
            flipFlopButterfly6 = @"3";
        }
        else if ([flipFlopButterfly6 isEqualToString:@"3"])
        {
            optionImage6.image = [UIImage imageNamed:@"butterfly"];
            flipFlopButterfly6 = @"4";
        }
        else if ([flipFlopButterfly6 isEqualToString:@"4"])
        {
            optionImage6.image = [UIImage imageNamed:@"butterfly"];
            flipFlopButterfly6 = @"1";
        }
    }
    else
    {
        if ([flipFlopButterfly6 isEqualToString:@"1"])
        {
            optionImage6.image = [UIImage imageNamed:@"butterflyflipright"];
            flipFlopButterfly6 = @"2";
        }
        else if ([flipFlopButterfly6 isEqualToString:@"2"])
        {
            optionImage6.image = [UIImage imageNamed:@"butterflyright"];
            flipFlopButterfly6 = @"3";
        }
        else if ([flipFlopButterfly6 isEqualToString:@"3"])
        {
            optionImage6.image = [UIImage imageNamed:@"butterflyright"];
            flipFlopButterfly6 = @"4";
        }
        else if ([flipFlopButterfly6 isEqualToString:@"4"])
        {
            optionImage6.image = [UIImage imageNamed:@"butterflyright"];
            flipFlopButterfly6 = @"1";
        }
    }
    
}


- (void)moveFish1
{
    if (!isFish1MovementRight)
    {
        
        negativeX1+=2;
        
        switch (isFirstTimeRun1) {
            case NO:
                optionView1.frame = CGRectMake(520-negativeX1, 260, 130, 100);
                break;
            case YES:
                optionView1.frame = CGRectMake(630-negativeX1, 260, 130, 100);
                break;
                
                
            default:
                break;
        }
        [self butterflyFlipFlop1:0];
        if (optionView1.frame.origin.x<=2)
        {
            optionImage1.image = [UIImage imageNamed:@"butterflyright"];
            optionLabel1.frame = CGRectMake(25, 20, 70, 70);
            isFish1MovementRight = YES;
            negativeX1 = 2;
        }
    }
    else if (isFish1MovementRight) {
        isFirstTimeRun1 = YES;
        negativeX1 += 2;
        optionView1.frame = CGRectMake(5 + negativeX1, 260, 130, 100);
    
        [self butterflyFlipFlop1:1];
        
        if (optionView1.frame.origin.x>630) {
            optionImage1.image = [UIImage imageNamed:@"butterfly"];
            optionLabel1.frame = CGRectMake(35, 20, 70, 70);
            isFish1MovementRight = NO;
            negativeX1 = 2;
        }
    }
    
}
- (void)moveFish2 {
    
    if (!isFish2MovementRight) {
        
        negativeX2+=2;
        
        switch (isFirstTimeRun2) {
            case NO:
                optionView2.frame = CGRectMake(495-negativeX2, 397, 130, 100);
                break;
            case YES:
                optionView2.frame = CGRectMake(630-negativeX2, 397, 130, 100);
                break;
                
                
            default:
                break;
        }
        [self butterflyFlipFlop2:0];
        if (optionView2.frame.origin.x<=2) {
            isFirstTimeRun2 = YES;
            optionImage2.image = [UIImage imageNamed:@"butterflyright"];
            optionLabel2.frame = CGRectMake(25, 20, 70, 70);
            isFish2MovementRight = YES;
            negativeX2 = 2;
        }
    }
    else if (isFish2MovementRight) {
        
        negativeX2 += 2;
        optionView2.frame = CGRectMake(5 + negativeX2, 397, 130, 100);
        
        [self butterflyFlipFlop2:1];
        
        if (optionView2.frame.origin.x>630) {
            optionImage2.image = [UIImage imageNamed:@"butterfly"];
            optionLabel2.frame = CGRectMake(35, 20, 70, 70);
            isFish2MovementRight = NO;
            negativeX2 = 2;
        }
    }
    
}
- (void)moveFish3 {
    
    if (!isFish3MovementRight) {
        
        negativeX3+=2;
        
        switch (isFirstTimeRun3) {
            case NO:
                optionView3.frame = CGRectMake(650-negativeX3, 330, 130, 100);
                break;
            case YES:
                optionView3.frame = CGRectMake(630-negativeX3, 330, 130, 100);
                break;
                
            default:
                break;
        }
        [self butterflyFlipFlop3:0];
        if (optionView3.frame.origin.x<=2) {
            optionImage3.image = [UIImage imageNamed:@"butterflyright"];
            optionLabel3.frame = CGRectMake(25, 20, 70, 70);
            isFish3MovementRight = YES;
            negativeX3 = 2;
        }
    }
    else if (isFish3MovementRight) {
        isFirstTimeRun3 = YES;
        negativeX3 += 2;
        optionView3.frame = CGRectMake(5 + negativeX3, 330, 130, 100);
        
        [self butterflyFlipFlop3:1];
        
        if (optionView3.frame.origin.x>630) {
            optionImage3.image = [UIImage imageNamed:@"butterfly"];
            optionLabel3.frame = CGRectMake(35, 20, 70, 70);
            isFish3MovementRight = NO;
            negativeX3 = 2;
        }
    }
    
}
- (void)moveFish4 {
    
    if (!isFish4MovementRight) {
        
        negativeX4+=2;
        
        switch (isFirstTimeRun4) {
            case NO:
                optionView4.frame = CGRectMake(595-negativeX4, 460, 130, 100);
                break;
            case YES:
                optionView4.frame = CGRectMake(630-negativeX4, 460, 130, 100);
                break;
                
            default:
                break;
        }
        [self butterflyFlipFlop4:0];
        if (optionView4.frame.origin.x<=2) {
            optionImage4.image = [UIImage imageNamed:@"butterflyright"];
            optionLabel4.frame = CGRectMake(25, 20, 70, 70);
            isFish4MovementRight = YES;
            negativeX4 = 2;
        }
    }
    else if (isFish4MovementRight) {
        isFirstTimeRun4 = YES;
        negativeX4 += 2;
        optionView4.frame = CGRectMake(5 + negativeX4, 460, 130, 100);
        optionLabel4.frame = CGRectMake(35, 20, 70, 70);
        
        [self butterflyFlipFlop4:1];
        
        if (optionView4.frame.origin.x>630) {
            optionImage4.image = [UIImage imageNamed:@"butterfly"];
            isFish4MovementRight = NO;
            negativeX4 = 2;
        }
    }
    
}
- (void)moveFish5 {
    
    if (!isFish5MovementRight) {
        
        negativeX5+=2;
        
        switch (isFirstTimeRun5) {
            case NO:
                optionView5.frame = CGRectMake(640-negativeX5, 530, 130, 100);
                break;
            case YES:
                optionView5.frame = CGRectMake(630-negativeX5, 530, 130, 100);
                break;
                
            default:
                break;
        }
        [self butterflyFlipFlop5:0];
        if (optionView5.frame.origin.x<=2) {
            optionImage5.image = [UIImage imageNamed:@"butterflyright"];
            optionLabel5.frame = CGRectMake(25, 20, 70, 70);
            isFish5MovementRight = YES;
            negativeX5 = 2;
        }
    }
    else if (isFish5MovementRight) {
        isFirstTimeRun5 = YES;
        negativeX5 += 2;
        optionView5.frame = CGRectMake(5 + negativeX5, 530, 130, 100);
        
        [self butterflyFlipFlop5:1];
        
        if (optionView5.frame.origin.x>630) {
            optionImage5.image = [UIImage imageNamed:@"butterfly"];
            optionLabel5.frame = CGRectMake(35, 20, 70, 70);
            isFish5MovementRight = NO;
            negativeX5 = 2;
        }
    }
    
}
- (void)moveFish6 {
    
    if (!isFish6MovementRight) {
        
        negativeX6+=2;
        
        switch (isFirstTimeRun6) {
            case NO:
                optionView6.frame = CGRectMake(450-negativeX6, 595, 130, 100);
                break;
            case YES:
                optionView6.frame = CGRectMake(630-negativeX6, 595, 130, 100);
                break;
                
            default:
                break;
        }
        [self butterflyFlipFlop6:0];
        if (optionView6.frame.origin.x<=2) {
            optionImage6.image = [UIImage imageNamed:@"butterflyright"];
            optionLabel6.frame = CGRectMake(25, 20, 70, 70);
            isFish6MovementRight = YES;
            negativeX6 = 2;
        }
    }
    else if (isFish6MovementRight) {
        isFirstTimeRun6 = YES;
        negativeX6 += 2;
        optionView6.frame = CGRectMake(5 + negativeX6, 595, 130, 100);
        
        [self butterflyFlipFlop6:1];
        
        if (optionView6.frame.origin.x>630) {
            optionImage6.image = [UIImage imageNamed:@"butterfly"];
            optionLabel6.frame = CGRectMake(35, 20, 70, 70);
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
            //nextLevelButton.userInteractionEnabled = NO;
            if ([bubbleNumber isEqualToString:@"0"])
            {
                randomnumber = [self getRandomNumber:81 to:190];
            }
            else
            {
                randomnumber = [self getRandomNumber:81 to:190];
            }
            
            numberLabel1.font = [UIFont fontWithName:@"MarkerFelt-Wide" size:38.0f];
            numberLabel2.font = [UIFont fontWithName:@"MarkerFelt-Wide" size:38.0f];
            numberLabel3.font = [UIFont fontWithName:@"MarkerFelt-Wide" size:38.0f];
            numberLabel4.font = [UIFont fontWithName:@"MarkerFelt-Wide" size:38.0f];
            numberLabel5.font = [UIFont fontWithName:@"MarkerFelt-Wide" size:38.0f];
            numberLabel6.font = [UIFont fontWithName:@"MarkerFelt-Wide" size:38.0f];
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
            //nextLevelButton.userInteractionEnabled = NO;
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
    
        if ([bubbleNumber isEqualToString:@"0"])
    {
        value2 = randomnumber+1;
        value3 = value2+1;
        value4 = value3+1;
        value5 = value4+1;
        value6 = value5+1;
    }
    else
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
                    [butterfly1 invalidate];
                    butterfly1 = nil;
                    originalFrameOfOptionView1 = [touch view].frame;
                    //optionframe1value++;
                    
                }
            }
            else if ([touch view]==optionView2)
            {
                if (optionframe2value ==1)
                {
                    [butterfly2 invalidate];
                    originalFrameOfOptionView2 = [touch view].frame;
                    //optionframe2value++;
                }
            }
            else if ([touch view]==optionView3)
            {
                if (optionframe3value ==1)
                {
                    [butterfly3 invalidate];
                    originalFrameOfOptionView3 = [touch view].frame;
                    
                    //optionframe3value++;
                }
            }
            else if ([touch view]==optionView4)
            {
                if (optionframe4value ==1)
                {
                    [butterfly4 invalidate];
                    originalFrameOfOptionView4 = [touch view].frame;
                    //optionframe4value++;
                }
            }
            else if ([touch view]==optionView5)
            {
                if (optionframe5value ==1)
                {
                    [butterfly5 invalidate];
                    originalFrameOfOptionView5 = [touch view].frame;
                    //optionframe5value++;
                }
            }
            else if ([touch view]==optionView6)
            {
                if (optionframe6value ==1)
                {
                    [butterfly6 invalidate];
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
        if ([butterfly1 isValid]) {
            [butterfly1 invalidate];
            butterfly1 = nil;
        }
        butterfly1 = [NSTimer scheduledTimerWithTimeInterval:0.1 target:self selector:@selector(moveFish1) userInfo:nil repeats:YES];
        
    } else if ([touch_ view]==optionView2) {
        if ([butterfly2 isValid]) {
            [butterfly2 invalidate];
            butterfly2 = nil;
        }
        butterfly2 = [NSTimer scheduledTimerWithTimeInterval:0.1 target:self selector:@selector(moveFish2) userInfo:nil repeats:YES];
        
    } else if ([touch_ view]==optionView3) {
        if ([butterfly3 isValid]) {
            [butterfly3 invalidate];
            butterfly3 = nil;
        }
        butterfly3 = [NSTimer scheduledTimerWithTimeInterval:0.1 target:self selector:@selector(moveFish3) userInfo:nil repeats:YES];
        
    } else if ([touch_ view]==optionView4) {
        if ([butterfly4 isValid]) {
            [butterfly4 invalidate];
            butterfly4 = nil;
        }
        butterfly4 = [NSTimer scheduledTimerWithTimeInterval:0.1 target:self selector:@selector(moveFish4) userInfo:nil repeats:YES];
        
    } else if ([touch_ view]==optionView5) {
        if ([butterfly5 isValid]) {
            [butterfly5 invalidate];
            butterfly5 = nil;
        }
        butterfly5 = [NSTimer scheduledTimerWithTimeInterval:0.1 target:self selector:@selector(moveFish5) userInfo:nil repeats:YES];
        
    } else if ([touch_ view]==optionView6) {
        if ([butterfly6 isValid]) {
            [butterfly6 invalidate];
            butterfly6 = nil;
        }
        butterfly6 = [NSTimer scheduledTimerWithTimeInterval:0.1 target:self selector:@selector(moveFish6) userInfo:nil repeats:YES];
        
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
        
        CGRect myRect = CGRectMake(label1Hide.frame.origin.x, label1Hide.frame.origin.y - 30, label1Hide.frame.size.width, label1Hide.frame.size.height);
        BOOL isInside = CGRectContainsPoint(myRect, touchPoint);
        
        CGRect myRect2 = CGRectMake(label2Hide.frame.origin.x, label2Hide.frame.origin.y - 30, label2Hide.frame.size.width, label2Hide.frame.size.height);
        BOOL isInside2 = CGRectContainsPoint(myRect2, touchPoint);
        
        CGRect myRect3 = CGRectMake(label3Hide.frame.origin.x, label3Hide.frame.origin.y - 30, label3Hide.frame.size.width, label3Hide.frame.size.height);
        BOOL isInside3 = CGRectContainsPoint(myRect3, touchPoint);
        
        if(isInside)
        {
            NSArray *subviewArray = [touch view].subviews;
            
            if ([[(UILabel*)[subviewArray objectAtIndex:1] text] isEqualToString:label1Hide.text] )
            {
                rect1 = label1Hide.frame;
                rect1 = CGRectMake(rect1.origin.x+15, rect1.origin.y-70, 80, 80);
                [touch view].frame = rect1;
                for (UIView *subview in [[touch view] subviews]) {
                    subview.frame = CGRectMake(8, 5, 80, 80);
                    
                }
                
                if ([touch view]==optionView1) {
                    if ([butterfly1 isValid]) {
                        [butterfly1 invalidate];
                        butterfly1 = nil;
                    }
                    
                } else if ([touch view]==optionView2) {
                    if ([butterfly2 isValid]) {
                        [butterfly2 invalidate];
                        butterfly2 = nil;
                    }
                    
                } else if ([touch view]==optionView3) {
                    if ([butterfly3 isValid]) {
                        [butterfly3 invalidate];
                        butterfly3 = nil;
                    }
                    
                } else if ([touch view]==optionView4) {
                    if ([butterfly4 isValid]) {
                        [butterfly4 invalidate];
                        butterfly4 = nil;
                    }
                    
                } else if ([touch view]==optionView5) {
                    if ([butterfly5 isValid]) {
                        [butterfly5 invalidate];
                        butterfly5 = nil;
                    }
                    
                } else if ([touch view]==optionView6) {
                    if ([butterfly6 isValid]) {
                        [butterfly6 invalidate];
                        butterfly6 = nil;
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
                rect2 = CGRectMake(rect2.origin.x+15, rect2.origin.y-70, 80, 80);
                [touch view].frame = rect2;
                for (UIView *subview in [[touch view] subviews]) {
                    subview.frame = CGRectMake(8, 5, 80, 80);
                    
                }
                
                if ([touch view]==optionView1) {
                    if ([butterfly1 isValid]) {
                        [butterfly1 invalidate];
                        butterfly1 = nil;
                    }
                    
                } else if ([touch view]==optionView2) {
                    if ([butterfly2 isValid]) {
                        [butterfly2 invalidate];
                        butterfly2 = nil;
                    }
                    
                } else if ([touch view]==optionView3) {
                    if ([butterfly3 isValid]) {
                        [butterfly3 invalidate];
                        butterfly3 = nil;
                    }
                    
                } else if ([touch view]==optionView4) {
                    if ([butterfly4 isValid]) {
                        [butterfly4 invalidate];
                        butterfly4 = nil;
                    }
                    
                } else if ([touch view]==optionView5) {
                    if ([butterfly5 isValid]) {
                        [butterfly5 invalidate];
                        butterfly5 = nil;
                    }
                    
                } else if ([touch view]==optionView6) {
                    if ([butterfly6 isValid]) {
                        [butterfly6 invalidate];
                        butterfly6 = nil;
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
                rect3 = CGRectMake(rect3.origin.x+15, rect3.origin.y-70, 80, 80);
                [touch view].frame = rect3;
                for (UIView *subview in [[touch view] subviews]) {
                    subview.frame = CGRectMake(8, 5, 80, 80);
                    
                }
                
                if ([touch view]==optionView1) {
                    if ([butterfly1 isValid]) {
                        [butterfly1 invalidate];
                        butterfly1 = nil;
                    }
                    
                } else if ([touch view]==optionView2) {
                    if ([butterfly2 isValid]) {
                        [butterfly2 invalidate];
                        butterfly2 = nil;
                    }
                    
                } else if ([touch view]==optionView3) {
                    if ([butterfly3 isValid]) {
                        [butterfly3 invalidate];
                        butterfly3 = nil;
                    }
                    
                } else if ([touch view]==optionView4) {
                    if ([butterfly4 isValid]) {
                        [butterfly4 invalidate];
                        butterfly4 = nil;
                    }
                    
                } else if ([touch view]==optionView5) {
                    if ([butterfly5 isValid]) {
                        [butterfly5 invalidate];
                        butterfly5 = nil;
                    }
                    
                } else if ([touch view]==optionView6) {
                    if ([butterfly6 isValid]) {
                        [butterfly6 invalidate];
                        butterfly6 = nil;
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
        
        if ([butterfly1 isValid]) {
            [butterfly1 invalidate];
            butterfly1 = nil;
        }
        
        if ([butterfly2 isValid]) {
            [butterfly2 invalidate];
            butterfly2 = nil;
        }
        
        if ([butterfly3 isValid]) {
            [butterfly3 invalidate];
            butterfly3 = nil;
        }
        
        if ([butterfly4 isValid]) {
            [butterfly4 invalidate];
            butterfly4 = nil;
        }
        
        if ([butterfly5 isValid]) {
            [butterfly5 invalidate];
            butterfly5 = nil;
        }
        
        if ([butterfly6 isValid]) {
            [butterfly6 invalidate];
            butterfly6 = nil;
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
    
    [optionView1 setFrame:CGRectMake(95, 100, 70, 70)];
    [optionView2 setFrame:CGRectMake(195, 200, 70, 70)];
    [optionView3 setFrame:CGRectMake(395, 150, 70, 70)];
    [optionView4 setFrame:CGRectMake(95, 300, 70, 70)];
    [optionView5 setFrame:CGRectMake(495, 320, 70, 70)];
    [optionView6 setFrame:CGRectMake(295, 320, 70, 70)];
    
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
