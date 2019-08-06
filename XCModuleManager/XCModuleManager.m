//
//  XCModuleManager.m
//  test
//
//  Created by XiaoCheng on 05/08/2019.
//  Copyright © 2019 bub chain. All rights reserved.
//

#import "XCModuleManager.h"

@interface XCModuleManager ()

@property (nonatomic, strong) NSMutableArray<id<XCModule>> *modules;

@end

@implementation XCModuleManager

+ (instancetype)sharedInstance
{
    static XCModuleManager *instance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[[self class] alloc] init];
    });
    return instance;
}


- (NSMutableArray<id<XCModule>> *)modules
{
    if (!_modules) {
        _modules = [NSMutableArray array];
    }
    return _modules;
}

- (void)addModule:(id<XCModule>) module
{
    if (![self.modules containsObject:module]) {
        [self.modules addObject:module];
    }
}

- (void)loadModulesWithPlistFile:(NSString *)plistFile
{
    NSArray<NSString *> *moduleNames = [NSArray arrayWithContentsOfFile:plistFile];
    for (NSString *moduleName in moduleNames) {
        id<XCModule> module = [[NSClassFromString(moduleName) alloc] init];
        [self addModule:module];
    }
}

- (NSArray<id<XCModule>> *)allModules
{
    return self.modules;
}

#pragma mark - UIApplicationDelegate's methods

- (BOOL)application:(UIApplication *)application willFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    for (id<XCModule> module in self.modules) {
        if ([module respondsToSelector:_cmd]) {
            [module application:application willFinishLaunchingWithOptions:launchOptions];
        }
    }
    return YES;
}

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    for (id<XCModule> module in self.modules) {
        if ([module respondsToSelector:_cmd]) {
            [module application:application didFinishLaunchingWithOptions:launchOptions];
        }
    }
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application
{
    for (id<XCModule> module in self.modules) {
        if ([module respondsToSelector:_cmd]) {
            [module applicationWillResignActive:application];
        }
    }
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    for (id<XCModule> module in self.modules) {
        if ([module respondsToSelector:_cmd]) {
            [module applicationDidEnterBackground:application];
        }
    }
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    for (id<XCModule> module in self.modules) {
        if ([module respondsToSelector:_cmd]) {
            [module applicationWillEnterForeground:application];
        }
    }
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    for (id<XCModule> module in self.modules) {
        if ([module respondsToSelector:_cmd]) {
            [module applicationDidBecomeActive:application];
        }
    }
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    for (id<XCModule> module in self.modules) {
        if ([module respondsToSelector:_cmd]) {
            [module applicationWillTerminate:application];
        }
    }
}

@end
