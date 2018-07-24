module.exports = [
  {
    mode: 'production',
    target: 'node',
    devtool: 'cheap-module-source-map',
    output: {
      path: __dirname,
      filename: 'index.js'
    }
  },
  {
    mode: 'production',
    target: 'web',
    devtool: 'cheap-module-source-map',
    node: {
      fs: 'empty'
    },
    output: {
      path: __dirname,
      filename: 'index.browser.js',
      library: 'pixel',
      libraryTarget: 'umd',
      // https://github.com/webpack/webpack/issues/3929#issuecomment-306063585
      libraryExport: 'default',
      // https://github.com/webpack/webpack/issues/6784#issuecomment-375941431
      globalObject: "typeof self !== 'undefined' ? self : this"
    }
  }
];
