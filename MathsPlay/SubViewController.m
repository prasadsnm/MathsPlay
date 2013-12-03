//
//  SubViewController.m
//  KidsLearningGame
//
//  Created by QA Infotech on 21/08/13.
//  Copyright (c) 2013 QAInfotech. All rights reserved.
//

#import "SubViewController.h"

@interface SubViewController ()

@end

@implementation SubViewController

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
    
    //self.view.backgroundColor= [UIColor colorWithRed:51/255.0 green:51/255.0 blue:51/255.0 alpha:1.0];
    self.view.backgroundColor = [UIColor darkGrayColor];
    
    dic = [Util readPListData];
    levelString = [[dic objectForKey:@"level"]copy];
    
    popupshowvariable = 1;
    stage = 1;
    livesremaining = 2;
    
    avatarImage = [[UIImageView alloc]initWithFrame:CGRectMake(260, 70, 140, 100)];
    
    NSData *imageData = [dic objectForKey:@"avatarImage"];
    avatarImage.image = [UIImage imageWithData:imageData];
    [self.view addSubview:avatarImage];
    
    username = [[UILabel alloc]initWithFrame:CGRectMake(40, 15, 600, 50)];
    username.text = [NSString stringWithFormat:@"HI  %@",[dic objectForKey:@"username"]];
    username.textAlignment = NSTextAlignmentCenter;
    username.textColor = [UIColor colorWithRed:0/255.0 green:171/255.0 blue:189/255.0 alpha:1.0];
    username.font = [UIFont fontWithName:@"BradleyHandITCTT-Bold" size:40];
    username.layer.shadowColor = [username.textColor CGColor];
    username.layer.shadowOffset = CGSizeMake(0.0, 0.0);
    username.layer.shadowRadius = 20.0;
    username.layer.shadowOpacity = 0.5;
    username.layer.masksToBounds = NO;
    username.backgroundColor = [UIColor clearColor];
    [self.view addSubview:username];
    
    level = [[UILabel alloc]initWithFrame:CGRectMake(420, 70, 300, 50)];
    level.text = [NSString stringWithFormat:@"Its %@ level - %d/5",levelString,stage];
    level.textAlignment = NSTextAlignmentCenter;
    level.textColor = [UIColor colorWithRed:255/225.0 green:236/255.0 blue:146/255.0 alpha:1.0];
    level.font = [UIFont fontWithName:@"BradleyHandITCTT-Bold" size:30.0];
    level.layer.shadowColor = [level.textColor CGColor];
    level.layer.shadowOffset = CGSizeMake(0.0, 0.0);
    level.layer.shadowRadius = 20.0;
    level.layer.shadowOpacity = 0.5;
    level.layer.masksToBounds = NO;
    level.backgroundColor = [UIColor clearColor];
    [self.view addSubview:level];
    
    if (![[[Util readPListData]objectForKey:@"level"] isEqualToString:@"HARD"])
    {
        UIButton *nextLevelButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [nextLevelButton setFrame:CGRectMake(460, 170, 150, 45)];
        nextLevelButton.layer.borderWidth = 1.0;
        nextLevelButton.layer.borderColor = [[UIColor colorWithRed:255/225.0 green:236/255.0 blue:146/255.0 alpha:1.0]CGColor];
        [nextLevelButton setTitleColor:[UIColor colorWithRed:255/225.0 green:236/255.0 blue:146/255.0 alpha:1.0] forState:UIControlStateNormal];
        [nextLevelButton addTarget:self action:@selector(nextLevel:) forControlEvents:UIControlEventTouchUpInside];
        [nextLevelButton setTitle:@"Next Level" forState:UIControlStateNormal];
        [self.view addSubview:nextLevelButton];
    }
    
    noOfLives = [[UILabel alloc]initWithFrame:CGRectMake(200, 720, 300, 50)];
    noOfLives.textAlignment = NSTextAlignmentCenter;
    noOfLives.textColor = [UIColor yellowColor];
    noOfLives.font = [UIFont fontWithName:@"AmericanTypewriter" size:20.0f];
    noOfLives.layer.shadowColor = [noOfLives.textColor CGColor];
    noOfLives.layer.shadowOffset = CGSizeMake(0.0, 0.0);
    noOfLives.layer.shadowRadius = 20.0;
    noOfLives.layer.shadowOpacity = 0.5;
    noOfLives.layer.masksToBounds = NO;
    noOfLives.backgroundColor = [UIColor clearColor];
    [self.view addSubview:noOfLives];
    
    orangeImage = [[UIImageView alloc]initWithFrame:CGRectMake(270, 756, 160, 3)];
    orangeImage.image = [UIImage imageNamed:@"OrangeLine.jpg"];
    [self.view addSubview:orangeImage];
    
    hintButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [hintButton setImage:[UIImage imageNamed:@"question-mark.png"] forState:UIControlStateNormal];
    hintButton.frame = CGRectMake(70, 110, 100, 50);
    [hintButton addTarget:self action:@selector(buttonClicked:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:hintButton];
    
    hintPopupImage = [[UIImageView alloc]initWithFrame:CGRectMake(-10, 160, 620, 150)];
    hintPopupImage.image = [UIImage imageNamed:@"blueBox.png"];
    [hintPopupImage setHidden:YES];
    
    livesRemainingImage1 = [[UIImageView alloc]initWithFrame:CGRectMake(290, 770, 40, 40)];
    livesRemainingImage1.image = [UIImage imageNamed:@"lives.png"];
    [self.view addSubview:livesRemainingImage1];
    
    livesRemainingImage2 = [[UIImageView alloc]initWithFrame:CGRectMake(340, 770, 40, 40)];
    livesRemainingImage2.image = [UIImage imageNamed:@"lives.png"];
    [self.view addSubview:livesRemainingImage2];
    
    heartbroken = [[UIImageView alloc]initWithFrame:CGRectMake(310, 220, 50, 50)];
    heartbroken.image = [UIImage imageNamed:@"wrongtick.png"];
    [heartbroken setHidden:YES];
    [self.view addSubview:heartbroken];
    
    stageZoomOut = [[UILabel alloc]initWithFrame:CGRectMake(450, 160, 50, 50)];
    [stageZoomOut setHidden:YES];
    stageZoomOut.backgroundColor = [UIColor clearColor];
    stageZoomOut.font = [UIFont fontWithName:@"DBLCDTempBlack" size:22];
    
    
    UILabel *hintLabel = [[UILabel alloc]initWithFrame:CGRectMake(30, 35, 550, 100)];
    hintLabel.text = @"Find the triplets that sums up to give same value. You will get 2 lives to solve the matrix.";
    hintLabel.backgroundColor = [UIColor clearColor];
    hintLabel.textColor = [UIColor whiteColor];
    hintLabel.textAlignment = NSTextAlignmentCenter;
    hintLabel.font = [UIFont boldSystemFontOfSize:18];
    hintLabel.numberOfLines = 0;
    hintLabel.lineBreakMode = NSLineBreakByWordWrapping;
    hintLabel.layer.shadowColor = [username.textColor CGColor];
    hintLabel.layer.shadowOffset = CGSizeMake(0.0, 0.0);
    hintLabel.layer.shadowRadius = 20.0;
    hintLabel.layer.shadowOpacity = 0.5;
    hintLabel.layer.masksToBounds = NO;
    [hintPopupImage addSubview:hintLabel];
    
    [self.view addSubview:hintPopupImage];
    [self matrixFunction];
    
}

- (void)nextLevel:(UIButton *)sender
{
    NSMutableDictionary *plistDict = [Util readPListData];
    if ([[plistDict objectForKey:@"level"]isEqualToString:@"EASY"])
    {
        [plistDict setObject:@"MEDIUM" forKey:@"level"];
        levelString = @"MEDIUM";
    }
    else if ([[plistDict objectForKey:@"level"]isEqualToString:@"MEDIUM"])
    {
        [plistDict setObject:@"HARD" forKey:@"level"];
        levelString = @"HARD";
        [sender removeFromSuperview];
    }
    [Util writeToPlist:plistDict];
    stage = 0;
    countForNextStage =0;
    buttonclick_count_in_a_row = 0;
    level.text = [NSString stringWithFormat:@"%@ level : %d/5",levelString,stage];
    [easyMatrixView removeFromSuperview];
    [livesRemainingImage1 setHidden:NO];
    [livesRemainingImage2 setHidden:NO];
    livesremaining = 2;
    [self matrixFunction];

    
}

-(void)buttonClicked:(id)sender
{
    
    if (sender == hintButton)
    {
        if (popupshowvariable==1)
        {
            [hintPopupImage setHidden:NO];
            popupshowvariable--;
            [hintButton setTitleColor:[UIColor orangeColor] forState:UIControlStateNormal];
        }
        else if (popupshowvariable==0)
        {
            [hintPopupImage setHidden:YES];
            popupshowvariable++;
            [hintButton setTitleColor:[UIColor greenColor] forState:UIControlStateNormal];
        }
        
    }
    
}

-(void)matrixFunction
{
    noOfLives.text = [NSString stringWithFormat:@"Lives Remaining"];
    if ([levelString isEqualToString:@"HARD"])
    {
        
        easyMatrixView = [[UIView alloc]initWithFrame:CGRectMake(200, 350, 450, 350)];
        easyMatrixView.backgroundColor = [UIColor clearColor];
        [self.view addSubview:easyMatrixView];
        
        int width1=0; //for first row
        int width2=0; //for sec row
        int width3=0; //for thrd row
        int width4=0; //for frth row
        
        // number generation start
        
        int one1 , one2, two1, two2, three1 , three2 ,four1 , four2 , five1 , five2 , six1 , six2 , seven1 , seven2 , eight1 , eight2 , nine1 , nine2 , ten1 , ten2 , eleven1 , eleven2 , twelve1 , twelve2 , result1, result2, result3, result4;
        
        one1 = [self getRandomNumber:101 to:999];
        one2 = [self getRandomNumber:100 to:one1-1];
        result1 = one1 - one2;
        two1 = [self getRandomNumber:result1 to:999];
        while (two1 == one1)
        {
            two1 = [self getRandomNumber:result1 to:999];
        }
        two2 = two1 - result1;
        three1 = [self getRandomNumber:result1 to:999];
        while (three1 == two1 || three1 == one1)
        {
            three1 = [self getRandomNumber:result1 to:999];
        }
        three2 = three1 - result1;
        
        four1 = [self getRandomNumber:101 to:999];
        four2 = [self getRandomNumber:100 to:four1-1];
        result2 = four1 - four2;
        while (result2 == result1)
        {
            four1 = [self getRandomNumber:101 to:999];
            four2 = [self getRandomNumber:100 to:four1-1];
            result2 = four1 - four2;
        }
        
        five1 = [self getRandomNumber:result2 to:999];
        while (five1 == four1)
        {
            five1 = [self getRandomNumber:result2 to:999];
        }
        five2 = five1 - result2;
        six1 = [self getRandomNumber:result2 to:999];
        while (six1 ==four1 || six1 == five1)
        {
            six1 = [self getRandomNumber:result2 to:999];
        }
        six2 = six1 - result2;
        
        seven1 = [self getRandomNumber:101 to:999];
        seven2 = [self getRandomNumber:100 to:seven1-1];
        result3 = seven1 - seven2;
        while (result3 == result2 || result3 == result1)
        {
            seven1 = [self getRandomNumber:101 to:999];
            seven2 = [self getRandomNumber:100 to:seven1-1];
            result3 = seven1 - seven2;
        }
        
        eight1 = [self getRandomNumber:result3 to:999];
        while (eight1 ==  seven1)
        {
            eight1 = [self getRandomNumber:result3 to:999];
        }
        eight2 = eight1 - result3;
        nine1 = [self getRandomNumber:result3 to:999];
        while (nine1 ==eight1|| nine1 == seven1)
        {
            nine1 = [self getRandomNumber:result3 to:999];
        }
        nine2 = nine1 - result3;
        
        ten1 = [self getRandomNumber:101 to:999];
        ten2 = [self getRandomNumber:100 to:ten1-1];
        result4 = ten1 - ten2;
        while (result4 == result3 || result4 == result2 || result4 == result1)
        {
            ten1 = [self getRandomNumber:101 to:999];
            ten2 = [self getRandomNumber:100 to:ten1-1];
            result4 = ten1 - ten2;
        }
        
        eleven1 = [self getRandomNumber:result4 to:999];
        while (eleven1 == ten1)
        {
            eleven1 = [self getRandomNumber:result4 to:999];
        }
        eleven2 = eleven1 - result4;
        twelve1 = [self getRandomNumber:result4 to:999];
        while (twelve1 == eleven1 || twelve1 == ten1)
        {
            twelve1 = [self getRandomNumber:result4 to:999];
        }
        twelve2 = twelve1 - result4;
        
        
        
        NSArray *array1 = [NSArray arrayWithObjects:[NSNumber numberWithInt:one1],[NSNumber numberWithInt:one2], nil];
        NSArray *array2 = [NSArray arrayWithObjects:[NSNumber numberWithInt:two1],[NSNumber numberWithInt:two2 ], nil];
        NSArray *array3 = [NSArray arrayWithObjects:[NSNumber numberWithInt:three1],[NSNumber numberWithInt:three2], nil];
        NSArray *array4 = [NSArray arrayWithObjects:[NSNumber numberWithInt:four1],[NSNumber numberWithInt:four2], nil];
        NSArray *array5 = [NSArray arrayWithObjects:[NSNumber numberWithInt:five1],[NSNumber numberWithInt:five2], nil];
        NSArray *array6 = [NSArray arrayWithObjects:[NSNumber numberWithInt:six1],[NSNumber numberWithInt:six2], nil];
        NSArray *array7 = [NSArray arrayWithObjects:[NSNumber numberWithInt:seven1],[NSNumber numberWithInt:seven2], nil];
        NSArray *array8 = [NSArray arrayWithObjects:[NSNumber numberWithInt:eight1],[NSNumber numberWithInt:eight2], nil];
        NSArray *array9 = [NSArray arrayWithObjects:[NSNumber numberWithInt:nine1],[NSNumber numberWithInt:nine2], nil];
        NSArray *array10 = [NSArray arrayWithObjects:[NSNumber numberWithInt:ten1],[NSNumber numberWithInt:ten2], nil];
        NSArray *array11 = [NSArray arrayWithObjects:[NSNumber numberWithInt:eleven1],[NSNumber numberWithInt:eleven2], nil];
        NSArray *array12 = [NSArray arrayWithObjects:[NSNumber numberWithInt:twelve1],[NSNumber numberWithInt:twelve2], nil];
        
        
        NSArray *arrayContainingArrays = [NSArray arrayWithObjects:array1,array2,array3,array4,array5,array6,array7,array8,array9,array10,array11,array12, nil];
        
        NSLog(@"%@",arrayContainingArrays);
        
        int randomno1 , randomno2 , randomno3 , randomno4 , randomno5 , randomno6 , randomno7 , randomno8 , randomno9 , randomno10 , randomno11 , randomno12 ;
        
        randomno1 = [self getRandomNumber:0 to:11];
        randomno2 = [self getRandomNumber:0 to:11];
        while (randomno1 == randomno2)
        {
            randomno2 = [self getRandomNumber:0 to:11];
        }
        randomno3 = [self getRandomNumber:0 to:11];
        while (randomno3==randomno2 || randomno3 == randomno1)
        {
            randomno3 = [self getRandomNumber:0 to:11];
        }
        randomno4 = [self getRandomNumber:0 to:11];
        while (randomno4 == randomno3 || randomno4 == randomno2 || randomno4 == randomno1)
        {
            randomno4 = [self getRandomNumber:0 to:11];
        }
        randomno5 = [self getRandomNumber:0 to:11];
        while (randomno5 == randomno4 || randomno5 == randomno3 || randomno5 == randomno2 || randomno5 == randomno1)
        {
            randomno5 = [self getRandomNumber:0 to:11];
        }
        randomno6 = [self getRandomNumber:0 to:11];
        while (randomno6==randomno5 || randomno6 == randomno4 || randomno6 == randomno3 || randomno6 == randomno2 || randomno6 == randomno1)
        {
            randomno6 = [self getRandomNumber:0 to:11];
        }
        randomno7 = [self getRandomNumber:0 to:11];
        while ( randomno7== randomno6 ||randomno7 == randomno5 || randomno7 == randomno4 || randomno7 == randomno3 || randomno7 == randomno2 || randomno7 == randomno1)
        {
            randomno7 = [self getRandomNumber:0 to:11];
        }
        randomno8 = [self getRandomNumber:0 to:11];
        while (randomno8 == randomno7 || randomno8== randomno6 ||randomno8 == randomno5 || randomno8 == randomno4 || randomno8 == randomno3 || randomno8 == randomno2 || randomno8 == randomno1)
        {
            randomno8 = [self getRandomNumber:0 to:11];
        }
        randomno9 = [self getRandomNumber:0 to:11];
        while (randomno9 == randomno8 || randomno9 == randomno7 || randomno9== randomno6 ||randomno9 == randomno5 || randomno9 == randomno4 || randomno9 == randomno3 || randomno9 == randomno2 || randomno9 == randomno1)
        {
            randomno9 = [self getRandomNumber:0 to:11];
        }
        randomno10 = [self getRandomNumber:0 to:11];
        while (randomno10 == randomno9 || randomno10 == randomno8 || randomno10 == randomno7 || randomno10== randomno6 ||randomno10 == randomno5 || randomno10 == randomno4 || randomno10 == randomno3 || randomno10 == randomno2 || randomno10 == randomno1)
        {
            randomno10 = [self getRandomNumber:0 to:11];
        }
        randomno11 = [self getRandomNumber:0 to:11];
        while (randomno11 == randomno10 || randomno11 == randomno9 || randomno11 == randomno8 || randomno11 == randomno7 || randomno11== randomno6 ||randomno11 == randomno5 || randomno11 == randomno4 || randomno11 == randomno3 || randomno11 == randomno2 || randomno11 == randomno1)
        {
            randomno11 = [self getRandomNumber:0 to:11];
        }
        randomno12 = [self getRandomNumber:0 to:11];
        while (randomno12 == randomno11 || randomno12 == randomno10 || randomno12 == randomno9 || randomno12 == randomno8 || randomno12 == randomno7 || randomno12== randomno6 ||randomno12 == randomno5 || randomno12 == randomno4 || randomno12 == randomno3 || randomno12 == randomno2 || randomno12 == randomno1)
        {
            randomno12 = [self getRandomNumber:0 to:11];
        }
        
        // number generation end
        
        for (int i =0; i<3; i++) //int i for first row of buttons
        {
            
            UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
            
            if (i == 0)
            {
                button.tag = ((int)([[[arrayContainingArrays objectAtIndex:randomno1]objectAtIndex:0]intValue]) - ((int)[[[arrayContainingArrays objectAtIndex:randomno1]objectAtIndex:1]intValue])) ;
                
                NSLog(@"------%d",button.tag);
                
                [button setTitle:[NSString stringWithFormat:@"%@ - %@",[[arrayContainingArrays objectAtIndex:randomno1]objectAtIndex:0],[[arrayContainingArrays objectAtIndex:randomno1]objectAtIndex:1] ] forState:UIControlStateNormal];
            }
            else if (i==1)
            {
                button.tag = ((int)([[[arrayContainingArrays objectAtIndex:randomno2]objectAtIndex:0]intValue]) - ((int)[[[arrayContainingArrays objectAtIndex:randomno2]objectAtIndex:1]intValue])) ;
                
                NSLog(@"------%d",button.tag);
                
                [button setTitle:[NSString stringWithFormat:@"%@ - %@",[[arrayContainingArrays objectAtIndex:randomno2]objectAtIndex:0],[[arrayContainingArrays objectAtIndex:randomno2]objectAtIndex:1] ] forState:UIControlStateNormal];
            }
            else if (i==2)
            {
                button.tag = ((int)([[[arrayContainingArrays objectAtIndex:randomno3]objectAtIndex:0]intValue]) - ((int)[[[arrayContainingArrays objectAtIndex:randomno3]objectAtIndex:1]intValue])) ;
                
                NSLog(@"------%d",button.tag);
                
                [button setTitle:[NSString stringWithFormat:@"%@ - %@",[[arrayContainingArrays objectAtIndex:randomno3]objectAtIndex:0],[[arrayContainingArrays objectAtIndex:randomno3]objectAtIndex:1] ] forState:UIControlStateNormal];
            }
            
            
            button.frame = CGRectMake(0+width1+i, 0, 100, 80);
            [button setTitleColor:[UIColor greenColor] forState:UIControlStateNormal];
            [button setTitleColor:[UIColor orangeColor] forState:UIControlStateHighlighted];
            button.titleLabel.textAlignment = NSTextAlignmentCenter;
            button.titleLabel.lineBreakMode = NSLineBreakByWordWrapping;
            button.titleLabel.numberOfLines = 0;
            [button setBackgroundColor:[UIColor blackColor]];
            [[button titleLabel] setFont:[UIFont fontWithName:@"GillSans-BoldItalic" size:18.0f]];
            CAGradientLayer *btnGradient12 = [CAGradientLayer layer];
            btnGradient12.frame = button.bounds;
            btnGradient12.colors = [NSArray arrayWithObjects:
                                    (id)[[UIColor colorWithRed:102.0f / 255.0f green:102.0f / 255.0f blue:102.0f / 255.0f alpha:1.0f] CGColor],
                                    (id)[[UIColor colorWithRed:51.0f / 255.0f green:51.0f / 255.0f blue:51.0f / 255.0f alpha:1.0f] CGColor],
                                    nil];
            [button.layer insertSublayer:btnGradient12 atIndex:0];
            [button addTarget:self action:@selector(matrixButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
            [easyMatrixView addSubview:button];
            
            width1 = width1 + 100;
        }
        for (int j = 0; j<3; j++) // int j for second row of buttons
        {
            UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
            
            if (j==0)
            {
                button.tag = ((int)([[[arrayContainingArrays objectAtIndex:randomno4]objectAtIndex:0]intValue]) - ((int)[[[arrayContainingArrays objectAtIndex:randomno4]objectAtIndex:1]intValue])) ;
                
                NSLog(@"------%d",button.tag);
                
                [button setTitle:[NSString stringWithFormat:@"%@ - %@",[[arrayContainingArrays objectAtIndex:randomno4]objectAtIndex:0],[[arrayContainingArrays objectAtIndex:randomno4]objectAtIndex:1] ] forState:UIControlStateNormal];
            }
            else if (j==1)
            {
                button.tag = ((int)([[[arrayContainingArrays objectAtIndex:randomno5]objectAtIndex:0]intValue]) - ((int)[[[arrayContainingArrays objectAtIndex:randomno5]objectAtIndex:1]intValue])) ;
                
                NSLog(@"------%d",button.tag);
                
                [button setTitle:[NSString stringWithFormat:@"%@ - %@",[[arrayContainingArrays objectAtIndex:randomno5]objectAtIndex:0],[[arrayContainingArrays objectAtIndex:randomno5]objectAtIndex:1] ] forState:UIControlStateNormal];
            }
            else if (j==2)
            {
                button.tag = ((int)([[[arrayContainingArrays objectAtIndex:randomno6]objectAtIndex:0]intValue]) - ((int)[[[arrayContainingArrays objectAtIndex:randomno6]objectAtIndex:1]intValue])) ;
                
                NSLog(@"------%d",button.tag);
                
                [button setTitle:[NSString stringWithFormat:@"%@ - %@",[[arrayContainingArrays objectAtIndex:randomno6]objectAtIndex:0],[[arrayContainingArrays objectAtIndex:randomno6]objectAtIndex:1] ] forState:UIControlStateNormal];
            }
            
            button.frame = CGRectMake(0+width2+j, 85, 100, 80);
            [button setTitleColor:[UIColor greenColor] forState:UIControlStateNormal];
            [button setTitleColor:[UIColor orangeColor] forState:UIControlStateHighlighted];
            button.titleLabel.textAlignment = NSTextAlignmentCenter;
            button.titleLabel.lineBreakMode = NSLineBreakByWordWrapping;
            button.titleLabel.numberOfLines = 0;
            [button setBackgroundColor:[UIColor blackColor]];
            [[button titleLabel] setFont:[UIFont fontWithName:@"GillSans-BoldItalic" size:18.0f]];
            CAGradientLayer *btnGradient12 = [CAGradientLayer layer];
            btnGradient12.frame = button.bounds;
            btnGradient12.colors = [NSArray arrayWithObjects:
                                    (id)[[UIColor colorWithRed:102.0f / 255.0f green:102.0f / 255.0f blue:102.0f / 255.0f alpha:1.0f] CGColor],
                                    (id)[[UIColor colorWithRed:51.0f / 255.0f green:51.0f / 255.0f blue:51.0f / 255.0f alpha:1.0f] CGColor],
                                    nil];
            [button.layer insertSublayer:btnGradient12 atIndex:0];
            [button addTarget:self action:@selector(matrixButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
            [easyMatrixView addSubview:button];
            
            width2 = width2 + 100;
        }
        for (int k = 0; k<3; k++) // int k for third row of buttons
        {
            UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
            
            if (k==0)
            {
                button.tag = ((int)([[[arrayContainingArrays objectAtIndex:randomno7]objectAtIndex:0]intValue]) - ((int)[[[arrayContainingArrays objectAtIndex:randomno7]objectAtIndex:1]intValue])) ;
                
                NSLog(@"------%d",button.tag);
                
                [button setTitle:[NSString stringWithFormat:@"%@ - %@",[[arrayContainingArrays objectAtIndex:randomno7]objectAtIndex:0],[[arrayContainingArrays objectAtIndex:randomno7]objectAtIndex:1] ] forState:UIControlStateNormal];
            }
            else if (k==1)
            {
                button.tag = ((int)([[[arrayContainingArrays objectAtIndex:randomno8]objectAtIndex:0]intValue]) - ((int)[[[arrayContainingArrays objectAtIndex:randomno8]objectAtIndex:1]intValue])) ;
                
                NSLog(@"------%d",button.tag);
                
                [button setTitle:[NSString stringWithFormat:@"%@ - %@",[[arrayContainingArrays objectAtIndex:randomno8]objectAtIndex:0],[[arrayContainingArrays objectAtIndex:randomno8]objectAtIndex:1] ] forState:UIControlStateNormal];
            }
            else if (k==2)
            {
                button.tag = ((int)([[[arrayContainingArrays objectAtIndex:randomno9]objectAtIndex:0]intValue]) - ((int)[[[arrayContainingArrays objectAtIndex:randomno9]objectAtIndex:1] intValue])) ;
                
                NSLog(@"------%d",button.tag);
                
                [button setTitle:[NSString stringWithFormat:@"%@ - %@",[[arrayContainingArrays objectAtIndex:randomno9]objectAtIndex:0],[[arrayContainingArrays objectAtIndex:randomno9]objectAtIndex:1] ] forState:UIControlStateNormal];
            }
            
            button.frame = CGRectMake(0+width3+k, 170, 100, 80);
            [button setTitleColor:[UIColor greenColor] forState:UIControlStateNormal];
            [button setTitleColor:[UIColor orangeColor] forState:UIControlStateHighlighted];
            button.titleLabel.textAlignment = NSTextAlignmentCenter;
            button.titleLabel.lineBreakMode = NSLineBreakByWordWrapping;
            button.titleLabel.numberOfLines = 0;
            [button setBackgroundColor:[UIColor blackColor]];
            [[button titleLabel] setFont:[UIFont fontWithName:@"GillSans-BoldItalic" size:18.0f]];
            CAGradientLayer *btnGradient12 = [CAGradientLayer layer];
            btnGradient12.frame = button.bounds;
            btnGradient12.colors = [NSArray arrayWithObjects:
                                    (id)[[UIColor colorWithRed:102.0f / 255.0f green:102.0f / 255.0f blue:102.0f / 255.0f alpha:1.0f] CGColor],
                                    (id)[[UIColor colorWithRed:51.0f / 255.0f green:51.0f / 255.0f blue:51.0f / 255.0f alpha:1.0f] CGColor],
                                    nil];
            [button.layer insertSublayer:btnGradient12 atIndex:0];
            [button addTarget:self action:@selector(matrixButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
            [easyMatrixView addSubview:button];
            
            width3 = width3 + 100;
        }
        for (int l = 0; l<3; l++) // int l for fourth row of buttons
        {
            UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
            
            if (l==0)
            {
                
                button.tag = ((int)([[[arrayContainingArrays objectAtIndex:randomno10]objectAtIndex:0] intValue]) - ((int)[[[arrayContainingArrays objectAtIndex:randomno10]objectAtIndex:1]intValue])) ;
                
                NSLog(@"------%d",button.tag);
                
                [button setTitle:[NSString stringWithFormat:@"%@ - %@",[[arrayContainingArrays objectAtIndex:randomno10]objectAtIndex:0],[[arrayContainingArrays objectAtIndex:randomno10]objectAtIndex:1] ] forState:UIControlStateNormal];
            }
            else if (l==1)
            {
                button.tag = ((int)([[[arrayContainingArrays objectAtIndex:randomno11]objectAtIndex:0]intValue]) - ((int)[[[arrayContainingArrays objectAtIndex:randomno11]objectAtIndex:1]intValue])) ;
                
                NSLog(@"------%d",button.tag);
                
                [button setTitle:[NSString stringWithFormat:@"%@ - %@",[[arrayContainingArrays objectAtIndex:randomno11]objectAtIndex:0],[[arrayContainingArrays objectAtIndex:randomno11]objectAtIndex:1] ] forState:UIControlStateNormal];
            }
            else if (l==2)
            {
                button.tag = ((int)([[[arrayContainingArrays objectAtIndex:randomno12]objectAtIndex:0]intValue]) - ((int)[[[arrayContainingArrays objectAtIndex:randomno12]objectAtIndex:1]intValue])) ;
                
                NSLog(@"------%d",button.tag);
                
                [button setTitle:[NSString stringWithFormat:@"%@ - %@",[[arrayContainingArrays objectAtIndex:randomno12]objectAtIndex:0],[[arrayContainingArrays objectAtIndex:randomno12]objectAtIndex:1] ] forState:UIControlStateNormal];
            }
            
            button.frame = CGRectMake(0+width4+l, 255, 100, 80);
            [button setTitleColor:[UIColor greenColor] forState:UIControlStateNormal];
            [button setTitleColor:[UIColor orangeColor] forState:UIControlStateHighlighted];
            
            button.titleLabel.textAlignment = NSTextAlignmentCenter;
            button.titleLabel.lineBreakMode = NSLineBreakByWordWrapping;
            button.titleLabel.numberOfLines = 0;
            [button setBackgroundColor:[UIColor blackColor]];
            [[button titleLabel] setFont:[UIFont fontWithName:@"GillSans-BoldItalic" size:18.0f]];
            CAGradientLayer *btnGradient12 = [CAGradientLayer layer];
            btnGradient12.frame = button.bounds;
            btnGradient12.colors = [NSArray arrayWithObjects:
                                    (id)[[UIColor colorWithRed:102.0f / 255.0f green:102.0f / 255.0f blue:102.0f / 255.0f alpha:1.0f] CGColor],
                                    (id)[[UIColor colorWithRed:51.0f / 255.0f green:51.0f / 255.0f blue:51.0f / 255.0f alpha:1.0f] CGColor],
                                    nil];
            [button.layer insertSublayer:btnGradient12 atIndex:0];
            [button addTarget:self action:@selector(matrixButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
            [easyMatrixView addSubview:button];
            
            width4 = width4 + 100;
        }//for l = 0
        
    } // if HARD
    else if ([levelString isEqualToString:@"MEDIUM"])
    {
        easyMatrixView = [[UIView alloc]initWithFrame:CGRectMake(200, 350, 450, 350)];
        easyMatrixView.backgroundColor = [UIColor clearColor];
        [self.view addSubview:easyMatrixView];
        
        int width1=0; //for first row
        int width2=0; //for sec row
        int width3=0; //for thrd row
        
        // number generation start
        
        int one1 , one2, two1, two2, three1 , three2 ,four1 , four2 , five1 , five2 , six1 , six2 , seven1 , seven2 , eight1 , eight2 , nine1 , nine2 , result1, result2, result3;
        
        one1 = [self getRandomNumber:55 to:199];
        one2 = [self getRandomNumber:50 to:one1-1];
        result1 = one1 - one2;
        two1 = [self getRandomNumber:result1 to:199];
        while (two1 == one1)
        {
            two1 = [self getRandomNumber:result1 to:199];
        }
        two2 = two1 - result1;
        three1 = [self getRandomNumber:result1 to:199];
        while (three1 == two1 || three1 == one1)
        {
            three1 = [self getRandomNumber:result1 to:199];
        }
        three2 = three1 - result1;
        
        four1 = [self getRandomNumber:55 to:199];
        four2 = [self getRandomNumber:50 to:four1-1];
        result2 = four1 - four2;
        while (result2 == result1)
        {
            four1 = [self getRandomNumber:55 to:199];
            four2 = [self getRandomNumber:50 to:four1-1];
            result2 = four1 - four2;
        }
        
        five1 = [self getRandomNumber:result2 to:199];
        while (five1 == four1)
        {
            five1 = [self getRandomNumber:result2 to:199];
        }
        five2 = five1 - result2;
        six1 = [self getRandomNumber:result2 to:199];
        while (six1 ==four1 || six1 == five1)
        {
            six1 = [self getRandomNumber:result2 to:199];
        }
        six2 = six1 - result2;
        
        seven1 = [self getRandomNumber:55 to:199];
        seven2 = [self getRandomNumber:50 to:seven1-1];
        result3 = seven1 - seven2;
        while (result3 == result2 || result3 == result1)
        {
            seven1 = [self getRandomNumber:55 to:199];
            seven2 = [self getRandomNumber:50 to:seven1-1];
            result3 = seven1 - seven2;
        }
        
        eight1 = [self getRandomNumber:result3 to:199];
        while (eight1 ==  seven1)
        {
            eight1 = [self getRandomNumber:result3 to:199];
        }
        eight2 = eight1 - result3;
        nine1 = [self getRandomNumber:result3 to:199];
        while (nine1 ==eight1|| nine1 == seven1)
        {
            nine1 = [self getRandomNumber:result3 to:199];
        }
        nine2 = nine1 - result3;
        
        NSArray *array1 = [NSArray arrayWithObjects:[NSNumber numberWithInt:one1],[NSNumber numberWithInt:one2], nil];
        NSArray *array2 = [NSArray arrayWithObjects:[NSNumber numberWithInt:two1],[NSNumber numberWithInt:two2 ], nil];
        NSArray *array3 = [NSArray arrayWithObjects:[NSNumber numberWithInt:three1],[NSNumber numberWithInt:three2], nil];
        NSArray *array4 = [NSArray arrayWithObjects:[NSNumber numberWithInt:four1],[NSNumber numberWithInt:four2], nil];
        NSArray *array5 = [NSArray arrayWithObjects:[NSNumber numberWithInt:five1],[NSNumber numberWithInt:five2], nil];
        NSArray *array6 = [NSArray arrayWithObjects:[NSNumber numberWithInt:six1],[NSNumber numberWithInt:six2], nil];
        NSArray *array7 = [NSArray arrayWithObjects:[NSNumber numberWithInt:seven1],[NSNumber numberWithInt:seven2], nil];
        NSArray *array8 = [NSArray arrayWithObjects:[NSNumber numberWithInt:eight1],[NSNumber numberWithInt:eight2], nil];
        NSArray *array9 = [NSArray arrayWithObjects:[NSNumber numberWithInt:nine1],[NSNumber numberWithInt:nine2], nil];
        
        
        NSArray *arrayContainingArrays = [NSArray arrayWithObjects:array1,array2,array3,array4,array5,array6,array7,array8,array9,nil];
        
        int randomno1 , randomno2 , randomno3 , randomno4 , randomno5 , randomno6 , randomno7 , randomno8 , randomno9 ;
        
        randomno1 = [self getRandomNumber:0 to:8];
        randomno2 = [self getRandomNumber:0 to:8];
        while (randomno1 == randomno2)
        {
            randomno2 = [self getRandomNumber:0 to:8];
        }
        randomno3 = [self getRandomNumber:0 to:8];
        while (randomno3==randomno2 || randomno3 == randomno1)
        {
            randomno3 = [self getRandomNumber:0 to:8];
        }
        randomno4 = [self getRandomNumber:0 to:8];
        while (randomno4 == randomno3 || randomno4 == randomno2 || randomno4 == randomno1)
        {
            randomno4 = [self getRandomNumber:0 to:8];
        }
        randomno5 = [self getRandomNumber:0 to:8];
        while (randomno5 == randomno4 || randomno5 == randomno3 || randomno5 == randomno2 || randomno5 == randomno1)
        {
            randomno5 = [self getRandomNumber:0 to:8];
        }
        randomno6 = [self getRandomNumber:0 to:8];
        while (randomno6==randomno5 || randomno6 == randomno4 || randomno6 == randomno3 || randomno6 == randomno2 || randomno6 == randomno1)
        {
            randomno6 = [self getRandomNumber:0 to:8];
        }
        randomno7 = [self getRandomNumber:0 to:8];
        while ( randomno7== randomno6 ||randomno7 == randomno5 || randomno7 == randomno4 || randomno7 == randomno3 || randomno7 == randomno2 || randomno7 == randomno1)
        {
            randomno7 = [self getRandomNumber:0 to:8];
        }
        randomno8 = [self getRandomNumber:0 to:8];
        while (randomno8 == randomno7 || randomno8== randomno6 ||randomno8 == randomno5 || randomno8 == randomno4 || randomno8 == randomno3 || randomno8 == randomno2 || randomno8 == randomno1)
        {
            randomno8 = [self getRandomNumber:0 to:8];
        }
        randomno9 = [self getRandomNumber:0 to:8];
        while (randomno9 == randomno8 || randomno9 == randomno7 || randomno9== randomno6 ||randomno9 == randomno5 || randomno9 == randomno4 || randomno9 == randomno3 || randomno9 == randomno2 || randomno9 == randomno1)
        {
            randomno9 = [self getRandomNumber:0 to:8];
        }
        
        // number generation end
        
        for (int i =0; i<3; i++) //int i for first row of buttons
        {
            
            UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
            
            if (i == 0)
            {
                button.tag = ((int)([[[arrayContainingArrays objectAtIndex:randomno1]objectAtIndex:0]intValue]) - ((int)[[[arrayContainingArrays objectAtIndex:randomno1]objectAtIndex:1]intValue])) ;
                
                [button setTitle:[NSString stringWithFormat:@"%@ - %@",[[arrayContainingArrays objectAtIndex:randomno1]objectAtIndex:0],[[arrayContainingArrays objectAtIndex:randomno1]objectAtIndex:1] ] forState:UIControlStateNormal];
            }
            else if (i==1)
            {
                button.tag = ((int)([[[arrayContainingArrays objectAtIndex:randomno2]objectAtIndex:0]intValue]) - ((int)[[[arrayContainingArrays objectAtIndex:randomno2]objectAtIndex:1]intValue])) ;
                
                [button setTitle:[NSString stringWithFormat:@"%@ - %@",[[arrayContainingArrays objectAtIndex:randomno2]objectAtIndex:0],[[arrayContainingArrays objectAtIndex:randomno2]objectAtIndex:1] ] forState:UIControlStateNormal];
            }
            else if (i==2)
            {
                button.tag = ((int)([[[arrayContainingArrays objectAtIndex:randomno3]objectAtIndex:0]intValue]) - ((int)[[[arrayContainingArrays objectAtIndex:randomno3]objectAtIndex:1]intValue])) ;
                
                [button setTitle:[NSString stringWithFormat:@"%@ - %@",[[arrayContainingArrays objectAtIndex:randomno3]objectAtIndex:0],[[arrayContainingArrays objectAtIndex:randomno3]objectAtIndex:1] ] forState:UIControlStateNormal];
            }
            
            button.frame = CGRectMake(0+width1+i, 0, 100, 80);
            [button setTitleColor:[UIColor greenColor] forState:UIControlStateNormal];
            [button setTitleColor:[UIColor orangeColor] forState:UIControlStateHighlighted];
            button.titleLabel.textAlignment = NSTextAlignmentCenter;
            button.titleLabel.lineBreakMode = NSLineBreakByWordWrapping;
            button.titleLabel.numberOfLines = 0;
            [button setBackgroundColor:[UIColor blackColor]];
            [[button titleLabel] setFont:[UIFont fontWithName:@"GillSans-BoldItalic" size:18.0f]];
            CAGradientLayer *btnGradient12 = [CAGradientLayer layer];
            btnGradient12.frame = button.bounds;
            btnGradient12.colors = [NSArray arrayWithObjects:
                                    (id)[[UIColor colorWithRed:102.0f / 255.0f green:102.0f / 255.0f blue:102.0f / 255.0f alpha:1.0f] CGColor],
                                    (id)[[UIColor colorWithRed:51.0f / 255.0f green:51.0f / 255.0f blue:51.0f / 255.0f alpha:1.0f] CGColor],
                                    nil];
            [button.layer insertSublayer:btnGradient12 atIndex:0];
            [button addTarget:self action:@selector(matrixButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
            [easyMatrixView addSubview:button];
            
            width1 = width1 + 100;
        }
        for (int j = 0; j<3; j++) // int j for second row of buttons
        {
            UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
            
            if (j==0)
            {
                button.tag = ((int)([[[arrayContainingArrays objectAtIndex:randomno4]objectAtIndex:0]intValue]) - ((int)[[[arrayContainingArrays objectAtIndex:randomno4]objectAtIndex:1]intValue])) ;
                
                [button setTitle:[NSString stringWithFormat:@"%@ - %@",[[arrayContainingArrays objectAtIndex:randomno4]objectAtIndex:0],[[arrayContainingArrays objectAtIndex:randomno4]objectAtIndex:1] ] forState:UIControlStateNormal];
                
                
            }
            else if (j==1)
            {
                button.tag = ((int)([[[arrayContainingArrays objectAtIndex:randomno5]objectAtIndex:0]intValue]) - ((int)[[[arrayContainingArrays objectAtIndex:randomno5]objectAtIndex:1]intValue])) ;
                
                [button setTitle:[NSString stringWithFormat:@"%@ - %@",[[arrayContainingArrays objectAtIndex:randomno5]objectAtIndex:0],[[arrayContainingArrays objectAtIndex:randomno5]objectAtIndex:1] ] forState:UIControlStateNormal];
                
            }
            else if (j==2)
            {
                button.tag = ((int)([[[arrayContainingArrays objectAtIndex:randomno6]objectAtIndex:0]intValue]) - ((int)[[[arrayContainingArrays objectAtIndex:randomno6]objectAtIndex:1]intValue])) ;
                
                [button setTitle:[NSString stringWithFormat:@"%@ - %@",[[arrayContainingArrays objectAtIndex:randomno6]objectAtIndex:0],[[arrayContainingArrays objectAtIndex:randomno6]objectAtIndex:1] ] forState:UIControlStateNormal];
                
                
            }
            
            
            button.frame = CGRectMake(0+width2+j, 85, 100, 80);
            [button setTitleColor:[UIColor greenColor] forState:UIControlStateNormal];
            [button setTitleColor:[UIColor orangeColor] forState:UIControlStateHighlighted];
            button.titleLabel.textAlignment = NSTextAlignmentCenter;
            button.titleLabel.lineBreakMode = NSLineBreakByWordWrapping;
            button.titleLabel.numberOfLines = 0;
            [button setBackgroundColor:[UIColor blackColor]];
            [[button titleLabel] setFont:[UIFont fontWithName:@"GillSans-BoldItalic" size:18.0f]];
            CAGradientLayer *btnGradient12 = [CAGradientLayer layer];
            btnGradient12.frame = button.bounds;
            btnGradient12.colors = [NSArray arrayWithObjects:
                                    (id)[[UIColor colorWithRed:102.0f / 255.0f green:102.0f / 255.0f blue:102.0f / 255.0f alpha:1.0f] CGColor],
                                    (id)[[UIColor colorWithRed:51.0f / 255.0f green:51.0f / 255.0f blue:51.0f / 255.0f alpha:1.0f] CGColor],
                                    nil];
            [button.layer insertSublayer:btnGradient12 atIndex:0];
            [button addTarget:self action:@selector(matrixButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
            [easyMatrixView addSubview:button];
            
            width2 = width2 + 100;
        }
        for (int k = 0; k<3; k++) // int k for third row of buttons
        {
            UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
            
            if (k==0)
            {
                button.tag = ((int)([[[arrayContainingArrays objectAtIndex:randomno7]objectAtIndex:0]intValue]) - ((int)[[[arrayContainingArrays objectAtIndex:randomno7]objectAtIndex:1]intValue])) ;
                
                [button setTitle:[NSString stringWithFormat:@"%@ - %@",[[arrayContainingArrays objectAtIndex:randomno7]objectAtIndex:0],[[arrayContainingArrays objectAtIndex:randomno7]objectAtIndex:1] ] forState:UIControlStateNormal];
                
                
            }
            else if (k==1)
            {
                button.tag = ((int)([[[arrayContainingArrays objectAtIndex:randomno8]objectAtIndex:0]intValue]) - ((int)[[[arrayContainingArrays objectAtIndex:randomno8]objectAtIndex:1]intValue])) ;
                
                [button setTitle:[NSString stringWithFormat:@"%@ - %@",[[arrayContainingArrays objectAtIndex:randomno8]objectAtIndex:0],[[arrayContainingArrays objectAtIndex:randomno8]objectAtIndex:1] ] forState:UIControlStateNormal];
                
            }
            else if (k==2)
            {
                button.tag = ((int)([[[arrayContainingArrays objectAtIndex:randomno9]objectAtIndex:0]intValue]) - ((int)[[[arrayContainingArrays objectAtIndex:randomno9]objectAtIndex:1]intValue])) ;
                
                [button setTitle:[NSString stringWithFormat:@"%@ - %@",[[arrayContainingArrays objectAtIndex:randomno9]objectAtIndex:0],[[arrayContainingArrays objectAtIndex:randomno9]objectAtIndex:1] ] forState:UIControlStateNormal];
                
            }
            
            button.frame = CGRectMake(0+width3+k, 170, 100, 80);
            [button setTitleColor:[UIColor greenColor] forState:UIControlStateNormal];
            [button setTitleColor:[UIColor orangeColor] forState:UIControlStateHighlighted];
            button.titleLabel.textAlignment = NSTextAlignmentCenter;
            button.titleLabel.lineBreakMode = NSLineBreakByWordWrapping;
            button.titleLabel.numberOfLines = 0;
            [button setBackgroundColor:[UIColor blackColor]];
            [[button titleLabel] setFont:[UIFont fontWithName:@"GillSans-BoldItalic" size:18.0f]];
            CAGradientLayer *btnGradient12 = [CAGradientLayer layer];
            btnGradient12.frame = button.bounds;
            btnGradient12.colors = [NSArray arrayWithObjects:
                                    (id)[[UIColor colorWithRed:102.0f / 255.0f green:102.0f / 255.0f blue:102.0f / 255.0f alpha:1.0f] CGColor],
                                    (id)[[UIColor colorWithRed:51.0f / 255.0f green:51.0f / 255.0f blue:51.0f / 255.0f alpha:1.0f] CGColor],
                                    nil];
            [button.layer insertSublayer:btnGradient12 atIndex:0];
            [button addTarget:self action:@selector(matrixButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
            [easyMatrixView addSubview:button];
            
            width3 = width3 + 100;
        }
    }
    else if ([levelString isEqualToString:@"EASY"])
    {
        easyMatrixView = [[UIView alloc]initWithFrame:CGRectMake(200, 350, 450, 350)];
        easyMatrixView.backgroundColor = [UIColor clearColor];
        [self.view addSubview:easyMatrixView];
        
        int width1=0; //for first row
        int width2=0; //for sec row
        int width3=0; //for thrd row
        
        // number generation start
        
        int one1 , one2, two1, two2, three1 , three2 ,four1 , four2 , five1 , five2 , six1 , six2 , seven1 , seven2 , eight1 , eight2 , nine1 , nine2 , result1, result2, result3;
        
        one1 = [self getRandomNumber:20 to:50];
        one2 = [self getRandomNumber:10 to:one1-1];
        result1 = one1 - one2;
        two1 = [self getRandomNumber:result1 to:50];
        while (two1 == one1)
        {
            two1 = [self getRandomNumber:result1 to:50];
        }
        two2 = two1 - result1;
        three1 = [self getRandomNumber:result1 to:50];
        while (three1 == two1 || three1 == one1)
        {
            three1 = [self getRandomNumber:result1 to:50];
        }
        three2 = three1 - result1;
        
        four1 = [self getRandomNumber:20 to:50];
        four2 = [self getRandomNumber:10 to:four1-1];
        result2 = four1 - four2;
        while (result2 == result1)
        {
            four1 = [self getRandomNumber:20 to:50];
            four2 = [self getRandomNumber:10 to:four1-1];
            result2 = four1 - four2;
        }
        
        five1 = [self getRandomNumber:result2 to:50];
        while (five1 == four1)
        {
            five1 = [self getRandomNumber:result2 to:50];
        }
        five2 = five1 - result2;
        six1 = [self getRandomNumber:result2 to:50];
        while (six1 ==four1 || six1 == five1)
        {
            six1 = [self getRandomNumber:result2 to:50];
        }
        six2 = six1 - result2;
        
        seven1 = [self getRandomNumber:20 to:50];
        seven2 = [self getRandomNumber:10 to:seven1-1];
        result3 = seven1 - seven2;
        while (result3 == result2 || result3 == result1)
        {
            seven1 = [self getRandomNumber:20 to:50];
            seven2 = [self getRandomNumber:10 to:seven1-1];
            result3 = seven1 - seven2;
        }
        
        eight1 = [self getRandomNumber:result3 to:50];
        while (eight1 ==  seven1)
        {
            eight1 = [self getRandomNumber:result3 to:50];
        }
        eight2 = eight1 - result3;
        nine1 = [self getRandomNumber:result3 to:50];
        while (nine1 ==eight1|| nine1 == seven1)
        {
            nine1 = [self getRandomNumber:result3 to:50];
        }
        nine2 = nine1 - result3;
        
        NSArray *array1 = [NSArray arrayWithObjects:[NSNumber numberWithInt:one1],[NSNumber numberWithInt:one2], nil];
        NSArray *array2 = [NSArray arrayWithObjects:[NSNumber numberWithInt:two1],[NSNumber numberWithInt:two2 ], nil];
        NSArray *array3 = [NSArray arrayWithObjects:[NSNumber numberWithInt:three1],[NSNumber numberWithInt:three2], nil];
        NSArray *array4 = [NSArray arrayWithObjects:[NSNumber numberWithInt:four1],[NSNumber numberWithInt:four2], nil];
        NSArray *array5 = [NSArray arrayWithObjects:[NSNumber numberWithInt:five1],[NSNumber numberWithInt:five2], nil];
        NSArray *array6 = [NSArray arrayWithObjects:[NSNumber numberWithInt:six1],[NSNumber numberWithInt:six2], nil];
        NSArray *array7 = [NSArray arrayWithObjects:[NSNumber numberWithInt:seven1],[NSNumber numberWithInt:seven2], nil];
        NSArray *array8 = [NSArray arrayWithObjects:[NSNumber numberWithInt:eight1],[NSNumber numberWithInt:eight2], nil];
        NSArray *array9 = [NSArray arrayWithObjects:[NSNumber numberWithInt:nine1],[NSNumber numberWithInt:nine2], nil];
        
        
        NSArray *arrayContainingArrays = [NSArray arrayWithObjects:array1,array2,array3,array4,array5,array6,array7,array8,array9,nil];
        
        int randomno1 , randomno2 , randomno3 , randomno4 , randomno5 , randomno6 , randomno7 , randomno8 , randomno9 ;
        
        randomno1 = [self getRandomNumber:0 to:8];
        randomno2 = [self getRandomNumber:0 to:8];
        while (randomno1 == randomno2)
        {
            randomno2 = [self getRandomNumber:0 to:8];
        }
        randomno3 = [self getRandomNumber:0 to:8];
        while (randomno3==randomno2 || randomno3 == randomno1)
        {
            randomno3 = [self getRandomNumber:0 to:8];
        }
        randomno4 = [self getRandomNumber:0 to:8];
        while (randomno4 == randomno3 || randomno4 == randomno2 || randomno4 == randomno1)
        {
            randomno4 = [self getRandomNumber:0 to:8];
        }
        randomno5 = [self getRandomNumber:0 to:8];
        while (randomno5 == randomno4 || randomno5 == randomno3 || randomno5 == randomno2 || randomno5 == randomno1)
        {
            randomno5 = [self getRandomNumber:0 to:8];
        }
        randomno6 = [self getRandomNumber:0 to:8];
        while (randomno6==randomno5 || randomno6 == randomno4 || randomno6 == randomno3 || randomno6 == randomno2 || randomno6 == randomno1)
        {
            randomno6 = [self getRandomNumber:0 to:8];
        }
        randomno7 = [self getRandomNumber:0 to:8];
        while ( randomno7== randomno6 ||randomno7 == randomno5 || randomno7 == randomno4 || randomno7 == randomno3 || randomno7 == randomno2 || randomno7 == randomno1)
        {
            randomno7 = [self getRandomNumber:0 to:8];
        }
        randomno8 = [self getRandomNumber:0 to:8];
        while (randomno8 == randomno7 || randomno8== randomno6 ||randomno8 == randomno5 || randomno8 == randomno4 || randomno8 == randomno3 || randomno8 == randomno2 || randomno8 == randomno1)
        {
            randomno8 = [self getRandomNumber:0 to:8];
        }
        randomno9 = [self getRandomNumber:0 to:8];
        while (randomno9 == randomno8 || randomno9 == randomno7 || randomno9== randomno6 ||randomno9 == randomno5 || randomno9 == randomno4 || randomno9 == randomno3 || randomno9 == randomno2 || randomno9 == randomno1)
        {
            randomno9 = [self getRandomNumber:0 to:8];
        }
        
        // number generation end
        
        for (int i =0; i<3; i++) //int i for first row of buttons
        {
            
            UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
            
            if (i == 0)
            {
                button.tag = ((int)([[[arrayContainingArrays objectAtIndex:randomno1]objectAtIndex:0]intValue]) - ((int)[[[arrayContainingArrays objectAtIndex:randomno1]objectAtIndex:1]intValue])) ;
                
                [button setTitle:[NSString stringWithFormat:@"%@ - %@",[[arrayContainingArrays objectAtIndex:randomno1]objectAtIndex:0],[[arrayContainingArrays objectAtIndex:randomno1]objectAtIndex:1] ] forState:UIControlStateNormal];
            }
            else if (i==1)
            {
                button.tag = ((int)([[[arrayContainingArrays objectAtIndex:randomno2]objectAtIndex:0]intValue]) - ((int)[[[arrayContainingArrays objectAtIndex:randomno2]objectAtIndex:1]intValue])) ;
                
                [button setTitle:[NSString stringWithFormat:@"%@ - %@",[[arrayContainingArrays objectAtIndex:randomno2]objectAtIndex:0],[[arrayContainingArrays objectAtIndex:randomno2]objectAtIndex:1] ] forState:UIControlStateNormal];
            }
            else if (i==2)
            {
                button.tag = ((int)([[[arrayContainingArrays objectAtIndex:randomno3]objectAtIndex:0]intValue]) - ((int)[[[arrayContainingArrays objectAtIndex:randomno3]objectAtIndex:1]intValue])) ;
                
                [button setTitle:[NSString stringWithFormat:@"%@ - %@",[[arrayContainingArrays objectAtIndex:randomno3]objectAtIndex:0],[[arrayContainingArrays objectAtIndex:randomno3]objectAtIndex:1] ] forState:UIControlStateNormal];
            }
            
            button.frame = CGRectMake(0+width1+i, 0, 100, 80);
            [button setTitleColor:[UIColor greenColor] forState:UIControlStateNormal];
            [button setTitleColor:[UIColor orangeColor] forState:UIControlStateHighlighted];
            button.titleLabel.textAlignment = NSTextAlignmentCenter;
            button.titleLabel.lineBreakMode = NSLineBreakByWordWrapping;
            button.titleLabel.numberOfLines = 0;
            [button setBackgroundColor:[UIColor blackColor]];
            [[button titleLabel] setFont:[UIFont fontWithName:@"GillSans-BoldItalic" size:18.0f]];
            CAGradientLayer *btnGradient12 = [CAGradientLayer layer];
            btnGradient12.frame = button.bounds;
            btnGradient12.colors = [NSArray arrayWithObjects:
                                    (id)[[UIColor colorWithRed:102.0f / 255.0f green:102.0f / 255.0f blue:102.0f / 255.0f alpha:1.0f] CGColor],
                                    (id)[[UIColor colorWithRed:51.0f / 255.0f green:51.0f / 255.0f blue:51.0f / 255.0f alpha:1.0f] CGColor],
                                    nil];
            [button.layer insertSublayer:btnGradient12 atIndex:0];
            [button addTarget:self action:@selector(matrixButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
            [easyMatrixView addSubview:button];
            
            width1 = width1 + 100;
        }
        for (int j = 0; j<3; j++) // int j for second row of buttons
        {
            UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
            
            if (j==0)
            {
                button.tag = ((int)([[[arrayContainingArrays objectAtIndex:randomno4]objectAtIndex:0]intValue]) - ((int)[[[arrayContainingArrays objectAtIndex:randomno4]objectAtIndex:1]intValue])) ;
                
                [button setTitle:[NSString stringWithFormat:@"%@ - %@",[[arrayContainingArrays objectAtIndex:randomno4]objectAtIndex:0],[[arrayContainingArrays objectAtIndex:randomno4]objectAtIndex:1] ] forState:UIControlStateNormal];
                
                
            }
            else if (j==1)
            {
                button.tag = ((int)([[[arrayContainingArrays objectAtIndex:randomno5]objectAtIndex:0]intValue]) - ((int)[[[arrayContainingArrays objectAtIndex:randomno5]objectAtIndex:1]intValue])) ;
                
                [button setTitle:[NSString stringWithFormat:@"%@ - %@",[[arrayContainingArrays objectAtIndex:randomno5]objectAtIndex:0],[[arrayContainingArrays objectAtIndex:randomno5]objectAtIndex:1] ] forState:UIControlStateNormal];
                
            }
            else if (j==2)
            {
                button.tag = ((int)([[[arrayContainingArrays objectAtIndex:randomno6]objectAtIndex:0]intValue]) - ((int)[[[arrayContainingArrays objectAtIndex:randomno6]objectAtIndex:1]intValue])) ;
                
                [button setTitle:[NSString stringWithFormat:@"%@ - %@",[[arrayContainingArrays objectAtIndex:randomno6]objectAtIndex:0],[[arrayContainingArrays objectAtIndex:randomno6]objectAtIndex:1] ] forState:UIControlStateNormal];
                
                
            }
            
            
            button.frame = CGRectMake(0+width2+j, 85, 100, 80);
            [button setTitleColor:[UIColor greenColor] forState:UIControlStateNormal];
            [button setTitleColor:[UIColor orangeColor] forState:UIControlStateHighlighted];
            button.titleLabel.textAlignment = NSTextAlignmentCenter;
            button.titleLabel.lineBreakMode = NSLineBreakByWordWrapping;
            button.titleLabel.numberOfLines = 0;
            [button setBackgroundColor:[UIColor blackColor]];
            [[button titleLabel] setFont:[UIFont fontWithName:@"GillSans-BoldItalic" size:18.0f]];
            CAGradientLayer *btnGradient12 = [CAGradientLayer layer];
            btnGradient12.frame = button.bounds;
            btnGradient12.colors = [NSArray arrayWithObjects:
                                    (id)[[UIColor colorWithRed:102.0f / 255.0f green:102.0f / 255.0f blue:102.0f / 255.0f alpha:1.0f] CGColor],
                                    (id)[[UIColor colorWithRed:51.0f / 255.0f green:51.0f / 255.0f blue:51.0f / 255.0f alpha:1.0f] CGColor],
                                    nil];
            [button.layer insertSublayer:btnGradient12 atIndex:0];
            [button addTarget:self action:@selector(matrixButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
            [easyMatrixView addSubview:button];
            
            width2 = width2 + 100;
        }
        for (int k = 0; k<3; k++) // int k for third row of buttons
        {
            UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
            
            if (k==0)
            {
                button.tag = ((int)([[[arrayContainingArrays objectAtIndex:randomno7]objectAtIndex:0]intValue]) - ((int)[[[arrayContainingArrays objectAtIndex:randomno7]objectAtIndex:1]intValue])) ;
                
                [button setTitle:[NSString stringWithFormat:@"%@ - %@",[[arrayContainingArrays objectAtIndex:randomno7]objectAtIndex:0],[[arrayContainingArrays objectAtIndex:randomno7]objectAtIndex:1] ] forState:UIControlStateNormal];
                
                
            }
            else if (k==1)
            {
                button.tag = ((int)([[[arrayContainingArrays objectAtIndex:randomno8]objectAtIndex:0]intValue]) - ((int)[[[arrayContainingArrays objectAtIndex:randomno8]objectAtIndex:1]intValue])) ;
                
                [button setTitle:[NSString stringWithFormat:@"%@ - %@",[[arrayContainingArrays objectAtIndex:randomno8]objectAtIndex:0],[[arrayContainingArrays objectAtIndex:randomno8]objectAtIndex:1] ] forState:UIControlStateNormal];
                
            }
            else if (k==2)
            {
                button.tag = ((int)([[[arrayContainingArrays objectAtIndex:randomno9]objectAtIndex:0]intValue]) - ((int)[[[arrayContainingArrays objectAtIndex:randomno9]objectAtIndex:1]intValue])) ;
                
                [button setTitle:[NSString stringWithFormat:@"%@ - %@",[[arrayContainingArrays objectAtIndex:randomno9]objectAtIndex:0],[[arrayContainingArrays objectAtIndex:randomno9]objectAtIndex:1] ] forState:UIControlStateNormal];
                
            }
            
            button.frame = CGRectMake(0+width3+k, 170, 100, 80);
            [button setTitleColor:[UIColor greenColor] forState:UIControlStateNormal];
            [button setTitleColor:[UIColor orangeColor] forState:UIControlStateHighlighted];
            button.titleLabel.textAlignment = NSTextAlignmentCenter;
            button.titleLabel.lineBreakMode = NSLineBreakByWordWrapping;
            button.titleLabel.numberOfLines = 0;
            [button setBackgroundColor:[UIColor blackColor]];
            [[button titleLabel] setFont:[UIFont fontWithName:@"GillSans-BoldItalic" size:18.0f]];
            CAGradientLayer *btnGradient12 = [CAGradientLayer layer];
            btnGradient12.frame = button.bounds;
            btnGradient12.colors = [NSArray arrayWithObjects:
                                    (id)[[UIColor colorWithRed:102.0f / 255.0f green:102.0f / 255.0f blue:102.0f / 255.0f alpha:1.0f] CGColor],
                                    (id)[[UIColor colorWithRed:51.0f / 255.0f green:51.0f / 255.0f blue:51.0f / 255.0f alpha:1.0f] CGColor],
                                    nil];
            [button.layer insertSublayer:btnGradient12 atIndex:0];
            [button addTarget:self action:@selector(matrixButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
            [easyMatrixView addSubview:button];
            
            width3 = width3 + 100;
        }
        
    }
    
} // MATRIX function

-(void)matrixButtonClicked:(id)sender
{
    
    UIButton *button = (UIButton *)sender;
    
    if (!([button.backgroundColor isEqual:[UIColor purpleColor]]))
    {
        
        buttonclick_count_in_a_row++;
        
        [button setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
        [button setAlpha:.8];
        [button setBackgroundColor:[UIColor purpleColor]];
        
        if (buttonclick_count_in_a_row==1)
        {
            clickedBtn1 = button;
            clickedBtn1.tag =(int) button.tag;
        }
        else if (buttonclick_count_in_a_row ==2)
        {
            clickedBtn2 = button;
            clickedBtn2.tag = (int)button.tag;
            
        }
        else if (buttonclick_count_in_a_row == 3)
        {
            clickedBtn3 = button;
            clickedBtn3.tag = (int)button.tag;
            
            if ((clickedBtn1.tag==clickedBtn2.tag) && (clickedBtn2.tag==clickedBtn3.tag))
            {
                countForNextStage++;
                NSLog(@"right ans");
                buttonclick_count_in_a_row = 0;
                
                clickedBtn1.userInteractionEnabled = NO;
                clickedBtn2.userInteractionEnabled = NO;
                clickedBtn3.userInteractionEnabled = NO;
                
                CGContextRef context1 = UIGraphicsGetCurrentContext();
                context1 = UIGraphicsGetCurrentContext();
                [UIView beginAnimations:nil context:context1];
                [UIView setAnimationDuration:0.75];
                [UIView setAnimationTransition:UIViewAnimationTransitionFlipFromRight forView:clickedBtn1 cache:YES];
                [UIView commitAnimations];
                
                CGContextRef context2 = UIGraphicsGetCurrentContext();
                context2 = UIGraphicsGetCurrentContext();
                [UIView beginAnimations:nil context:context2];
                [UIView setAnimationDuration:0.75];
                [UIView setAnimationTransition:UIViewAnimationTransitionFlipFromRight forView:clickedBtn2 cache:YES];
                [UIView commitAnimations];
                
                CGContextRef context3 = UIGraphicsGetCurrentContext();
                context3 = UIGraphicsGetCurrentContext();
                [UIView beginAnimations:nil context:context3];
                [UIView setAnimationDuration:0.75];
                [UIView setAnimationTransition:UIViewAnimationTransitionFlipFromRight forView:clickedBtn3 cache:YES];
                [UIView commitAnimations];
                
                [clickedBtn1 setImage:[UIImage imageNamed:@"righttick1.png"] forState:UIControlStateNormal];
                [clickedBtn2 setImage:[UIImage imageNamed:@"righttick1.png"] forState:UIControlStateNormal];
                [clickedBtn3 setImage:[UIImage imageNamed:@"righttick1.png"] forState:UIControlStateNormal];
                if (countForNextStage==3 && [levelString isEqualToString:@"EASY"])
                {
                    stage++;
                    stageZoomOut.text = [NSString stringWithFormat:@"%d",stage];
                    [stageZoomOut setHidden:NO];
                    [UIView beginAnimations:nil context:NULL];
                    [UIView setAnimationDuration:1];
                    [UIView setAnimationDelegate:self];
                    [UIView setAnimationDidStopSelector:@selector(zoomOutLabel)];
                    CGAffineTransform transform = CGAffineTransformMakeScale(1.5f, 1.5f);
                    stageZoomOut.transform = transform;
                    [UIView commitAnimations];
                    
                    
                }
                else if (countForNextStage==3 && [levelString isEqualToString:@"MEDIUM"])
                {
                    stage++;
                    if (stage == 6)
                    {
                        stage = 0;
                        levelString = @"HARD";
                        
                    }
                    countForNextStage =0;
                    level.text = [NSString stringWithFormat:@"%@ level : %d/5",levelString,stage];
                    [easyMatrixView removeFromSuperview];
                    [livesRemainingImage1 setHidden:NO];
                    [livesRemainingImage2 setHidden:NO];
                    livesremaining = 2;
                    [self matrixFunction];
                }
                else if (countForNextStage==4 && [levelString isEqualToString:@"HARD"])
                {
                    stage++;
                    if (stage == 6)
                    {
                        stage = 0;
                        UIAlertView *allLevelsCleared = [[UIAlertView alloc]initWithTitle:[NSString stringWithFormat:@"Superb %@",username.text] message:@"All Levels Cleared" delegate:self cancelButtonTitle:@"Home" otherButtonTitles:@"Play again", nil];
                        allLevelsCleared.tag = 1001;
                        [allLevelsCleared show];
                        
                    }
                    countForNextStage =0;
                    level.text = [NSString stringWithFormat:@"%@ level : %d/5",levelString,stage];
                    [easyMatrixView removeFromSuperview];
                    [livesRemainingImage1 setHidden:NO];
                    [livesRemainingImage2 setHidden:NO];
                    livesremaining = 2;
                    [self matrixFunction];
                }
                
            } // if right ans ends
            else
            {
                countForNextStage++;
                buttonclick_count_in_a_row = 0;
                NSLog(@"wrong ans");
                
                [clickedBtn1 setTitleColor:[UIColor greenColor] forState:UIControlStateNormal];
                [clickedBtn1 setAlpha:1];
                [clickedBtn1 setBackgroundColor:[UIColor blackColor]];
                [clickedBtn2 setTitleColor:[UIColor greenColor] forState:UIControlStateNormal];
                [clickedBtn2 setAlpha:1];
                [clickedBtn2 setBackgroundColor:[UIColor blackColor]];
                [clickedBtn3 setTitleColor:[UIColor greenColor] forState:UIControlStateNormal];
                [clickedBtn3 setAlpha:1];
                [clickedBtn3 setBackgroundColor:[UIColor blackColor]];
                
                CGContextRef context1 = UIGraphicsGetCurrentContext();
                context1 = UIGraphicsGetCurrentContext();
                [UIView beginAnimations:nil context:context1];
                [UIView setAnimationDuration:0.75];
                [UIView setAnimationTransition:UIViewAnimationTransitionFlipFromRight forView:clickedBtn1 cache:YES];
                [UIView commitAnimations];
                
                CGContextRef context2 = UIGraphicsGetCurrentContext();
                context2 = UIGraphicsGetCurrentContext();
                [UIView beginAnimations:nil context:context2];
                [UIView setAnimationDuration:0.75];
                [UIView setAnimationTransition:UIViewAnimationTransitionFlipFromRight forView:clickedBtn2 cache:YES];
                [UIView commitAnimations];
                
                CGContextRef context3 = UIGraphicsGetCurrentContext();
                context3 = UIGraphicsGetCurrentContext();
                [UIView beginAnimations:nil context:context3];
                [UIView setAnimationDuration:0.75];
                [UIView setAnimationTransition:UIViewAnimationTransitionFlipFromRight forView:clickedBtn3 cache:YES];
                [UIView commitAnimations];
                
                livesremaining--;
                [heartbroken setHidden:NO];
                [UIView beginAnimations:nil context:NULL];
                [UIView setAnimationDuration:1];
                [UIView setAnimationDelegate:self];
                [UIView setAnimationDidStopSelector:@selector(zoomOut)];
                CGAffineTransform transform = CGAffineTransformMakeScale(1.5f, 1.5f);
                heartbroken.transform = transform;
                [UIView commitAnimations];
                
            } // if wrong ans ends
            
        } // if click count is 3 ends
        
    }
    else
    {
        if (buttonclick_count_in_a_row==2)
        {
            if (sender == clickedBtn1)
            {
                clickedBtn1 = clickedBtn2;
                clickedBtn1.tag = clickedBtn2.tag;
                
            }
        }
        buttonclick_count_in_a_row--;
        
        [button setTitleColor:[UIColor greenColor] forState:UIControlStateNormal];
        [button setAlpha:1];
        [button setBackgroundColor:[UIColor blackColor]];
        
    }
    
    
}//matrixbuttonclikd

-(void)zoomOut
{
    
	[UIView beginAnimations:nil context:NULL];
	[UIView setAnimationDuration:1];
	[UIView setAnimationDelegate:self];
	CGAffineTransform transform = CGAffineTransformMakeScale(1.0f, 1.0f);
	heartbroken.transform = transform;
	[UIView commitAnimations];
    [heartbroken setHidden:YES];
    if (livesremaining==1)
    {
        [livesRemainingImage2 setHidden:YES];
    }
    else if (livesremaining==0)
    {
        countForNextStage = 0;
        [livesRemainingImage1 setHidden:YES];
        UIAlertView *tryAgainAlert = [[UIAlertView alloc]initWithTitle:@"Oops !!" message:@"Try Again" delegate:self cancelButtonTitle:@"Ok" otherButtonTitles: nil];
        tryAgainAlert.tag = 1000;
        [tryAgainAlert show];
        
    }
    
}

-(void)zoomOutLabel
{
    [UIView beginAnimations:nil context:NULL];
	[UIView setAnimationDuration:1];
	[UIView setAnimationDelegate:self];
	CGAffineTransform transform = CGAffineTransformMakeScale(1.0f, 1.0f);
	heartbroken.transform = transform;
	[UIView commitAnimations];
    if (stage == 6)
    {
        stage = 0;
        levelString = @"MEDIUM";
        
    }
    countForNextStage =0;
    level.text = [NSString stringWithFormat:@"%@ level : %d/5",levelString,stage];
    [easyMatrixView removeFromSuperview];
    [livesRemainingImage1 setHidden:NO];
    [livesRemainingImage2 setHidden:NO];
    livesremaining = 2;
    [self matrixFunction];
}

-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (alertView.tag ==1000) // tryAgain Alert
    {
        [easyMatrixView removeFromSuperview];
        [livesRemainingImage1 setHidden:NO];
        [livesRemainingImage2 setHidden:NO];
        livesremaining = 2;
        [self matrixFunction];
        
    }
    else if (alertView.tag == 1001) // allLevelsCleared Alert
    {
        if (buttonIndex == 0) //home button
        {
            [self.navigationController popToRootViewControllerAnimated:NO];
        }
        else //play again
        {
            stage = 0;
            levelString = @"HARD";
            countForNextStage =0;
            level.text = [NSString stringWithFormat:@"%@ level : %d/5",levelString,stage];
            [easyMatrixView removeFromSuperview];
            [livesRemainingImage1 setHidden:NO];
            [livesRemainingImage2 setHidden:NO];
            livesremaining = 2;
            [self matrixFunction];
        }
    }
    
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

