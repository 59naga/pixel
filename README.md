# Pixel [![NPM version][npm-image]][npm] [![Build Status][travis-image]][travis] [![Coverage Status][coveralls-image]][coveralls]

[![Sauce Test Status][sauce-image]][sauce]

> Get ImageData in cross-platform

## Installation
### Via npm
```bash
$ npm install pixel --save
```
```js
var pixel= require('pixel');
console.log(pixel); //function
```

### Via bower
```bash
$ bower install pixel --save
```
```html
<script src="bower_components/pixel/pixel.min.js"></script>
<script>
  console.log(pixel); //function
</script>
```

# API

## pixel.parse(`file`) -> promise.then(`images`)

return `images` is Array contains one or more `ImageData`.
> Return the `object` instead of `ImageData` at Node.js

`file` is below:
* string: url (e.g. `http[s]://...`)
* string: datauri (e.g. `data:image/...`)
* string: path (e.g. `/path/to/file`)
* string: binary (unless above)
* object: Blob/File
* object: Buffer/ArrayBuffer/Uint8Array/Uint8ClampedArray
* object: HTMLImageElement

## Support
* gif (static/animation)
* png (static/animation)
* jpeg
* bitmap (24bit or less)

## Known issues
* [IE9,IE10 Security Error](https://github.com/kangax/fabric.js/issues/1957#issuecomment-101674049)

# See
* __pixel__
* [pixel-util](https://github.com/59naga/pixel-util/)
* [pixel-gif](https://github.com/59naga/pixel-gif-/)
* [pixel-png](https://github.com/59naga/pixel-png/)
* [pixel-jpg](https://github.com/59naga/pixel-jpg/)
* [pixel-bmp](https://github.com/59naga/pixel-bmp/)


License
---
[MIT][License]

[License]: http://59naga.mit-license.org/

[sauce-image]: http://soysauce.berabou.me/u/59798/pixel.svg
[sauce]: https://saucelabs.com/u/59798
[npm-image]:https://img.shields.io/npm/v/pixel.svg?style=flat-square
[npm]: https://npmjs.org/package/pixel
[travis-image]: http://img.shields.io/travis/59naga/pixel.svg?style=flat-square
[travis]: https://travis-ci.org/59naga/pixel
[coveralls-image]: http://img.shields.io/coveralls/59naga/pixel.svg?style=flat-square
[coveralls]: https://coveralls.io/r/59naga/pixel?branch=master