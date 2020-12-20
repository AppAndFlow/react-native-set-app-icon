#import "React/RCTLog.h"
#import "SetAppIcon.h"

@implementation SetAppIcon

RCT_EXPORT_MODULE()

+ (BOOL)requiresMainQueueSetup
{
  return NO;
}

- (dispatch_queue_t)methodQueue
{
  return dispatch_get_main_queue();
}

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
            RCTLog(@"Alternate Icons are not supported on this device");
            return;
        }
    } else {
        reject(@"Error", @"This feature requires iOS 10.3 or higher", error);
        RCTLog(@"Alternate Icons are not supported on this device");
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
        reject(@"Error", @"This feature requires iOS 10.3 or higher", error);
        RCTLog(@"Alternate Icons are not supported on this device");
        return;
    }

    resolve(@(YES));

    // Custom icon
    if (@available(iOS 10.3, *)) {
        [[UIApplication sharedApplication] setAlternateIconName:iconName completionHandler:^(NSError * _Nullable error) {
            RCTLog(@"%@", [error description]);
        }];
    } else {
        reject(@"Error", @"This feature requires iOS 10.3 or higher", error);
        RCTLog(@"Alternate Icons are not supported on this device");
        return;
    }
}

RCT_EXPORT_METHOD(getIconName:(RCTResponseSenderBlock) callback){
    NSString *name = @"default";
    NSDictionary *results;

    if (@available(iOS 10.3, *)) {
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
