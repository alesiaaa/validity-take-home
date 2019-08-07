const webpackConfig = require(`./build-utils/webpack.${process.env.NODE_ENV}.js`);

module.exports = webpackConfig;
