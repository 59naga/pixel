# Dependencies
imageType= require 'image-type'

# Public
class Utility
  Blob: Blob ? ->
  Buffer: Buffer ? ->
  Uint8ClampedArray: Uint8ClampedArray ? Uint8Array
  Image: Image ? ->
  URL: window?.URL ? window?.webkitURL

  getType: (file)->
    switch typeof file
      when 'string'
        @getSchemaType file

      when 'object'
        @getClassName file

  getSchemaType: (string)->
    switch
      when string.match /^https?:\/\//
        'url'
      when string.match /^data:image\//
        'datauri'
      else
        'path'

  getClassName: (object)->
    switch
      when object instanceof @Buffer
        'buffer'

      when object instanceof ArrayBuffer
        'buffer'

      when object instanceof @Blob
        'blob'

      when object instanceof Uint8Array
        'buffer'

      when object instanceof @Uint8ClampedArray
        'buffer'

      when object instanceof @Image
        'image'

      else
        'image'

  getExtension: (file='',type='url')->
    switch type
      when 'url'
        @getSuffix file
      when 'datauri'
        (file.match /^data:image\/(\w+);/)[1]
      when 'path'
        @getSuffix file
      when 'blob'
        file.type?.split('/')[1]
      when 'buffer'
        (imageType file)?.ext
      else
        @getSuffix file.src

  getSuffix: (string='')->
    suffix= (string.match /.\w+$/)?[0].toLowerCase().slice(1)
    suffix= 'jpg' if suffix is 'jpeg'
    suffix
  
  # http://www.html5.jp/canvas/ref/method/getImageData.html
  createImageData: (width,height)->
    if document?
      context= document.createElement('canvas').getContext '2d'

      ImageData= context.createImageData width,height
    else
      {}

module.exports= Utility