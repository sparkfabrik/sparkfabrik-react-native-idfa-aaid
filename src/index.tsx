import { NativeModules } from 'react-native';

type ReactNativeIdfaAaidType = {
  multiply(a: number, b: number): Promise<number>;
};

const { ReactNativeIdfaAaid } = NativeModules;

export default ReactNativeIdfaAaid as ReactNativeIdfaAaidType;
