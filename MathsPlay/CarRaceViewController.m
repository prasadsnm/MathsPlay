//
//  CarRaceViewController.m
//  KidsLearningGame
//
//  Created by QA Infotech on 30/08/13.
//  Copyright (c) 2013 QAInfotech. All rights reserved.
//

#import "CarRaceViewController.h"

@interface CarRaceViewController ()
{
    int hh,mm,ss;
    int run_onlyone_time;
    BOOL isTimerPaused;
}
@end

@implementation CarRaceViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        
    }
    return self;
}


- (void)backButtonPressed {
    
    if ([balloonMoveTimer isValid]) {
        [balloonMoveTimer invalidate];
        balloonMoveTimer = nil;
    } else if ([clockTimer isValid]) {
        [clockTimer invalidate];
        clockTimer = nil;
    } else if ([carTimer1 isValid]) {
        [carTimer1 invalidate];
        carTimer1 = nil;
    } else if ([carTimer2 isValid]) {
        [carTimer2 invalidate];
        carTimer2 = nil;
    } else if ([carTimer3 isValid]) {
        [carTimer3 invalidate];
        carTimer3 = nil;
    } else if ([myCarTimer isValid]) {
        [myCarTimer invalidate];
        myCarTimer = nil;
    } else if ([myCarTimerAtDoubleSpeed isValid]) {
        [myCarTimerAtDoubleSpeed invalidate];
        myCarTimerAtDoubleSpeed = nil;
    }
    
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    SET_USERNAME_AS_TITLE
	// Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor colorWithRed:0/255.0 green:178/255.0 blue:236/255.0 alpha:1.0];
    
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
    
    hh=0;
    mm=0;
    ss=0;
    run_onlyone_time=0;
    correctAns=0;
    wrongAns=0;
    
    clockLabel = [[UILabel alloc]initWithFrame:CGRectMake(40, 50, 200, 40)];
    clockLabel.text = @"";
    clockLabel.textColor = [UIColor colorWithRed:0/255.0 green:0/255.0 blue:0/255.0 alpha:1.0];
    clockLabel.backgroundColor = [UIColor clearColor];
    clockLabel.font = [UIFont fontWithName:@"BradleyHandITCTT-Bold" size:40];
    [self.view addSubview:clockLabel];
    
    UIImageView *correctImageLogo = [[UIImageView alloc]initWithFrame:CGRectMake(380, 40, 30, 30)];
    correctImageLogo.image = [UIImage imageNamed:@"correct"];
    [self.view addSubview:correctImageLogo];
    
    UIImageView *inCorrectImageLogo = [[UIImageView alloc]initWithFrame:CGRectMake(380, 80, 30, 30)];
    inCorrectImageLogo.image = [UIImage imageNamed:@"incorrect"];
    [self.view addSubview:inCorrectImageLogo];
    
    correctAnsLabel = [[UILabel alloc]initWithFrame:CGRectMake(300, 30, 80, 30)];
    correctAnsLabel.backgroundColor = [UIColor clearColor];
    correctAnsLabel.textAlignment = NSTextAlignmentCenter;
    correctAnsLabel.font = [UIFont fontWithName:@"BradleyHandITCTT-Bold" size:40];
    correctAnsLabel.text = @"0";
    correctAnsLabel.textColor = [UIColor purpleColor];
    [self.view addSubview:correctAnsLabel];
    
    inCorrectAnsLabel = [[UILabel alloc]initWithFrame:CGRectMake(300, 80, 80, 30)];
    inCorrectAnsLabel.backgroundColor = [UIColor clearColor];
    inCorrectAnsLabel.textAlignment = NSTextAlignmentCenter;
    inCorrectAnsLabel.font = [UIFont fontWithName:@"BradleyHandITCTT-Bold" size:40];
    inCorrectAnsLabel.text = @"0";
    inCorrectAnsLabel.textColor = [UIColor purpleColor];
    [self.view addSubview:inCorrectAnsLabel];
    
    UIView *track1 = [[UIView alloc]initWithFrame:CGRectMake(0, 140, 750, 80)];
    track1.backgroundColor = [UIColor lightTextColor];
    [self.view addSubview:track1];
    
    UIView *track2 = [[UIView alloc]initWithFrame:CGRectMake(0, 222, 750, 80)];
    track2.backgroundColor = [UIColor lightGrayColor];
    [self.view addSubview:track2];
    
    UIView *track3 = [[UIView alloc]initWithFrame:CGRectMake(0, 304, 750, 80)];
    track3.backgroundColor = [UIColor lightTextColor];
    [self.view addSubview:track3];
    
    UIView *track4 = [[UIView alloc]initWithFrame:CGRectMake(0, 386, 750, 80)];
    track4.backgroundColor = [UIColor lightGrayColor];
    [self.view addSubview:track4];
    
    finishLine = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"finishline2"]];
    finishLine.frame = CGRectMake(750, 140, 18, 324);
    [self.view addSubview:finishLine];
    
    carImage1 = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"Acomp2"]];
    carImage1.frame = CGRectMake(0, 15, 90, 50);
    [track1 addSubview:carImage1];
    
    carImage2 = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"Acar1.png"]];
    carImage2.frame = CGRectMake(0, 15, 90, 50);
    [track2 addSubview:carImage2];
    
    carImage3 = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"Acomp1.jpg"]];
    carImage3.frame = CGRectMake(0, 20, 90, 40);
    [track3 addSubview:carImage3];
    
    carImage4 = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"Acomp3"]];
    carImage4.frame = CGRectMake(0, 15, 90, 50);
    [track4 addSubview:carImage4];
    
    UIImageView *spikesImage = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"spikes"]];
    spikesImage.frame = CGRectMake(0, 550, 384, 30);
    [self.view addSubview:spikesImage];
    
    UIImageView *spikesImage1 = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"spikes"]];
    spikesImage1.frame = CGRectMake(384, 550, 384, 30);
    [self.view addSubview:spikesImage1];
    
    UIButton *playButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [playButton setTitle:@"< GO >" forState:UIControlStateNormal];
    [playButton setBackgroundColor:[UIColor yellowColor]];
    [playButton setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    playButton.frame = CGRectMake(300, 280, 150, 50);
    playButton.titleLabel.font = [UIFont fontWithName:@"Chalkduster" size:20.0];;
    [playButton addTarget:self action:@selector(goButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:playButton];
    
    yourCarArrow = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"arrow"]];
    yourCarArrow.frame = CGRectMake(130, 30, 30, 30);
    [track2 addSubview:yourCarArrow];
    [self performSelector:@selector(moveArrow)];
    
    questionLabel = [[UILabel alloc]initWithFrame:CGRectMake(270, 465, 160, 80)];
    questionLabel.font = [UIFont fontWithName:@"Verdana" size:50];
    questionLabel.textAlignment = NSTextAlignmentCenter;
    questionLabel.textColor = [UIColor yellowColor];
    questionLabel.backgroundColor = [UIColor clearColor];
    [self.view addSubview:questionLabel];
    
    helpButton=[UIButton buttonWithType:UIButtonTypeCustom];
    [helpButton setImage:[UIImage imageNamed:@"rules"] forState:UIControlStateNormal];
    helpButton.tag=100011;
    [helpButton addTarget:self action:@selector(buttonActionMethod:) forControlEvents:UIControlEventTouchUpInside];
    helpButton.frame=CGRectMake(self.view.frame.size.width-200 , 20, 200, 80);
    helpButton.showsTouchWhenHighlighted=YES;
    [self.view addSubview:helpButton];
    
    plistDict = [[Util readPListData]copy];
}


-(void)buttonActionMethod:(UIButton *)sender
{
    [self pauseTheGame];
    UIViewController *modalForRules=[[UIViewController alloc]init];
    modalForRules.view.backgroundColor=[UIColor colorWithRed:132/255.0 green:240/255.0 blue:88/255.0 alpha:1];
    modalForRules.modalTransitionStyle=UIModalTransitionStyleCoverVertical;
    modalForRules.modalPresentationStyle=UIModalPresentationFormSheet;
    [self presentViewController:modalForRules animated:YES completion:NULL];
    UITapGestureRecognizer *tapEvent=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(handleTapOnModal:)];
    [modalForRules.view addGestureRecognizer:tapEvent];
    UILabel *instructionLabelTitle=[[UILabel alloc]initWithFrame:CGRectMake(10, 25,modalForRules.view.frame.size.width-30, 50)];
    instructionLabelTitle.numberOfLines=1;
    instructionLabelTitle.backgroundColor=[UIColor clearColor];
    instructionLabelTitle.textAlignment=NSTextAlignmentCenter;
    instructionLabelTitle.font=[UIFont fontWithName:RULES_FONT_NAME size:35];
    instructionLabelTitle.text=@"Rules";
    [modalForRules.view addSubview:instructionLabelTitle];
    
    UIImageView *topbar=[[UIImageView alloc]initWithFrame:CGRectMake(0, -10, modalForRules.view.frame.size.width, 50)];
    topbar.image=[UIImage imageNamed:@"sp-top"];
    [modalForRules.view addSubview:topbar];
    
    UILabel *instructionLabel=[[UILabel alloc]initWithFrame:CGRectMake(40, 80, modalForRules.view.frame.size.width-70, modalForRules.view.frame.size.height-100)];
    instructionLabel.numberOfLines=0;
    instructionLabel.backgroundColor=[UIColor clearColor];
    instructionLabel.textAlignment=NSTextAlignmentLeft;
    instructionLabel.font=[UIFont fontWithName:RULES_FONT_NAME size:30];
    instructionLabel.text=@"a)Choose the right option among the ballons.\n\nb)If answer is correct your car's(2nd from top) speed increases.\n\nc)Answer quickly to accelerate the car.\n\n \t\t\t\t[ Tap to dismiss. ]";
    [modalForRules.view addSubview:instructionLabel];
}

-(void)handleTapOnModal:(UITapGestureRecognizer *)recognizer
{
    [self resumeTheGame];
    [self dismissModalViewControllerAnimated:YES];
}


#pragma mark Go Button Clicked

- (void)goButtonClicked:(UIButton *)btn  {
    
    self.view.userInteractionEnabled = YES;
    if (run_onlyone_time==0) {
        // remove arrow and go btn
        [yourCarArrow.layer removeAllAnimations];
        [yourCarArrow removeFromSuperview];
        [btn removeFromSuperview];
        // start clock timer
        clockTimer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(clockTimer) userInfo:nil repeats:YES];
        carTimer1 = [NSTimer scheduledTimerWithTimeInterval:.1 target:self selector:@selector(firstAutoCar) userInfo:nil repeats:YES];
        carTimer2 = [NSTimer scheduledTimerWithTimeInterval:.1 target:self selector:@selector(secondAutoCar) userInfo:nil repeats:YES];
        carTimer3 = [NSTimer scheduledTimerWithTimeInterval:.1 target:self selector:@selector(thirdAutoCar) userInfo:nil repeats:YES];
        myCarTimer = [NSTimer scheduledTimerWithTimeInterval:.1 target:self selector:@selector(myCarMoveWithNormalSpeed) userInfo:nil repeats:YES];
        run_onlyone_time++;
    }
    
        balloonBtn1 = nil;
        balloonBtn2 = nil;
        balloonBtn3 = nil;
        balloonBtn4 = nil;
        balloonArray = nil;
        
        balloonBtn1 = [UIButton buttonWithType:UIButtonTypeCustom];
        [balloonBtn1 setImage:[UIImage imageNamed:@"ball1"] forState:UIControlStateNormal];
        [balloonBtn1 addTarget:self action:@selector(balloonClicked:) forControlEvents:UIControlEventTouchUpInside];
        [balloonBtn1 setFrame:CGRectMake(50, 850, 150, 100)];
        balloonBtn2 = [UIButton buttonWithType:UIButtonTypeCustom];
        [balloonBtn2 setImage:[UIImage imageNamed:@"ball2"] forState:UIControlStateNormal];
        [balloonBtn2 addTarget:self action:@selector(balloonClicked:) forControlEvents:UIControlEventTouchUpInside];
        [balloonBtn2 setFrame:CGRectMake(220, 860, 150, 100)];
        balloonBtn3 = [UIButton buttonWithType:UIButtonTypeCustom];
        [balloonBtn3 setImage:[UIImage imageNamed:@"ball3"] forState:UIControlStateNormal];
        [balloonBtn3 addTarget:self action:@selector(balloonClicked:) forControlEvents:UIControlEventTouchUpInside];
        [balloonBtn3 setFrame:CGRectMake(390, 865, 150, 100)];
        balloonBtn4 = [UIButton buttonWithType:UIButtonTypeCustom];
        [balloonBtn4 setImage:[UIImage imageNamed:@"ball4"] forState:UIControlStateNormal];
        [balloonBtn4 addTarget:self action:@selector(balloonClicked:) forControlEvents:UIControlEventTouchUpInside];
        [balloonBtn4 setFrame:CGRectMake(560, 850, 150, 100)];
        
        balloonArray = [[NSArray alloc]initWithObjects:balloonBtn1,balloonBtn2,balloonBtn3,balloonBtn4, nil]; // so that we can randomly select a balloon and put right ans on it
    
        // show question and options
        [self generateQuestion];    
    
}


- (void)firstAutoCar {
    
    carImage1.frame = CGRectMake(carImage1.frame.origin.x+1, carImage1.frame.origin.y, carImage1.frame.size.width, carImage1.frame.size.height);
    
    if (carImage1.frame.origin.x>670) {
        if ([carTimer1 isValid]) {
            [carTimer1 invalidate];
            carTimer1 = nil;
            firstCar = 1; // i.e car 1 came first
        }
    }
}


- (void)secondAutoCar {
    
    carImage3.frame = CGRectMake(carImage3.frame.origin.x+0.8, carImage3.frame.origin.y, carImage3.frame.size.width, carImage3.frame.size.height);
    if (carImage3.frame.origin.x>670) {
        if ([carTimer2 isValid]) {
            [carTimer2 invalidate];
            carTimer2 = nil;
            secondCar = 2; // i.e car 2 came second as it can't come first 
        }
    }
}


- (void)thirdAutoCar {
    
    carImage4.frame = CGRectMake(carImage4.frame.origin.x+0.7, carImage4.frame.origin.y, carImage4.frame.size.width, carImage4.frame.size.height);
    if (carImage4.frame.origin.x>670) {
        if ([carTimer3 isValid]) {
            [carTimer3 invalidate];
            carTimer3 = nil;
        } if ([myCarTimer isValid]) {
            [myCarTimer invalidate];
            myCarTimer = nil;
        }
    
        myCar = 4;
    
        [balloonBtn1 removeFromSuperview];
        [balloonBtn2 removeFromSuperview];
        [balloonBtn3 removeFromSuperview];
        [balloonBtn4 removeFromSuperview];
        [questionLabel removeFromSuperview];
        UILabel *rankingLabelOfYourCar = [[UILabel alloc]initWithFrame:CGRectMake(250, 650, 400, 100)];
        rankingLabelOfYourCar.backgroundColor = [UIColor clearColor];
        rankingLabelOfYourCar.font = [UIFont fontWithName:@"BradleyHandITCTT-Bold" size:40];
        rankingLabelOfYourCar.text = @"You came last";
        [self.view addSubview:rankingLabelOfYourCar];
        if ([balloonMoveTimer isValid]) {
        [balloonMoveTimer invalidate];
        balloonMoveTimer = nil;
        } else if ([clockTimer isValid]) {
        [clockTimer invalidate];
        clockTimer = nil;
        } else if ([carTimer1 isValid]) {
        [carTimer1 invalidate];
        carTimer1 = nil;
        } else if ([carTimer2 isValid]) {
        [carTimer2 invalidate];
        carTimer2 = nil;
        } else if ([carTimer3 isValid]) {
        [carTimer3 invalidate];
        carTimer3 = nil;
        } else if ([myCarTimer isValid]) {
        [myCarTimer invalidate];
        myCarTimer = nil;
        } else if ([myCarTimerAtDoubleSpeed isValid]) {
        [myCarTimerAtDoubleSpeed invalidate];
        myCarTimerAtDoubleSpeed = nil;
        }
    }
}


- (void)myCarMoveWithNormalSpeed {
    
    carImage2.frame = CGRectMake(carImage2.frame.origin.x+0.5, carImage2.frame.origin.y, carImage2.frame.size.width, carImage2.frame.size.height);
    if (carImage2.frame.origin.x>670) {
        if ([balloonMoveTimer isValid]) {
            [balloonMoveTimer invalidate];
            balloonMoveTimer = nil;
        } else if ([clockTimer isValid]) {
            [clockTimer invalidate];
            clockTimer = nil;
        } else if ([carTimer1 isValid]) {
            [carTimer1 invalidate];
            carTimer1 = nil;
        } else if ([carTimer2 isValid]) {
            [carTimer2 invalidate];
            carTimer2 = nil;
        } else if ([carTimer3 isValid]) {
            [carTimer3 invalidate];
            carTimer3 = nil;
        } else if ([myCarTimer isValid]) {
            [myCarTimer invalidate];
            myCarTimer = nil;
        } else if ([myCarTimerAtDoubleSpeed isValid]) {
            [myCarTimerAtDoubleSpeed invalidate];
            myCarTimerAtDoubleSpeed = nil;
        }
        [balloonBtn1 removeFromSuperview];
        [balloonBtn2 removeFromSuperview];
        [balloonBtn3 removeFromSuperview];
        [balloonBtn4 removeFromSuperview];
        [questionLabel removeFromSuperview];
        
        UILabel *rankingLabelOfYourCar = [[UILabel alloc]initWithFrame:CGRectMake(250, 650, 400, 100)];
        rankingLabelOfYourCar.backgroundColor = [UIColor clearColor];
        rankingLabelOfYourCar.font = [UIFont fontWithName:@"BradleyHandITCTT-Bold" size:40];
        [self.view addSubview:rankingLabelOfYourCar];
        
        if (firstCar==1) {
            if (secondCar==2) {
                myCar = 3;
                rankingLabelOfYourCar.text = @"You came third";
            } else {
                myCar = 2;
                rankingLabelOfYourCar.text = @"You came second";
            }
            
        } else {
            myCar = 1;
            rankingLabelOfYourCar.text = @"You came first";
        }
        
        
    }
}


- (void)myCarMoveWithDoubleSpeed {
    
    carImage2.frame = CGRectMake(carImage2.frame.origin.x+2, carImage2.frame.origin.y, carImage2.frame.size.width, carImage2.frame.size.height);
    if (carImage2.frame.origin.x>670) {
        if ([balloonMoveTimer isValid]) {
            [balloonMoveTimer invalidate];
            balloonMoveTimer = nil;
        } else if ([clockTimer isValid]) {
            [clockTimer invalidate];
            clockTimer = nil;
        } else if ([carTimer1 isValid]) {
            [carTimer1 invalidate];
            carTimer1 = nil;
        } else if ([carTimer2 isValid]) {
            [carTimer2 invalidate];
            carTimer2 = nil;
        } else if ([carTimer3 isValid]) {
            [carTimer3 invalidate];
            carTimer3 = nil;
        } else if ([myCarTimer isValid]) {
            [myCarTimer invalidate];
            myCarTimer = nil;
        } else if ([myCarTimerAtDoubleSpeed isValid]) {
            [myCarTimerAtDoubleSpeed invalidate];
            myCarTimerAtDoubleSpeed = nil;
        }
        [balloonBtn1 removeFromSuperview];
        [balloonBtn2 removeFromSuperview];
        [balloonBtn3 removeFromSuperview];
        [balloonBtn4 removeFromSuperview];
        [questionLabel removeFromSuperview];
        
        UILabel *rankingLabelOfYourCar = [[UILabel alloc]initWithFrame:CGRectMake(250, 650, 400, 100)];
        rankingLabelOfYourCar.backgroundColor = [UIColor clearColor];
        rankingLabelOfYourCar.font = [UIFont fontWithName:@"BradleyHandITCTT-Bold" size:40];
        [self.view addSubview:rankingLabelOfYourCar];
        
        if (firstCar==1) {
            if (secondCar==2) {
                myCar = 3;
                rankingLabelOfYourCar.text = @"You came third";
            } else {
                myCar = 2;
                rankingLabelOfYourCar.text = @"You came second";
            }
            
        } else {
            myCar = 1;
            rankingLabelOfYourCar.text = @"You came first";
        }
        
    }
}


- (void)myCarMoveWithNormalSpeedAgain {
    
    if (carImage2.frame.origin.x<670) {
        if ([myCarTimerAtDoubleSpeed isValid]) {
        
            [myCarTimerAtDoubleSpeed invalidate];
            myCarTimerAtDoubleSpeed = nil;
        
        }if ([myCarTimer isValid]) {
            
            [myCarTimer invalidate];
            myCarTimer = nil;
            
        }
        
        myCarTimer = [NSTimer scheduledTimerWithTimeInterval:.1 target:self selector:@selector(myCarMoveWithNormalSpeed) userInfo:nil repeats:YES];
    }
    else
    {
        if ([balloonMoveTimer isValid]) {
            [balloonMoveTimer invalidate];
            balloonMoveTimer = nil;
        } else if ([clockTimer isValid]) {
            [clockTimer invalidate];
            clockTimer = nil;
        } else if ([carTimer1 isValid]) {
            [carTimer1 invalidate];
            carTimer1 = nil;
        } else if ([carTimer2 isValid]) {
            [carTimer2 invalidate];
            carTimer2 = nil;
        } else if ([carTimer3 isValid]) {
            [carTimer3 invalidate];
            carTimer3 = nil;
        } else if ([myCarTimer isValid]) {
            [myCarTimer invalidate];
            myCarTimer = nil;
        } else if ([myCarTimerAtDoubleSpeed isValid]) {
            [myCarTimerAtDoubleSpeed invalidate];
            myCarTimerAtDoubleSpeed = nil;
        }
        [balloonBtn1 removeFromSuperview];
        [balloonBtn2 removeFromSuperview];
        [balloonBtn3 removeFromSuperview];
        [balloonBtn4 removeFromSuperview];
        [questionLabel removeFromSuperview];
        
        UILabel *rankingLabelOfYourCar = [[UILabel alloc]initWithFrame:CGRectMake(250, 650, 400, 100)];
        rankingLabelOfYourCar.backgroundColor = [UIColor clearColor];
        rankingLabelOfYourCar.font = [UIFont fontWithName:@"BradleyHandITCTT-Bold" size:40];
        [self.view addSubview:rankingLabelOfYourCar];
        
        if (firstCar==1) {
            if (secondCar==2) {
                myCar = 3;
                rankingLabelOfYourCar.text = @"You came third";
            } else {
                myCar = 2;
                rankingLabelOfYourCar.text = @"You came second";
            }
            
        } else {
            myCar = 1;
            rankingLabelOfYourCar.text = @"You came first";
        }
        
    }
    
}


- (void)generateQuestion {
    
    //if ([[plistDict objectForKey:@"level"] isEqualToString:@"EASY"]) {
        rightAnsPart1 = [self getRandomNumber:2 to:9];
        rightAnsPart2 = [self getRandomNumber:3 to:9];
        question = rightAnsPart1 * rightAnsPart2;
        
        fakeAns1Part1 = rightAnsPart2 - 1;
        fakeAns1Part2 = rightAnsPart2 + 1;
        fakeArray1 = [[NSArray alloc]initWithObjects:[NSNumber numberWithInteger:fakeAns1Part1],[NSNumber numberWithInteger:fakeAns1Part2], nil];
        
        fakeAns2Part1 = rightAnsPart1;
        if (rightAnsPart2==3) {
            fakeAns2Part2 = rightAnsPart2 - 1;
        } else {
            fakeAns2Part2 = rightAnsPart2 - 2;
        }
        
        fakeArray2 = [[NSArray alloc]initWithObjects:[NSNumber numberWithInteger:fakeAns2Part1],[NSNumber numberWithInteger:fakeAns2Part2], nil];
        
        fakeAns3Part1 = rightAnsPart1 + 10;
        fakeAns3Part2 = rightAnsPart2;
        fakeArray3 = [[NSArray alloc]initWithObjects:[NSNumber numberWithInteger:fakeAns3Part1],[NSNumber numberWithInteger:fakeAns3Part2], nil];
        
    
        
        [self showQuestionAndAnswer];
 //   }
}


-(void) showQuestionAndAnswer {
    
    questionLabel.text = [NSString stringWithFormat:@"%ld",(long)question];
    // RANDOMLY SELECT BALLO0N BTN FROM BALLOON ARRAY AND PASTE RIGHT ANS TO IT
    int i = arc4random() % [balloonArray count];
    UIButton *randomBalloon1 = (UIButton *)[balloonArray objectAtIndex:i];
    randomBalloon1.tag = rightAnsPart1*rightAnsPart2;
    UILabel *balonLbl1 = [[UILabel alloc]initWithFrame:CGRectMake(40, 20, 70, 35)];
    balonLbl1.text = [NSString stringWithFormat:@"%ld X %ld",(long)rightAnsPart1,(long)rightAnsPart2];
    balonLbl1.textColor = [UIColor blackColor];
    balonLbl1.textAlignment = NSTextAlignmentCenter;
    balonLbl1.font = [UIFont systemFontOfSize:18.0];
    balonLbl1.backgroundColor = [UIColor clearColor];
    [randomBalloon1 addSubview:balonLbl1];
    [self.view addSubview:randomBalloon1];
    
    // RANDOMLY SELECT BALLO0N BTN FROM BALLOON ARRAY AND PASTE FAKE ANS 1 TO IT
    int j = arc4random() % [balloonArray count];
    while (i==j) {
        j = arc4random() % [balloonArray count];
    }
    int f1,f2; // randomly selected fake array object 
    f1 = arc4random() % [fakeArray1 count];
    if (f1==0) {
        f2 = 1;
    } else {
        f2 = 0;
    }
    UIButton *randomBalloon2 = (UIButton *)[balloonArray objectAtIndex:j];
    randomBalloon2.tag = fakeAns1Part1*fakeAns1Part2;
    UILabel *balonLbl2 = [[UILabel alloc]initWithFrame:CGRectMake(40, 20, 70, 35)];
    balonLbl2.text = [NSString stringWithFormat:@"%@ X %@",[fakeArray1 objectAtIndex:f1],[fakeArray1 objectAtIndex:f2]];
    balonLbl2.textColor = [UIColor blackColor];
    balonLbl2.textAlignment = NSTextAlignmentCenter;
    balonLbl2.font = [UIFont systemFontOfSize:18.0];
    balonLbl2.backgroundColor = [UIColor clearColor];
    [randomBalloon2 addSubview:balonLbl2];
    [self.view addSubview:randomBalloon2];
    
    // RANDOMLY SELECT BALLO0N BTN FROM BALLOON ARRAY AND PASTE FAKE ANS 2 TO IT
    int k = arc4random() % [balloonArray count];
    while (i==k ||j==k ) {
        k = arc4random() % [balloonArray count];
    }
    int f3,f4; // randomly selected fake array object 
    f3 = arc4random() % [fakeArray1 count];
    if (f3==0) {
        f4 = 1;
    } else {
        f4 = 0;
    }
    UIButton *randomBalloon3 = (UIButton *)[balloonArray objectAtIndex:k];
    randomBalloon3.tag = fakeAns2Part1*fakeAns2Part2;
    UILabel *balonLbl3 = [[UILabel alloc]initWithFrame:CGRectMake(40, 20, 70, 35)];
    balonLbl3.text = [NSString stringWithFormat:@"%@ X %@",[fakeArray2 objectAtIndex:f3],[fakeArray2 objectAtIndex:f4]];
    balonLbl3.textColor = [UIColor blackColor];
    balonLbl3.textAlignment = NSTextAlignmentCenter;
    balonLbl3.font = [UIFont systemFontOfSize:18.0];
    balonLbl3.backgroundColor = [UIColor clearColor];
    [randomBalloon3 addSubview:balonLbl3];
    [self.view addSubview:randomBalloon3];
    
    // RANDOMLY SELECT BALLO0N BTN FROM BALLOON ARRAY AND PASTE FAKE ANS 3 TO IT
    int l = arc4random() % [balloonArray count];
    while (i==l || j==l || k==l) {
        l = arc4random() % [balloonArray count];
    }
    int f5,f6; // randomly selected fake array object 
    f5 = arc4random() % [fakeArray1 count];
    if (f5==0) {
        f6 = 1;
    } else {
        f6 = 0;
    }
    UIButton *randomBalloon4 = (UIButton *)[balloonArray objectAtIndex:l];
    randomBalloon4.tag = fakeAns3Part1*fakeAns3Part2;
    UILabel *balonLbl4 = [[UILabel alloc]initWithFrame:CGRectMake(40, 20, 70, 35)];
    balonLbl4.text = [NSString stringWithFormat:@"%@ X %@",[fakeArray3 objectAtIndex:f5],[fakeArray3 objectAtIndex:f6]];
    balonLbl4.textColor = [UIColor blackColor];
    balonLbl4.textAlignment = NSTextAlignmentCenter;
    balonLbl4.font = [UIFont systemFontOfSize:18.0];
    balonLbl4.backgroundColor = [UIColor clearColor];
    [randomBalloon4 addSubview:balonLbl4];
    [self.view addSubview:randomBalloon4];
    

    if ([[plistDict objectForKey:@"level"] isEqualToString:@"EASY"]) {
        if (myCar !=1 ||myCar !=2||myCar !=3||myCar !=4) {
            balloonMoveTimer = [NSTimer scheduledTimerWithTimeInterval:0.04 target:self selector:@selector(moveBalloonUpwards) userInfo:nil repeats:YES];
        } else {
            if ([balloonMoveTimer isValid]) {
                [balloonMoveTimer invalidate];
                balloonMoveTimer = nil;
            }
        }
    }
    else if ([[plistDict objectForKey:@"level"] isEqualToString:@"MEDIUM"])
    {
        if (myCar !=1 ||myCar !=2||myCar !=3||myCar !=4) {
            balloonMoveTimer = [NSTimer scheduledTimerWithTimeInterval:0.028 target:self selector:@selector(moveBalloonUpwards) userInfo:nil repeats:YES];
        } else {
            if ([balloonMoveTimer isValid]) {
                [balloonMoveTimer invalidate];
                balloonMoveTimer = nil;
            }
        }
    }
    else
    {
        if (myCar !=1 ||myCar !=2||myCar !=3||myCar !=4) {
            balloonMoveTimer = [NSTimer scheduledTimerWithTimeInterval:0.022 target:self selector:@selector(moveBalloonUpwards) userInfo:nil repeats:YES];
        } else {
            if ([balloonMoveTimer isValid]) {
                [balloonMoveTimer invalidate];
                balloonMoveTimer = nil;
            }
        }
    }
}


- (void)moveBalloonUpwards {
    
    balloonBtn1.frame = CGRectMake(balloonBtn1.frame.origin.x, balloonBtn1.frame.origin.y-2, balloonBtn1.frame.size.width, balloonBtn1.frame.size.height);
    balloonBtn2.frame = CGRectMake(balloonBtn2.frame.origin.x, balloonBtn2.frame.origin.y-2, balloonBtn2.frame.size.width, balloonBtn2.frame.size.height);
    balloonBtn3.frame = CGRectMake(balloonBtn3.frame.origin.x, balloonBtn3.frame.origin.y-2, balloonBtn3.frame.size.width, balloonBtn3.frame.size.height);
    balloonBtn4.frame = CGRectMake(balloonBtn4.frame.origin.x, balloonBtn4.frame.origin.y-2, balloonBtn4.frame.size.width, balloonBtn4.frame.size.height);
    
    if (balloonBtn1.frame.origin.y <=560) {
        [balloonMoveTimer invalidate];
        balloonMoveTimer = nil;
        
        // remove all the objects
       if (myCar !=1 ||myCar !=2||myCar !=3||myCar !=4) { 
        [balloonBtn1 removeFromSuperview];
        [balloonBtn2 removeFromSuperview];
        [balloonBtn3 removeFromSuperview];
        [balloonBtn4 removeFromSuperview];
       }
        // click go button again
        [self goButtonClicked:nil];
    }
}


-(void)balloonClicked:(UIButton *)sender {
    
    self.view.userInteractionEnabled = NO;
    if (sender.tag == [questionLabel.text integerValue]) {
        NSLog(@"Correct Answer");
        correctAns++;
        correctAnsLabel.text = [NSString stringWithFormat:@"%d",correctAns];
        if ([myCarTimer isValid]) {
            [myCarTimer invalidate];
            myCarTimer = nil;
        }
        if ([myCarTimerAtDoubleSpeed isValid]) {
            [myCarTimerAtDoubleSpeed invalidate];
            myCarTimerAtDoubleSpeed = nil;
        }
        // so increase the speed of car
        myCarTimerAtDoubleSpeed = [NSTimer scheduledTimerWithTimeInterval:0.1 target:self selector:@selector(myCarMoveWithDoubleSpeed) userInfo:nil repeats:YES];
        [self performSelector:@selector(myCarMoveWithNormalSpeedAgain) withObject:nil afterDelay:1];
        
    } else {
        
        wrongAns++;
        inCorrectAnsLabel.text = [NSString stringWithFormat:@"%d",wrongAns];
        
    }
    // change the question
    
    // remove all the objects
    [balloonMoveTimer invalidate];
    balloonMoveTimer = nil;
    
    [balloonBtn1 removeFromSuperview];
    [balloonBtn2 removeFromSuperview];
    [balloonBtn3 removeFromSuperview];
    [balloonBtn4 removeFromSuperview];
    [self goButtonClicked:nil];
}


- (void)moveArrow {
    
    [UIView animateWithDuration:0.5
                     animations:^
     {
         //move right
         yourCarArrow.center = CGPointMake(yourCarArrow.center.x - 5, yourCarArrow.center.y);
     }
                     completion:^(BOOL completed)
     {
         if (completed)
         {
             //completed move right..now move left
             [UIView animateWithDuration:0.5
                              animations:^
              {
                  yourCarArrow.center = CGPointMake(yourCarArrow.center.x + 5, yourCarArrow.center.y);
              }];
             [self moveArrow];
         }
     }];
}


- (void)clockTimer {
    
    if (!isTimerPaused) {
        ss++;
        if (ss>59) {
            ss=0;
            mm++;
            if (mm>59)
            {
                ss=0;
                mm=0;
                hh++;
            }
        }
        clockLabel.text = [NSString stringWithFormat:@"%i : %i : %i",hh,mm,ss];
    }
}


- (int)getRandomNumber:(int)from to:(int)to
{
    
    return (int)from + arc4random() % (to-from+1);
}

-(void)pauseTheGame
{
    isTimerPaused=YES;
    
    if ([carTimer1 isValid]) {
        [carTimer1 invalidate];
    }
    if ([carTimer2 isValid]) {
        [carTimer2 invalidate];
    }
    if ([carTimer3 isValid]) {
        [carTimer3 invalidate];
    }
    if ([carTimer1 isValid]) {
        [carTimer1 invalidate];
    }
    
    if ([myCarTimer isValid]) {
        [myCarTimer invalidate];
    }

    if ([balloonMoveTimer isValid]) {
        [balloonMoveTimer invalidate];
        balloonMoveTimer = nil;
    }
   
}

-(void)resumeTheGame
{
    isTimerPaused=NO;
    
    if (run_onlyone_time) {
        carTimer1 = [NSTimer scheduledTimerWithTimeInterval:.1 target:self selector:@selector(firstAutoCar) userInfo:nil repeats:YES];
        carTimer2 = [NSTimer scheduledTimerWithTimeInterval:.1 target:self selector:@selector(secondAutoCar) userInfo:nil repeats:YES];
        carTimer3 = [NSTimer scheduledTimerWithTimeInterval:.1 target:self selector:@selector(thirdAutoCar) userInfo:nil repeats:YES];
        myCarTimer = [NSTimer scheduledTimerWithTimeInterval:.1 target:self selector:@selector(myCarMoveWithNormalSpeed) userInfo:nil repeats:YES];
        
        if ([[plistDict objectForKey:@"level"] isEqualToString:@"EASY"]) {
            if (myCar !=1 ||myCar !=2||myCar !=3||myCar !=4) {
                balloonMoveTimer = [NSTimer scheduledTimerWithTimeInterval:0.04 target:self selector:@selector(moveBalloonUpwards) userInfo:nil repeats:YES];
            } else {
                if ([balloonMoveTimer isValid]) {
                    [balloonMoveTimer invalidate];
                    balloonMoveTimer = nil;
                }
            }
        }
        else if ([[plistDict objectForKey:@"level"] isEqualToString:@"MEDIUM"])
        {
            if (myCar !=1 ||myCar !=2||myCar !=3||myCar !=4) {
                balloonMoveTimer = [NSTimer scheduledTimerWithTimeInterval:0.028 target:self selector:@selector(moveBalloonUpwards) userInfo:nil repeats:YES];
            } else {
                if ([balloonMoveTimer isValid]) {
                    [balloonMoveTimer invalidate];
                    balloonMoveTimer = nil;
                }
            }
        }
        else
        {
            if (myCar !=1 ||myCar !=2||myCar !=3||myCar !=4) {
                balloonMoveTimer = [NSTimer scheduledTimerWithTimeInterval:0.022 target:self selector:@selector(moveBalloonUpwards) userInfo:nil repeats:YES];
            } else {
                if ([balloonMoveTimer isValid]) {
                    [balloonMoveTimer invalidate];
                    balloonMoveTimer = nil;
                }
            }
        }

    }

    
    
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

// TO DO :
// PRINT MSG ABT THE RANK OF MY CAR

@end
