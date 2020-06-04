#import "SetAppIcon.h"

@implementation SetAppIcon

#define SYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(v)  ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] != NSOrderedAscending)

RCT_EXPORT_MODULE()

RCT_REMAP_METHOD(changeIcon, iconName:(NSString *)iconName resolver:(RCTPromiseResolveBlock)resolve rejecter:(RCTPromiseRejectBlock)reject) {
    NSError *error = nil;

    // Not supported
    if ([[UIApplication sharedApplication] supportsAlternateIcons] == NO) {
        reject(@"Error", @"Alternate icon not supported", error);
        RCTLog(@"Alternate icons are not supported");
        return;
    }

    NSString *currentIcon = [[UIApplication sharedApplication] alternateIconName];

    // If icon is already in use
    if ([iconName isEqualToString:currentIcon]) {
        reject(@"Error", @"Icon already in use", error);
        RCTLog(@"Icon already in use");
        return;
    }

    resolve(@(YES));

    // Custom icon
    [[UIApplication sharedApplication] setAlternateIconName:iconName completionHandler:^(NSError * _Nullable error) {
        RCTLog(@"%@", [error description]);
    }];
}

RCT_EXPORT_METHOD(getIconName:(RCTResponseSenderBlock) callback){
    NSString *name = @"default";
    NSDictionary *results;

    if( SYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(@"10.3") ){
        if( [[UIApplication sharedApplication] supportsAlternateIcons ] ){
            name = [[UIApplication sharedApplication] alternateIconName];
            if(name == nil){
                name = @"default";
            }
        }
    }

    results = @{
                @"iconName":name
                };
    callback(@[results]);
}

@end
