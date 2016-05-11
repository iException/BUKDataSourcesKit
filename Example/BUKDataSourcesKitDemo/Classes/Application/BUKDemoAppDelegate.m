//
//  BUKAppDelegate.m
//  BUKDataSourcesKit
//
//  Created by Yiming Tang on 12/15/2015.
//  Copyright (c) 2015 Yiming Tang. All rights reserved.
//

#import "BUKDemoAppDelegate.h"
#import "BUKDemoRootViewController.h"


@implementation BUKDemoAppDelegate

#pragma mark - Accessors

@synthesize window = _window;

- (UIWindow *)window {
    if (!_window) {
        _window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
        _window.backgroundColor = [UIColor whiteColor];
    }
    return _window;
}


#pragma mark - UIApplicationDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    BUKDemoRootViewController *demoViewController = [[BUKDemoRootViewController alloc] init];
    self.window.rootViewController = [[UINavigationController alloc] initWithRootViewController:demoViewController];
    [self.window makeKeyAndVisible];
    return YES;
}

@end
