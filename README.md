@sparkfabrik/react-native-idfa-aaid
# React Native module to get IDFA (iOS) or AAID (Android)

## Intro

[React Native](https://reactnative.dev/) is a framework for creating native mobile apps based on React.

The **Advertising Identifier** ([IDFA](https://developer.apple.com/documentation/adsupport/asidentifiermanager) on iOS, [AAID](https://developer.android.com/training/articles/ad-id) on Android) is a device-specific, unique, resettable ID for advertising that allows developers and marketers to track activity for advertising purposes.

This npm module allows any mobile application built with React Native to access the Advertising ID, following the OS specific definition and user permissions.

The module output in the RN framework is the following:

```ts
interface AdvertisingInfoResponse {
  id: string; // the Advertising ID (or null if not defined/permitted)
  isAdTrackingLimited: boolean; // the user defined permission to track
}
```

## Supported platform

- Android
- iOS

## Installation

```sh
npm install @sparkfabrik/react-native-idfa-aaid
```
or

```sh
yarn add @sparkfabrik/react-native-idfa-aaid
```

Then run `pod install` in your `ios` folder after installation.

## Usage

### iOS configuration

For `native` apps, in `info.plist` make sure to add:

```xml
<key>NSUserTrackingUsageDescription</key>
<string>...</string>
```

For `Expo` apps, in `app.json` make sure to add:

```json
{
  "expo": {
    "plugins": [
      [
        "expo-tracking-transparency",
        {
          "userTrackingPermission": "..."
        }
      ]
    ]
  }
}

```

### React Native components

Example of a basic integration in a RN component.

```js
import ReactNativeIdfaAaid, { AdvertisingInfoResponse } from '@sparkfabrik/react-native-idfa-aaid';

const MyComponent: React.FC = () => {
  const [idfa, setIdfa] = useState<string | null>();

  useEffect(() => {
    ReactNativeIdfaAaid.getAdvertisingInfo()
      .then((res: AdvertisingInfoResponse) =>
        !res.isAdTrackingLimited ? setIdfa(res.id) : setIdfa(null),
      )
      .catch((err) => {
        console.log(err);
        return setIdfa(null);
      });
  }, []);
```

## Contributing

See the [contributing guide](CONTRIBUTING.md) to learn how to contribute to the repository and the development workflow.

## License

MIT
