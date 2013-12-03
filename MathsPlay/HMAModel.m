//
//  HMAModel.m
//  MathsPlay
//
//  Created by qainfotech on 11/27/13.
//  Copyright (c) 2013 qainfotech. All rights reserved.
//

#import "HMAModel.h"

@implementation HMAModel

+ (int)getRandomNumber:(int)from to:(int)to
{
    
    return (int)from + arc4random() % (to-from+1);
    
}

@end
