//
//  AppDelegate.m
//  MathsPlay
//
//  Created by qainfotech on 10/21/13.
//  Copyright (c) 2013 qainfotech. All rights reserved.
//

#import "AppDelegate.h"
#import "HomeScreenViewController.h"

@implementation AppDelegate
@synthesize managedObjectContext = _managedObjectContext;
@synthesize managedObjectModel = _managedObjectModel;

@synthesize persistentStoreCoordinator = _persistentStoreCoordinator;

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    // Override point for customization after application launch.
    self.window.backgroundColor = [UIColor whiteColor];
    // splash screen
    splashImage = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"splashscreen"]];
    splashImage.frame = CGRectMake(0, 0, 768, 1024);
    [self.window addSubview:splashImage];
    [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(fadeScreen) userInfo:nil repeats:NO];
    self.window.rootViewController = [[UIViewController alloc]init];
    [self.window makeKeyAndVisible];
    return YES;
}


- (void)fadeScreen
{
    [splashImage removeFromSuperview];
    HomeScreenViewController *homeController = [[HomeScreenViewController alloc]init];
    UINavigationController *navigation = [[UINavigationController alloc]initWithRootViewController:homeController];
    navigation.navigationBar.translucent = NO;
    if (NSFoundationVersionNumber <=NSFoundationVersionNumber_iOS_6_1)
    {
        navigation.navigationBar.tintColor = [UIColor colorWithRed:65/255.0 green:105/255.0 blue:225/255.0 alpha:1.0];
    }
    else
    {
        navigation.navigationBar.barTintColor = [UIColor colorWithRed:30/255.0 green:144/255.0 blue:255/255.0 alpha:1.0];
    }
    self.window.rootViewController = navigation;
    [self.window addSubview:navigation.view];
}
- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}


#pragma Mark CoreData methods

- (NSManagedObjectContext *) managedObjectContext {
    if (_managedObjectContext != nil) {
        return _managedObjectContext;
    }
    NSPersistentStoreCoordinator *coordinator = [self persistentStoreCoordinator];
    if (coordinator != nil) {
        _managedObjectContext = [[NSManagedObjectContext alloc] init];
        [_managedObjectContext setPersistentStoreCoordinator: coordinator];
    }
    return _managedObjectContext;
}


- (NSManagedObjectModel *)managedObjectModel {
    if (_managedObjectModel != nil) {
        return _managedObjectModel;
    }
    _managedObjectModel = [NSManagedObjectModel mergedModelFromBundles:nil];
    return _managedObjectModel;
}


- (NSPersistentStoreCoordinator *)persistentStoreCoordinator {
    if (_persistentStoreCoordinator != nil) {
        return _persistentStoreCoordinator;
    }
    
    NSString *storePath = [[self applicationDocumentsDirectory]
                           stringByAppendingPathComponent: @"Questionare.sqlite"];
    NSURL *storeUrl;
    if (storePath) {
        storeUrl = [NSURL fileURLWithPath:storePath];
        
        NSFileManager *fileManager = [NSFileManager defaultManager];
        if (![fileManager fileExistsAtPath:storePath]) {
            NSString *defaultStorePath = [[NSBundle mainBundle]
                                          pathForResource:@"Questionare" ofType:@"sqlite"];
            if (defaultStorePath) {
                [fileManager copyItemAtPath:defaultStorePath toPath:storePath error:NULL];
            }
        }
    }
    else
    {
        storeUrl = [NSURL fileURLWithPath: [[self applicationDocumentsDirectory]
                                            stringByAppendingPathComponent: @"Questionare.sqlite"]];
    }
    NSDictionary *options = @{ NSSQLitePragmasOption : @{@"journal_mode" : @"DELETE"} };//for prepopulating persistence store.
    NSError *error = nil;
    _persistentStoreCoordinator = [[NSPersistentStoreCoordinator alloc]
                                   initWithManagedObjectModel:[self managedObjectModel]];
    if(![_persistentStoreCoordinator addPersistentStoreWithType:NSSQLiteStoreType
                                                  configuration:nil URL:storeUrl options:options error:&error]) {
    }
    return _persistentStoreCoordinator;
}


-(void) checkAndCreateDatabase{
    NSString  *databaseName=@"Questionare.sqlite";
    NSArray *documentPath=NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDir = [documentPath objectAtIndex:0];
    NSString	*databasePath = [documentsDir stringByAppendingPathComponent:databaseName];
	
    BOOL success;
	NSFileManager *fileManager = [NSFileManager defaultManager];
    success = [fileManager fileExistsAtPath:databasePath];
    if(success) return;
	NSString *databasePathFromApp = [[[NSBundle mainBundle] resourcePath] stringByAppendingPathComponent:databaseName];
    [fileManager copyItemAtPath:databasePathFromApp toPath:databasePath error:nil];
}

- (NSString *)applicationDocumentsDirectory {
    return [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
}

@end
