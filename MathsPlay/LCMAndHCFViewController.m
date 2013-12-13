//
//  LCMAndHCFViewController.m
//  KidsLearningGame
//
//  Created by qainfotech on 09/10/13.
//  Copyright (c) 2013 QAInfotech. All rights reserved.
//

#import "LCMAndHCFViewController.h"
#define BACKGROUND_COLOR [UIColor colorWithRed:85/255.0 green:192/255.0 blue:247/255.0 alpha:1]
#define Y_AXIS_VALUE 300
#define ANSWER_LOCK @"THE_LOCK"


@interface LCMAndHCFViewController ()
{
    NSArray *optionArray;
    int selectedIndex;
    int selectedAnswer;
    UIImageView *tanker;
    BOOL isALligned;
    int currentHighlightedTag;
    int correctAnswerLabelTag;
    int scoreCount;
    
    UIViewController *modal;

}
@property(nonatomic,assign) CGPoint targetCenter;

@end

@implementation LCMAndHCFViewController
@synthesize targetCenter=_targetCenter;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    
    modal=[[UIViewController alloc]init];
    modal.view.backgroundColor=[UIColor yellowColor];
    modal.modalTransitionStyle=UIModalTransitionStyleCrossDissolve;
    modal.modalPresentationStyle=UIModalPresentationFormSheet;
    
    UILabel *resultLabel=nil;
    resultLabel=[[UILabel alloc]initWithFrame:CGRectMake(140, 200, 300, 200)];
    resultLabel.backgroundColor=[UIColor clearColor];
    resultLabel.text=[NSString stringWithFormat:@"Game Over\n \nScore : %d",scoreCount+1];
    resultLabel.textColor=[UIColor blackColor];
    resultLabel.font=[UIFont fontWithName:@"Chalkduster" size:40];
    resultLabel.textAlignment=NSTextAlignmentCenter;
    resultLabel.numberOfLines=0;
    [modal.view addSubview:resultLabel];
        audioToolBox=[[CustomAudioToolBox alloc]init];
    currentHighlightedTag=12345;
    correctAnswerLabelTag=12346;
    self.view.tag=1111;
    SET_USERNAME_AS_TITLE
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
    
    
    selectedAnswer=0;
    self.view.backgroundColor=BACKGROUND_COLOR;
    
    questionLabel=nil;
    questionLabel=[[UILabel alloc]initWithFrame:CGRectMake(84, 50, 600, 200)];
    questionLabel.tag=1010;
    questionLabel.backgroundColor=[UIColor clearColor];
    questionLabel.numberOfLines=0;
    questionLabel.textAlignment=NSTextAlignmentCenter;
    questionLabel.font = FONT;
    [self.view addSubview:questionLabel];
    //[self refreshQuestion];
    
    tanker=nil;
    tanker=[[UIImageView alloc]initWithFrame:CGRectMake(self.view.frame.size.width/3, self.view.frame.size.height-200, 200, 100)];
    tanker.image=[UIImage imageNamed:@"fighter"];
    tanker.userInteractionEnabled=YES;
    tanker.tag=1007;
    [self.view addSubview:tanker];
    _targetCenter=CGPointMake(tanker.center.x, 0);
    
    
    
    
    panGestureRecognizer=[[UIPanGestureRecognizer alloc]initWithTarget:self action:@selector(handlePan:)];
    [tanker addGestureRecognizer:panGestureRecognizer];
    
    tapGestureRecognizer=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(handleTap:)];
    tapGestureRecognizer.numberOfTapsRequired=1;
    [tanker addGestureRecognizer:tapGestureRecognizer];

    [self start];
    [self startEmmitter];
    
    
   
    
    
    
}


- (void) dismissInstructionScreen:(UITapGestureRecognizer *)recognize
{
    [recognize.view removeFromSuperview];
}

-(void)refreshGiftWithCount:(int)count
{
    for (Goodies *gift in self.view.subviews) {
        if ([gift isKindOfClass:[Goodies class]] && gift.tag==5555) {
            [gift removeFromSuperview];
        }
    }
    
    goodies=[[Goodies alloc]initWithFrame:CGRectZero Count:count giftimage:@"gift-box"];
    goodies.tag=5555;
    [self.view addSubview:goodies];
}


-(void)start
{
    [self makeDisplayGrid];
}



-(void)submitMethod
{
    if (selectedIndex<4) {
        if (isCorrect) {
            UIAlertView *gameOver = [[UIAlertView alloc]initWithTitle:@"Correct !!" message:@"Your Answer is Correct" delegate:self cancelButtonTitle:@"ok" otherButtonTitles:nil, nil];
            [gameOver show];
            
        }
        else
        {
            UIAlertView *gameOver = [[UIAlertView alloc]initWithTitle:@"Wrong" message:@"Your Answer is inCorrect" delegate:self cancelButtonTitle:@"ok" otherButtonTitles:nil, nil];
            [gameOver show];
            
        }
        [self refreshQuestion];
    }
    else
    {
        UIAlertView *gameOver = [[UIAlertView alloc]initWithTitle:@"Error" message:@"Please Select at least one Option" delegate:self cancelButtonTitle:@"ok" otherButtonTitles:nil, nil];
        [gameOver show];
    }
}



// The cell that is returned must be retrieved from a call to -dequeueReusableCellWithReuseIdentifier:forIndexPath:

- (int)getRandomNumber:(int)from to:(int)to
{
    return (int)from + arc4random() % (to-from+1);
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark Fresh Question

-(NSArray *)refreshQuestion
{
    int firstRandom=[self getRandomNumber:1 to:10];
    int secondRandom=[self getRandomNumber:1 to:10];
    answer=0;
    
    if (([self getRandomNumber:1 to:8]%2)==0) {
        
        questionLabel.text=[NSString stringWithFormat:@"The LCM of %i and %i ?",firstRandom,secondRandom];
        @synchronized(ANSWER_LOCK){
            answer=lcm(firstRandom, secondRandom);
        }
    }
    else
    {
        questionLabel.text=[NSString stringWithFormat:@"The HCF of %i and %i ?",firstRandom,secondRandom];
        @synchronized(ANSWER_LOCK){
            answer=gcd(firstRandom, secondRandom);
        }
    }
    optionArray=nil;
    optionArray=[[NSArray alloc]initWithArray:[self getShuffledArrayWithAnswer:[NSString stringWithFormat:@"%d",answer]]];
    return optionArray;
}



#pragma mark LOGICS in c
int gcd(int a, int b)
{
    for (;;)
    {
        if (a == 0) return b;
        b %= a;
        if (b == 0) return a;
        a %= b;
    }
}

int lcm(int a, int b)
{
    int temp = gcd(a, b);
    
    return temp ? (a / temp * b) : 0;
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


#pragma mark Diplay options

-(void)makeDisplayGrid
{
    NSArray *arrayWithResult=[self refreshQuestion];
    // 4444 for missile
    for (UIView *view in [self.view subviews]) {
       if ([view isKindOfClass:[UIImageView class]]&& view.tag==4444) {
          [view removeFromSuperview];
       }
        
        if (view.tag==1 && view.tag==2 &&view.tag==3 &&view.tag==4)  {
            [view removeFromSuperview];
        }
    }
    int xValue=114;
    int yValue=300;
    int width=100;
    int height=100;
    
    for (int count=0; count<[arrayWithResult count]; count++) {
        UILabel *label=[[UILabel alloc]initWithFrame:CGRectMake(xValue, yValue, width, height)];
        label.tag=count+1;
        label.layer.cornerRadius=50.0;
        label.layer.borderWidth=1.0;
        
        label.backgroundColor=[UIColor colorWithRed:59/255.0 green:0/255.0 blue:133/255.0 alpha:1.0];
        label.font=[UIFont fontWithName:@"Marker Felt" size:30];
        label.textColor=[UIColor whiteColor];
        label.textAlignment=NSTextAlignmentCenter;
        label.text=[NSString stringWithFormat:@"%@",[arrayWithResult objectAtIndex:count]];
        if ([[arrayWithResult objectAtIndex:count] intValue]==answer) {
                    correctAnswerLabelTag=label.tag;
        }
        xValue=xValue+width+50;
        [self.view addSubview:label];
    }
  //  [NSTimer scheduledTimerWithTimeInterval:5 target:self selector:@selector(refreshDisplayGrid) userInfo:nil repeats:YES];

}



-(void)refreshDisplayGrid
{
    
    for (UIView *view in [self.view subviews]) {
        if ([view isKindOfClass:[UIImageView class]]&& view.tag==4444) {
            [view removeFromSuperview];
        }}
    
    NSArray *arrayWithResult=[self refreshQuestion];
    int index=0;
    for (UILabel *options  in self.view.subviews) {
        if ([options isKindOfClass:[UILabel class]] && options.tag>0 && options.tag<5 ) {  //instropection
            
            if ([[arrayWithResult objectAtIndex:index] intValue]==answer) {
                correctAnswerLabelTag=options.tag;
            }
            [options setText:[NSString stringWithFormat:@"%@",[arrayWithResult objectAtIndex:index++]]];
        }
    }

}


-(void) dragTank : (UIImageView *) sender {
    
    sender.center=[tapGestureRecognizer locationInView:self.view];
}


- (void)handlePan:(UIPanGestureRecognizer *)recognizer {
    [self handleMovementView:recognizer];
    
    
    for (UIView *optionLabel in self.view.subviews)
    {
        if ([optionLabel isKindOfClass:[UILabel class]]&& optionLabel.tag>0 && optionLabel.tag<5) {
            if (recognizer.view.center.x >= optionLabel.center.x-49 && recognizer.view.center.x <= optionLabel.center.x+49 )
            {
                _targetCenter=CGPointMake(recognizer.view.center.x, optionLabel.center.y);
                [optionLabel setBackgroundColor:[UIColor redColor]];
                currentHighlightedTag=optionLabel.tag;
                break;
            }
            else
            {
                [optionLabel setBackgroundColor:[UIColor colorWithRed:59/255.0 green:0/255.0 blue:133/255.0 alpha:1.0]];
                currentHighlightedTag=12345;
            }
        }
        else
        {
            _targetCenter=CGPointMake(recognizer.view.center.x, 0);
        }
    }
}


-(void)handleMovementView:(UIPanGestureRecognizer *)recognizer
{
    CGPoint movement;
    
    if(recognizer.state == UIGestureRecognizerStateBegan || recognizer.state == UIGestureRecognizerStateChanged || recognizer.state == UIGestureRecognizerStateEnded)
    {
        CGRect rec = recognizer.view.frame;
        CGRect imgvw = tanker.frame;
        if((rec.origin.x >= imgvw.origin.x && (rec.origin.x + rec.size.width <= imgvw.origin.x + imgvw.size.width)))
        {
            CGPoint translation = [recognizer translationInView:recognizer.view.superview];
            movement = translation;
            recognizer.view.center = CGPointMake(recognizer.view.center.x + translation.x, recognizer.view.center.y + translation.y);
            rec = recognizer.view.frame;
            
            
            if (rec.origin.x<self.view.frame.origin.x+20)
                rec.origin.x = imgvw.origin.x;
            
            
            if (rec.origin.x>self.view.frame.size.width-200)
                rec.origin.x = self.view.frame.size.width-200;
            
            
            if( rec.origin.y < imgvw.origin.y )
                rec.origin.y = imgvw.origin.y;
            
            if( rec.origin.y + rec.size.width > imgvw.origin.y + imgvw.size.width )
                rec.origin.y = imgvw.origin.y + imgvw.size.width - rec.size.width;
            
            recognizer.view.frame = rec;
            [recognizer setTranslation:CGPointZero inView:recognizer.view.superview];
        }
    }
    
}
- (void)handleTap:(UITapGestureRecognizer *)recognizer {
    recognizer.enabled=NO;
    recognizer.view.transform = CGAffineTransformIdentity;
    [UIView animateWithDuration:0.1 delay:0 options:UIViewAnimationOptionCurveEaseOut animations:^{
        recognizer.view.transform = CGAffineTransformMakeTranslation(0,+10);
    } completion:^(BOOL finished){
        recognizer.view.transform = CGAffineTransformMakeTranslation(0,-10);
    }];
    
    UIImage *lazerImage = [UIImage imageNamed:@"missile"];
    __block UIImageView *lazerImageView = [[UIImageView alloc] initWithImage:lazerImage];
    lazerImageView.tag=4444;
    [lazerImageView setFrame:CGRectMake(0, 0, 20, 20)];
    [lazerImageView setCenter:recognizer.view.center];
    [self.view addSubview:lazerImageView];
    
    
    [UIView animateWithDuration:0.2 delay:0 options:UIViewAnimationOptionCurveEaseOut animations:^{
        
        [lazerImageView setCenter:_targetCenter];
        
        // [lazerImageView setCenter:_targetCenter];
        [audioToolBox playSound:@"lazer_ship" withExtension:@"caf"];
        
        NSLog(@"target point ===%f %f ",_targetCenter.x,_targetCenter.y);
    } completion:^(BOOL finished) {
        
        [UIView animateWithDuration:0.5 delay:0 options:UIViewAnimationOptionCurveLinear animations:^{
            
            lazerImageView.center=CGPointMake([self targetCenter:_targetCenter].x, _targetCenter.y);
            CGAffineTransform zoom    = CGAffineTransformMakeScale(7.0, 7.0);
            lazerImageView.transform=zoom;
            
            
            if (correctAnswerLabelTag==currentHighlightedTag ) {
                [audioToolBox playSound:@"powerup" withExtension:@"caf"];
                [self refreshGiftWithCount:++scoreCount];
                [lazerImageView setImage:[UIImage imageNamed:@"thumbs-up"]];
                
            }
            else if (_targetCenter.y==0){
                [audioToolBox playSound:@"explosion_large" withExtension:@"mp3"];
                [lazerImageView setImage:[UIImage imageNamed:@"boom"]];
            }
            
            else {
                [audioToolBox playSound:@"shake" withExtension:@"caf"];
                [lazerImageView setImage:[UIImage imageNamed:@"thumbs-down"]];
            }
        }completion:^(BOOL finished) {
            
            
            if (scoreCount>0) {
                [self presentViewController:modal animated:YES completion:NULL];
            }
            
            [self refreshDisplayGrid];
            recognizer.enabled=YES;
            
        }];
    }];
    
}


-(CGPoint )targetCenter:(CGPoint )point
{
    for (UILabel *lbl in [self.view subviews]) {
        if ([lbl isKindOfClass:[UILabel class]]&& lbl.tag>0 && lbl.tag<5) {
            if (CGRectContainsPoint (lbl.frame, point ))
            {
                return lbl.center;
            }
        }}
    return point;
}

-(void)startEmmitter
{
    CAEmitterLayer *emiterLayer=[CAEmitterLayer layer];
    emiterLayer.emitterPosition =CGPointMake(self.view.center.x, 0);
    //CGPointMake(self.view.bounds.size.width/2,self.view.bounds.origin.y);
    emiterLayer.emitterZPosition=10;
    emiterLayer.emitterSize=CGSizeMake(self.view.bounds.size.width, 0);
    emiterLayer.emitterShape = kCAEmitterLayerSphere;
  
    CAEmitterCell * emitterCell = [CAEmitterCell emitterCell];
    emitterCell.scale = 0.2;
    emitterCell.scaleRange = 0.2;
    emitterCell.birthRate = 40;
    emitterCell.emissionRange = 269.0;
    emitterCell.lifetime = 8.0;
    emitterCell.velocity = 5;
    emitterCell.velocityRange = 150;
    emitterCell.yAcceleration = 10;
    emitterCell.contents = (id)[[UIImage imageNamed:@"spark"] CGImage];
    emiterLayer.emitterCells = [NSArray arrayWithObject:emitterCell];
    [self.view.layer addSublayer:emiterLayer];
    
}

- (void)viewDidUnload {
    [audioToolBox dispose];
}

@end
