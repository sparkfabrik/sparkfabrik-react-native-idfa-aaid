import * as React from 'react';
import { StyleSheet, View, Text } from 'react-native';
import ReactNativeIdfaAaid, {
  AdvertisingInfoResponse,
} from '@sparkfabrik/react-native-idfa-aaid';

export default function App() {
  const [result, setResult] = React.useState<AdvertisingInfoResponse>();

  React.useEffect(() => {
    ReactNativeIdfaAaid.getAdvertisingInfo()
      .then(setResult)
      .catch((err) => console.error(JSON.stringify(err)));
  }, []);

  return (
    <View style={styles.container}>
      <Text>Result: {result?.id}</Text>
    </View>
  );
}

const styles = StyleSheet.create({
  container: {
    flex: 1,
    alignItems: 'center',
    justifyContent: 'center',
  },
});
