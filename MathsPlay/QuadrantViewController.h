//
//  QuadrantViewController.h
//  MathsPlay
//
//  Created by qainfotech on 27/01/14.
//  Copyright (c) 2014 qainfotech. All rights reserved.
//

#import <UIKit/UIKit.h>
//#import "AppDelegate.h"
#import "BarChartView.h"
#import "Questionare.h"
#import "RadioButton.h"

@interface QuadrantViewController : UIViewController<RadioDelegate>
-(id)init;
@property (nonatomic, strong) NSManagedObjectContext *managedObjectContext;
@property(nonatomic,copy)NSString *answer;
@property(nonatomic,strong)Questionare *sharedResultSet;
@property(nonatomic,assign)NSInteger count;
@end
