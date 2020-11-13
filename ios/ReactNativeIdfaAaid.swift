import AdSupport
import AppTrackingTransparency
import Foundation

@objc(ReactNativeIdfaAaid)
class ReactNativeIdfaAaid: NSObject {

    @objc(getAdvertisingInfo:withRejecter:)
    func getAdvertisingInfo(resolve: @escaping RCTPromiseResolveBlock, reject: @escaping RCTPromiseRejectBlock) -> Void {
        if #available(iOS 14, *) {
            ATTrackingManager.requestTrackingAuthorization { status in
                switch status {
                    case .authorized:
                        // Tracking authorization dialog was shown
                        // and we are authorized
                        resolve([
                            "id": ASIdentifierManager.shared().advertisingIdentifier.uuidString,
                            "isAdTrackingLimited": false
                        ])
                    case .denied:
                        // Tracking authorization dialog was
                        // shown and permission is denied
                        resolve([
                            "id": nil,
                            "isAdTrackingLimited": true
                        ])
                    case .notDetermined:
                        // Tracking authorization dialog has not been shown
                        reject("@track_not_determined", "Tracking not determined", nil)
                    case .restricted:
                        reject("@track_restricted", "Tracking restricted", nil)
                    @unknown default:
                        reject("@track_unknown", "Tracking unknown", nil)
                }
            }
        } else {
            resolve([
                "id": ASIdentifierManager.shared().advertisingIdentifier.uuidString,
                "isAdTrackingLimited": false
            ])
        }
    }
}
