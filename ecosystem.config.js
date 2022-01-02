module.exports = {
  /**
   * Application configuration section
   * http://pm2.keymetrics.io/docs/usage/application-declaration/
   */
  apps : [
    // First application
    {
      name : 'reflections',
      script : '/home/pi/signalk-server/bin/signalk-server',
      cwd : '/home/pi/signalk-server',
      env: {
          "PORT": 3000,
          "SIGNALK_NODE_CONFIG_DIR": "/home/pi/signalk-settings/.signalk"
      }
    }
  ]
};
