/********* CordovaPluginTiktokLogin.m Cordova Plugin Implementation *******/

#import <Cordova/CDV.h>
#import <TikTokOpenSDK/TikTokOpenSDKAuth.h>

@interface CordovaPluginTiktokLogin : CDVPlugin {
  // Member variables go here.
}

- (void)coolMethod:(CDVInvokedUrlCommand*)command;
- (void)login:(CDVInvokedUrlCommand*)command;
@end

@implementation CordovaPluginTiktokLogin

- (void)coolMethod:(CDVInvokedUrlCommand*)command
{
    CDVPluginResult* pluginResult = nil;
    NSString* echo = [command.arguments objectAtIndex:0];

    if (echo != nil && [echo length] > 0) {
        pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK messageAsString:echo];
    } else {
        pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_ERROR];
    }

    [self.commandDelegate sendPluginResult:pluginResult callbackId:command.callbackId];
}


- (void)login:(CDVInvokedUrlCommand*)command
{
    CDVPluginResult* pluginResult = nil;
    NSString* echo = [command.arguments objectAtIndex:0];

    // if (echo != nil && [echo length] > 0) {
    //     pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK messageAsString:echo];
    // } else {
    //     pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_ERROR];
    // }

    /* STEP 1: Create the request and set permissions */
NSArray *scopes = @"user.info.basic,video.list"; // list your scopes;
NSOrderedSet *scopesSet = [NSOrderedSet orderedSetWithArray:scopes];
TikTokOpenSDKAuthRequest *request = [[TikTokOpenSDKAuthRequest alloc] init];
request.permissions = scopesSet;

/* STEP 2: Send the request */
__weak typeof(self) ws = self;
[request sendAuthRequestViewController:self
                completion:^(TikTokOpenSDKAuthResponse *_Nonnull resp) {
    __strong typeof(ws) sf = ws;

    /* STEP 3: Parse and handle the response */
    if (resp.errCode == 0) {
        NSString *responseCode = resp.code;
        // Upload response code to your server and obtain user access token
        pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK messageAsString:responseCode];
    } else {
        // User authorization failed. Handle errors
        pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_ERROR];
    }
    [self.commandDelegate sendPluginResult:pluginResult callbackId:command.callbackId];
}];
}

@end
