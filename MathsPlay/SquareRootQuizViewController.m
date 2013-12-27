//
//  SquareRootQuizViewController.m
//  MathsPlay
//
//  Created by qainfotech on 17/12/13.
//  Copyright (c) 2013 qainfotech. All rights reserved.
//

#import "SquareRootQuizViewController.h"

@interface SquareRootQuizViewController ()
{
    UILabel *questionLabel;
    UIView *displayView;

}
@end

@implementation SquareRootQuizViewController

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
    [self checkObject:questionLabel];
    questionLabel=[[UILabel alloc]initWithFrame:CGRectMake(300, 0, self.view.frame.size.width, 100)];

    questionLabel.backgroundColor=[UIColor clearColor];
    questionLabel.layer.cornerRadius=10.0;
    questionLabel.font=[UIFont boldSystemFontOfSize:50];
    questionLabel.textColor=[UIColor blackColor];
    questionLabel.numberOfLines=0;
    questionLabel.text=@"Find the Square root of 25";
    questionLabel.textAlignment=NSTextAlignmentCenter;
    [questionLabel sizeToFit];
    [self.view addSubview:questionLabel];
    [self performSelector:@selector(showQuestion) withObject:nil afterDelay:0.5];
    
    
    

}


-(void)showQuestion
{
 
    
 

}




-(void)startOptionAnimation:(NSArray *)arrayToDisplay
{
    int width=50;
    int height=50;
    int yValue=-50;
    

    for (int count=0; count<[arrayToDisplay count]; count++) {
        UILabel *label=[[UILabel alloc]initWithFrame:CGRectMake([self getRandomNumber:50 to:self.view.frame.size.width-100], yValue, width, height)];
        label.tag=count+1;
        label.layer.cornerRadius=50.0;
        label.layer.borderWidth=1.0;
        
        label.backgroundColor=[UIColor colorWithRed:59/255.0 green:0/255.0 blue:133/255.0 alpha:1.0];
        label.font=[UIFont fontWithName:@"Marker Felt" size:30];
        label.textColor=[UIColor whiteColor];
        label.textAlignment=NSTextAlignmentCenter;
        label.text=[NSString stringWithFormat:@"%@",[arrayToDisplay objectAtIndex:count]];
        yValue=yValue-100;
        [displayView addSubview:label];
    }
    
    

}

-(NSMutableArray *)getTenRandomLessThan:(int)M {
    NSMutableArray *uniqueNumbers = [[NSMutableArray alloc] init];
    int randomNumber;
    while ([uniqueNumbers count] < M) {
        randomNumber = arc4random() % M; // ADD 1 TO GET NUMBERS BETWEEN 1 AND M RATHER THAN 0 and M-1
        
        int perfectSquare=(randomNumber*randomNumber) +(2*randomNumber)+1;
        if (![uniqueNumbers containsObject:[NSNumber numberWithInt:perfectSquare]]) {
            [uniqueNumbers addObject:[NSNumber numberWithInt:perfectSquare]];
        }
    }
    return uniqueNumbers;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

-(void)checkObject:(id)object
{
    if (object) {
        object=nil;
    }
}

- (void)centerButtonAnimation:(UILabel *)buttonToAnimate{
    CAKeyframeAnimation *centerZoom = [CAKeyframeAnimation animationWithKeyPath:@"transform"];
    centerZoom.duration = 1.0f;
    centerZoom.values = @[[NSValue valueWithCATransform3D:CATransform3DMakeScale(1, 1, 1)],[NSValue valueWithCATransform3D:CATransform3DMakeScale(1.5, 1.5, 1)],[NSValue valueWithCATransform3D:CATransform3DMakeScale(1, 1, 1)],[NSValue valueWithCATransform3D:CATransform3DMakeScale(1.2, 1.2, 1)],[NSValue valueWithCATransform3D:CATransform3DMakeScale(1, 1, 1)]];
    centerZoom.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionLinear];
    [buttonToAnimate.layer addAnimation:centerZoom forKey:@"buttonScale"];

}
- (int)getRandomNumber:(int)from to:(int)to
{
    return (int)from + arc4random() % (to-from+1);
}

@end
