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


@interface LCMAndHCFViewController ()
{
    NSArray *optionArray;
    int selectedIndex;
    int selectedAnswer;
    UIImageView *tanker;
    BOOL isALligned;

}
@property(nonatomic,assign) CGPoint targetCenter;

@end

@implementation LCMAndHCFViewController
@synthesize targetCenter=_targetCenter;

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
    tanker.image=[UIImage imageNamed:@"tank"];
    tanker.userInteractionEnabled=YES;
    [self.view addSubview:tanker];
    _targetCenter=CGPointMake(tanker.center.x, Y_AXIS_VALUE);


    
    
    panGestureRecognizer=[[UIPanGestureRecognizer alloc]initWithTarget:self action:@selector(handlePan:)];
    [tanker addGestureRecognizer:panGestureRecognizer];
    
    tapGestureRecognizer=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(handleTap:)];
    tapGestureRecognizer.numberOfTapsRequired=1;
    [tanker addGestureRecognizer:tapGestureRecognizer];
    
    [self start];
    
//[NSTimer scheduledTimerWithTimeInterval:5    target:self    selector:@selector(start)    userInfo:nil repeats:YES];
    
    
    
}

//- (void)viewWillLayoutSubviews
//{
//    [super viewWillLayoutSubviews];
//    // Configure the view.
//    // Configure the view after it has been sized for the correct orientation.
//    SKView *skView = (SKView *)self.view;
//    if (!skView.scene) {
//        skView.showsFPS = NO;
//        skView.showsNodeCount = NO;
//        
//        // Create and configure the scene.
//        MyScene *theScene = [MyScene sceneWithSize:skView.bounds.size];
//        theScene.scaleMode = SKSceneScaleModeAspectFill;
//        
//        // Present the scene.
//        [skView presentScene:theScene];
//    }
//}


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
        answer=lcm(firstRandom, secondRandom);
        
    }
    else
    {
        questionLabel.text=[NSString stringWithFormat:@"The HCF of %i and %i ?",firstRandom,secondRandom];
        answer=gcd(firstRandom, secondRandom);
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
    // 4444 for millile
    for (UIView *view in [self.view subviews]) {
        if ([view isKindOfClass:[UIImageView class]] && view.tag==4444 ) {
            [view removeFromSuperview];
        }
        
        if (view.tag==1 && view.tag==2 &&view.tag==3 &&view.tag==4 )  {
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
        xValue=xValue+width+50;
        [self.view addSubview:label];
    }
    
}


-(void) dragTank : (UIImageView *) sender {
    
     sender.center=[tapGestureRecognizer locationInView:self.view];
}


- (void)handlePan:(UIPanGestureRecognizer *)recognizer {
    [self handleMovementView:recognizer];
    
    

    
    
    for (UILabel *optionLabel in self.view.subviews)
    {
        if ([optionLabel isKindOfClass:[UILabel class]]&& optionLabel.tag>0 && optionLabel.tag<5) {
            if (recognizer.view.center.x >= optionLabel.center.x-49 && recognizer.view.center.x <= optionLabel.center.x+49 )
            {
                
                _targetCenter=CGPointMake(recognizer.view.center.x, optionLabel.center.y);

                [optionLabel setBackgroundColor:[UIColor redColor]];
                
                NSLog(@"if option tag%d",optionLabel.tag);
                break;
                
            }
            else
            {
                    [optionLabel setBackgroundColor:[UIColor colorWithRed:59/255.0 green:0/255.0 blue:133/255.0 alpha:1.0]];
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

    // Step 1 - Create a new peaball image
    UIImage *lazerImage = [UIImage imageNamed:@"missile"];
   __block UIImageView *lazerImageView = [[UIImageView alloc] initWithImage:lazerImage];
    lazerImageView.tag=4444;

    [lazerImageView setFrame:CGRectMake(0, 0, 20, 20)];
    [lazerImageView setCenter:recognizer.view.center];
    [self.view addSubview:lazerImageView];
    
    // Step 2 - Use the in-built animation methods by Apple to animate our pea
    
    
    
    [UIView animateWithDuration:0.2 delay:0 options:UIViewAnimationOptionCurveEaseOut animations:^{
    [lazerImageView setCenter:_targetCenter];

        NSLog(@"target point ===%f %f ",_targetCenter.x,_targetCenter.y);
    } completion:^(BOOL finished) {
        [lazerImageView setImage:[UIImage imageNamed:@"boom"]];
        //[self start];
    }];
    
}


/*-(CGPoint *)detectTheAllignedBallCenter:(UITapGestureRecognizer *)recognizer
{
//    CGPoint center;
//
//    
//    
//    
//    return center;
    
}*/


@end
