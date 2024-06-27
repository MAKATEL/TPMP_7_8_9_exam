//
//  AppDelegate.m
//  9lab_example5_KlimkoEugene
//
//  Created by MacOSExi on 17.05.24.
//  Copyright © 2024 MacOSExi. All rights reserved.
//

#import "AppDelegate.h"
#import "Model+CoreDataModel.h"
#import <CoreData/CoreData.h>

@interface AppDelegate ()

@property (readonly, strong) NSPersistentContainer *persistentContainer;

@end

@implementation AppDelegate

@synthesize persistentContainer = _persistentContainer;

- (NSManagedObjectContext *)managedObjectContext {
    return self.persistentContainer.viewContext;
}

- (NSManagedObjectModel *)managedObjectModel {
    return self.persistentContainer.managedObjectModel;
}

- (NSPersistentStoreCoordinator *)persistentStoreCoordinator {
    return self.persistentContainer.persistentStoreCoordinator;
}

- (NSURL *)applicationDocumentsDirectory {
    return [[[NSFileManager defaultManager] URLsForDirectory:NSDocumentDirectory inDomains:NSUserDomainMask] lastObject];
}

- (NSPersistentContainer *)persistentContainer {
    if (_persistentContainer == nil) {
        _persistentContainer = [[NSPersistentContainer alloc] initWithName:@"Model"];
        [_persistentContainer loadPersistentStoresWithCompletionHandler:^(NSPersistentStoreDescription *storeDescription, NSError *error) {
            if (error != nil) {
                NSLog(@"Unresolved error %@, %@", error, error.userInfo);
                abort();
            }
        }];
    }
    return _persistentContainer;
}

- (void)saveContext {
    NSManagedObjectContext *context = self.managedObjectContext;
    NSError *error = nil;
    if ([context hasChanges] && ![context save:&error]) {
        NSLog(@"Unresolved error %@, %@", error, error.userInfo);
        abort();
    }
}

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    if (![[NSUserDefaults standardUserDefaults] boolForKey:@"HasLaunchedOnce"]) {
        [[NSUserDefaults standardUserDefaults] setBool:YES forKey:@"HasLaunchedOnce"];
        [[NSUserDefaults standardUserDefaults] synchronize];
        
        Record *firstFlight = [NSEntityDescription insertNewObjectForEntityForName:@"Record" inManagedObjectContext:self.managedObjectContext];
        firstFlight.cityFrom = @"Челябинск";
        firstFlight.cityTo = @"Москва";
        firstFlight.aviaCompany = @"Аэрофлот";
        firstFlight.price = 1000.0;
        
        Record *secondFlight = [NSEntityDescription insertNewObjectForEntityForName:@"Record" inManagedObjectContext:self.managedObjectContext];
        secondFlight.cityFrom = @"Челябинск";
        secondFlight.cityTo = @"Москва";
        secondFlight.aviaCompany = @"ЧелАвиа";
        secondFlight.price = 2000.0;
        
        Record *thirdFlight = [NSEntityDescription insertNewObjectForEntityForName:@"Record" inManagedObjectContext:self.managedObjectContext];
        thirdFlight.cityFrom = @"Екатеринбург";
        thirdFlight.cityTo = @"Уфа";
        thirdFlight.aviaCompany = @"Аэрофлот";
        thirdFlight.price = 500.0;
        
        Record *fourthFlight = [NSEntityDescription insertNewObjectForEntityForName:@"Record" inManagedObjectContext:self.managedObjectContext];
        fourthFlight.cityFrom = @"Челябинск";
        fourthFlight.cityTo = @"Уфа";
        fourthFlight.aviaCompany = @"РусЛайн";
        fourthFlight.price = 1500.0;
        
        Record *fifthFlight = [NSEntityDescription insertNewObjectForEntityForName:@"Record" inManagedObjectContext:self.managedObjectContext];
        fifthFlight.cityFrom = @"Екатеринбург";
        fifthFlight.cityTo = @"Москва";
        fifthFlight.aviaCompany = @"Аэрофлот";
        fifthFlight.price = 800.0;
        
        [self saveContext];
    }
    return YES;
}

#pragma mark - UISceneSession lifecycle

- (UISceneConfiguration *)application:(UIApplication *)application configurationForConnectingSceneSession:(UISceneSession *)connectingSceneSession options:(UISceneConnectionOptions *)options {
    return [[UISceneConfiguration alloc] initWithName:@"Default Configuration" sessionRole:connectingSceneSession.role];
}

- (void)application:(UIApplication *)application didDiscardSceneSessions:(NSSet<UISceneSession *> *)sceneSessions {
}

@end
