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
console.log(pixel); //object
```

### Via bower
```bash
$ bower install pixel --save
```
```html
<script src="bower_components/pixel/pixel.min.js"></script>
<script>
  console.log(pixel); //object
</script>
```

# API

## pixel.parse(`file`) -> promise.then(`images`)

return `images` is Array contains one or more `ImageData`.
> Return the `object` instead of `ImageData` at Node.js

```js
var gif= 'https://59naga.github.io/fixtures/animated.GIF';
pixel.parse(gif).then(function(images){
  console.log(images.loopCount); // 0(Infinite)
  console.log(images[0]);
});
// { width: 73, height: 73, data: <Uint8Array ..>, x: 0, y: 0, has_local_palette: false, palette_offset: 13, data_offset: 818, data_length: 393, transparent_index: null, interlaced: false, delay: 1000, disposal: 0 }

var png= 'https://59naga.github.io/fixtures/animated.PNG';
pixel.parse(png).then(function(images){
  console.log(images.numPlays); // 0(Infinite)
  console.log(images[0]);
});
// { width: 73, height: 73, data: <Uint8Array ..>, left: 0, top: 0, delay: 1000, disposeOp: 0, blendOp: 0 }

var jpg= 'https://59naga.github.io/fixtures/still.JPG';
pixel.parse(jpg).then(function(images){
  console.log(images[0]);
});
// {width: 256, height: 192, data: <Uint8Array ..>}

var bmp= 'https://59naga.github.io/fixtures/still.BMP';
pixel.parse(bmp).then(function(images){
  console.log(images[0]);
});
// {width: 128, height: 128, data: <Uint8Array ..>}
```

`file`:
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

# Related projects
* [pixel-util](https://github.com/59naga/pixel-util/)
* [pixel-gif](https://github.com/59naga/pixel-gif-/)
* [pixel-png](https://github.com/59naga/pixel-png/)
* [pixel-jpg](https://github.com/59naga/pixel-jpg/)
* [pixel-bmp](https://github.com/59naga/pixel-bmp/)
* __pixel__
* [pixel-to-ansi](https://github.com/59naga/pixel-to-ansi/)
* [pixel-to-svg](https://github.com/59naga/pixel-to-svg/)

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