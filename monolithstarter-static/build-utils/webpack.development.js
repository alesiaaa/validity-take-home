const webpack = require('webpack');
const Merge = require('webpack-merge');
const CommonConfig = require('./webpack.common.js');
const HtmlWebpackPlugin = require('html-webpack-plugin');
const PATHS = require('./common-paths');
const WebpackBar = require('webpackbar'); // better terminal output

module.exports = Merge(CommonConfig, {
  devtool: 'eval-cheap-module-source-map',
  mode: 'development',
  output: {
    path: PATHS.dist,
    filename: '[name].bundle.js'
  },
  devServer: {
    port: 9000,
    historyApiFallback: {
      index: '/assets/'
    },
    noInfo: true,
    stats: 'minimal',
    contentBase: PATHS.appSrc,
    hot: true,
    inline: true,
    watchContentBase: false, // true here will reload the browser everything any time a file changes in src
    compress: true
  },
  plugins: [
    new HtmlWebpackPlugin({
      template: `${PATHS.public}/index.html`,
      inject: 'body',
      alwaysWriteToDisk: false
    }),
    new webpack.NamedModulesPlugin(),
    new webpack.HotModuleReplacementPlugin(),

    new WebpackBar()
  ],
  module: {
    rules: [
      {
        test: /\.scss$/,
        use: [
          require.resolve('style-loader'), // creates style nodes from JS strings
          require.resolve('css-loader'), // translates CSS into CommonJS
          require.resolve('sass-loader') // compiles Sass to CSS, using Node Sass by default
        ]
      },
      {
        test: /\.css$/,
        use: [
          require.resolve('style-loader'), // creates style nodes from JS strings
          require.resolve('css-loader') // translates CSS into CommonJS
        ]
      }
    ]
  }
});
