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


- (void)applicationDidFinishLaunching:(UIApplication *)application{
    for (id<XCModule> module in self.modules) {
        if ([module respondsToSelector:_cmd]) {
            [module applicationDidFinishLaunching:application];
        }
    }
}

#if UIKIT_STRING_ENUMS
typedef NSString * UIApplicationOpenURLOptionsKey NS_TYPED_ENUM;
#else
typedef NSString * UIApplicationOpenURLOptionsKey;
#endif

- (BOOL)application:(UIApplication *)app openURL:(NSURL *)url options:(NSDictionary<UIApplicationOpenURLOptionsKey, id> *)options NS_AVAILABLE_IOS(9_0){
    for (id<XCModule> module in self.modules) {
        if ([module respondsToSelector:_cmd]) {
            [module application:app openURL:url options:options];
        }
    }
    return YES;
}

- (void)applicationDidReceiveMemoryWarning:(UIApplication *)application{
    for (id<XCModule> module in self.modules) {
        if ([module respondsToSelector:_cmd]) {
            [module applicationDidReceiveMemoryWarning:application];
        }
    }
}

- (void)applicationSignificantTimeChange:(UIApplication *)application{
    for (id<XCModule> module in self.modules) {
        if ([module respondsToSelector:_cmd]) {
            [module applicationSignificantTimeChange:application];
        }
    }
}

- (void)application:(UIApplication *)application willChangeStatusBarOrientation:(UIInterfaceOrientation)newStatusBarOrientation duration:(NSTimeInterval)duration {
    for (id<XCModule> module in self.modules) {
        if ([module respondsToSelector:_cmd]) {
            [module application:application willChangeStatusBarOrientation:newStatusBarOrientation duration:duration];
        }
    }
}
- (void)application:(UIApplication *)application didChangeStatusBarOrientation:(UIInterfaceOrientation)oldStatusBarOrientation {
    for (id<XCModule> module in self.modules) {
        if ([module respondsToSelector:_cmd]) {
            [module application:application didChangeStatusBarOrientation:oldStatusBarOrientation];
        }
    }
}

- (void)application:(UIApplication *)application willChangeStatusBarFrame:(CGRect)newStatusBarFrame{
    for (id<XCModule> module in self.modules) {
        if ([module respondsToSelector:_cmd]) {
            [module application:application willChangeStatusBarFrame:newStatusBarFrame];
        }
    }
}
- (void)application:(UIApplication *)application didChangeStatusBarFrame:(CGRect)oldStatusBarFrame{
    for (id<XCModule> module in self.modules) {
        if ([module respondsToSelector:_cmd]) {
            [module application:application didChangeStatusBarFrame:oldStatusBarFrame];
        }
    }
}

- (void)application:(UIApplication *)application didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken{
    for (id<XCModule> module in self.modules) {
        if ([module respondsToSelector:_cmd]) {
            [module application:application didRegisterForRemoteNotificationsWithDeviceToken:deviceToken];
        }
    }
}

- (void)application:(UIApplication *)application didFailToRegisterForRemoteNotificationsWithError:(NSError *)error{
    for (id<XCModule> module in self.modules) {
        if ([module respondsToSelector:_cmd]) {
            [module application:application didFailToRegisterForRemoteNotificationsWithError:error];
        }
    }
}

#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wdeprecated-implementations"
// Called when your app has been activated by the user selecting an action from a local notification.
// A nil action identifier indicates the default action.
// You should call the completion handler as soon as you've finished handling the action.
- (void)application:(UIApplication *)application handleActionWithIdentifier:(nullable NSString *)identifier forLocalNotification:(UILocalNotification *)notification completionHandler:(void(^)())completionHandler NS_DEPRECATED_IOS(8_0, 10_0, "Use UserNotifications Framework's -[UNUserNotificationCenterDelegate didReceiveNotificationResponse:withCompletionHandler:]") __TVOS_PROHIBITED{
    for (id<XCModule> module in self.modules) {
        if ([module respondsToSelector:_cmd]) {
            [module application:application handleActionWithIdentifier:identifier forLocalNotification:notification completionHandler:completionHandler];
        }
    }
}

- (void)application:(UIApplication *)application handleActionWithIdentifier:(nullable NSString *)identifier forRemoteNotification:(NSDictionary *)userInfo withResponseInfo:(NSDictionary *)responseInfo completionHandler:(void(^)())completionHandler NS_DEPRECATED_IOS(9_0, 10_0, "Use UserNotifications Framework's -[UNUserNotificationCenterDelegate didReceiveNotificationResponse:withCompletionHandler:]") __TVOS_PROHIBITED{
    for (id<XCModule> module in self.modules) {
        if ([module respondsToSelector:_cmd]) {
            [module application:application handleActionWithIdentifier:identifier forRemoteNotification:userInfo withResponseInfo:responseInfo completionHandler:completionHandler];
        }
    }
}

// Called when your app has been activated by the user selecting an action from a remote notification.
// A nil action identifier indicates the default action.
// You should call the completion handler as soon as you've finished handling the action.
- (void)application:(UIApplication *)application handleActionWithIdentifier:(nullable NSString *)identifier forRemoteNotification:(NSDictionary *)userInfo completionHandler:(void(^)())completionHandler NS_DEPRECATED_IOS(8_0, 10_0, "Use UserNotifications Framework's -[UNUserNotificationCenterDelegate didReceiveNotificationResponse:withCompletionHandler:]") __TVOS_PROHIBITED{
    for (id<XCModule> module in self.modules) {
        if ([module respondsToSelector:_cmd]) {
            [module application:application handleActionWithIdentifier:identifier forRemoteNotification:userInfo completionHandler:completionHandler];
        }
    }
}

- (void)application:(UIApplication *)application handleActionWithIdentifier:(nullable NSString *)identifier forLocalNotification:(UILocalNotification *)notification withResponseInfo:(NSDictionary *)responseInfo completionHandler:(void(^)())completionHandler NS_DEPRECATED_IOS(9_0, 10_0, "Use UserNotifications Framework's -[UNUserNotificationCenterDelegate didReceiveNotificationResponse:withCompletionHandler:]") __TVOS_PROHIBITED{
    for (id<XCModule> module in self.modules) {
        if ([module respondsToSelector:_cmd]) {
            [module application:application handleActionWithIdentifier:identifier forLocalNotification:notification withResponseInfo:responseInfo completionHandler:completionHandler];
        }
    }
}
#pragma clang diagnostic pop

/*! This delegate method offers an opportunity for applications with the "remote-notification" background mode to fetch appropriate new data in response to an incoming remote notification. You should call the fetchCompletionHandler as soon as you're finished performing that operation, so the system can accurately estimate its power and data cost.
 
 This method will be invoked even if the application was launched or resumed because of the remote notification. The respective delegate methods will be invoked first. Note that this behavior is in contrast to application:didReceiveRemoteNotification:, which is not called in those cases, and which will not be invoked if this method is implemented. !*/
- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo fetchCompletionHandler:(void (^)(UIBackgroundFetchResult result))completionHandler NS_AVAILABLE_IOS(7_0){
    for (id<XCModule> module in self.modules) {
        if ([module respondsToSelector:_cmd]) {
            [module application:application didReceiveRemoteNotification:userInfo fetchCompletionHandler:completionHandler];
        }
    }
}

/// Applications with the "fetch" background mode may be given opportunities to fetch updated content in the background or when it is convenient for the system. This method will be called in these situations. You should call the fetchCompletionHandler as soon as you're finished performing that operation, so the system can accurately estimate its power and data cost.
- (void)application:(UIApplication *)application performFetchWithCompletionHandler:(void (^)(UIBackgroundFetchResult result))completionHandler API_AVAILABLE(ios(7.0), tvos(11.0)){
    for (id<XCModule> module in self.modules) {
        if ([module respondsToSelector:_cmd]) {
            [module application:application performFetchWithCompletionHandler:completionHandler];
        }
    }
}

// Called when the user activates your application by selecting a shortcut on the home screen,
// except when -application:willFinishLaunchingWithOptions: or -application:didFinishLaunchingWithOptions returns NO.
- (void)application:(UIApplication *)application performActionForShortcutItem:(UIApplicationShortcutItem *)shortcutItem completionHandler:(void(^)(BOOL succeeded))completionHandler NS_AVAILABLE_IOS(9_0) __TVOS_PROHIBITED{
    for (id<XCModule> module in self.modules) {
        if ([module respondsToSelector:_cmd]) {
            [module application:application performActionForShortcutItem:shortcutItem completionHandler:completionHandler];
        }
    }
}

// Applications using an NSURLSession with a background configuration may be launched or resumed in the background in order to handle the
// completion of tasks in that session, or to handle authentication. This method will be called with the identifier of the session needing
// attention. Once a session has been created from a configuration object with that identifier, the session's delegate will begin receiving
// callbacks. If such a session has already been created (if the app is being resumed, for instance), then the delegate will start receiving
// callbacks without any action by the application. You should call the completionHandler as soon as you're finished handling the callbacks.
- (void)application:(UIApplication *)application handleEventsForBackgroundURLSession:(NSString *)identifier completionHandler:(void (^)(void))completionHandler NS_AVAILABLE_IOS(7_0){
    for (id<XCModule> module in self.modules) {
        if ([module respondsToSelector:_cmd]) {
            [module application:application handleEventsForBackgroundURLSession:identifier completionHandler:completionHandler];
        }
    }
}

- (void)application:(UIApplication *)application handleWatchKitExtensionRequest:(nullable NSDictionary *)userInfo reply:(void(^)(NSDictionary * __nullable replyInfo))reply NS_AVAILABLE_IOS(8_2){
    for (id<XCModule> module in self.modules) {
        if ([module respondsToSelector:_cmd]) {
            [module application:application handleWatchKitExtensionRequest:userInfo reply:reply];
        }
    }
}

- (void)applicationShouldRequestHealthAuthorization:(UIApplication *)application NS_AVAILABLE_IOS(9_0){
    for (id<XCModule> module in self.modules) {
        if ([module respondsToSelector:_cmd]) {
            [module applicationShouldRequestHealthAuthorization:application];
        }
    }
}

- (void)application:(UIApplication *)application handleIntent:(INIntent *)intent completionHandler:(void(^)(INIntentResponse *intentResponse))completionHandler NS_AVAILABLE_IOS(11_0){
    for (id<XCModule> module in self.modules) {
        if ([module respondsToSelector:_cmd]) {
            [module application:application handleIntent:intent completionHandler:completionHandler];
        }
    }
}

- (void)applicationProtectedDataWillBecomeUnavailable:(UIApplication *)application NS_AVAILABLE_IOS(4_0){
    for (id<XCModule> module in self.modules) {
        if ([module respondsToSelector:_cmd]) {
            [module applicationProtectedDataWillBecomeUnavailable:application];
        }
    }
}
- (void)applicationProtectedDataDidBecomeAvailable:(UIApplication *)application    NS_AVAILABLE_IOS(4_0){
    for (id<XCModule> module in self.modules) {
        if ([module respondsToSelector:_cmd]) {
            [module applicationProtectedDataDidBecomeAvailable:application];
        }
    }
}


//- (UIInterfaceOrientationMask)application:(UIApplication *)application supportedInterfaceOrientationsForWindow:(nullable UIWindow *)window  NS_AVAILABLE_IOS(6_0) __TVOS_PROHIBITED{
//    for (id<XCModule> module in self.modules) {
//        if ([module respondsToSelector:_cmd]) {
//            [module application:application supportedInterfaceOrientationsForWindow:window];
//        }
//    }
//}

#if UIKIT_STRING_ENUMS
typedef NSString * UIApplicationExtensionPointIdentifier NS_TYPED_ENUM;
#else
typedef NSString * UIApplicationExtensionPointIdentifier;
#endif

// Applications may reject specific types of extensions based on the extension point identifier.
// Constants representing common extension point identifiers are provided further down.
// If unimplemented, the default behavior is to allow the extension point identifier.
- (BOOL)application:(UIApplication *)application shouldAllowExtensionPointIdentifier:(UIApplicationExtensionPointIdentifier)extensionPointIdentifier NS_AVAILABLE_IOS(8_0){
    for (id<XCModule> module in self.modules) {
        if ([module respondsToSelector:_cmd]) {
            [module application:application shouldAllowExtensionPointIdentifier:extensionPointIdentifier];
        }
    }
    return YES;
}

#pragma mark -- State Restoration protocol adopted by UIApplication delegate --

//- (nullable UIViewController *) application:(UIApplication *)application viewControllerWithRestorationIdentifierPath:(NSArray<NSString *> *)identifierComponents coder:(NSCoder *)coder NS_AVAILABLE_IOS(6_0){
//    for (id<XCModule> module in self.modules) {
//        if ([module respondsToSelector:_cmd]) {
//            [module application:application viewControllerWithRestorationIdentifierPath:identifierComponents coder:coder];
//        }
//    }
//}
- (BOOL) application:(UIApplication *)application shouldSaveApplicationState:(NSCoder *)coder NS_AVAILABLE_IOS(6_0){
    for (id<XCModule> module in self.modules) {
        if ([module respondsToSelector:_cmd]) {
            [module application:application shouldSaveApplicationState:coder];
        }
    }
    return YES;
}
- (BOOL) application:(UIApplication *)application shouldRestoreApplicationState:(NSCoder *)coder NS_AVAILABLE_IOS(6_0){
    for (id<XCModule> module in self.modules) {
        if ([module respondsToSelector:_cmd]) {
            [module application:application shouldRestoreApplicationState:coder];
        }
    }
    return YES;
}
- (void) application:(UIApplication *)application willEncodeRestorableStateWithCoder:(NSCoder *)coder NS_AVAILABLE_IOS(6_0){
    for (id<XCModule> module in self.modules) {
        if ([module respondsToSelector:_cmd]) {
            [module application:application willEncodeRestorableStateWithCoder:coder];
        }
    }
}
- (void) application:(UIApplication *)application didDecodeRestorableStateWithCoder:(NSCoder *)coder NS_AVAILABLE_IOS(6_0){
    for (id<XCModule> module in self.modules) {
        if ([module respondsToSelector:_cmd]) {
            [module application:application didDecodeRestorableStateWithCoder:coder];
        }
    }
}

#pragma mark -- User Activity Continuation protocol adopted by UIApplication delegate --

// Called on the main thread as soon as the user indicates they want to continue an activity in your application. The NSUserActivity object may not be available instantly,
// so use this as an opportunity to show the user that an activity will be continued shortly.
// For each application:willContinueUserActivityWithType: invocation, you are guaranteed to get exactly one invocation of application:continueUserActivity: on success,
// or application:didFailToContinueUserActivityWithType:error: if an error was encountered.
- (BOOL)application:(UIApplication *)application willContinueUserActivityWithType:(NSString *)userActivityType NS_AVAILABLE_IOS(8_0){
    for (id<XCModule> module in self.modules) {
        if ([module respondsToSelector:_cmd]) {
            [module application:application willContinueUserActivityWithType:userActivityType];
        }
    }
    return YES;
}

// Called on the main thread after the NSUserActivity object is available. Use the data you stored in the NSUserActivity object to re-create what the user was doing.
// You can create/fetch any restorable objects associated with the user activity, and pass them to the restorationHandler. They will then have the UIResponder restoreUserActivityState: method
// invoked with the user activity. Invoking the restorationHandler is optional. It may be copied and invoked later, and it will bounce to the main thread to complete its work and call
// restoreUserActivityState on all objects.
- (BOOL)application:(UIApplication *)application continueUserActivity:(NSUserActivity *)userActivity restorationHandler:(void(^)(NSArray<id<UIUserActivityRestoring>> * __nullable restorableObjects))restorationHandler NS_AVAILABLE_IOS(8_0){
    for (id<XCModule> module in self.modules) {
        if ([module respondsToSelector:_cmd]) {
            [module application:application continueUserActivity:userActivity restorationHandler:restorationHandler];
        }
    }
    return YES;
}

// If the user activity cannot be fetched after willContinueUserActivityWithType is called, this will be called on the main thread when implemented.
- (void)application:(UIApplication *)application didFailToContinueUserActivityWithType:(NSString *)userActivityType error:(NSError *)error NS_AVAILABLE_IOS(8_0){
    for (id<XCModule> module in self.modules) {
        if ([module respondsToSelector:_cmd]) {
            [module application:application didFailToContinueUserActivityWithType:userActivityType error:error];
        }
    }
}

// This is called on the main thread when a user activity managed by UIKit has been updated. You can use this as a last chance to add additional data to the userActivity.
- (void)application:(UIApplication *)application didUpdateUserActivity:(NSUserActivity *)userActivity NS_AVAILABLE_IOS(8_0){
    for (id<XCModule> module in self.modules) {
        if ([module respondsToSelector:_cmd]) {
            [module application:application didUpdateUserActivity:userActivity];
        }
    }
}

#pragma mark -- CloudKit Sharing Invitation Handling --
// This will be called on the main thread after the user indicates they want to accept a CloudKit sharing invitation in your application.
// You should use the CKShareMetadata object's shareURL and containerIdentifier to schedule a CKAcceptSharesOperation, then start using
// the resulting CKShare and its associated record(s), which will appear in the CKContainer's shared database in a zone matching that of the record's owner.
- (void) application:(UIApplication *)application userDidAcceptCloudKitShareWithMetadata:(CKShareMetadata *)cloudKitShareMetadata NS_AVAILABLE_IOS(10_0){
    for (id<XCModule> module in self.modules) {
        if ([module respondsToSelector:_cmd]) {
            [module application:application userDidAcceptCloudKitShareWithMetadata:cloudKitShareMetadata];
        }
    }
}


@end
