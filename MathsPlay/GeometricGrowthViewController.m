//
//  GeometricGrowthViewController.m
//  KidsLearningGame
//
//  Created by qainfotech on 04/10/13.
//  Copyright (c) 2013 QAInfotech. All rights reserved.
//
#define OPTION_CIRCLE_COLOR [UIColor colorWithRed:64.0/255.0 green:172.0/255.0 blue:57.0/255.0 alpha:1.0]
#define BACKGROUND_COLOR [UIColor colorWithRed:195.0/255.0 green:0.0/255.0 blue:99.0/255.0 alpha:1.0]
#import "GeometricGrowthViewController.h"

@interface GeometricGrowthViewController ()
{
    NSString *answer;
    CountDownTimer *timer;
    int correctAnswerCount,incorrectAnswerCount;
    UIView *modalForAnswerStatus;
    UILabel *answerStatusText;
    CAEmitterCell *emitterCell;
    int direction;  //for shaking when answer is incorrect.
    int shakes;  //for shaking when answer is incorrect.
    UILabel *resultLabel;
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
    audioToolBox=[[CustomAudioToolBox alloc]init];
    SET_USERNAME_AS_TITLE
     self.navigationController.navigationBar.titleTextAttributes = @{UITextAttributeTextColor : [UIColor whiteColor]}; // to change the color of navigation bar title to white color.
     self.view.backgroundColor=BACKGROUND_COLOR;
    UIImageView *blackboard=[[UIImageView alloc]initWithFrame:CGRectMake(0, 0,self.view.frame.size.width, (self.view.frame.size.height/3)-30)];
    blackboard.tag=333;
    [blackboard setImage:[UIImage imageNamed:@"ResultBoard"]];
    resultLabel=nil;
    resultLabel=[[UILabel alloc]initWithFrame:CGRectMake(0, 0, blackboard.frame.size.width, blackboard.frame.size.height)];
    resultLabel.backgroundColor=[UIColor clearColor];
    resultLabel.textColor=[UIColor whiteColor];
    resultLabel.font=[UIFont fontWithName:@"Chalkduster" size:50];
    resultLabel.textAlignment=NSTextAlignmentCenter;
    resultLabel.numberOfLines=0;
    resultLabel.tag=444;
    resultLabel.text=@"Find the missing ball \nin the series?";
    [blackboard addSubview:resultLabel];
    [self.view addSubview:blackboard];

    
    //to adjust the navigation bar size in ios7
    if ([self respondsToSelector:@selector(edgesForExtendedLayout)])
        self.edgesForExtendedLayout = UIRectEdgeNone;
    correctAnswerCount=incorrectAnswerCount=0;

    UIView *shadow=[[UIView alloc]initWithFrame:self.view.bounds];
    shadow.backgroundColor=[[UIColor blackColor] colorWithAlphaComponent:.9];
    //info level for instruction.
    UILabel *infoLabel=nil;
    infoLabel=[[UILabel alloc]initWithFrame:CGRectMake(5, 350, shadow.frame.size.width, 100)];
    infoLabel.backgroundColor=[UIColor clearColor];
    infoLabel.text=@"Find the missing number in the series.. \n Enjoy!!";
    infoLabel.textColor=[UIColor whiteColor];
    infoLabel.font=[UIFont fontWithName:@"Lucida Grande" size:25];
    infoLabel.textAlignment=NSTextAlignmentCenter;
    infoLabel.numberOfLines=0;
    [shadow addSubview:infoLabel];
    [self startMethod];
    
    helpButton=[UIButton buttonWithType:UIButtonTypeCustom];
    [helpButton setImage:[UIImage imageNamed:@"rules"] forState:UIControlStateNormal];
    helpButton.tag=100011;
    [helpButton addTarget:self action:@selector(buttonActionMethod:) forControlEvents:UIControlEventTouchUpInside];
    helpButton.frame=CGRectMake(self.view.frame.size.width-160 , 10, 150, 80);
    helpButton.showsTouchWhenHighlighted=YES;
    [self.view addSubview:helpButton];
    
 }

-(void)buttonActionMethod:(UIButton *)sender
{
    [timer pause];
    MODAL_FOR_RULES;
    HEADER_TITLE;
    SPIRAL_VIEW;
    INSTRUCTION_LABEL_WITHOUT_TEXT;
    instructionLabel.text=@"a)Choose the missing number in the series(balls).\n\nb)Status of answer is shown in screen.\n\nc)Try as many question in given time, the result will be shown after time finishes.";
    FOOTER_TITLE;
}

-(void)handleTapOnModal:(UITapGestureRecognizer *)recognizer
{
    [timer resume];
    [self dismissModalViewControllerAnimated:YES];
}
-(void)startEmmitter
{
    CAEmitterLayer *emiterLayer=[CAEmitterLayer layer];
    emiterLayer.emitterPosition =self.view.center;
    //CGPointMake(self.view.bounds.size.width/2,self.view.bounds.origin.y);
    emiterLayer.emitterZPosition=10;
    emiterLayer.emitterSize=CGSizeMake(self.view.bounds.size.width, 0);
    emiterLayer.emitterShape = kCAEmitterLayerSphere;
    if (emitterCell) {
        emitterCell=nil;
    }
    emitterCell = [CAEmitterCell emitterCell];
    emitterCell.scale = 0.2;
    emitterCell.scaleRange = 0.4;
    emitterCell.birthRate = 15;
    emitterCell.emissionRange = (CGFloat)M_PI;
    emitterCell.lifetime = 8.0;
    emitterCell.velocity = 5;
    emitterCell.velocityRange = 150;
    emitterCell.yAcceleration = 9.8;
    emitterCell.contents = (id)[[UIImage imageNamed:@"spark"] CGImage];
    emiterLayer.emitterCells = [NSArray arrayWithObject:emitterCell];
    [self.view.layer addSublayer:emiterLayer];

}
-(void)startMethod
{
    [self performSelector:@selector(startEmmitter) withObject:nil afterDelay:2.0 ];
    [self refreshQuestion];
    timer=nil;
    timer=[[CountDownTimer alloc]initWithFrame:CGRectMake(625, 220, 120
                                                          , 44)];
    timer.tag=111;
    timer.backgroundColor=[UIColor clearColor];
    //timer.layer.cornerRadius=35.0;
    //timer.layer.borderWidth=5.0;
    //timer.layer.borderColor=[UIColor grayColor].CGColor;
    timer.delegate=self;
    
   [self.view addSubview:timer];
    [timer start];
    [timer setMaxSecond:60];
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
    int yValue=350;
    int width=100;
    int height=100;
   UIView *displayCard=[[UIView alloc]initWithFrame:CGRectMake(64, yValue,self.view.frame.size.width-30, 15)];
    for (int count=0; count<[arrayToDisplay count]; count++) {
        UILabel *label=[[UILabel alloc]initWithFrame:CGRectMake(xValue, 0, width, height)];
        label.tag=count+1;
        label.layer.cornerRadius=50.0;
        label.layer.borderWidth=1.0;
        
        label.backgroundColor=[UIColor colorWithRed:59/255.0 green:0/255.0 blue:133/255.0 alpha:1.0];
        label.font=[UIFont fontWithName:@"Marker Felt" size:30];
        label.textColor=[UIColor whiteColor];
        label.textAlignment=NSTextAlignmentCenter;
        label.text=[NSString stringWithFormat:@"%@",[arrayToDisplay objectAtIndex:count]];
        xValue=xValue+width+9;
        [displayCard addSubview:label];
    }
    int randomNumber=[self getRandomNumber:1 to:(long)[arrayToDisplay count]];
    UIView *viewToHide=[displayCard viewWithTag:randomNumber];
    if ([viewToHide isKindOfClass:[UILabel class]]) {
        UILabel *numberlabel=(UILabel *)viewToHide;
        answer= [numberlabel.text copy];
        numberlabel.text=@"?";
        firstOptionButton.layer.borderWidth=0.0;
        numberlabel.textColor=[UIColor whiteColor];
        numberlabel.backgroundColor=OPTION_CIRCLE_COLOR;
    }
    return displayCard;
}

-(void)refreshQuestion
{
    for (UIView *view in [self.view subviews]) {
        if (view.tag!=111 && view.tag!=222 &&view.tag!=1010 &&view.tag!=333 &&view.tag!=444 &&view.tag!=100011) {
            [view removeFromSuperview];
        }
    }
    NSArray *array=[self getPatternArray:[self getRandomNumber:1 to:5] operationCode:[self getRandomNumber:1 to:2]];
    UIView *circleContainerView=[self makeDisplayGrid:array];
    direction = 1;
    shakes = 0;
    [self.view addSubview:circleContainerView];
    [self shake:circleContainerView];
    [self showOptions:[self getShuffledArrayWithAnswer:answer]];
}



-(void)showOptions:(NSMutableArray *)arrayWithAnswer
{
    UILabel *firstOptionLabel=[[UILabel alloc]initWithFrame:CGRectMake(10, 500, 50, 50)];
    firstOptionLabel.text=@"a)";
    firstOptionLabel.textColor=[UIColor blackColor];
    firstOptionLabel.backgroundColor=[UIColor clearColor];
    firstOptionLabel.font=[UIFont fontWithName:@"Marker Felt" size:30];
    firstOptionLabel.textAlignment=NSTextAlignmentCenter;
    [self.view addSubview:firstOptionLabel];
    firstOptionButton=nil;
    firstOptionButton=[UIButton buttonWithType:UIButtonTypeCustom];
    firstOptionButton.frame=CGRectMake(60, 500, 100, 100);
    [firstOptionButton setTitle:[NSString stringWithFormat:@"%@",[arrayWithAnswer objectAtIndex:0]] forState:UIControlStateNormal];
    firstOptionButton.tag=[[arrayWithAnswer objectAtIndex:0] integerValue];
    [firstOptionButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [firstOptionButton setBackgroundColor:OPTION_CIRCLE_COLOR];
    firstOptionButton.titleLabel.font=[UIFont fontWithName:@"Marker Felt" size:30];
    firstOptionButton.showsTouchWhenHighlighted=YES;
    firstOptionButton.layer.cornerRadius=50.0;
    firstOptionButton.layer.borderWidth=1.0;
    firstOptionButton.layer.shadowColor=[UIColor blackColor].CGColor;
    [firstOptionButton addTarget:self action:@selector(optionChoosen:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:firstOptionButton];
    
    
    UILabel *secondOptionLabel=[[UILabel alloc]initWithFrame:CGRectMake(500, 500, 50, 50)];
    secondOptionLabel.text=@"b)";
    secondOptionLabel.textColor=[UIColor blackColor];

    secondOptionLabel.backgroundColor=[UIColor clearColor];
    secondOptionLabel.font=[UIFont fontWithName:@"Marker Felt" size:30];
    secondOptionLabel.textAlignment=NSTextAlignmentCenter;
    [self.view addSubview:secondOptionLabel];
    secondOptionButton=nil;
    secondOptionButton=[UIButton buttonWithType:UIButtonTypeCustom];
    secondOptionButton.frame=CGRectMake(560, 500, 100, 100);
    secondOptionButton.tag=[[arrayWithAnswer objectAtIndex:1] integerValue];
    [secondOptionButton setTitle:[NSString stringWithFormat:@"%@",[arrayWithAnswer objectAtIndex:1]] forState:UIControlStateNormal];
    [secondOptionButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [secondOptionButton setBackgroundColor:OPTION_CIRCLE_COLOR];
    secondOptionButton.titleLabel.font=[UIFont fontWithName:@"Marker Felt" size:30];
    secondOptionButton.showsTouchWhenHighlighted=YES;
    secondOptionButton.layer.cornerRadius=50.0;
    secondOptionButton.layer.borderWidth=1.0;
    secondOptionButton.layer.shadowColor=[UIColor blackColor].CGColor;
    [secondOptionButton addTarget:self action:@selector(optionChoosen:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:secondOptionButton];

    UILabel *thirdOptionLabel=[[UILabel alloc]initWithFrame:CGRectMake(10, 800, 50, 50)];
    thirdOptionLabel.text=@"c)";
    thirdOptionLabel.textColor=[UIColor blackColor];

    thirdOptionLabel.backgroundColor=[UIColor clearColor];
    thirdOptionLabel.font=[UIFont fontWithName:@"Marker Felt" size:30];
    thirdOptionLabel.textAlignment=NSTextAlignmentCenter;
    [self.view addSubview:thirdOptionLabel];
    thirdOptionButton=nil;
    thirdOptionButton=[UIButton buttonWithType:UIButtonTypeCustom];
    thirdOptionButton.frame=CGRectMake(60, 800, 100, 100);
    thirdOptionButton.tag=[[arrayWithAnswer objectAtIndex:2] integerValue];
    [thirdOptionButton setTitle:[NSString stringWithFormat:@"%@",[arrayWithAnswer objectAtIndex:2]] forState:UIControlStateNormal];
    [thirdOptionButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [thirdOptionButton setBackgroundColor:OPTION_CIRCLE_COLOR];
    thirdOptionButton.titleLabel.font=[UIFont fontWithName:@"Marker Felt" size:30];
    thirdOptionButton.showsTouchWhenHighlighted=YES;
    thirdOptionButton.layer.cornerRadius=50.0;
    thirdOptionButton.layer.borderWidth=1.0;
    thirdOptionButton.layer.shadowColor=[UIColor blackColor].CGColor;
    [thirdOptionButton addTarget:self action:@selector(optionChoosen:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:thirdOptionButton];

    UILabel *forthOptionLabel=[[UILabel alloc]initWithFrame:CGRectMake(500, 800, 50, 50)];
    forthOptionLabel.text=@"d)";
    forthOptionLabel.textColor=[UIColor blackColor];
    forthOptionLabel.backgroundColor=[UIColor clearColor];
    forthOptionLabel.font=[UIFont fontWithName:@"Marker Felt" size:30];
    forthOptionLabel.textAlignment=NSTextAlignmentCenter;
    [self.view addSubview:forthOptionLabel];
    fourthOptionButton=nil;
    fourthOptionButton=[UIButton buttonWithType:UIButtonTypeCustom];
    fourthOptionButton.frame=CGRectMake(560, 800, 100, 100);
    fourthOptionButton.tag=[[arrayWithAnswer objectAtIndex:3] integerValue];
    [fourthOptionButton setTitle:[NSString stringWithFormat:@"%@",[arrayWithAnswer objectAtIndex:3]] forState:UIControlStateNormal];
    [fourthOptionButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [fourthOptionButton setBackgroundColor:OPTION_CIRCLE_COLOR];
    fourthOptionButton.titleLabel.font=[UIFont fontWithName:@"Marker Felt" size:30];
    fourthOptionButton.showsTouchWhenHighlighted=YES;
    fourthOptionButton.layer.cornerRadius=50.0;
    fourthOptionButton.layer.borderWidth=1.0;
    fourthOptionButton.layer.shadowColor=[UIColor blackColor].CGColor;
    [fourthOptionButton addTarget:self action:@selector(optionChoosen:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:fourthOptionButton];

}


- (void)centerButtonAnimation:(UILabel *)buttonToAnimate{
    CAKeyframeAnimation *centerZoom = [CAKeyframeAnimation animationWithKeyPath:@"transform"];
    centerZoom.duration = 1.0f;
    centerZoom.values = @[[NSValue valueWithCATransform3D:CATransform3DMakeScale(1, 1, 1)],[NSValue valueWithCATransform3D:CATransform3DMakeScale(1.5, 1.5, 1)],[NSValue valueWithCATransform3D:CATransform3DMakeScale(1, 1, 1)],[NSValue valueWithCATransform3D:CATransform3DMakeScale(1.2, 1.2, 1)],[NSValue valueWithCATransform3D:CATransform3DMakeScale(1, 1, 1)]];
    centerZoom.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionLinear];
    [buttonToAnimate.layer addAnimation:centerZoom forKey:@"buttonScale"];
}

-(void)shake:(UIView *)theButtonToShake
{
    [UIView animateWithDuration:0.1 animations:^
     {
         theButtonToShake.transform = CGAffineTransformMakeTranslation(50*direction, 0);
     }
                     completion:^(BOOL finished)
     {
         if(shakes >= 10)
         {
             theButtonToShake.transform = CGAffineTransformIdentity;
             return;
         }
         shakes++;
         direction = direction * -1;
         [self shake:theButtonToShake];
     }];
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
                    [audioToolBox playSound:@"correct" withExtension:@"mp3"];
                    correctAnswerCount++;
                    [resultLabel setText:@"Correct !!"];
                    [UIView animateWithDuration:1.0 delay:0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
                        [self centerButtonAnimation:resultLabel];
                    } completion:^(BOOL finished) {
                        sleep(0.7);
                        [self refreshQuestion];
                    }];
                }
                else
                {
                    
                    incorrectAnswerCount++;
                    [audioToolBox playSound:@"wrong" withExtension:@"mp3"];

                    [resultLabel setText:@"Wrong !!"];

                    [UIView animateWithDuration:1.0 delay:0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
                        [self centerButtonAnimation:resultLabel];

                    } completion:^(BOOL finished) {
                        sleep(0.7);
                        [self refreshQuestion];
                    }];
                    
                }
 
}

#pragma CountDownTimer-DELEGATE

-(void)TimeUp
{
    [audioToolBox playSound:@"award" withExtension:@"mp3"];
    [resultLabel setText:[NSString stringWithFormat:@"Game Over!! \n %i Correct out of %i attempted",correctAnswerCount,correctAnswerCount+incorrectAnswerCount]];
    [firstOptionButton setUserInteractionEnabled:NO];
    [secondOptionButton setUserInteractionEnabled:NO];
    [thirdOptionButton setUserInteractionEnabled:NO];
    [fourthOptionButton setUserInteractionEnabled:NO];
}

-(void)viewWillDisappear:(BOOL)animated
{
    [timer stop];
}




- (void)viewDidUnload {
    [audioToolBox dispose];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
