//
//  HomeScreenViewController.m
//  MathsPlay
//
//  Created by qainfotech on 10/21/13.
//  Copyright (c) 2013 qainfotech. All rights reserved.
//

#import "HomeScreenViewController.h"
// class one
#import "DragBubblesViewController.h"
#import "CompareViewController.h"
#import "DragToAddOrSubViewController.h"
#import "ButterflyCatchViewController.h"
// class three
#import "AddViewController.h"
#import "AdvanceMathViewController.h"
#import "FollowViewController.h"
#import "SubViewController.h"
#import "HelpMeAdditionViewController.h"
// class five
#import "CarRaceViewController.h"
#import "SquareRootViewController.h"
#import "DivisibiltyCheckViewController.h"
#import "GeometricGrowthViewController.h"
#import "LCMAndHCFViewController.h"
//class six
#import "QuadrantViewController.h"

@interface HomeScreenViewController ()
{
    NSArray *boyAvatarArray, *girlAvatarArray;
    NSUInteger boy_avatar_index, girl_avatar_index, oldsegmentindex;
}
@end

@implementation HomeScreenViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        ishighclass = NO;
    }
    return self;
}

-(id)init
{
    self=[super init];
    return self;

}


- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    
    if ([self respondsToSelector:@selector(edgesForExtendedLayout)])
    {
        self.edgesForExtendedLayout = UIRectEdgeNone;
    }
    
    self.title = @"My Home";
    boyAvatarArray = @[@"greenlantern",@"flash",@"minion",@"superman"];
    girlAvatarArray = @[@"bubbles",@"barbie-pink",@"blossom",@"buttercup",@"girl-minion"];
    boy_avatar_index = 0;
    girl_avatar_index = 0;
    oldsegmentindex = 0;
    
    
    UIImageView *backImage = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 768, 1024)];
    backImage.image = [UIImage imageNamed:@"back3"];

    backImage.alpha = 1.0;
    backImage.backgroundColor = [UIColor clearColor];
    [self.view addSubview:backImage];
    
    UIImageView *backImage2 = [[UIImageView alloc]initWithFrame:CGRectMake(100, 750, 600, 200)];
    backImage2.image = [UIImage imageNamed:@"groupofkids"];
    backImage2.alpha = 1.0;
    backImage2.backgroundColor = [UIColor clearColor];
    [self.view addSubview:backImage2];
    
    UILabel *usernameLabel = [[UILabel alloc]initWithFrame:CGRectMake(145, 40, 180, 45)];
    usernameLabel.text = @"NAME ";
    usernameLabel.textColor = [UIColor colorWithRed:0/255.0 green:100/255.0 blue:0/255.0 alpha:1.0];
    usernameLabel.backgroundColor = [UIColor clearColor];
    usernameLabel.textAlignment = NSTextAlignmentLeft;
    usernameLabel.font = [Util themeFontWithSize:27];
    [self.view addSubview:usernameLabel];
    
    UIImageView *ovalImage = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"speech-bubble-xxl (1)"]];
    ovalImage.frame = CGRectMake(277, 10, 300, 100);
    [self.view addSubview:ovalImage];
    
    UIImageView *ovalImage2 = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"tweety3"]];
    ovalImage2.frame = CGRectMake(577, 0, 100, 100);
    [self.view addSubview:ovalImage2];
    
    nameTextfield = [[UITextField alloc]initWithFrame:CGRectMake(295, 35, 260, 60)];
    nameTextfield.textAlignment = NSTextAlignmentCenter;
    nameTextfield.backgroundColor = [UIColor clearColor];
    
    if (NSFoundationVersionNumber <= NSFoundationVersionNumber_iOS_6_1) {
        // ios 6 or earlier
        nameTextfield.text = @"NickName";
    }
    else
    {
       // ios 7 or later
        nameTextfield.placeholder = @"NickName";
        
    }
    
    nameTextfield.textColor = [UIColor whiteColor];
    nameTextfield.autocapitalizationType =UITextAutocapitalizationTypeNone;
    nameTextfield.autocorrectionType = UITextAutocorrectionTypeNo;
    nameTextfield.font = [UIFont fontWithName:@"MarkerFelt-Thin" size:24.0];
    [nameTextfield setContentVerticalAlignment:UIControlContentVerticalAlignmentCenter];
    nameTextfield.delegate = self;
    [self.view addSubview:nameTextfield];
    
    segmentForGender = [[UISegmentedControl alloc]initWithItems:@[@"BOY",@"GIRL"]];
    segmentForGender.frame = CGRectMake(130, 130, 480, 45);
    segmentForGender.selectedSegmentIndex = 0;
    
    NSDictionary *attributes = [NSDictionary dictionaryWithObjectsAndKeys:
                                [UIFont boldSystemFontOfSize:17], UITextAttributeFont,
                                [UIColor blackColor], UITextAttributeTextColor,
                                nil];
    [segmentForGender setTitleTextAttributes:attributes forState:UIControlStateNormal];
    NSDictionary *highlightedAttributes = [NSDictionary dictionaryWithObject:[UIColor whiteColor] forKey:UITextAttributeTextColor];
    [segmentForGender setTitleTextAttributes:highlightedAttributes forState:UIControlStateHighlighted];
    segmentForGender.tintColor = [UIColor colorWithRed:147/255.0 green:112/255.0 blue:219/255.0 alpha:1.0];
    
    [segmentForGender addTarget:self action:@selector(didChangeGenderSegment) forControlEvents:UIControlEventValueChanged];
    [self.view addSubview:segmentForGender];
    
  
    UILabel *avatarLabel = [[UILabel alloc]initWithFrame:CGRectMake(120, 230, 180, 45)];
    avatarLabel.text = @"AVATAR";
    avatarLabel.textColor = [UIColor colorWithRed:0/255.0 green:100/255.0 blue:0/255.0 alpha:1.0];
    avatarLabel.backgroundColor = [UIColor clearColor];
    avatarLabel.textAlignment = NSTextAlignmentLeft;
    avatarLabel.font = [Util themeFontWithSize:27.0];
    [self.view addSubview:avatarLabel];
    
    UIButton *avatarArrowLeft = [UIButton buttonWithType:UIButtonTypeCustom];
    [avatarArrowLeft setFrame:CGRectMake(250, 235, 40, 40)];
    avatarArrowLeft.tag = 11;
    [avatarArrowLeft setBackgroundColor:[UIColor clearColor]];
    [avatarArrowLeft setImage:[UIImage imageNamed:@"left"] forState:UIControlStateNormal];
    [avatarArrowLeft addTarget:self action:@selector(avatarArrow:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:avatarArrowLeft];
    
    UIButton *avatarArrowRight = [UIButton buttonWithType:UIButtonTypeCustom];
    [avatarArrowRight setFrame:CGRectMake(500, 240, 40, 40)];
    avatarArrowRight.tag = 22;
    [avatarArrowRight setBackgroundColor:[UIColor clearColor]];
    [avatarArrowRight setImage:[UIImage imageNamed:@"right"] forState:UIControlStateNormal];
    [avatarArrowRight addTarget:self action:@selector(avatarArrow:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:avatarArrowRight];
    
    UIButton *browseButton=nil;
    browseButton = [UIButton buttonWithType:UIButtonTypeCustom];
    browseButton.tag = 33;
    [browseButton setBackgroundImage:[UIImage imageNamed:@"browse3"] forState:UIControlStateNormal];
    browseButton.frame = CGRectMake(550, 240, 40, 40);
    [browseButton addTarget:self action:@selector(browseButton:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:browseButton];
    
    avatarImage = [[UIImageView alloc]initWithFrame:CGRectMake( 320, 210, 130, 85)];
    avatarImage.image = [UIImage imageNamed:@"greenlantern"];
    avatarImage.backgroundColor = [UIColor clearColor];
    [self.view addSubview:avatarImage];
    
    UILabel *skillLabel = [[UILabel alloc]initWithFrame:CGRectMake(130, 310, 100, 45)];
    skillLabel.text = @"SKILL";
    skillLabel.textColor = [UIColor colorWithRed:0/255.0 green:100/255.0 blue:0/255.0 alpha:1.0];
    skillLabel.backgroundColor = [UIColor clearColor];
    skillLabel.textAlignment = NSTextAlignmentLeft;
    skillLabel.font = [Util themeFontWithSize:27.0];
    [self.view addSubview:skillLabel];
    
    UIButton *skillArrowLeft = [UIButton buttonWithType:UIButtonTypeCustom];
    [skillArrowLeft setFrame:CGRectMake(250, 310, 40, 40)];
    skillArrowLeft.tag = 33;
    [skillArrowLeft setBackgroundColor:[UIColor clearColor]];
    [skillArrowLeft setImage:[UIImage imageNamed:@"left"] forState:UIControlStateNormal];
    [skillArrowLeft addTarget:self action:@selector(didChangeSkillArrow:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:skillArrowLeft];
    
    UIButton *skillArrowRight = [UIButton buttonWithType:UIButtonTypeCustom];
    [skillArrowRight setFrame:CGRectMake(500, 315, 40, 40)];
    skillArrowRight.tag = 44;
    [skillArrowRight setBackgroundColor:[UIColor clearColor]];
    [skillArrowRight setImage:[UIImage imageNamed:@"right"] forState:UIControlStateNormal];
    [skillArrowRight addTarget:self action:@selector(didChangeSkillArrow:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:skillArrowRight];
    
    skillLabelValue = [[UILabel alloc]initWithFrame:CGRectMake(300, 310, 190, 45)];
    skillLabelValue.text = @"EASY";
    skillLabelValue.textColor = [UIColor blackColor];
    skillLabelValue.backgroundColor = [UIColor clearColor];
    skillLabelValue.textAlignment = NSTextAlignmentCenter;
    skillLabelValue.font = [Util themeFontWithSize:22.0];
    [self.view addSubview:skillLabelValue];
    
    classSegmentControl = [[UISegmentedControl alloc]initWithItems:[NSArray arrayWithObjects:@"CLASS I",@"CLASS II",@"CLASS III",@"CLASS IV",@"CLASS V",@"CLASS VI" ,nil]];
    classSegmentControl.frame = CGRectMake(10, 400, 748, 50);
    classSegmentControl.selectedSegmentIndex = 0;
    
    NSDictionary *attributesForClass = [NSDictionary dictionaryWithObjectsAndKeys:
                                [UIFont boldSystemFontOfSize:17], UITextAttributeFont,
                                [UIColor blackColor], UITextAttributeTextColor,
                                nil];
    [classSegmentControl setTitleTextAttributes:attributesForClass forState:UIControlStateNormal];
    NSDictionary *highlightedAttributesForClass = [NSDictionary dictionaryWithObject:[UIColor whiteColor] forKey:UITextAttributeTextColor];
    [classSegmentControl setTitleTextAttributes:highlightedAttributesForClass forState:UIControlStateHighlighted];
    //classSegmentControl.tintColor = [UIColor colorWithRed:165/255.0 green:42/255.0 blue:42/255.0 alpha:1.0];
    classSegmentControl.tintColor = [UIColor colorWithRed:123/255.0 green:104/255.0 blue:238/255.0 alpha:1.0];
    //classSegmentControl.tintColor = [UIColor colorWithRed:147/255.0 green:112/255.0 blue:219/255.0 alpha:1.0];
    classSegmentControl.segmentedControlStyle = UISegmentedControlStyleBar;
    [classSegmentControl addTarget:self action:@selector(didChangeClassSegment:) forControlEvents:UIControlEventValueChanged];
    
    if (NSFoundationVersionNumber <= NSFoundationVersionNumber_iOS_6_1) {
        CGRect rect = CGRectMake(0, 0, 1, 1);
        UIGraphicsBeginImageContext(rect.size);
        CGContextRef context = UIGraphicsGetCurrentContext();
        CGContextSetFillColorWithColor(context, [[UIColor colorWithRed:123/255.0 green:104/255.0 blue:238/255.0 alpha:0.7] CGColor]);
        CGContextFillRect(context, rect);
        UIImage *transparentImage = UIGraphicsGetImageFromCurrentImageContext();
        UIGraphicsEndImageContext();
        
        [classSegmentControl setBackgroundImage:transparentImage forState:UIControlStateNormal barMetrics:UIBarMetricsDefault];
    }
    classSegmentControl.layer.borderWidth = 1.0;
    [self.view addSubview:classSegmentControl];
   
    [self showClassOneGames];
    
}


#pragma mark Class 1 Games

- (void)showClassOneGames {
    
    
    classOneView = [[UIView alloc]initWithFrame:CGRectMake(78, 495, 645, 250)];
    classOneView.backgroundColor = [UIColor clearColor];
    [self.view addSubview:classOneView];
    
    UIView *borderview = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 645, 250)];
    borderview.alpha = 0.3;
    borderview.layer.borderWidth = 1.0;
    borderview.layer.cornerRadius = 15.0;
    borderview.layer.borderColor = [[UIColor grayColor]CGColor];
    borderview.backgroundColor = [UIColor lightGrayColor];
    [classOneView addSubview:borderview];
    
    UIButton *compareGame = [UIButton buttonWithType:UIButtonTypeCustom];
    compareGame.frame = CGRectMake(10, 10, 100, 80);
    compareGame.tag = 101;
    [compareGame setImage:[UIImage imageNamed:@"compare"] forState:UIControlStateNormal];
    UILabel *footnoteCompare = [[UILabel alloc]initWithFrame:CGRectMake(0, 80, 100, 20)];
    footnoteCompare.text = @"Compare";
    footnoteCompare.textColor = [UIColor blackColor];
    footnoteCompare.backgroundColor = [UIColor clearColor];
    footnoteCompare.textAlignment = NSTextAlignmentCenter;
    footnoteCompare.font = [UIFont fontWithName:@"Optima-ExtraBlack" size:18.0];
    [compareGame addTarget:self action:@selector(loadClassOneComponent:) forControlEvents:UIControlEventTouchUpInside];
    [compareGame addSubview:footnoteCompare];
    [classOneView addSubview:compareGame];
    
    
    UIButton *addGame = [UIButton buttonWithType:UIButtonTypeCustom];
    addGame.frame = CGRectMake(267, 20, 100, 80);
    addGame.tag = 102;
    [addGame setImage:[UIImage imageNamed:@"add"] forState:UIControlStateNormal];
    UILabel *footnoteAdd = [[UILabel alloc]initWithFrame:CGRectMake(0, 65, 100, 15)];
    footnoteAdd.text = @"Add";
    footnoteAdd.textColor = [UIColor blackColor];
    footnoteAdd.backgroundColor = [UIColor clearColor];
    footnoteAdd.textAlignment = NSTextAlignmentCenter;
    footnoteAdd.font = [UIFont fontWithName:@"Optima-ExtraBlack" size:18.0];
    [addGame addTarget:self action:@selector(loadClassOneComponent:) forControlEvents:UIControlEventTouchUpInside];
    [addGame addSubview:footnoteAdd];
    [classOneView addSubview:addGame];
    
    
    UIButton *subtractGame = [UIButton buttonWithType:UIButtonTypeCustom];
    subtractGame.frame = CGRectMake(522,20,100,80);
    subtractGame.tag = 103;
    [subtractGame setImage:[UIImage imageNamed:@"minus"] forState:UIControlStateNormal];
    UILabel *footnoteSubtract = [[UILabel alloc]initWithFrame:CGRectMake(0, 65, 100, 15)];
    footnoteSubtract.text = @"Subtract";
    footnoteSubtract.textColor = [UIColor blackColor];
    footnoteSubtract.backgroundColor = [UIColor clearColor];
    footnoteSubtract.textAlignment = NSTextAlignmentCenter;
    footnoteSubtract.font = [UIFont fontWithName:@"Optima-ExtraBlack" size:18.0];
    [subtractGame addTarget:self action:@selector(loadClassOneComponent:) forControlEvents:UIControlEventTouchUpInside];
    [subtractGame addSubview:footnoteSubtract];
    [classOneView addSubview:subtractGame];

    UIButton *dropGame = [UIButton buttonWithType:UIButtonTypeCustom];
    dropGame.frame = CGRectMake(122, 125, 100, 80);
    dropGame.tag = 104;
    [dropGame setImage:[UIImage imageNamed:@"bubble"] forState:UIControlStateNormal];
    UILabel *footnoteDrop = [[UILabel alloc]initWithFrame:CGRectMake(-10, 80, 120, 20)];
    footnoteDrop.text = @"Counting";
    footnoteDrop.textColor = [UIColor blackColor];
    footnoteDrop.backgroundColor = [UIColor clearColor];
    footnoteDrop.textAlignment = NSTextAlignmentCenter;
    footnoteDrop.font = [UIFont fontWithName:@"Optima-ExtraBlack" size:18.0];
    [dropGame addTarget:self action:@selector(loadClassOneComponent:) forControlEvents:UIControlEventTouchUpInside];
    [dropGame addSubview:footnoteDrop];
    [classOneView addSubview:dropGame];
    
    UIButton *reverseDropGame = [UIButton buttonWithType:UIButtonTypeCustom];
    reverseDropGame.frame = CGRectMake(372, 125, 100, 80);
    reverseDropGame.tag = 105;
    [reverseDropGame setImage:[UIImage imageNamed:@"reversebubble"] forState:UIControlStateNormal];
    UILabel *footnoteReverseDrop = [[UILabel alloc]initWithFrame:CGRectMake(0, 70, 120, 60)];
    footnoteReverseDrop.text = @"Reverse Counting";
    footnoteReverseDrop.numberOfLines = 0;
    footnoteReverseDrop.lineBreakMode = NSLineBreakByWordWrapping;
    footnoteReverseDrop.textColor = [UIColor blackColor];
    footnoteReverseDrop.backgroundColor = [UIColor clearColor];
    footnoteReverseDrop.textAlignment = NSTextAlignmentCenter;
    footnoteReverseDrop.font = [UIFont fontWithName:@"Optima-ExtraBlack" size:18.0];
    [reverseDropGame addTarget:self action:@selector(loadClassOneComponent:) forControlEvents:UIControlEventTouchUpInside];
    [reverseDropGame addSubview:footnoteReverseDrop];
    [classOneView addSubview:reverseDropGame];
    
}

#pragma mark Class Three Games

- (void)showClassThreeGames
{
    classThreeView = [[UIView alloc]initWithFrame:CGRectMake(78, 495, 645, 250)];
    classThreeView.backgroundColor = [UIColor clearColor];
    [self.view addSubview:classThreeView];
    
    UIView *borderview = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 645, 250)];
    borderview.alpha = 0.3;
    borderview.layer.borderWidth = 1.0;
    borderview.layer.cornerRadius = 15.0;
    borderview.layer.borderColor = [[UIColor grayColor]CGColor];
    borderview.backgroundColor = [UIColor lightGrayColor];
    [classThreeView addSubview:borderview];
    
    UIButton *compareGame = [UIButton buttonWithType:UIButtonTypeCustom];
    compareGame.frame = CGRectMake(522,20,100,90);
    compareGame.tag = 301;
    [compareGame setImage:[UIImage imageNamed:@"puzzle"] forState:UIControlStateNormal];
    UILabel *footnoteCompare = [[UILabel alloc]initWithFrame:CGRectMake(0, 88, 100, 45)];
    footnoteCompare.text = @"Miscellaneous";
    footnoteCompare.numberOfLines = 0;
    footnoteCompare.lineBreakMode = NSLineBreakByWordWrapping;
    footnoteCompare.textColor = [UIColor blackColor];
    footnoteCompare.backgroundColor = [UIColor clearColor];
    footnoteCompare.textAlignment = NSTextAlignmentCenter;
    footnoteCompare.font = [UIFont fontWithName:@"Optima-ExtraBlack" size:18.0];
    [compareGame addTarget:self action:@selector(loadClassThreeComponent:) forControlEvents:UIControlEventTouchUpInside];
    [compareGame addSubview:footnoteCompare];
    [classThreeView addSubview:compareGame];
    
    
    UIButton *addGame = [UIButton buttonWithType:UIButtonTypeCustom];
    addGame.frame = CGRectMake(10, 10, 100, 80);
    addGame.tag = 302;
    [addGame setImage:[UIImage imageNamed:@"add"] forState:UIControlStateNormal];
    UILabel *footnoteAdd = [[UILabel alloc]initWithFrame:CGRectMake(0, 65, 100, 15)];
    footnoteAdd.text = @"Addition";
    footnoteAdd.textColor = [UIColor blackColor];
    footnoteAdd.backgroundColor = [UIColor clearColor];
    footnoteAdd.textAlignment = NSTextAlignmentCenter;
    footnoteAdd.font = [UIFont fontWithName:@"Optima-ExtraBlack" size:18.0];
    [addGame addTarget:self action:@selector(loadClassThreeComponent:) forControlEvents:UIControlEventTouchUpInside];
    [addGame addSubview:footnoteAdd];
    [classThreeView addSubview:addGame];
    
    
    UIButton *subtractGame = [UIButton buttonWithType:UIButtonTypeCustom];
    subtractGame.frame = CGRectMake(267, 20, 130, 80);
    subtractGame.tag = 303;
    [subtractGame setImage:[UIImage imageNamed:@"minus"] forState:UIControlStateNormal];
    UILabel *footnoteSubtract = [[UILabel alloc]initWithFrame:CGRectMake(0, 65, 130, 15)];
    footnoteSubtract.text = @"Subtraction";
    footnoteSubtract.textColor = [UIColor blackColor];
    footnoteSubtract.backgroundColor = [UIColor clearColor];
    footnoteSubtract.textAlignment = NSTextAlignmentCenter;
    footnoteSubtract.font = [UIFont fontWithName:@"Optima-ExtraBlack" size:18.0];
    [subtractGame addTarget:self action:@selector(loadClassThreeComponent:) forControlEvents:UIControlEventTouchUpInside];
    [subtractGame addSubview:footnoteSubtract];
    [classThreeView addSubview:subtractGame];
    
    UIButton *dropGame = [UIButton buttonWithType:UIButtonTypeCustom];
    dropGame.frame = CGRectMake(122, 140, 100, 80);
    dropGame.tag = 304;
    [dropGame setImage:[UIImage imageNamed:@"raceiconfree"] forState:UIControlStateNormal];
    UILabel *footnoteDrop = [[UILabel alloc]initWithFrame:CGRectMake(-10, 70, 130, 20)];
    footnoteDrop.text = @"Multiplication";
    footnoteDrop.textColor = [UIColor blackColor];
    footnoteDrop.backgroundColor = [UIColor clearColor];
    footnoteDrop.textAlignment = NSTextAlignmentCenter;
    footnoteDrop.font = [UIFont fontWithName:@"Optima-ExtraBlack" size:18.0];
    [dropGame addTarget:self action:@selector(loadClassThreeComponent:) forControlEvents:UIControlEventTouchUpInside];
    [dropGame addSubview:footnoteDrop];
    [classThreeView addSubview:dropGame];
    
    UIButton *reverseDropGame = [UIButton buttonWithType:UIButtonTypeCustom];
    reverseDropGame.frame = CGRectMake(372, 140, 100, 80);
    reverseDropGame.tag = 305;
    [reverseDropGame setImage:[UIImage imageNamed:@"raceiconfree"] forState:UIControlStateNormal];
    UILabel *footnoteReverseDrop = [[UILabel alloc]initWithFrame:CGRectMake(-10, 50, 150, 60)];
    footnoteReverseDrop.text = @"Coming Soon ..";
    footnoteReverseDrop.textColor = [UIColor blackColor];
    footnoteReverseDrop.backgroundColor = [UIColor clearColor];
    footnoteReverseDrop.textAlignment = NSTextAlignmentCenter;
    footnoteReverseDrop.font = [UIFont fontWithName:@"Optima-ExtraBlack" size:18.0];
    [reverseDropGame addTarget:self action:@selector(loadClassThreeComponent:) forControlEvents:UIControlEventTouchUpInside];
    [reverseDropGame addSubview:footnoteReverseDrop];
    [classThreeView addSubview:reverseDropGame];
}

#pragma mark Class Five Games

- (void)showClassFiveGames
{
    classFiveView = [[UIView alloc]initWithFrame:CGRectMake(78, 495, 645, 250)];
    classFiveView.backgroundColor = [UIColor clearColor];
    [self.view addSubview:classFiveView];
    
    UIView *borderview = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 645, 250)];
    borderview.alpha = 0.3;
    borderview.layer.borderWidth = 1.0;
    borderview.layer.cornerRadius = 15.0;
    borderview.layer.borderColor = [[UIColor grayColor]CGColor];
    borderview.backgroundColor = [UIColor lightGrayColor];
    [classFiveView addSubview:borderview];
    
    UIButton *squareRoot = [UIButton buttonWithType:UIButtonTypeCustom];
    squareRoot.frame = CGRectMake(522,20,120,80);
    squareRoot.tag = 501;
    [squareRoot setImage:[UIImage imageNamed:@"square_root"] forState:UIControlStateNormal];
    UILabel *footnoteSqrt = [[UILabel alloc]initWithFrame:CGRectMake(0, 80, 120, 20)];
    footnoteSqrt.text = @"Square Root";
    footnoteSqrt.textColor = [UIColor blackColor];
    footnoteSqrt.backgroundColor = [UIColor clearColor];
    footnoteSqrt.textAlignment = NSTextAlignmentCenter;
    footnoteSqrt.font = [UIFont fontWithName:@"Optima-ExtraBlack" size:18.0];
    [squareRoot addTarget:self action:@selector(loadClassFiveComponent:) forControlEvents:UIControlEventTouchUpInside];
    [squareRoot addSubview:footnoteSqrt];
    [classFiveView addSubview:squareRoot];
    
    
    UIButton *divisibility = [UIButton buttonWithType:UIButtonTypeCustom];
    divisibility.frame = CGRectMake(10, 10, 100, 80);
    divisibility.tag = 502;
    [divisibility setImage:[UIImage imageNamed:@"add"] forState:UIControlStateNormal];
    UILabel *footnoteDiv = [[UILabel alloc]initWithFrame:CGRectMake(0, 65, 100, 25)];
    footnoteDiv.text = @"Divisibility Rules";
    footnoteDiv.numberOfLines = 0;
    footnoteDiv.lineBreakMode = NSLineBreakByWordWrapping;
    footnoteDiv.textColor = [UIColor blackColor];
    footnoteDiv.backgroundColor = [UIColor clearColor];
    footnoteDiv.textAlignment = NSTextAlignmentCenter;
    footnoteDiv.font = [UIFont fontWithName:@"Optima-ExtraBlack" size:18.0];
    [divisibility addTarget:self action:@selector(loadClassFiveComponent:) forControlEvents:UIControlEventTouchUpInside];
    [divisibility addSubview:footnoteDiv];
    [classFiveView addSubview:divisibility];
    
    
    UIButton *multiplication = [UIButton buttonWithType:UIButtonTypeCustom];
    multiplication.frame = CGRectMake(267, 20, 130, 80);
    multiplication.tag = 503;
    [multiplication setImage:[UIImage imageNamed:@"minus"] forState:UIControlStateNormal];
    UILabel *footnoteMul = [[UILabel alloc]initWithFrame:CGRectMake(0, 65, 130, 15)];
    footnoteMul.text = @"Multiplication";
    footnoteMul.textColor = [UIColor blackColor];
    footnoteMul.backgroundColor = [UIColor clearColor];
    footnoteMul.textAlignment = NSTextAlignmentCenter;
    footnoteMul.font = [UIFont fontWithName:@"Optima-ExtraBlack" size:18.0];
    [multiplication addTarget:self action:@selector(loadClassFiveComponent:) forControlEvents:UIControlEventTouchUpInside];
    [multiplication addSubview:footnoteMul];
    [classFiveView addSubview:multiplication];
    
    UIButton *pattern = [UIButton buttonWithType:UIButtonTypeCustom];
    pattern.frame = CGRectMake(122, 125, 100, 80);
    pattern.tag = 504;
    [pattern setImage:[UIImage imageNamed:@"number_puzzle"] forState:UIControlStateNormal];
    UILabel *footnotePattern = [[UILabel alloc]initWithFrame:CGRectMake(-10, 70, 120, 50)];
    footnotePattern.text = @"Complete The Pattern";
    footnotePattern.numberOfLines = 0;
    footnotePattern.lineBreakMode = NSLineBreakByWordWrapping;
    footnotePattern.textColor = [UIColor blackColor];
    footnotePattern.backgroundColor = [UIColor clearColor];
    footnotePattern.textAlignment = NSTextAlignmentCenter;
    footnotePattern.font = [UIFont fontWithName:@"Optima-ExtraBlack" size:18.0];
    [pattern addTarget:self action:@selector(loadClassFiveComponent:) forControlEvents:UIControlEventTouchUpInside];
    [pattern addSubview:footnotePattern];
    [classFiveView addSubview:pattern];
    
    UIButton *HcfLcm = [UIButton buttonWithType:UIButtonTypeCustom];
    HcfLcm.frame = CGRectMake(372, 125, 100, 80);
    HcfLcm.tag = 505;
    [HcfLcm setImage:[UIImage imageNamed:@"reversebubble"] forState:UIControlStateNormal];
    UILabel *footnoteHcfLcm = [[UILabel alloc]initWithFrame:CGRectMake(0, 70, 120, 60)];
    footnoteHcfLcm.text = @"HCF & LCM";
    footnoteHcfLcm.textColor = [UIColor blackColor];
    footnoteHcfLcm.backgroundColor = [UIColor clearColor];
    footnoteHcfLcm.textAlignment = NSTextAlignmentCenter;
    footnoteHcfLcm.font = [UIFont fontWithName:@"Optima-ExtraBlack" size:18.0];
    [HcfLcm addTarget:self action:@selector(loadClassFiveComponent:) forControlEvents:UIControlEventTouchUpInside];
    [HcfLcm addSubview:footnoteHcfLcm];
    [classFiveView addSubview:HcfLcm];
}




#pragma mark Class Six Games

- (void)showClassSixGames
{
    classSixView = [[UIView alloc]initWithFrame:CGRectMake(78, 495, 645, 250)];
    classSixView.backgroundColor = [UIColor clearColor];
    [self.view addSubview:classSixView];
    
    UIView *borderview = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 645, 250)];
    borderview.alpha = 0.3;
    borderview.layer.borderWidth = 1.0;
    borderview.layer.cornerRadius = 15.0;
    borderview.layer.borderColor = [[UIColor grayColor]CGColor];
    borderview.backgroundColor = [UIColor lightGrayColor];
    [classSixView addSubview:borderview];
    
    UIButton *quadRant = [UIButton buttonWithType:UIButtonTypeCustom];
    quadRant.frame = CGRectMake(522,20,120,80);
    quadRant.tag = 601;
    [quadRant setImage:[UIImage imageNamed:@"barGraph"] forState:UIControlStateNormal];
    UILabel *footnoteSqrt = [[UILabel alloc]initWithFrame:CGRectMake(0, 80, 120, 20)];
    footnoteSqrt.text = @"Bar Graph";
    footnoteSqrt.textColor = [UIColor blackColor];
    footnoteSqrt.backgroundColor = [UIColor clearColor];
    footnoteSqrt.textAlignment = NSTextAlignmentCenter;
    footnoteSqrt.font = [UIFont fontWithName:@"Optima-ExtraBlack" size:18.0];
    [quadRant addTarget:self action:@selector(loadClassSixComponent:) forControlEvents:UIControlEventTouchUpInside];
    [quadRant addSubview:footnoteSqrt];
    [classSixView addSubview:quadRant];
    
    
    UIButton *divisibility = [UIButton buttonWithType:UIButtonTypeCustom];
    divisibility.frame = CGRectMake(10, 10, 100, 80);
    divisibility.tag = 602;
    [divisibility setImage:[UIImage imageNamed:@"add"] forState:UIControlStateNormal];
    UILabel *footnoteDiv = [[UILabel alloc]initWithFrame:CGRectMake(0, 65, 100, 25)];
    footnoteDiv.text = @"Coming soon..";
    footnoteDiv.numberOfLines = 0;
    footnoteDiv.lineBreakMode = NSLineBreakByWordWrapping;
    footnoteDiv.textColor = [UIColor blackColor];
    footnoteDiv.backgroundColor = [UIColor clearColor];
    footnoteDiv.textAlignment = NSTextAlignmentCenter;
    footnoteDiv.font = [UIFont fontWithName:@"Optima-ExtraBlack" size:18.0];
    [divisibility addTarget:self action:@selector(loadClassSixComponent:) forControlEvents:UIControlEventTouchUpInside];
    [divisibility addSubview:footnoteDiv];
    [classSixView addSubview:divisibility];
    
    
    UIButton *multiplication = [UIButton buttonWithType:UIButtonTypeCustom];
    multiplication.frame = CGRectMake(267, 20, 130, 80);
    multiplication.tag = 603;
    [multiplication setImage:[UIImage imageNamed:@"minus"] forState:UIControlStateNormal];
    UILabel *footnoteMul = [[UILabel alloc]initWithFrame:CGRectMake(0, 65, 130, 15)];
    footnoteMul.text = @"Coming soon..";
    footnoteMul.textColor = [UIColor blackColor];
    footnoteMul.backgroundColor = [UIColor clearColor];
    footnoteMul.textAlignment = NSTextAlignmentCenter;
    footnoteMul.font = [UIFont fontWithName:@"Optima-ExtraBlack" size:18.0];
    [multiplication addTarget:self action:@selector(loadClassSixComponent:) forControlEvents:UIControlEventTouchUpInside];
    [multiplication addSubview:footnoteMul];
    [classSixView addSubview:multiplication];
    
    UIButton *pattern = [UIButton buttonWithType:UIButtonTypeCustom];
    pattern.frame = CGRectMake(122, 125, 100, 80);
    pattern.tag = 604;
    [pattern setImage:[UIImage imageNamed:@"bubble"] forState:UIControlStateNormal];
    UILabel *footnotePattern = [[UILabel alloc]initWithFrame:CGRectMake(-10, 70, 120, 50)];
    footnotePattern.text = @"Coming soon..";
    footnotePattern.numberOfLines = 0;
    footnotePattern.lineBreakMode = NSLineBreakByWordWrapping;
    footnotePattern.textColor = [UIColor blackColor];
    footnotePattern.backgroundColor = [UIColor clearColor];
    footnotePattern.textAlignment = NSTextAlignmentCenter;
    footnotePattern.font = [UIFont fontWithName:@"Optima-ExtraBlack" size:18.0];
    [pattern addTarget:self action:@selector(loadClassSixComponent:) forControlEvents:UIControlEventTouchUpInside];
    [pattern addSubview:footnotePattern];
    [classSixView addSubview:pattern];
    
    UIButton *HcfLcm = [UIButton buttonWithType:UIButtonTypeCustom];
    HcfLcm.frame = CGRectMake(372, 125, 100, 80);
    HcfLcm.tag = 605;
    [HcfLcm setImage:[UIImage imageNamed:@"reversebubble"] forState:UIControlStateNormal];
    UILabel *footnoteHcfLcm = [[UILabel alloc]initWithFrame:CGRectMake(0, 70, 120, 60)];
    footnoteHcfLcm.text = @"Coming soon..";
    footnoteHcfLcm.textColor = [UIColor blackColor];
    footnoteHcfLcm.backgroundColor = [UIColor clearColor];
    footnoteHcfLcm.textAlignment = NSTextAlignmentCenter;
    footnoteHcfLcm.font = [UIFont fontWithName:@"Optima-ExtraBlack" size:18.0];
    [HcfLcm addTarget:self action:@selector(loadClassSixComponent:) forControlEvents:UIControlEventTouchUpInside];
    [HcfLcm addSubview:footnoteHcfLcm];
    [classSixView addSubview:HcfLcm];
}



#pragma mark Segment


- (void)didChangeGenderSegment {
    
    if (segmentForGender.selectedSegmentIndex == 1) { //i.e girl segment
        avatarImage.image=[UIImage imageNamed:[girlAvatarArray objectAtIndex:0]];
        girl_avatar_index = 0;
        
    }
    else if (segmentForGender.selectedSegmentIndex == 0) { //i.e boy segment
        avatarImage.image=[UIImage imageNamed:[boyAvatarArray objectAtIndex:0]];
        boy_avatar_index = 0;
        
        
    }
}

- (void)didChangeClassSegment:(UISegmentedControl *)segment {
    
    if (segment.selectedSegmentIndex == 0 || segment.selectedSegmentIndex == 1)
    {
        if (oldsegmentindex == 2)
        {
            // remove classThreeGames
            [classThreeView removeFromSuperview];
            
            
            [self showClassOneGames];
        }
        else if (oldsegmentindex == 4)
        {
            
            // remove classFiveGames
            [classFiveView removeFromSuperview];
            
            [self showClassOneGames];
        }
        else if (oldsegmentindex ==5)
        {
            // remove classSixGames
            
            [classSixView removeFromSuperview];
            [self showClassOneGames];
        }

        
        oldsegmentindex = 0;
    }
    else if (segment.selectedSegmentIndex == 2 || segment.selectedSegmentIndex == 3)
    {
        if (oldsegmentindex == 0 )
        {
            // remove classOneGames
            [classOneView removeFromSuperview];
            
            [self showClassThreeGames];
        }
        else if (oldsegmentindex == 4)
        {
            
            // remove classFiveGames
            [classFiveView removeFromSuperview];
            
            [self showClassThreeGames];
        }
        else if (oldsegmentindex ==5)
        {
            // remove classSixGames
            
            [classSixView removeFromSuperview];
            [self showClassThreeGames];
        }
        oldsegmentindex = 2;
    }
    
    
    else if (segment.selectedSegmentIndex==5)
    {
        if (oldsegmentindex == 0 )
        {
            // remove classOneGames
            [classOneView removeFromSuperview];
            
            // show classSixeGames
            [self showClassSixGames];
        }
        else if (oldsegmentindex == 2 )
        {
            // remove classThreeGames
            [classThreeView removeFromSuperview];
            // show classSixeGames
            [self showClassSixGames];
        }
        else if (oldsegmentindex == 4)
        {
            // remove classFiveGames
            [classFiveView removeFromSuperview];
            // show classSixeGames
            [self showClassSixGames];
        }
        oldsegmentindex = 5;
    }
    else
    {
        if (oldsegmentindex == 0 )
        {
            // remove classOneGames
            [classOneView removeFromSuperview];
            
            // show classFiveGames
            [self showClassFiveGames];
        }
        else if (oldsegmentindex == 2 )
        {
            // remove classThreeGames
            [classThreeView removeFromSuperview];
                        // show classFiveGames
            [self showClassFiveGames];
        }
        
        else if (oldsegmentindex ==5)
        {
            // remove classSixGames

            [classSixView removeFromSuperview];
            // show classFiveGames
            [self showClassFiveGames];
        }
        
        oldsegmentindex = 4;
    }
}

#pragma mark Button

- (void)avatarArrow:(UIButton *)button {
    
        if (button.tag == 22)
        {
            
            if (segmentForGender.selectedSegmentIndex==0) {
                [self toggleBoyAvatar:(UIButton *)button];
                
            }
            else if (segmentForGender.selectedSegmentIndex==1) {
                [self toggleGirlsAvatar:(UIButton *)button];
            }
            
        }
        else if (button.tag == 11)
        {
            
            if (segmentForGender.selectedSegmentIndex==0) {
                [self toggleBoyAvatar:(UIButton *)button];
                
            }
            else if (segmentForGender.selectedSegmentIndex==1) {
                [self toggleGirlsAvatar:(UIButton *)button];
            }
            
        }

    
}


-(void)didChangeSkillArrow:(UIButton *)button {
    if (button.tag == 44)
    {
        if ([skillLabelValue.text isEqualToString:@"EASY"])
        {
            skillLabelValue.text = @"MEDIUM";
            
            
        }
        else if([skillLabelValue.text isEqualToString:@"MEDIUM"])
        {
            skillLabelValue.text = @"HARD";
        }
        else
        {
            skillLabelValue.text = @"EASY";
            
        }
    }
    else if (button.tag == 33)
    {
        if ([skillLabelValue.text isEqualToString:@"EASY"])
        {
            skillLabelValue.text = @"HARD";
            
            
        }
        else if([skillLabelValue.text isEqualToString:@"MEDIUM"])
        {
            skillLabelValue.text = @"EASY";
            
        }
        else
        {
            skillLabelValue.text = @"MEDIUM";
            
        }
    }
}

-(void)toggleBoyAvatar:(UIButton *)button
{
    if (button.tag == 22)
    {
        if (boy_avatar_index < [boyAvatarArray count]-1) {
            
            boy_avatar_index++;
        }
        else {
            
            boy_avatar_index = 0;
        }
       
        avatarImage.image = [UIImage imageNamed:[boyAvatarArray objectAtIndex:boy_avatar_index]];
    }
    else if(button.tag == 11)
    {
        if (boy_avatar_index > 0) {
           
            --boy_avatar_index;
        }
        else {
            
            boy_avatar_index = [boyAvatarArray count] - 1;
        }
        avatarImage.image = [UIImage imageNamed:[boyAvatarArray objectAtIndex:boy_avatar_index]];
    }
}

-(void)toggleGirlsAvatar:(UIButton *)button
{
    if (button.tag == 22)
    {
        if (girl_avatar_index < [girlAvatarArray count]-1) {
            
            girl_avatar_index++;
        }
        else {
            
            girl_avatar_index = 0;
        }
        
        avatarImage.image = [UIImage imageNamed:[girlAvatarArray objectAtIndex:girl_avatar_index]];
    }
    else if(button.tag == 11)
    {
        if (girl_avatar_index > 0) {
            
            --girl_avatar_index;
        }
        else {
            
            girl_avatar_index = [girlAvatarArray count] - 1;
        }
        avatarImage.image = [UIImage imageNamed:[girlAvatarArray objectAtIndex:girl_avatar_index]];
    }
}


- (void)browseButton:(UIButton *)button {
    
    imagePicker=nil;
    imagePicker = [[UIImagePickerController alloc] init];
    imagePicker.delegate = self;
    if ([UIImagePickerController isSourceTypeAvailable:
         UIImagePickerControllerSourceTypePhotoLibrary])
    {
        // Set source to the Photo Library
        imagePicker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
        
    }
    //put the image picker in its own container controller, to control its size
    UIViewController *containerController = [[UIViewController alloc] init];
    containerController.contentSizeForViewInPopover = CGSizeMake(400,400);
    [containerController.view addSubview:imagePicker.view];
    
    //then, put the container controller in the popover
    popover = [[UIPopoverController alloc] initWithContentViewController:containerController];
    [popover presentPopoverFromRect:button.bounds
                             inView:button
           permittedArrowDirections:UIPopoverArrowDirectionUp
                           animated:YES];
    
    [imagePicker.view setFrame:containerController.view.frame];
    
}


- (void)loadClassOneComponent:(UIButton *)button
    
{
        [self storeToPlist];
        DragBubblesViewController *dragBubblesController;
        CompareViewController *compareController;
        DragToAddOrSubViewController *dragToAddController;
        ButterflyCatchViewController *butterflyController;
    
        switch (button.tag)
        {
            case 101: // compare objects
                if (classSegmentControl.selectedSegmentIndex == 1) {
                    ishighclass = YES;
                } else ishighclass = NO;
                compareController = [[CompareViewController alloc]init];
                [self.navigationController pushViewController:compareController animated:YES];
                break;
                
            case 102: // addition
                if (classSegmentControl.selectedSegmentIndex == 1) {
                    ishighclass = YES;
                } else ishighclass = NO;
                dragToAddController = [[DragToAddOrSubViewController alloc]init];
                dragToAddController.addOrSub = @"add";
                [self.navigationController pushViewController:dragToAddController animated:YES];
                break;
                
            case 103: // subtraction
                if (classSegmentControl.selectedSegmentIndex == 1) {
                    ishighclass = YES;
                } else ishighclass = NO;
                dragToAddController = [[DragToAddOrSubViewController alloc]init];
                dragToAddController.addOrSub = @"sub";
                [self.navigationController pushViewController:dragToAddController animated:YES];
                break;
                
            case 104: // drop the bubbles button clicked
                if (classSegmentControl.selectedSegmentIndex == 1) {
                    ishighclass = YES;
                } else ishighclass = NO;
                if (segmentForGender.selectedSegmentIndex==0)
                {
                    // boy controller
                    dragBubblesController = [[DragBubblesViewController alloc]init];
                    dragBubblesController.bubbleNumber = @"0";
                    [self.navigationController pushViewController:dragBubblesController animated:YES];
                }
                else
                {
                    // girl controller
                    butterflyController = [[ButterflyCatchViewController alloc]init];
                    butterflyController.bubbleNumber = @"0";
                    [self.navigationController pushViewController:butterflyController animated:YES];
                }
                
                break;
                
            case 105:  // reverse drop bubble clicked
                if (classSegmentControl.selectedSegmentIndex == 1) {
                    ishighclass = YES;
                } else ishighclass = NO;
                if (segmentForGender.selectedSegmentIndex==0)
                {
                    dragBubblesController = [[DragBubblesViewController alloc]init];
                    dragBubblesController.bubbleNumber = @"1";
                    [self.navigationController pushViewController:dragBubblesController animated:YES];
                }
                else
                {
                    // girl controller
                    butterflyController = [[ButterflyCatchViewController alloc]init];
                    butterflyController.bubbleNumber = @"1";
                    [self.navigationController pushViewController:butterflyController animated:YES];
                }
                
                break;
                
            default:
                break;
        }
        
}


- (void)loadClassThreeComponent:(UIButton *)button
{
    {
        [self storeToPlist];
        
        AdvanceMathViewController *carRaceController;
        SubViewController *subtractController;
        FollowViewController *followController;
        HelpMeAdditionViewController *jumpeyController;
        
        switch (button.tag)
        {
            case 302: // class 3 addition
                //addController = [[AddViewController alloc]init];
                //[self.navigationController pushViewController:addController animated:YES];
                jumpeyController = [[HelpMeAdditionViewController alloc]init];
                [self.navigationController pushViewController:jumpeyController animated:YES];
                break;
                
            case 303: // class 3 subtraction
                subtractController = [[SubViewController alloc]init];
                [self.navigationController pushViewController:subtractController animated:YES];
                break;
                
            case 304: // class 3 multiplication
                carRaceController = [[AdvanceMathViewController alloc]init];
                [self.navigationController pushViewController:carRaceController animated:YES];
                break;
                
            case 305: // class 3 division
                break;
                
            case 301: // class 3 follow the path
                followController = [[FollowViewController alloc]init];
                [self.navigationController pushViewController:followController animated:YES];
                break;
                
            default:
                break;
        }
        
    }
}


- (void)loadClassFiveComponent:(UIButton *)button
{
    {
        [self storeToPlist];
        
        CarRaceViewController *advanceCarRaceController;
        SquareRootViewController *squareRootQuiz;
        DivisibiltyCheckViewController *divisibilityCheckController;
        GeometricGrowthViewController *geometricGrowthViewController;
        LCMAndHCFViewController *lcmAndHcfViewController;
        
        switch (button.tag)
        {
            case 501: //class 5 square root
                squareRootQuiz = nil;
                squareRootQuiz=[[SquareRootViewController alloc]init];
                [self.navigationController pushViewController:squareRootQuiz animated:YES];
                break;
                
            case 502: //class 5 divisibility
                divisibilityCheckController=nil;
                divisibilityCheckController=[[DivisibiltyCheckViewController alloc]init];
                [self.navigationController pushViewController:divisibilityCheckController animated:YES];
              
                break;
                
            case 503: // class 5 advance race
                advanceCarRaceController=nil;
                advanceCarRaceController = [[CarRaceViewController alloc]init];
                [self.navigationController pushViewController:advanceCarRaceController animated:YES];
                
                break;
                
            case 504: // class 5 pattern
                geometricGrowthViewController=nil;
                geometricGrowthViewController = [[GeometricGrowthViewController alloc]init];
                [self.navigationController pushViewController:geometricGrowthViewController animated:YES];
                
                break;
                
            case 505://class 5 HCF/LCM
                lcmAndHcfViewController=nil;
                lcmAndHcfViewController=[[LCMAndHCFViewController alloc]init];
                [self.navigationController pushViewController:lcmAndHcfViewController animated:YES];
              
                
            default:
                break;
        }
        
    }
}






- (void)loadClassSixComponent:(UIButton *)button
{
    
       // [self storeToPlist];
        
        QuadrantViewController *quadrantViewController;
        
        switch (button.tag)
        {
            case 601: //class 6 Quadrant
                quadrantViewController=nil;
                quadrantViewController=[[QuadrantViewController alloc]init];
                [self.navigationController pushViewController:quadrantViewController animated:YES];
                break;
                
            case 702: //class 6 divisibility
              //  divisibilityCheckController=[[DivisibiltyCheckViewController alloc]init];
              //  [self.navigationController pushViewController:divisibilityCheckController animated:YES];
                
                break;
                
            case 703: // class 6 advance race
             //   advanceCarRaceController = [[CarRaceViewController alloc]init];
               // [self.navigationController pushViewController:advanceCarRaceController animated:YES];
                
                break;
                
            case 704: // class 6 pattern
               // geometricGrowthViewController = [[GeometricGrowthViewController alloc]init];
                //[self.navigationController pushViewController:geometricGrowthViewController animated:YES];
                
                break;
                
            case 505://class 5 HCF/LCM
              //  lcmAndHcfViewController=nil;
               // lcmAndHcfViewController=[[LCMAndHCFViewController alloc]init];
               // [self.navigationController pushViewController:lcmAndHcfViewController animated:YES];
                
                
            default:
                break;
        }
        
    
}




    #pragma mark ImagePicker Delegates


-(void)imagePickerControllerDidCancel:(UIImagePickerController *)picker
{
    [picker dismissViewControllerAnimated:YES completion:nil];
    [popover dismissPopoverAnimated:YES];
}


- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info{
    
    
    NSURL *imageURL = [info valueForKey:UIImagePickerControllerReferenceURL];
    ALAssetsLibraryAssetForURLResultBlock resultblock = ^(ALAsset *myasset)
    {
        CGImageRef iref = [myasset aspectRatioThumbnail];
        if (iref) {
            UIImage *theThumbnail = [UIImage imageWithCGImage:iref];
            [avatarImage setImage:theThumbnail];
            
        }
    };
    
    
    ALAssetsLibraryAccessFailureBlock failureblock  = ^(NSError *myerror)
    {
        NSLog(@" cant get image - %@",[myerror localizedDescription]);
    };
    
    if(imageURL)
    {
        ALAssetsLibrary* assetslibrary = [[ALAssetsLibrary alloc] init];
        [assetslibrary assetForURL:imageURL
                       resultBlock:resultblock
                      failureBlock:failureblock];
    }
    [self storeToPlist];
    [picker dismissViewControllerAnimated:YES completion:nil];
    [popover dismissPopoverAnimated:YES];
    
}

    #pragma mark TextField Delegates

- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField {
    
    if (NSFoundationVersionNumber <= NSFoundationVersionNumber_iOS_6_1) {
        // ios 6 or earlier
        textField.text = @"";
    }
    textField.backgroundColor = [UIColor clearColor];
    return YES;
}

-(BOOL)textFieldShouldEndEditing:(UITextField *)textField
{
    textField.backgroundColor=[UIColor clearColor];
    return YES;
}

-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    NSString *rawString = [nameTextfield text];
    NSCharacterSet *whitespace = [NSCharacterSet whitespaceAndNewlineCharacterSet];
    NSString *trimmed = [rawString stringByTrimmingCharactersInSet:whitespace];
    if ([trimmed length] == 0) {
        // Text was empty or only whitespace.
        nameTextfield.backgroundColor = [UIColor colorWithRed:135/255.0 green:123/255.0 blue:129/255.0 alpha:1.0];
        if (NSFoundationVersionNumber <= NSFoundationVersionNumber_iOS_6_1) {
            // ios 6 or earlier
           nameTextfield.text = @"NickName";
        }
        else
        {
            nameTextfield.text = @"";
            nameTextfield.placeholder = @"NickName";
        }
        
    }
    [textField resignFirstResponder];
    return YES;
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    
    NSString *rawString = [nameTextfield text];
    NSCharacterSet *whitespace = [NSCharacterSet whitespaceAndNewlineCharacterSet];
    NSString *trimmed = [rawString stringByTrimmingCharactersInSet:whitespace];
    if ([trimmed length] == 0) {
        // Text was empty or only whitespace.
        if (NSFoundationVersionNumber <= NSFoundationVersionNumber_iOS_6_1) {
            // ios 6 or earlier
            nameTextfield.text = @"NickName";
        }
        else
        {
            nameTextfield.text = @"";
            nameTextfield.placeholder = @"NickName";
        }
    }
    [nameTextfield resignFirstResponder];
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    NSUInteger newLength = [textField.text length] + [string length] - range.length;
    return (newLength > 20) ? NO : YES;
}

#pragma mark PLIST

-(void)storeToPlist
{
    
    NSMutableDictionary *plistdic = [Util readPListData];
    
    NSString *rawString = [nameTextfield text];
    NSCharacterSet *whitespace = [NSCharacterSet whitespaceAndNewlineCharacterSet];
    NSString *trimmed = [rawString stringByTrimmingCharactersInSet:whitespace];
    if ([trimmed length] == 0) {
        // Text was empty or only whitespace.
        [plistdic setObject:@"learner" forKey:@"username"];
    } else {
        if ([nameTextfield.text isEqualToString:@"NickName"]) {
            [plistdic setObject:@"learner" forKey:@"username"];
        }
        else
        [plistdic setObject:nameTextfield.text forKey:@"username"];
    }
    [plistdic setObject:[NSData dataWithData:UIImagePNGRepresentation(avatarImage.image)] forKey:@"avatarImage"]; // saving image so that wen browsed from gallery , it 'll save the gallery image to plist
    
     [plistdic setObject:skillLabelValue.text forKey:@"level"];
    [Util writeToPlist:plistdic];
}


-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];

}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
