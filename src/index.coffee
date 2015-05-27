# Dependencies
Parser= require './parser'

Promise= require 'bluebird'

unless window?
  request= require 'request'
  fs= require 'fs'

U8CA= Uint8ClampedArray ? Uint8Array

# Public
class Pixel extends Parser
  # API
  @parse: (file)->
    imagedata= new Pixel

    unless window?
      imagedata.load file
    else
      imagedata.fetch file

  # Node.js API
  load: (file)->
    type= @getType file
    extension= @getExtension file,type

    loaded=
      switch type
        when 'url'
          @request file
        when 'datauri'
          @datauri file
        when 'blob'
          Promise.resolve file
        when 'buffer'
          Promise.resolve file
        when 'path'
          @readFile file
        when 'image'
          @request file.src
        else
          throw new TypeError "#{type} is unsupport type"

    loaded.then (buffer)=>
      switch extension
        when 'jpg'  then @jpg buffer
        when 'png'  then @png buffer
        when 'gif'  then @gif buffer
        else
          throw new TypeError "#{extension} is unsupport extension"

  request: (url,encoding=null)->
    new Promise (resolve,reject)->
      request {url,encoding},(error,response,buffer)->
        return reject error if error?

        resolve buffer

  readFile: (file)->
    new Promise (resolve)->
      resolve fs.readFileSync file

  # Browser API
  fetch: (file)->
    type= @getType file
    extension= @getExtension file,type

    file= @createObjectURL file if type is 'datauri'
    file= URL.createObjectURL file if type is 'blob'

    switch
      when type is 'image'
        @getImage file

      when extension is 'gif'
        @fetchGif file

      else
        new Promise (resolve,reject)=>
          image= new Image
          image.crossOrigin= 'Anonymous'
          image.src= file

          image.onerror= (error)->
            reject error.message
          image.onload= =>
            images= @getImages image

            resolve images

  fetchGif: (file)->
    new Promise (resolve,reject)=>
      switch typeof file
        when 'string'
          xhr= new XMLHttpRequest
          xhr.open 'GET',file,true
          xhr.responseType= 'arraybuffer'
          xhr.send()

          xhr.onerror= (error)->
            reject xhr.statusText

          xhr.onload= =>
            return reject xhr.statusText unless xhr.readyState is 4

            @gif new U8CA xhr.response
            .then (images)->
              resolve images

        else
          @gif new U8CA file
          .then (images)->
            resolve images

  getImage: (image)->
    new Promise (resolve,reject)=>
      if image.complete
        resolve @getImages image
      else
        image.addEventListener 'load',=>
          resolve @getImages image

  getImages: (image)->
    context= document.createElement('canvas').getContext '2d'
    context.canvas.width= image.width
    context.canvas.height= image.height
    context.drawImage image,0,0

    imageData= context.getImageData 0,0,image.width,image.height
    images= [imageData]
    
    images.loopCount= -1
    images

module.exports= Pixel