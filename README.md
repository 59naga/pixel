Pixel
---
<p align="right">
  <a href="https://www.npmjs.com/package/pixel">
    <img alt="Npm version" src="https://badge.fury.io/js/pixel.svg">
  </a>
  <a href="https://travis-ci.org/59naga/pixel">
    <img alt="Build Status" src="https://travis-ci.org/59naga/pixel.svg?branch=master">
  </a>
</p>

> Get ImageData in cross-platform

Installation
---

## for NodeJS
```bash
$ yarn add -D pixel
# or
$ npm install pixel --save
```

## for Browser
```html
<script src="https://unpkg.com/pixel/index.js"></script>
<script>
  console.log(pixel); //function
</script>
```

API
---

## pixel(`file`) -> Promise<ImageData[]>

return `images` is Array contains one or more `ImageData`.
> Return the `object` instead of `ImageData` at Node.js

`file` is...
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
* webp (static/animation)

Related projects
---
* [pixel-util](https://github.com/59naga/pixel-util/)
* [pixel-gif](https://github.com/59naga/pixel-gif-/)
* [pixel-png](https://github.com/59naga/pixel-png/)
* [pixel-jpg](https://github.com/59naga/pixel-jpg/)
* [pixel-bmp](https://github.com/59naga/pixel-bmp/)
* [pixel-webp](https://github.com/59naga/pixel-webp/)
* __pixel__
* [pixel-to-ansi](https://github.com/59naga/pixel-to-ansi/)
* [pixel-to-svg](https://github.com/59naga/pixel-to-svg/)

License
---
[MIT][License]

[License]: http://59naga.mit-license.org/
