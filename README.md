# IOS GUIDE

## INSTALL

cordova plugin add ../CordovaPluginTiktokLogin

## Info.plist

Replace $TikTokAppID with your App's Client Key

If you have any issues in installation then refer to this link https://developers.tiktok.com/doc/getting-started-ios-quickstart-objective-c/

## Connect App Delegate and/or Scene Delegate

#import <TikTokOpenSDK/TikTokOpenSDKApplicationDelegate.h>
@implementation AppDelegate
- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    [[TikTokOpenSDKApplicationDelegate sharedInstance] application:application didFinishLaunchingWithOptions:launchOptions];
    return YES;
}

- (BOOL)application:(UIApplication *)application openURL:(nonnull NSURL *)url options:(nonnull NSDictionary<UIApplicationOpenURLOptionsKey,id> *)options {

    if ([[TikTokOpenSDKApplicationDelegate sharedInstance] application:application openURL:url sourceApplication:options[UIApplicationOpenURLOptionsSourceApplicationKey] annotation:options[UIApplicationOpenURLOptionsAnnotationKey]]
        ) {
        return YES;
    }
    return NO;
}

- (BOOL)application:(UIApplication *)application openURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication annotation:(id)annotation
{
    if ([[TikTokOpenSDKApplicationDelegate sharedInstance] application:application openURL:url sourceApplication:sourceApplication annotation:annotation]) {
        return YES;
    }
    return NO;
}

- (BOOL)application:(UIApplication *)application handleOpenURL:(NSURL *)url
{
    if ([[TikTokOpenSDKApplicationDelegate sharedInstance] application:application openURL:url sourceApplication:nil annotation:nil]) {
        return YES;
    }
    return NO;
}
@end




## If your application does not have a SceneDelegate, you are good to go! If your application makes use of the SceneDelegate, you will need to add the following code to your SceneDelegate.m file.

#import <TikTokOpenSDK/TikTokOpenSDKApplicationDelegate.h>
@implementation SceneDelegate

- (void)scene:(UIScene *)scene openURLContexts:(NSSet<UIOpenURLContext *> *)URLContexts
{
    NSURL *url = [[URLContexts allObjects] firstObject].URL;
    [UIApplication.sharedApplication.delegate application:UIApplication.sharedApplication openURL:url options:@{}];
}

@end