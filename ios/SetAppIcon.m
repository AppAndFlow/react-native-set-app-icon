#import "React/RCTLog.h"
#import "SetAppIcon.h"

@implementation SetAppIcon

#define SYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(v)  ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] != NSOrderedAscending)

RCT_EXPORT_MODULE()

RCT_REMAP_METHOD(supportsDynamicAppIcon, resolver:(RCTPromiseResolveBlock)resolve rejecter:(RCTPromiseRejectBlock)reject)
{
    if (@available(iOS 10.3, *)) {
        bool supported = [[UIApplication sharedApplication] supportsAlternateIcons];
        resolve(@(supported));
    } else {
        resolve(@(NO));
    }
}

RCT_REMAP_METHOD(changeIcon, iconName:(NSString *)iconName resolver:(RCTPromiseResolveBlock)resolve rejecter:(RCTPromiseRejectBlock)reject) {
    NSError *error = nil;

    // Not supported
    if (@available(iOS 10.3, *)) {
        if ([[UIApplication sharedApplication] supportsAlternateIcons] == NO) {
            reject(@"Error", @"Alternate icon not supported", error);
            RCTLog(@"Alternate icons are not supported");
            return;
        }
    } else {
        reject(@"Error", @"Need IOS Version 10.3 at least", error);
        RCTLog(@"Alternate icons are not supported");
        return;
    }

    if (@available(iOS 10.3, *)) {
        NSString *currentIcon = [[UIApplication sharedApplication] alternateIconName];

        // If icon is already in use
        if ([iconName isEqualToString:currentIcon]) {
            reject(@"Error", @"Icon already in use", error);
            RCTLog(@"Icon already in use");
            return;
        }
    } else {
        reject(@"Error", @"Need IOS Version 10.3 at least", error);
        RCTLog(@"Alternate icons are not supported");
        return;
    }

    resolve(@(YES));

    // Custom icon
    if (@available(iOS 10.3, *)) {
        [[UIApplication sharedApplication] setAlternateIconName:iconName completionHandler:^(NSError * _Nullable error) {
            RCTLog(@"%@", [error description]);
        }];
    } else {
        reject(@"Error", @"Need IOS Version 10.3 at least", error);
        RCTLog(@"Alternate icons are not supported");
        return;
    }
}

RCT_EXPORT_METHOD(getIconName:(RCTResponseSenderBlock) callback){
    NSString *name = @"default";
    NSDictionary *results;

    if( SYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(@"10.3") ){
        if (@available(iOS 10.3, *)) {
            if( [[UIApplication sharedApplication] supportsAlternateIcons ] ){
                name = [[UIApplication sharedApplication] alternateIconName];
                if(name == nil){
                    name = @"default";
                }
            }
        } else {
            reject(@"Error", @"Need IOS Version 10.3 at least", error);
            RCTLog(@"Alternate icons are not supported");
            return;
        }
    }

    results = @{
                @"iconName":name
                };
    callback(@[results]);
}

@end
