//
//  FollowTPModel.m
//  MathsPlay
//
//  Created by qainfotech on 11/20/13.
//  Copyright (c) 2013 qainfotech. All rights reserved.
//

#import "FollowTPModel.h"

@implementation FollowTPModel

+ (NSArray *)easyValues
{
    NSArray *easyValueArray = @[@"0",@"1",@"2",@"3",@"4",@"5",@"6",@"7",@"8",@"9"];
    return easyValueArray;
}

+ (NSArray *)mediumValues
{
    NSArray *mediumValueArray = @[@"10",@"11",@"12",@"13",@"14",@"15",@"16",@"17",@"18",@"19",@"20",@"21",@"22"];
    return mediumValueArray;
}

+ (NSArray *)hardValues
{
    NSArray *hardValueArray = @[@"100",@"101",@"102",@"103",@"104",@"105",@"106",@"107",@"108",@"109"];
    return hardValueArray;
}

@end
