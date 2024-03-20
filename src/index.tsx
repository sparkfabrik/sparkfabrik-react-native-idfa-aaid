import { NativeModules } from 'react-native';

export type AdvertisingInfoResponse = {
  id: string | null;
  isAdTrackingLimited: boolean;
};

type ReactNativeIdfaAaidType = {
  getAdvertisingInfo(): Promise<AdvertisingInfoResponse>;
  getAdvertisingInfoAndCheckAuthorization(
    check: boolean
  ): Promise<AdvertisingInfoResponse>;
};

const { ReactNativeIdfaAaid } = NativeModules;

export default ReactNativeIdfaAaid as ReactNativeIdfaAaidType;
