//
//  AppDelegate.h
//  MathsPlay
//
//  Created by qainfotech on 10/21/13.
//  Copyright (c) 2013 qainfotech. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>


@interface AppDelegate : UIResponder <UIApplicationDelegate>
{
    UIImageView *splashImage;
}
@property (strong, nonatomic) UIWindow *window;


@property (nonatomic, retain, readonly) NSManagedObjectModel *managedObjectModel;
@property (nonatomic, retain, readonly) NSManagedObjectContext *managedObjectContext;
@property (nonatomic, retain, readonly) NSPersistentStoreCoordinator *persistentStoreCoordinator ;
@end
