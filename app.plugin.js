const { createRunOncePlugin, withInfoPlist } = require('@expo/config-plugins');
const pkg = require('./package.json');

const USER_TRACKING =
  'Allow $(PRODUCT_NAME) to use data for tracking users or the device';

function withUserTracking(config, { description } = {}) {
  return withInfoPlist(config, config => {
    config.modResults['NSUserTrackingUsageDescription'] =
      description || USER_TRACKING;
    return config;
  });
}

module.exports = createRunOncePlugin(withUserTracking, pkg.name, pkg.version);
