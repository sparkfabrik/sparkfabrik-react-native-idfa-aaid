import AdSupport
import AppTrackingTransparency
import Foundation

@objc(ReactNativeIdfaAaid)
class ReactNativeIdfaAaid: NSObject {
  
    @objc
    static func requiresMainQueueSetup() -> Bool {
        return false
    }

    @objc(getAdvertisingInfo:withRejecter:)
    func getAdvertisingInfo(resolve: @escaping RCTPromiseResolveBlock, reject: @escaping RCTPromiseRejectBlock) -> Void {
        getAdvertisingInfoAndCheckAuthorization(false, resolve: resolve, reject: reject)
    }

    /// Use this to enable an additional check and prevent a iOS 17.4 bug which causes the callback to be invoked immediately with a value of `status = denied`,
    /// even though the true value of `ATTrackingManager.trackingAuthorizationStatus`` is still `notDetermined` because the user has not yet made a choice by responding to the tracking consent popup.
    @objc(getAdvertisingInfoAndCheckAuthorization:withResolver:withRejecter:)
    func getAdvertisingInfoAndCheckAuthorization(_ checkAuthorization: Bool, resolve: @escaping RCTPromiseResolveBlock, reject: @escaping RCTPromiseRejectBlock) -> Void {
        if #available(iOS 14, *) {
            ATTrackingManager.requestTrackingAuthorization { [weak self] status in
                switch status {
                    case .authorized:
                        // Tracking authorization dialog was shown
                        // and we are authorized
                        resolve([
                            "id": ASIdentifierManager.shared().advertisingIdentifier.uuidString,
                            "isAdTrackingLimited": false
                        ])
                    case .denied:
                        if checkAuthorization, ATTrackingManager.trackingAuthorizationStatus == .notDetermined {
                            // iOS 17.4 authorization bug detected
                            self?.addObserver(resolve: resolve, reject: reject)
                        } else {
                            // Tracking authorization dialog was
                            // shown and permission is denied
                            resolve([
                                "id": nil,
                                "isAdTrackingLimited": true
                            ])
                        }
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
    
    private weak var observer: NSObjectProtocol?
    
    private func addObserver(resolve: @escaping RCTPromiseResolveBlock, reject: @escaping RCTPromiseRejectBlock) {
        removeObserver()
        
        observer = NotificationCenter.default.addObserver(
            forName: UIApplication.didBecomeActiveNotification,
            object: nil,
            queue: .main
        ) { [weak self] _ in
            self?.getAdvertisingInfoAndCheckAuthorization(true, resolve: resolve, reject: reject)
        }
    }
    
    private func removeObserver() {
        if let observer {
            NotificationCenter.default.removeObserver(observer)
        }
    }
}
