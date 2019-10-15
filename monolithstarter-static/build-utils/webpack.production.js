const webpack = require("webpack");
const path = require("path");
const Merge = require("webpack-merge");
const CommonConfig = require("./webpack.common.js");
const HtmlWebpackPlugin = require("html-webpack-plugin");
const CleanWebpackPlugin = require("clean-webpack-plugin");
const PATHS = require("./common-paths");
const UglifyJsPlugin = require("uglifyjs-webpack-plugin");
const MiniCssExtractPlugin = require("mini-css-extract-plugin");
const pjson = require("../package.json");

// Assert this just to be safe.
// Development builds of React are slow and not intended for production.
if (process.env.NODE_ENV !== "production") {
  throw new Error("Production builds must have NODE_ENV=production.");
}

const htmlFile = process.env.DEPLOY_MODE === "true" ? path.resolve(
  __dirname,
  "../../monolithstarter-svc/src/main/resources/templates/main.html"
) : path.resolve(__dirname, "../build/main.html");

// remove . from version number
const versionNumber = pjson.version
  .split("")
  .filter(i => i !== ".")
  .join("");

const cssFile = `${versionNumber}/css/main.css`;
const jsFile = `${versionNumber}/js/main.js`;

const plugins = [
  new CleanWebpackPlugin({
    cleanOnceBeforeBuildPatterns: [
      PATHS.build
    ],
  }),
  // Generates an `index.html` file with the <script> injected.
  new HtmlWebpackPlugin({
    inject: true,
    template: `${PATHS.public}/index.html`,
    filename: htmlFile,
    minify: {
      removeComments: true,
      collapseWhitespace: true,
      removeRedundantAttributes: true,
      useShortDoctype: true,
      removeEmptyAttributes: true,
      removeStyleLinkTypeAttributes: true,
      keepClosingSlash: true,
      minifyJS: true,
      minifyCSS: true,
      minifyURLs: true
    }
  }),
  // https://github.com/jmblog/how-to-optimize-momentjs-with-webpack
  new webpack.IgnorePlugin(/^\.\/locale$/, /moment$/),

  new UglifyJsPlugin({
    cache: true,
    parallel: true,
    uglifyOptions: {
      beautify: false,
      mangle: {
        keep_fnames: true
      },
      output: {
        comments: false
      }
    },
    sourceMap: true
  }),
  new MiniCssExtractPlugin({
    filename: cssFile
  })
];

module.exports = Merge(CommonConfig, {
  bail: true,
  mode: "production",
  devtool: "source-map",
  output: {
    path: PATHS.build,
    filename: jsFile
  },
  module: {
    rules: [
      {
        test: /\.scss$/,
        use: [
          MiniCssExtractPlugin.loader,
          {
            loader: "css-loader",
            options: { sourceMap: true, importLoaders: 1 }
          },
          {
            loader: "postcss-loader",
            options: {
              sourceMap: true,
              plugins: loader => [require("cssnano")]
            }
          },
          { loader: "sass-loader", options: { sourceMap: true } }
        ]
      },
      {
        test: /\.css$/,
        use: [
          MiniCssExtractPlugin.loader,
          {
            loader: "css-loader",
            options: { sourceMap: true, importLoaders: 1 }
          },
          {
            loader: "postcss-loader",
            options: {
              sourceMap: true,
              plugins: loader => [require("cssnano")]
            }
          }
        ]
      }
    ]
  },
  plugins
});
