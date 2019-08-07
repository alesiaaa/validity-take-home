const PATHS = require('./common-paths');

module.exports = {
  entry: {
    app: [PATHS.appSrc + '/index.js']
  },
  resolve: {
    extensions: [".js", ".scss"],
    modules: ["node_modules", PATHS.appSrc]
  },
  module: {
    rules: [
      // First, run the linter.
      // It's important to do this before Babel processes the JS.
      {
        test: /\.(js|jsx)$/,
        enforce: "pre",
        use: [
          {
            options: {
              formatter: require.resolve('react-dev-utils/eslintFormatter'),
              eslintPath: require.resolve('eslint')
            },
            loader: require.resolve('eslint-loader')
          }
        ],
        include: PATHS.appSrc
      },
      // Process JS with Babel.
      {
        test: /\.(js|jsx)$/,
        include: PATHS.appSrc,
        loader: require.resolve('babel-loader'),
        options: {
          // This is a feature of `babel-loader` for webpack (not Babel itself).
          // It enables caching results in ./node_modules/.cache/babel-loader/
          // directory for faster rebuilds.
          cacheDirectory: true
        }
      },
      {
        exclude: [
          /\.html$/,
          /\.(js|jsx)$/,
          /\.css$/,
          /\.json$/,
          /\.bmp$/,
          /\.gif$/,
          /\.jpe?g$/,
          /\.png$/,
          /\.scss$/,
          /\.svg$/
        ],
        loader: require.resolve("file-loader")
      },
      {
        test: /\.(png|jpg|gif)$/i,
        use: [
          {
            loader: require.resolve('url-loader')
          }
        ]
      },
      {
        test: /\.svg$/,
        loader: require.resolve('svg-inline-loader')
      }
    ]
  }
};
