package com.sparkfabrikreactnativeidfaaaid

import android.util.Log;

import com.facebook.react.bridge.ReactApplicationContext
import com.facebook.react.bridge.ReactContextBaseJavaModule
import com.facebook.react.bridge.ReactMethod
import com.facebook.react.bridge.Promise
import com.facebook.react.bridge.WritableNativeMap

import com.google.android.gms.ads.identifier.AdvertisingIdClient;

class ReactNativeIdfaAaidModule(private val reactContext: ReactApplicationContext) : ReactContextBaseJavaModule(reactContext) {

    override fun getName(): String {
        return "ReactNativeIdfaAaid"
    }

    @ReactMethod
    fun getAdvertisingInfo(promise: Promise): Unit {
        val ret = WritableNativeMap()

        try {
            val adInfo = AdvertisingIdClient.getAdvertisingIdInfo(this.reactContext)
            ret.putString("id", adInfo?.id)
            ret.putBoolean("isAdTrackingLimited", false)
        } catch (e: Exception) {
            Log.e(this.getName(), "Failed to connect to Advertising ID provider.")
            promise.reject("Error getting aaid.", e)
        }
        promise.resolve(ret)
    }
}
