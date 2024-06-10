#import <React/RCTBridgeModule.h>

@interface RCT_EXTERN_MODULE(ReactNativeIdfaAaid, NSObject)

RCT_EXTERN_METHOD(getAdvertisingInfo:(RCTPromiseResolveBlock)resolve withRejecter:(RCTPromiseRejectBlock)reject)

/// Use this to enable an additional check and prevent a iOS 17.4 bug which causes the callback to be invoked immediately with a value of `status = denied`,
/// even though the true value of `ATTrackingManager.trackingAuthorizationStatus`` is still `notDetermined` because the user has not yet made a choice by responding to the tracking consent popup.
RCT_EXTERN_METHOD(getAdvertisingInfoAndCheckAuthorization:(BOOL)checkAuthorization withResolver:(RCTPromiseResolveBlock)resolve withRejecter:(RCTPromiseRejectBlock)reject)

@end
