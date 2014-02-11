//
//  AdvanceMathViewController.m
//  KidsLearning
//
//  Created by QA Infotech on 10/10/12.
//  Copyright (c) 2012 ithelpdesk@qainfotech.net. All rights reserved.
//

#import "AdvanceMathViewController.h"


@implementation AdvanceMathViewController
@synthesize modeValue;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        
    }
    return self;
}

- (void)viewWillDisappear:(BOOL)animated
{
    if (t ==2)
    {
        
        [carTimer1 invalidate];
        [carTimer2 invalidate];
        [carTimer3 invalidate];
        [carTimer4 invalidate];
        [countDownTimer invalidate];
        [audioPlayer stop];
        
    }
    else if (u == 2)
    {
        [carTimer1 invalidate];
        [carTimer2 invalidate];
        [carTimer3 invalidate];
        [carTimer4 invalidate];
        [audioPlayer stop];
    }
    else if(v ==2)
    {
        [audioPlayerClap stop];
    }
    [self.navigationController popViewControllerAnimated:NO];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	
    z=0;
    c2=5; c4=5;
    t=2;
 
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
    levelName = [[dic objectForKey:@"level"]copy];
    
    self.view.backgroundColor = [UIColor colorWithRed:102/255.0 green:193/255.0 blue:30/255.0 alpha:1];
    viewForBackgroundImage = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 768, 200)];
    
    backgroundImage = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"cartoon-forest.jpg"]];
    backgroundImage.frame = CGRectMake(0, 0, 768, 200);
    [viewForBackgroundImage addSubview:backgroundImage];
    
    [self.view addSubview:viewForBackgroundImage];
    
    
    trackView1 = [[UIView alloc]initWithFrame:CGRectMake(0, 201, 768, 100)];    //width = 748
    trackView1.layer.borderColor = [[UIColor whiteColor]CGColor];
    trackView1.backgroundColor = [UIColor lightGrayColor];
    [self.view addSubview:trackView1];
    
    trackView2 = [[UIView alloc]initWithFrame:CGRectMake(-5, 301, 773, 100)];   //width = 753
    trackView2.layer.borderWidth = 2.0;
    trackView2.layer.borderColor = [[UIColor whiteColor]CGColor];
    trackView2.backgroundColor = [UIColor grayColor];
    [self.view addSubview:trackView2];
    
    trackView3 = [[UIView alloc]initWithFrame:CGRectMake(0, 400, 768, 100)];    //width = 748
    trackView3.layer.borderColor = [[UIColor whiteColor]CGColor];
    trackView3.backgroundColor = [UIColor lightGrayColor];
    [self.view addSubview:trackView3];
    
    trackView4 = [[UIView alloc]initWithFrame:CGRectMake(-5, 500, 773, 100)];   //width = 753
    trackView4.layer.borderWidth = 2.0;
    trackView4.layer.borderColor = [[UIColor whiteColor]CGColor];
    trackView4.backgroundColor = [UIColor grayColor];
    [self.view addSubview:trackView4];
    
    finishLineView = [[UIView alloc]initWithFrame:CGRectMake(748, 201, 20, 400)];
    finishLineView.backgroundColor = [UIColor clearColor];
    [self.view addSubview:finishLineView];
    
    finishLine1 = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"finishline.png"]];
    finishLine1.frame = CGRectMake(0, 10, 18, 80);
    [finishLineView addSubview:finishLine1];
    
    finishLine2 = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"finishline.png"]];
    finishLine2.frame = CGRectMake(0, 110, 18, 80);
    [finishLineView addSubview:finishLine2];
    
    finishLine3 = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"finishline.png"]];
    finishLine3.frame = CGRectMake(0, 210, 18, 80);
    [finishLineView addSubview:finishLine3];
    
    finishLine4 = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"finishline.png"]];
    finishLine4.frame = CGRectMake(0, 300, 18, 80);
    [finishLineView addSubview:finishLine4];

    
    carImage1 = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"car1.png"]];
    carImage1.frame = CGRectMake(0, 10, 90, 90);
    [trackView1 addSubview:carImage1];
 
    
    carImage2 = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"car.png"]];
    carImage2.frame = CGRectMake(5, 10, 90, 90);
    [trackView2 addSubview:carImage2];

    
    carImage3 = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"car1.png"]];
    carImage3.frame = CGRectMake(0, 10, 90, 90);
    [trackView3 addSubview:carImage3];
 
    
    carImage4 = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"car1.png"]];
    carImage4.frame = CGRectMake(5, 10, 90, 90);
    [trackView4 addSubview:carImage4];

    
    playButton = [UIButton buttonWithType:UIButtonTypeCustom];
    playButton.frame = CGRectMake(315, 372, 150, 50);
    [playButton setImage:[UIImage imageNamed:@"begin_race"] forState:UIControlStateNormal];
    [playButton addTarget:self action:@selector(goButtonClicked) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:playButton];
    
    
    
    mulQuestion = [[UILabel alloc]initWithFrame:CGRectMake(250, 650,150, 50)];
    //mulQuestion.text = [NSString stringWithFormat:@"%i",questionValue];
    mulQuestion.textAlignment = NSTextAlignmentCenter;
    mulQuestion.font = [UIFont boldSystemFontOfSize:26.0];
    mulQuestion.textColor = [UIColor redColor];
    mulQuestion.backgroundColor = [UIColor yellowColor];
    [mulQuestion setHidden:YES];
    mulQuestion.layer.cornerRadius = 7.0;
    [self.view addSubview:mulQuestion];

    
    option1 = [UIButton buttonWithType:UIButtonTypeCustom];
    [option1 setFrame:CGRectMake(80, 730, 200, 50)];
    option1.layer.cornerRadius = 15.0;
    //option1.layer.borderWidth = 2.0;
    [option1 setHidden:YES];
    [option1 setBackgroundColor:[UIColor clearColor]];
    //[option1 setTitle:[NSString stringWithFormat:@"%i x %i",a1 , a2] forState:UIControlStateNormal];
    [option1 addTarget:self action:@selector(optionButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
    
    buttonImage1 = [[UIImageView alloc]initWithFrame:CGRectMake(15, 3, 65, 40)];
   // buttonImage1.image=[UIImage imageNamed:@"white_square.png"];
    buttonImage1.layer.borderWidth = 1.0;
    [option1 addSubview:buttonImage1];

    
    buttonLabel1 = [[UILabel alloc]initWithFrame:CGRectMake(70, 3, 120, 44)];
    //buttonLabel1.text = [NSString stringWithFormat:@"%i x %i",a1 , a2];
    buttonLabel1.backgroundColor = [UIColor clearColor];
    buttonLabel1.textAlignment = NSTextAlignmentCenter;
    buttonLabel1.font = [UIFont boldSystemFontOfSize:25.0];
    [option1 addSubview:buttonLabel1];

    
    [self.view addSubview:option1];
    
    // Start of second button
    option2 = [UIButton buttonWithType:UIButtonTypeCustom];
    [option2 setFrame:CGRectMake(450, 730, 200, 50)];
    option2.layer.cornerRadius = 15.0;
    //option2.layer.borderWidth = 2.0;
    [option2 setHidden:YES];
    [option2 setBackgroundColor:[UIColor clearColor]];
    //[option2 setTitle:[NSString stringWithFormat:@"%i x %i",a1 , a2] forState:UIControlStateNormal];
    [option2 addTarget:self action:@selector(optionButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
    
    buttonImage2 = [[UIImageView alloc]initWithFrame:CGRectMake(15, 3, 65, 40)];
    //buttonImage2.image = [UIImage imageNamed:@"white_square.png"];
    buttonImage2.layer.borderWidth = 1.0;
    [option2 addSubview:buttonImage2];

    
    buttonLabel2 = [[UILabel alloc]initWithFrame:CGRectMake(70, 3, 120, 44)];
    //buttonLabel2.text = [NSString stringWithFormat:@"%i x %i",a1 , a2];
    buttonLabel2.backgroundColor = [UIColor clearColor];
    buttonLabel2.textAlignment = NSTextAlignmentCenter;
    buttonLabel2.font = [UIFont boldSystemFontOfSize:25.0];
    [option2 addSubview:buttonLabel2];

    
    [self.view addSubview:option2];
    // end of second button
    
    option3 = [UIButton buttonWithType:UIButtonTypeCustom];
    [option3 setFrame:CGRectMake(80, 830, 200, 50)];
    option3.layer.cornerRadius = 15.0;
    [option3 setHidden:YES];
    [option3 setBackgroundColor:[UIColor clearColor]];
    [option3 addTarget:self action:@selector(optionButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
    
    buttonImage3 = [[UIImageView alloc]initWithFrame:CGRectMake(15, 3, 65, 40) ];
   // buttonImage3.image=[UIImage imageNamed:@"white_square.png"];
    buttonImage3.layer.borderWidth = 1.0;
    [option3 addSubview:buttonImage3];

    
    buttonLabel3 = [[UILabel alloc]initWithFrame:CGRectMake(70, 3, 120, 44)];
    //buttonLabel3.text = [NSString stringWithFormat:@"%i x %i",a1 , a2];
    buttonLabel3.backgroundColor = [UIColor clearColor];
    buttonLabel3.textAlignment = NSTextAlignmentCenter;
    buttonLabel3.font = [UIFont boldSystemFontOfSize:25.0];
    [option3 addSubview:buttonLabel3];

    
    [self.view addSubview:option3];
    
    option4 = [UIButton buttonWithType:UIButtonTypeCustom];
    [option4 setFrame:CGRectMake(450, 830, 200, 50)];
    option4.layer.cornerRadius = 15.0;
    [option4 setHidden:YES];
    [option4 setBackgroundColor:[UIColor clearColor]];
    [option4 addTarget:self action:@selector(optionButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
    
    buttonImage4 = [[UIImageView alloc]initWithFrame:CGRectMake(15, 3, 65, 40) ];
   // buttonImage4.image=[UIImage imageNamed:@"white_square.png"];
    buttonImage4.layer.borderWidth = 1.0;
    [option4 addSubview:buttonImage4];

    
    buttonLabel4 = [[UILabel alloc]initWithFrame:CGRectMake(70, 3, 120, 44)];
    //buttonLabel4.text = [NSString stringWithFormat:@"%i x %i",a1 , a2];
    buttonLabel4.backgroundColor = [UIColor clearColor];
    buttonLabel4.textAlignment = NSTextAlignmentCenter;
    buttonLabel4.font = [UIFont boldSystemFontOfSize:25.0];
    [option4 addSubview:buttonLabel4];


    [self.view addSubview:option4];
    
    [self randomQuestionAndAnswer];
    questionValue = a1 * a2 ;
    
    mulQuestion.text = [NSString stringWithFormat:@"%i",questionValue];
    
    buttonImage1.image=[UIImage imageNamed:@"white_square.png"];
    buttonImage2.image=[UIImage imageNamed:@"white_square.png"];
    buttonImage3.image=[UIImage imageNamed:@"white_square.png"];
    buttonImage4.image=[UIImage imageNamed:@"white_square.png"];
   
    
}

-(void)randomQuestionAndAnswer
{
    
    if (z==0)
    {
        self.view.userInteractionEnabled = YES;
    }
    else
    {
        NSLog(@"view disabled");
        self.view.userInteractionEnabled = NO;
    }
    
    if (countDownTimerVariable ==1)
  {
    countDownTimer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(countDownFunction) userInfo:nil repeats:YES];
  }
  
    flag1 = 0;
    flag2 = 0;
    flag3 = 0;
    flag4 = 0;
    a1 = arc4random() % 11;
    a2 = arc4random() % 11;
    while (a1 == 0 || a2 == 0)
    {
        a1 = arc4random() %11;
        a2 = arc4random() %11;
    }
    
    b1 = arc4random() % 11;
    b2 = arc4random() % 11;
    while((b1 == 0 || b2 == 0) || ((b1 == a1 && b2 == a2) || (b2 == a1 && b1 == a2)) ||((b1*b2) == (a1*a2)))
    {
        b1 = arc4random() %11;
        b2 = arc4random() %11;
    }
    
    d1 = arc4random() % 11;
    d2 = arc4random() % 11;
    while ((d1 == 0 || d2 == 0) || ((d1 == a1 && d2 == a2) || (d2 == a1 && d1 == a2))||((d1*d2) == (a1*a2)))
    {
        d1 = arc4random() %11;
        d2 = arc4random() %11;
    }
    
    e1 = a1+ 10;
    e2 = arc4random() % 11;
    while ((e1 == 0 || e2 == 0) || ((e1 == a1 && e2 == a2) || (e2 == a1 && e1 == a2))||((e1*e2) == (a1*a2)))
    {
        //e1 = arc4random() %11;
        e2 = arc4random() %11;
    }
    
    
    questionValue = a1 * a2 ;
    
    mulQuestion.text = [NSString stringWithFormat:@"%i",questionValue];
    
    buttonImage1.image=[UIImage imageNamed:@"white_square.png"];
    buttonImage2.image=[UIImage imageNamed:@"white_square.png"];
    buttonImage3.image=[UIImage imageNamed:@"white_square.png"];
    buttonImage4.image=[UIImage imageNamed:@"white_square.png"];
    buttonImage1.layer.borderWidth = 1.0;
    buttonImage2.layer.borderWidth = 1.0;
    buttonImage3.layer.borderWidth = 1.0;
    buttonImage4.layer.borderWidth = 1.0;

    optionNumberLabelArray = [NSArray arrayWithObjects:buttonLabel1,buttonLabel2,buttonLabel3,buttonLabel4, nil];
    randomNumberOne = arc4random()%4;
    randomLabel = [optionNumberLabelArray objectAtIndex:randomNumberOne];
    if ([randomLabel isEqual:buttonLabel1]) {
        flag1 = 1;
        
        buttonLabel1.text = [NSString stringWithFormat:@"%i x %i",a1 , a2];
        
        buttonLabel2.text = [NSString stringWithFormat:@"%i x %i",b1 , b2];
        
        buttonLabel3.text = [NSString stringWithFormat:@"%i x %i",d1 , d2];
        
        buttonLabel4.text = [NSString stringWithFormat:@"%i x %i",e1 , e2];
    }
    else if([randomLabel isEqual:buttonLabel2])
    {
        flag2 = 2;
        
        buttonLabel2.text = [NSString stringWithFormat:@"%i x %i",a1 , a2];
        
        buttonLabel1.text = [NSString stringWithFormat:@"%i x %i",b1 , b2];
        
        buttonLabel3.text = [NSString stringWithFormat:@"%i x %i",d1 , d2];
        
        buttonLabel4.text = [NSString stringWithFormat:@"%i x %i",e1 , e2];
        
    }
    else if ([randomLabel isEqual:buttonLabel3])
    {
        flag3 = 3;
        
        buttonLabel3.text = [NSString stringWithFormat:@"%i x %i",a1 , a2];
        
        buttonLabel2.text = [NSString stringWithFormat:@"%i x %i",b1 , b2];
        
        buttonLabel1.text = [NSString stringWithFormat:@"%i x %i",d1 , d2];
        
        buttonLabel4.text = [NSString stringWithFormat:@"%i x %i",e1 , e2];
    }
    else
    {
        
        flag4 = 4;
        
        buttonLabel4.text = [NSString stringWithFormat:@"%i x %i",a1 , a2];
        
        buttonLabel2.text = [NSString stringWithFormat:@"%i x %i",b1 , b2];
        
        buttonLabel1.text = [NSString stringWithFormat:@"%i x %i",d1 , d2];
        
        buttonLabel3.text = [NSString stringWithFormat:@"%i x %i",e1 , e2];
    }
}

-(void)optionButtonClicked:(id)sender
{
    [countDownTimer invalidate];//to get the value of k
    if ([carTimer2 isValid])
    {
        [carTimer2 invalidate];// to change the value of car2
    }
    t=1; u = 2;
    
    if (sender == option1)
    {
        
        if(flag1 == 1)
        {
            if (k <=3)
            {
              
                carTimer2 = [NSTimer scheduledTimerWithTimeInterval:.002 target: self selector:@selector(moveCarImage:) userInfo: nil repeats:YES];
                self.view.userInteractionEnabled = NO;
                [self performSelector:@selector(delayLoad) withObject:nil afterDelay:.5];
  
            }
            
            else if (4<=k<=6 )
            {
                
                carTimer2 = [NSTimer scheduledTimerWithTimeInterval:.006 target: self selector:@selector(moveCarImage:) userInfo: nil repeats:YES];
                self.view.userInteractionEnabled = NO;
                [self performSelector:@selector(delayLoad) withObject:nil afterDelay:.5];

            }
            else if (7<=k<=10 )
            {
              
                carTimer2 = [NSTimer scheduledTimerWithTimeInterval:.01 target: self selector:@selector(moveCarImage:) userInfo: nil repeats:YES];
                self.view.userInteractionEnabled = NO;
                [self performSelector:@selector(delayLoad) withObject:nil afterDelay:.5];
            
            }
            else if (k>10)
            {
                
                carTimer2 = [NSTimer scheduledTimerWithTimeInterval:.05 target: self selector:@selector(moveCarImage:) userInfo: nil repeats:YES];
                self.view.userInteractionEnabled = NO;
                [self performSelector:@selector(delayLoad) withObject:nil afterDelay:.5];
             
            }
            
            
            NSLog(@"Right Answer1");
            buttonImage1.image=[UIImage imageNamed:@"rightans.png"];
            buttonImage1.layer.borderWidth = 0;
            if(carImage2.frame.origin.x <=675)
            {
             [self performSelector:@selector(randomQuestionAndAnswer) withObject:nil afterDelay:.5];
            }
           
            
        }
        else
        {
            carTimer2 = [NSTimer scheduledTimerWithTimeInterval:.02 target: self selector:@selector(moveCarImage:) userInfo: nil repeats:YES];
            
            buttonImage1.image=[UIImage imageNamed:@"wrongans.png"];
            buttonImage1.layer.borderWidth = 0;
            
            self.view.userInteractionEnabled = NO;
            [self performSelector:@selector(randomQuestionAndAnswer) withObject:nil afterDelay:.5];
            
        }
    }
    else if (sender == option2)
    {
        if(flag2 == 2)
        {

            if (k <=3)
            {
                
                    carTimer2 = [NSTimer scheduledTimerWithTimeInterval:.002 target: self selector:@selector(moveCarImage:) userInfo: nil repeats:YES];
                self.view.userInteractionEnabled = NO;
                    [self performSelector:@selector(delayLoad) withObject:nil afterDelay:.5];
                
            }
            
            else if (4<=k<=6 )
            {
                
                    carTimer2 = [NSTimer scheduledTimerWithTimeInterval:.006 target: self selector:@selector(moveCarImage:) userInfo: nil repeats:YES];
                    self.view.userInteractionEnabled = NO;
                [self performSelector:@selector(delayLoad) withObject:nil afterDelay:.5];
            }
            else if (7<=k<=10 )
            {
                
                    carTimer2 = [NSTimer scheduledTimerWithTimeInterval:.01 target: self selector:@selector(moveCarImage:) userInfo: nil repeats:YES];
                self.view.userInteractionEnabled = NO;
                [self performSelector:@selector(delayLoad) withObject:nil afterDelay:.5];
                
            }
            else if (k>10)
            {
                
                    carTimer2 = [NSTimer scheduledTimerWithTimeInterval:.05 target: self selector:@selector(moveCarImage:) userInfo: nil repeats:YES];
                self.view.userInteractionEnabled = NO;
                [self performSelector:@selector(delayLoad) withObject:nil afterDelay:.5];
                
            }
            
            NSLog(@"Right Answer2");
            buttonImage2.image=[UIImage imageNamed:@"rightans.png"];
            buttonImage2.layer.borderWidth = 0;
            
            if(carImage2.frame.origin.x <=675)
            {
                [self performSelector:@selector(randomQuestionAndAnswer) withObject:nil afterDelay:.5];
            }
           
        }
        else
        {
            carTimer2 = [NSTimer scheduledTimerWithTimeInterval:.02 target: self selector:@selector(moveCarImage:) userInfo: nil repeats:YES];
            
            buttonImage2.image=[UIImage imageNamed:@"wrongans.png"];
            buttonImage2.layer.borderWidth = 0;
            self.view.userInteractionEnabled = NO;
            [self performSelector:@selector(randomQuestionAndAnswer) withObject:nil afterDelay:.5];
           
        }
        
    }
    else if (sender == option3)
    {
        if(flag3 == 3)
        {
            
            if (k <=3)
            {
                
                    carTimer2 = [NSTimer scheduledTimerWithTimeInterval:.002 target: self selector:@selector(moveCarImage:) userInfo: nil repeats:YES];
                self.view.userInteractionEnabled = NO;
                 [self performSelector:@selector(delayLoad) withObject:nil afterDelay:.5];
                
            }
            
            else if (4<=k<=6 )
            {
                
                    carTimer2 = [NSTimer scheduledTimerWithTimeInterval:.006 target: self selector:@selector(moveCarImage:) userInfo: nil repeats:YES];
                    self.view.userInteractionEnabled = NO;
                [self performSelector:@selector(delayLoad) withObject:nil afterDelay:.5];
            }
            else if (7<=k<=10 )
            {
                
                    carTimer2 = [NSTimer scheduledTimerWithTimeInterval:.01 target: self selector:@selector(moveCarImage:) userInfo: nil repeats:YES];
                    self.view.userInteractionEnabled = NO;
                [self performSelector:@selector(delayLoad) withObject:nil afterDelay:.5];
            }
            else if (k>10)
            {
                
                    carTimer2 = [NSTimer scheduledTimerWithTimeInterval:.05 target: self selector:@selector(moveCarImage:) userInfo: nil repeats:YES];
                self.view.userInteractionEnabled = NO;
                [self performSelector:@selector(delayLoad) withObject:nil afterDelay:.5];
               
            }
            NSLog(@"Right Answer3");
            buttonImage3.image=[UIImage imageNamed:@"rightans.png"];
            buttonImage3.layer.borderWidth = 0;
            
            if(carImage2.frame.origin.x <=675)
            {
                [self performSelector:@selector(randomQuestionAndAnswer) withObject:nil afterDelay:.5];
            }
           
        }
        else
        {
            carTimer2 = [NSTimer scheduledTimerWithTimeInterval:.02 target: self selector:@selector(moveCarImage:) userInfo: nil repeats:YES];
            
            buttonImage3.image=[UIImage imageNamed:@"wrongans.png"];
            buttonImage3.layer.borderWidth = 0;
            self.view.userInteractionEnabled = NO;
            [self performSelector:@selector(randomQuestionAndAnswer) withObject:nil afterDelay:.5];
            
        }
    }
    else
    {
        if(flag4 == 4)
        {
            
            if (k <=3)
            {
                
                    carTimer2 = [NSTimer scheduledTimerWithTimeInterval:.002 target: self selector:@selector(moveCarImage:) userInfo: nil repeats:YES];
                self.view.userInteractionEnabled = NO;
                [self performSelector:@selector(delayLoad) withObject:nil afterDelay:.5];
            }
            
            else if (4<=k<=6 )
            {
                
                    carTimer2 = [NSTimer scheduledTimerWithTimeInterval:.006 target: self selector:@selector(moveCarImage:) userInfo: nil repeats:YES];
                self.view.userInteractionEnabled = NO;
                
               [self performSelector:@selector(delayLoad) withObject:nil afterDelay:.5];
            }
            else if (7<=k<=10 )
            {   
                
                    carTimer2 = [NSTimer scheduledTimerWithTimeInterval:.01 target: self selector:@selector(moveCarImage:) userInfo: nil repeats:YES];
                    self.view.userInteractionEnabled = NO;
                [self performSelector:@selector(delayLoad) withObject:nil afterDelay:.5];
            }
            else if (k>10)
            {
                
                    carTimer2 = [NSTimer scheduledTimerWithTimeInterval:.05 target: self selector:@selector(moveCarImage:) userInfo: nil repeats:YES];
                    self.view.userInteractionEnabled = NO;
                [self performSelector:@selector(delayLoad) withObject:nil afterDelay:.5];
            }
            NSLog(@"Right Answer4");
            buttonImage4.image=[UIImage imageNamed:@"rightans.png"];
            buttonImage4.layer.borderWidth = 0;
            
            if(carImage2.frame.origin.x <=675)
            {
                [self performSelector:@selector(randomQuestionAndAnswer) withObject:nil afterDelay:.5];
            }
            
        }
  
        else
        {
            carTimer2 = [NSTimer scheduledTimerWithTimeInterval:.02 target: self selector:@selector(moveCarImage:) userInfo: nil repeats:YES];
            
            buttonImage4.image=[UIImage imageNamed:@"wrongans.png"];
            buttonImage4.layer.borderWidth = 0;
            self.view.userInteractionEnabled = NO;
            [self performSelector:@selector(randomQuestionAndAnswer) withObject:nil afterDelay:.5];
           
        }
    }
    k = 0;
}

-(void)delayLoad
{
    if (carImage2.frame.origin.x <=695)
    {
        if ([carTimer2 isValid])
        {
            NSLog(@"car 2 stop in delay load");
            [carTimer2 invalidate];
    
        NSLog(@"car 2 start in delay load");
        carTimer2 = [NSTimer scheduledTimerWithTimeInterval:.02 target: self selector:@selector(moveCarImage:) userInfo: nil repeats:YES];
        self.view.userInteractionEnabled = YES;
        }
    }
}


// when go button is pressed
-(void)goButtonClicked
{
    t =2;
    
    //audio player start
    
    NSURL *url = [NSURL fileURLWithPath:[NSString stringWithFormat:@"%@/race.wav", [[NSBundle mainBundle] resourcePath]]];
	
	NSError *error;
	audioPlayer = [[AVAudioPlayer alloc] initWithContentsOfURL:url error:&error];
	audioPlayer.numberOfLoops = -1;
    [audioPlayer play];
    
    //audio player end
    
    countDownTimerVariable = 1;
    
    // to increment the value of k 
    countDownTimer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(countDownFunction) userInfo:nil repeats:YES];
    
    [mulQuestion setHidden:NO];
    [option1 setHidden:NO];
    [option2 setHidden:NO];
    [option3 setHidden:NO];
    [option4 setHidden:NO];
    [playButton removeFromSuperview];
    
    NSMutableDictionary *dic12 = [Util readPListData];
    levelName = [dic12 objectForKey:@"level"];
    if([levelName isEqualToString:@"EASY"])
    {
        carTimer1 = [NSTimer scheduledTimerWithTimeInterval:.02 target: self selector:@selector(moveCarImage:) userInfo: nil repeats:YES];
        
        carTimer2 = [NSTimer scheduledTimerWithTimeInterval:.02 target: self selector:@selector(moveCarImage:) userInfo: nil repeats:YES];
        
        carTimer3 = [NSTimer scheduledTimerWithTimeInterval:.02 target: self selector:@selector(moveCarImage:) userInfo: nil repeats:YES];
        
        carTimer4 = [NSTimer scheduledTimerWithTimeInterval:.02 target: self selector:@selector(moveCarImage:) userInfo: nil repeats:YES];
    }
    
    else if ([levelName isEqualToString:@"MEDIUM"])
    {
        carTimer1 = [NSTimer scheduledTimerWithTimeInterval:.015 target: self selector:@selector(moveCarImage:) userInfo: nil repeats:YES];
        
        carTimer2 = [NSTimer scheduledTimerWithTimeInterval:.02 target: self selector:@selector(moveCarImage:) userInfo: nil repeats:YES];
        
        carTimer3 = [NSTimer scheduledTimerWithTimeInterval:.013 target: self selector:@selector(moveCarImage:) userInfo: nil repeats:YES];
        
        carTimer4 = [NSTimer scheduledTimerWithTimeInterval:.02 target: self selector:@selector(moveCarImage:) userInfo: nil repeats:YES];
    }
    
    else if ([levelName isEqualToString:@"HARD"])
    {
        carTimer1 = [NSTimer scheduledTimerWithTimeInterval:.012 target: self selector:@selector(moveCarImage:) userInfo: nil repeats:YES];
        
        carTimer2 = [NSTimer scheduledTimerWithTimeInterval:.02 target: self selector:@selector(moveCarImage:) userInfo: nil repeats:YES];
        
        carTimer3 = [NSTimer scheduledTimerWithTimeInterval:.012 target: self selector:@selector(moveCarImage:) userInfo: nil repeats:YES];
        
        carTimer4 = [NSTimer scheduledTimerWithTimeInterval:.019 target: self selector:@selector(moveCarImage:) userInfo: nil repeats:YES];
    }
       
    

}

-(void)countDownFunction
{
    k++;  // time that users takes to give answer 
}


-(void) moveCarImage:(id)sender
{
  
    if(sender == carTimer1)
  {
      
      carImage1.frame = CGRectMake(c1, 10, 90, 90);
      c1 = c1 +.25;
      
      if (carImage1.frame.origin.x >=675)
      {
          if(z ==0)
        {
            if (self.view.userInteractionEnabled == YES)
            {
                self.view.userInteractionEnabled = NO;
            }
            z++;
        }
      }
      
      if (carImage1.frame.origin.x >=693)
      {
          if (self.view.userInteractionEnabled ==YES)
          {
              self.view.userInteractionEnabled = NO;
              NSLog(@"view.userInteractionDisabled");
          }
          
          if(z==1)
        {
            
           t=1;
           NSLog(@"car1 %f",carImage1.frame.origin.x);
            if ([carTimer2 isValid])
            {
                [carTimer2 invalidate];
            }
            if ([carTimer1 isValid])
            {
                [carTimer1 invalidate];
                [carTimer3 invalidate];
                [carTimer4 invalidate];
            }
            z++;
        }
          
          int x1 = carImage1.frame.origin.x;
          int x2 = carImage2.frame.origin.x;
          int x3 = carImage3.frame.origin.x;
          
          resultView = [[UIView alloc]initWithFrame:CGRectMake(80, 650, 650, 880)];
          resultView.backgroundColor = [UIColor colorWithRed:102/255.0 green:193/255.0 blue:30/255.0 alpha:1];
          resultViewLabel = [[UILabel alloc]initWithFrame:CGRectMake(40, 40, 500, 100)];
          resultViewLabel.backgroundColor = [UIColor clearColor];
          resultViewLabel.textAlignment = NSTextAlignmentCenter;
          resultViewLabel.font = [UIFont fontWithName:@"Chalkduster" size:28.0];
          u=3;v=3;
          if (x2<=x3)
          {
              resultViewLabel.text = @"You Came Third";
              [audioPlayer stop];
          }
          else if (x1>x2 && x2>x3)
          {
              resultViewLabel.text = @"You Came Second";
               [audioPlayer stop];
          }
          [resultView addSubview:resultViewLabel];
          [self.view addSubview:resultView];
  
      }
      
  }
    else if (sender == carTimer2)
    {
        if (carImage2.frame.origin.x >=670)
        {
           if(z ==0)
           {
               if (self.view.userInteractionEnabled == YES)
               {
                   self.view.userInteractionEnabled = NO;
               }
               NSLog(@"-----------");
               z++;
           }
        }
        carImage2.frame = CGRectMake(c2, 10, 90, 90);
        c2 = c2 + .15;
        
        if (carImage2.frame.origin.x >=695) //695
        {
                if (self.view.userInteractionEnabled ==YES)
                {
                    self.view.userInteractionEnabled = NO;
                    NSLog(@"view.userInteractionDisabled");
                }
                if (z==1)
                {
                    NSLog(@"car2 %f",carImage2.frame.origin.x);
                    t=1;
              
                    if ([carTimer2 isValid])
                    {
                         NSLog(@"car 2 stop");
                        [carTimer2 invalidate];
                        
                    }
                    if ([carTimer1 isValid])
                    {
                        [carTimer1 invalidate];
                        [carTimer3 invalidate];
                        [carTimer4 invalidate];
                    }
                    
                    z++;
                    
                    resultView = [[UIView alloc]initWithFrame:CGRectMake(80, 650, 650, 880)];
                    resultView.backgroundColor = [UIColor colorWithRed:102/255.0 green:193/255.0 blue:30/255.0 alpha:1];
                    
                    
                    resultViewLabel = [[UILabel alloc]initWithFrame:CGRectMake(40, 40, 500, 100)];
                    resultViewLabel.backgroundColor = [UIColor clearColor];
                    resultViewLabel.textAlignment = NSTextAlignmentCenter;
                    resultViewLabel.font = [UIFont fontWithName:@"Chalkduster" size:28.0];
                    resultViewLabel.text = @"You Came First";
                    [resultView addSubview:resultViewLabel];
                    [audioPlayer stop];
                    [self.view addSubview:resultView];
    
                    NSLog(@"You came first");
                    
                    if(self.view.userInteractionEnabled == YES)
                    {
                        NSLog(@"option button disabled");
                        self.view.userInteractionEnabled = NO;
                    }
                    //clap play start
                    
                    v=2;
                    NSURL *url1 = [NSURL fileURLWithPath:[NSString stringWithFormat:@"%@/clap.mp3", [[NSBundle mainBundle] resourcePath]]];
                    
                    NSError *error1;
                    audioPlayerClap = [[AVAudioPlayer alloc] initWithContentsOfURL:url1 error:&error1];
                    audioPlayerClap.numberOfLoops = -1;
                    [audioPlayerClap play];
                    
                    [self performSelector:@selector(clap) withObject:nil afterDelay:7.0];
                    u=3;
                    //clap play end
                }

        }
        
    }
    
   else if (sender == carTimer3)
    {
        if (carImage3.frame.origin.x >=675)
        {
            if(z ==0)
            {
                self.view.userInteractionEnabled = NO;
                
                z++;
            }
        }
        carImage3.frame = CGRectMake(c3, 10, 90, 90);
        c3 = c3 + .2;
        
        if (carImage3.frame.origin.x >=693)
        {
            if(z==1)
          {
            t=1;
              if ([carTimer2 isValid])
              {
                  [carTimer2 invalidate];
              }
              if ([carTimer1 isValid])
              {
                  [carTimer1 invalidate];
                  [carTimer3 invalidate];
                  [carTimer4 invalidate];
              }
              z++;
          }
            
            self.view.userInteractionEnabled = NO;
        }
        
    }
    else if (sender == carTimer4)
    {
        if (carImage4.frame.origin.x >=670)
        {
            self.view.userInteractionEnabled = NO;
        }
        
        carImage4.frame = CGRectMake(c4, 10, 90, 90);
        c4 = c4 + .15;
        
        if (carImage4.frame.origin.x >=685)
        {
            t=1;
            if ([carTimer2 isValid])
            {
                [carTimer2 invalidate];
            }
            if ([carTimer1 isValid])
            {
                [carTimer1 invalidate];
                [carTimer3 invalidate];
                [carTimer4 invalidate];
            }
            
            self.view.userInteractionEnabled = NO;
        }
        
    }
    
}

-(void)clap
{
    [audioPlayerClap stop];
    v=1;
    u=3;
}



- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
