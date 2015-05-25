# Pixel [![NPM version][npm-image]][npm] [![Build Status][travis-image]][travis] [![Coverage Status][coveralls-image]][coveralls]

[![Sauce Test Status][sauce-image]][sauce]

> Get the Animated/Static ImageData

## Installation
```bash
$ npm install pixel
```

## Installation
### Via npm
```bash
$ npm install pixel --save
```
```js
var Pixel= require('pixel');
console.log(Pixel); //function
```

### Via bower
```bash
$ bower install pixel --save
```
```html
<script src="bower_components/pixel/pixel.min.js"></script>
<script>
  console.log(Pixel); //function
</script>
```

# API

## Pixel.parse(<url/datauri/path>) -> promise

return Array contains one or more `ImageData`.
> Return the `object` instead of `ImageData` at Node.js

Support:
* gif (static/animation)
* png, jpeg

```js
var url= 'https://59naga.github.io/fixtures/animated.GIF';
var canvas= document.querySelector('#pixel');
var context= canvas.getContext('2d');

Pixel.parse(url).then(function(images){
  var i= 0;

  var nextImage= function(){
    var imageData= images[i++];

    console.log(imageData);
    // ImageData {
    //   height: 73, width: 73, data: Uint8ClampedArray[21316],
    //   delay: 1000, disposal: 0 ...
    //   

    if(canvas.width!=imageData.width){
      canvas.width=imageData.width;
    }
    if(canvas.height!=imageData.height){
      canvas.height=imageData.height;
    }
    context.putImageData(imageData,0,0);

    if(images[i]==null){
      i= 0;
    }
    if(imageData.delay){
      setTimeout(nextImage,imageData.delay);
    }
  }

  nextImage();
});
```

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