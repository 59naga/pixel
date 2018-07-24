module.exports = {
  mode: 'production',
  node: {
    fs: 'empty'
  },
  output: {
    library: 'pixel',
    libraryTarget: 'umd',
    // https://github.com/webpack/webpack/issues/3929#issuecomment-306063585
    libraryExport: 'default',
    // https://github.com/webpack/webpack/issues/6784#issuecomment-375941431
    globalObject: 'typeof self !== \'undefined\' ? self : this'
  }
};