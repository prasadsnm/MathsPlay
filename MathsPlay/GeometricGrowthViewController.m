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
    UIView *modalForAnswerStatus;
    UILabel *answerStatusText;
    CAEmitterCell *emitterCell;
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
    
    
    
    
    
    //to adjust the navigation bar size in ios7
    if ([self respondsToSelector:@selector(edgesForExtendedLayout)])
        self.edgesForExtendedLayout = UIRectEdgeNone;
    
    correctAnswerCount=incorrectAnswerCount=0;
    self.view.backgroundColor=[UIColor blackColor];
    self.title=@"Find The Missing value ??";
    UIView *shadow=[[UIView alloc]initWithFrame:self.view.bounds];
    shadow.backgroundColor=[UIColor darkGrayColor];
    shadow.alpha=0.9 ;
    //info level for instruction.
    UILabel *infoLabel=nil;
    infoLabel=[[UILabel alloc]initWithFrame:CGRectMake(5, 350, shadow.frame.size.width, 100)];
    infoLabel.backgroundColor=[UIColor clearColor];
    infoLabel.text=@"Find the missing number in the series.. \n Enjoy!!";
    infoLabel.textColor=[UIColor whiteColor];
    infoLabel.font=[UIFont fontWithName:@"NoteWorthy" size:25];
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
    
    
    
    modalForAnswerStatus=[[UIView alloc]initWithFrame:CGRectMake(0, 0, 300, 200)];
    modalForAnswerStatus.tag=222;
    answerStatusText=[[UILabel alloc]initWithFrame:CGRectMake(0, 70, modalForAnswerStatus.frame.size.width, 50)];
    answerStatusText.textAlignment=NSTextAlignmentCenter;
    answerStatusText.numberOfLines=0;
    answerStatusText.textColor=[UIColor colorWithRed:230/255.0 green:230/255.0  blue:230/255.0  alpha:1];
    answerStatusText.font=[UIFont fontWithName:@"Futura" size:18];
    answerStatusText.backgroundColor=[UIColor clearColor];
    modalForAnswerStatus.center=CGPointMake(self.view.center.x-30, self.view.center.y+160);
    [modalForAnswerStatus addSubview:answerStatusText];
    
    modalForAnswerStatus.backgroundColor=[UIColor colorWithRed:57/255.0 green:57/255.0  blue:57/255.0  alpha:1];
    
    
    
    modalForAnswerStatus.layer.cornerRadius=30.0f;
    modalForAnswerStatus.layer.borderWidth=5.0;
    modalForAnswerStatus.layer.borderColor=[UIColor colorWithRed:204/255.0 green:204/255.0  blue:204/255.0  alpha:1].CGColor;
    [self.view addSubview:modalForAnswerStatus];
    modalForAnswerStatus.alpha=0;
}


-(void)startStopSnowingMethod:(UISwitch *)sender
{

    if (sender.isOn) {
        [self startEmmitter];

    }
    else
    {
        for (CALayer *layer in self.view.layer.sublayers) {
            if (layer.class == [CAEmitterLayer class]) {
                [layer removeFromSuperlayer];
                break;
            }

        
    
            }
        emitterCell.birthRate=0;

    }

}
-(void)startEmmitter
{
    CAEmitterLayer *emiterLayer=[CAEmitterLayer layer];
    emiterLayer.emitterPosition = CGPointMake(self.view.bounds.size.width/2,self.view.bounds.origin.y);
    emiterLayer.emitterZPosition=10;
    emiterLayer.emitterSize=CGSizeMake(self.view.bounds.size.width, 0);
    emiterLayer.emitterShape = kCAEmitterLayerSphere;
    if (emitterCell) {
        emitterCell=nil;
    }
    emitterCell = [CAEmitterCell emitterCell];
    emitterCell.scale = 0.3;
    emitterCell.scaleRange = 0.2;
    emitterCell.emissionRange = (CGFloat)M_PI;
    emitterCell.lifetime = 12.0;
    emitterCell.birthRate = 40;
    emitterCell.velocity = 10;
    emitterCell.velocityRange = 50;
    emitterCell.yAcceleration = 9.8;
    emitterCell.contents = (id)[[UIImage imageNamed:@"drop"] CGImage];
    emiterLayer.emitterCells = [NSArray arrayWithObject:emitterCell];
    [self.view.layer addSublayer:emiterLayer];

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
    timer.layer.borderWidth=5.0;
    timer.layer.borderColor=[UIColor grayColor].CGColor;
    timer.delegate=self;
    [self.view addSubview:timer];
    [timer start];
    [timer setMaxSecond:120];
    
    
    UISwitch *onOffSwtichForSnow=[[UISwitch alloc]initWithFrame:CGRectMake(600, 50, 50, 60)];
    onOffSwtichForSnow.tag=1010;
    [onOffSwtichForSnow addTarget:self action:@selector(startStopSnowingMethod:) forControlEvents:UIControlEventValueChanged];
    [self.view addSubview:onOffSwtichForSnow];
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
        if (view.tag!=111 && view.tag!=222 &&view.tag!=1010) {
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
    sender.userInteractionEnabled=NO;
    if (sender.tag==[answer integerValue]) {
        correctAnswerCount++;
        [UIView animateWithDuration:1.0 delay:0.0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
            modalForAnswerStatus.alpha=1;
            answerStatusText.text=@"Yippe !!\nCorrect Answer";
        } completion:^(BOOL finished) {
            sleep(0.5);
            modalForAnswerStatus.alpha=0;
            [self refreshQuestion];
            sender.userInteractionEnabled=YES;
            
            
        }];
    }
    else
    {
        incorrectAnswerCount++;
        [UIView animateWithDuration:1.0 delay:0.0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
            answerStatusText.text=@"Oops !!\nWrong Answer ";
            modalForAnswerStatus.alpha=1;
        } completion:^(BOOL finished) {
            sleep(0.5);
            modalForAnswerStatus.alpha=0;
            [self refreshQuestion];
            sender.userInteractionEnabled=YES;
            
        }];
    }
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
