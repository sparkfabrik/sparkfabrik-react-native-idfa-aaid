const {getDefaultConfig, mergeConfig} = require('@react-native/metro-config');
const path = require('path');

/**
 * Metro configuration
 * https://facebook.github.io/metro/docs/configuration
 *
 * @type {import('metro-config').MetroConfig}
 */
const config = {
  resolver: {
    nodeModulesPaths: [
      path.join(__dirname, 'node_modules', '@sparkfabrik/react-native-idfa-aaid',),
    ],
  },
  watchFolders: [
    path.join(__dirname, 'node_modules', '@sparkfabrik/react-native-idfa-aaid'),
  ],
};

module.exports = mergeConfig(getDefaultConfig(__dirname), config);
