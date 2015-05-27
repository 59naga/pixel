# Dependencies
Parser= require './parser'

Promise= require 'bluebird'

unless window?
  request= require 'request'
  fs= require 'fs'

# Public
class Pixel extends Parser
  parse: (file)->
    unless window?
      @load file
    else
      @fetch file

  # Node.js API
  load: (file)->
    type= @getType file
    extension= @getExtension file,type

    loaded=
      switch type
        when 'url'
          @request file
        when 'datauri'
          @getBuffer file
        when 'buffer'
          Promise.resolve file
        when 'path'
          @readFile file
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

  getBuffer: (datauri)->
    new Promise (resolve)->
      resolve new Buffer (datauri.slice datauri.indexOf(',')+1),'base64'

  readFile: (file)->
    new Promise (resolve)->
      resolve fs.readFileSync file

  # Browser API
  fetch: (file)->
    type= @getType file
    extension= @getExtension file,type

    file= @parseDatauri file if type is 'datauri'
    file= @URL.createObjectURL file if type is 'blob'

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

            @gif new Uint8Array xhr.response
            .then (images)->
              resolve images

        else
          @gif new Uint8Array file
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

module.exports= new Pixel