//
//  GeometricGrowthViewController.m
//  KidsLearningGame
//
//  Created by qainfotech on 04/10/13.
//  Copyright (c) 2013 QAInfotech. All rights reserved.
//

#import "GeometricGrowthViewController.h"

@interface GeometricGrowthViewController ()
{
    NSString *answer;
    CountDownTimer *timer;
    int correctAnswerCount,incorrectAnswerCount;
}
@end

@implementation GeometricGrowthViewController

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
    
    correctAnswerCount=incorrectAnswerCount=0;
    self.view.backgroundColor=[UIColor lightGrayColor];
    self.title=@"Find The Missing value ??";
    
    UIView *shadow=[[UIView alloc]initWithFrame:self.view.bounds];
    shadow.backgroundColor=[UIColor darkGrayColor];
    shadow.alpha=0.9 ;
    
    // ant preview on dim preview.
    //    UIImageView  *antPreview=nil;
    //    antPreview=[[UIImageView alloc]initWithFrame:CGRectMake(350,300, 50, 50)];
    //    antPreview.image=[UIImage imageNamed:@"ant_black"];
    //    [shadow addSubview:antPreview];
    
    
    
    //info level for instruction.
    UILabel *infoLabel=nil;
    infoLabel=[[UILabel alloc]initWithFrame:CGRectMake(5, 350, shadow.frame.size.width, 100)];
    infoLabel.backgroundColor=[UIColor clearColor];
    infoLabel.text=@"Find the missing number in the series.. \n Enjoy!!";
    
    infoLabel.textColor=[UIColor whiteColor];
    infoLabel.font=[UIFont fontWithName:@"NoteWorthy" size:25];
    // infoLabel.font=[UIFont fontWithName:@"digital-7" size:25];
    
    infoLabel.textAlignment=NSTextAlignmentCenter;
    infoLabel.numberOfLines=0;
    [shadow addSubview:infoLabel];
    
    
    UIButton *letsPlaybutton=[UIButton buttonWithType:UIButtonTypeCustom];
    letsPlaybutton.frame=CGRectMake(0, 0, 90, 60) ;
    letsPlaybutton.center=shadow.center;
    letsPlaybutton.backgroundColor=[UIColor clearColor];
    letsPlaybutton.layer.cornerRadius=10.0;
    letsPlaybutton.layer.borderWidth=5.0;
    letsPlaybutton.layer.borderColor=[UIColor whiteColor].CGColor;
    letsPlaybutton.showsTouchWhenHighlighted=YES;
    [letsPlaybutton setTitle:@"Lets Play" forState:UIControlStateNormal];
    [letsPlaybutton addTarget:self action:@selector(startMethod) forControlEvents:UIControlEventTouchUpInside];
    [shadow addSubview:letsPlaybutton];
    
    [self.view addSubview:shadow];
    
    
}

-(void)startMethod
{
    [self refreshQuestion];
    timer=nil;
    timer=[[CountDownTimer alloc]initWithFrame:CGRectMake(250, 50, 300
                                                          , 100)];
    timer.tag=111;
    timer.backgroundColor=[UIColor blackColor];
    timer.layer.cornerRadius=35.0;
    timer.delegate=self;
    [self.view addSubview:timer];
    [timer start];
    [timer setMaxSecond:600];
    
}



//method to generate pattern
//opCode= 1-->square
//opcode= 2-->constant multiplication
-(NSArray *)getPatternArray:(double)baseNumber operationCode:(int)opCode
{
    NSMutableArray *temp=[[NSMutableArray alloc]initWithCapacity:0];
    
    switch (opCode)
    {
        case 1:
            [temp removeAllObjects];
            if (baseNumber==1) {
                baseNumber++;
            }
            for (int index=0; index<6; index++){
                [temp addObject:[NSNumber numberWithInt: powf(baseNumber, index)]];
            }
            break;
            
        case 2:
            [temp removeAllObjects];
            double local=baseNumber;
            int randomConstant=[self getRandomNumber:2 to:7];
            for (int index=0; index<6; index++){
                [temp addObject:[NSNumber numberWithInt:local]];
                local=local*randomConstant;
            }
            break;
            
    }
    
    return temp;
    
}


- (int)getRandomNumber:(int)from to:(int)to
{
    return (int)from + arc4random() % (to-from+1);
}





-(UIView *)makeDisplayGrid :(NSArray *)arrayToDisplay
{
    int xValue=1;
    int yValue=300;
    int width=120;
    int height=100;
    
    UIView *displayCard=[[UIView alloc]initWithFrame:CGRectMake(10, yValue,self.view.frame.size.width-30, height)];
    
    displayCard.layer.cornerRadius=5.0;
    displayCard.layer.borderWidth=1.0;
    displayCard.layer.shadowColor=[UIColor blackColor].CGColor;
    // displayCard.layer.borderColor=[UIColor blackColor].CGColor;
    
    
    
    for (int count=0; count<[arrayToDisplay count]; count++) {
        UILabel *label=[[UILabel alloc]initWithFrame:CGRectMake(xValue, 0, width, height)];
        label.tag=count+1;
        label.backgroundColor=[UIColor colorWithRed:126/255.0 green:188/255.0 blue:74/255.0 alpha:1.0];
        label.font=[UIFont fontWithName:@"Marker Felt" size:30];
        label.textAlignment=NSTextAlignmentCenter;
        
        
        
        label.text=[NSString stringWithFormat:@"%@",[arrayToDisplay objectAtIndex:count]];
        xValue=xValue+width+3;
        [displayCard addSubview:label];
        
    }
    
    int randomNumber=[self getRandomNumber:1 to:[arrayToDisplay count]];
    UIView *viewToHide=[displayCard viewWithTag:randomNumber];
    
    if ([viewToHide isKindOfClass:[UILabel class]]) {
        UILabel *numberlabel=(UILabel *)viewToHide;
        answer= [numberlabel.text copy];
        numberlabel.text=@"?";
    }
    return displayCard;
    
    
    
}

-(void)refreshQuestion
{
    for (UIView *view in [self.view subviews]) {
        if (view.tag!=111) {
            [view removeFromSuperview];
            
        }
    }
    NSArray *array=[self getPatternArray:[self getRandomNumber:1 to:5] operationCode:[self getRandomNumber:1 to:2]];
    [self.view addSubview:[self makeDisplayGrid:array]];
    [self showOptions:[self getShuffledArrayWithAnswer:answer]];
}



-(void)showOptions:(NSMutableArray *)arrayWithAnswer
{
    
    UILabel *firstOptionLabel=[[UILabel alloc]initWithFrame:CGRectMake(10, 500, 50, 50)];
    firstOptionLabel.text=@"a)";
    firstOptionLabel.backgroundColor=[UIColor clearColor];
    firstOptionLabel.font=[UIFont fontWithName:@"Marker Felt" size:30];
    firstOptionLabel.textAlignment=NSTextAlignmentCenter;
    [self.view addSubview:firstOptionLabel];
    
    firstOptionButton=nil;
    firstOptionButton=[UIButton buttonWithType:UIButtonTypeCustom];
    firstOptionButton.frame=CGRectMake(60, 500, 120, 100);
    [firstOptionButton setTitle:[NSString stringWithFormat:@"%@",[arrayWithAnswer objectAtIndex:0]] forState:UIControlStateNormal];
    firstOptionButton.tag=[[arrayWithAnswer objectAtIndex:0] integerValue];
    [firstOptionButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [firstOptionButton setBackgroundColor:[UIColor colorWithRed:126/255.0 green:188/255.0 blue:74/255.0 alpha:1.0]];
    firstOptionButton.titleLabel.font=[UIFont fontWithName:@"Marker Felt" size:30];
    firstOptionButton.showsTouchWhenHighlighted=YES;
    firstOptionButton.layer.cornerRadius=5.0;
    firstOptionButton.layer.borderWidth=1.0;
    firstOptionButton.layer.shadowColor=[UIColor blackColor].CGColor;
    [firstOptionButton addTarget:self action:@selector(optionChoosen:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:firstOptionButton];
    
    
    
    
    UILabel *secondOptionLabel=[[UILabel alloc]initWithFrame:CGRectMake(500, 500, 50, 50)];
    secondOptionLabel.text=@"b)";
    secondOptionLabel.backgroundColor=[UIColor clearColor];
    secondOptionLabel.font=[UIFont fontWithName:@"Marker Felt" size:30];
    secondOptionLabel.textAlignment=NSTextAlignmentCenter;
    [self.view addSubview:secondOptionLabel];
    
    secondOptionButton=nil;
    secondOptionButton=[UIButton buttonWithType:UIButtonTypeCustom];
    secondOptionButton.frame=CGRectMake(560, 500, 120, 100);
    secondOptionButton.tag=[[arrayWithAnswer objectAtIndex:1] integerValue];
    [secondOptionButton setTitle:[NSString stringWithFormat:@"%@",[arrayWithAnswer objectAtIndex:1]] forState:UIControlStateNormal];
    [secondOptionButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [secondOptionButton setBackgroundColor:[UIColor colorWithRed:126/255.0 green:188/255.0 blue:74/255.0 alpha:1.0]];
    secondOptionButton.titleLabel.font=[UIFont fontWithName:@"Marker Felt" size:30];
    secondOptionButton.showsTouchWhenHighlighted=YES;
    secondOptionButton.layer.cornerRadius=5.0;
    secondOptionButton.layer.borderWidth=1.0;
    secondOptionButton.layer.shadowColor=[UIColor blackColor].CGColor;
    [secondOptionButton addTarget:self action:@selector(optionChoosen:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:secondOptionButton];
    
    
    
    UILabel *thirdOptionLabel=[[UILabel alloc]initWithFrame:CGRectMake(10, 800, 50, 50)];
    thirdOptionLabel.text=@"c)";
    thirdOptionLabel.backgroundColor=[UIColor clearColor];
    thirdOptionLabel.font=[UIFont fontWithName:@"Marker Felt" size:30];
    thirdOptionLabel.textAlignment=NSTextAlignmentCenter;
    [self.view addSubview:thirdOptionLabel];
    
    thirdOptionButton=nil;
    thirdOptionButton=[UIButton buttonWithType:UIButtonTypeCustom];
    thirdOptionButton.frame=CGRectMake(60, 800, 120, 100);
    thirdOptionButton.tag=[[arrayWithAnswer objectAtIndex:2] integerValue];
    
    [thirdOptionButton setTitle:[NSString stringWithFormat:@"%@",[arrayWithAnswer objectAtIndex:2]] forState:UIControlStateNormal];
    [thirdOptionButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [thirdOptionButton setBackgroundColor:[UIColor colorWithRed:126/255.0 green:188/255.0 blue:74/255.0 alpha:1.0]];
    thirdOptionButton.titleLabel.font=[UIFont fontWithName:@"Marker Felt" size:30];
    thirdOptionButton.showsTouchWhenHighlighted=YES;
    thirdOptionButton.layer.cornerRadius=5.0;
    thirdOptionButton.layer.borderWidth=1.0;
    thirdOptionButton.layer.shadowColor=[UIColor blackColor].CGColor;
    [thirdOptionButton addTarget:self action:@selector(optionChoosen:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:thirdOptionButton];
    
    
    UILabel *forthOptionLabel=[[UILabel alloc]initWithFrame:CGRectMake(500, 800, 50, 50)];
    forthOptionLabel.text=@"d)";
    forthOptionLabel.backgroundColor=[UIColor clearColor];
    forthOptionLabel.font=[UIFont fontWithName:@"Marker Felt" size:30];
    forthOptionLabel.textAlignment=NSTextAlignmentCenter;
    [self.view addSubview:forthOptionLabel];
    
    forthOptionButton=nil;
    forthOptionButton=[UIButton buttonWithType:UIButtonTypeCustom];
    forthOptionButton.frame=CGRectMake(560, 800, 120, 100);
    forthOptionButton.tag=[[arrayWithAnswer objectAtIndex:3] integerValue];
    
    [forthOptionButton setTitle:[NSString stringWithFormat:@"%@",[arrayWithAnswer objectAtIndex:3]] forState:UIControlStateNormal];
    [forthOptionButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [forthOptionButton setBackgroundColor:[UIColor colorWithRed:126/255.0 green:188/255.0 blue:74/255.0 alpha:1.0]];
    forthOptionButton.titleLabel.font=[UIFont fontWithName:@"Marker Felt" size:30];
    forthOptionButton.showsTouchWhenHighlighted=YES;
    forthOptionButton.layer.cornerRadius=5.0;
    forthOptionButton.layer.borderWidth=1.0;
    forthOptionButton.layer.shadowColor=[UIColor blackColor].CGColor;
    [forthOptionButton addTarget:self action:@selector(optionChoosen:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:forthOptionButton];
}


-(NSMutableArray *)getShuffledArrayWithAnswer:(NSString *)correctAnswer
{
    int localTemp=[correctAnswer integerValue];
    NSMutableArray *tempArray=[[NSMutableArray alloc]initWithCapacity:0];
    [tempArray addObject:[NSNumber numberWithInt:localTemp]];
    [tempArray addObject:[NSNumber numberWithInt:abs(localTemp-[self getRandomNumber:1 to:100])]];
    [tempArray addObject:[NSNumber numberWithInt:localTemp+[self getRandomNumber:1 to:100]]];
    [tempArray addObject:[NSNumber numberWithInt:localTemp+[self getRandomNumber:1 to:100]]];
    
    NSSet *uniqueTempArray=[NSSet setWithArray:tempArray];
    
    //check to avoid repeating option generated randomly..
    if (uniqueTempArray.count<tempArray.count) {
        [tempArray removeAllObjects];
        [tempArray addObject:[NSNumber numberWithInt:localTemp]];
        [tempArray addObject:[NSNumber numberWithInt:abs(localTemp-[self getRandomNumber:1 to:100])]];
        [tempArray addObject:[NSNumber numberWithInt:localTemp+[self getRandomNumber:101 to:150]]];
        [tempArray addObject:[NSNumber numberWithInt:localTemp+[self getRandomNumber:151 to:200]]];
    }
    
    
    for (int x = 0; x < [tempArray count]; x++) {
        int randInt = (arc4random() % ([tempArray count] - x)) + x;
        [tempArray exchangeObjectAtIndex:x withObjectAtIndex:randInt];
    }
    return tempArray;
}


-(void)optionChoosen:(UIButton *)sender
{
    if (sender.tag==[answer integerValue]) {
        correctAnswerCount++;
    }
    else
    {
        incorrectAnswerCount++;
    }
    [self refreshQuestion];
}

#pragma CountDownTimer-DELEGATE

-(void)TimeUp
{
    
    int totalScore=(correctAnswerCount-(incorrectAnswerCount*0.25));
    UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"Result !!" message:[NSString stringWithFormat:@"%i Correct out of %i attempted",totalScore,correctAnswerCount+incorrectAnswerCount] delegate:nil cancelButtonTitle:@"ok" otherButtonTitles:nil, nil];
    [alert show];
    
    [self.navigationController popViewControllerAnimated:YES];
    [firstOptionButton setUserInteractionEnabled:NO];
    [secondOptionButton setUserInteractionEnabled:NO];
    [thirdOptionButton setUserInteractionEnabled:NO];
    [forthOptionButton setUserInteractionEnabled:NO];
    
    
}

-(void)viewWillDisappear:(BOOL)animated
{
    [timer stop];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
