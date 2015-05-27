# Dependencies
imageType= require 'image-type'

# Public
class Utility
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

  getClassName: (instance)->
    switch instance?.constructor?.name
      when 'Blob' then 'blob'
      when 'Buffer' then 'buffer'
      when 'ArrayBuffer' then 'buffer'
      when 'HTMLImageElement' then 'image'
      when 'Uint8ClampedArray' then 'blob'# for mock
      else throw new TypeError 'Invalid constructor'

  getExtension: (file='',type='url')->
    switch type
      when 'url'
        @getSuffix file
      when 'datauri'
        (file.match /^data:image\/(\w+);/)[1]
      when 'path'
        @getSuffix file
      when 'blob'
        file.type.split('/')[1]
      when 'buffer'
        (imageType file).ext
      when 'image'
        @getSuffix file.src
      else
        throw new TypeError 'Invalid constructor'

  getSuffix: (string)->
    suffix= (string.match /.\w+$/)?[0].toLowerCase().slice(1)
    suffix= 'jpg' if suffix is 'jpeg'
    suffix
  
  # http://stackoverflow.com/questions/4998908/convert-data-uri-to-file-then-append-to-formdata
  createObjectURL: (datauri)->
    binary= atob datauri.slice datauri.indexOf(',')+1
    mimeType= datauri.match(/image\/\w*/)?[0]

    arrayBuffer= new ArrayBuffer binary.length
    data= new Uint8ClampedArray arrayBuffer
    data[i]= binary.charCodeAt i for i in [0..binary.length]

    URL.createObjectURL new Blob [data],{type:mimeType}

  # http://www.html5.jp/canvas/ref/method/getImageData.html
  createImageData: (width,height)->
    if document?
      context= document.createElement('canvas').getContext '2d'

      ImageData= context.createImageData width,height
    else
      {}

module.exports= Utility