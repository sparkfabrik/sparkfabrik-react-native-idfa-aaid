const path = require('path');
const { makeMetroConfig } = require('@rnx-kit/metro-config');

const localModulePath = path.resolve(__dirname, '../');

module.exports = makeMetroConfig({
  transformer: {
    getTransformOptions: async () => ({
      transform: {
        experimentalImportSupport: false,
        inlineRequires: false,
      },
    }),
  },
  resolver: {
    extraNodeModules: {
      '@sparkfabrik/react-native-idfa-aaid': localModulePath,
    },
  },
  watchFolders: [localModulePath],
});
