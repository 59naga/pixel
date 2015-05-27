# Dependencies
Parser= require './parser'

Promise= require 'bluebird'

unless window?
  request= require 'request'
  fs= require 'fs'

# Public
class Pixel extends Parser
  # API
  @parse: (file)->
    imagedata= new Pixel

    unless window?
      imagedata.load file
    else
      imagedata.fetch file

  # Browser API
  fetch: (file)->
    type= @getType file
    extension= @getExtension file

    if extension is 'gif'
      new Promise (resolve,reject)=>
        xhr= new XMLHttpRequest
        xhr.open 'GET',file,true
        xhr.responseType= 'arraybuffer'
        xhr.send()

        xhr.onload= =>
          return reject xhr.statusText unless xhr.readyState is 4

          @gif new Uint8ClampedArray xhr.response
          .then (images)->
            resolve images
        xhr.onerror= (error)->
          reject xhr.statusText
    else
      new Promise (resolve,reject)=>
        url= file
        url= @createObjectURL file if type is 'datauri'

        image= new Image
        image.crossOrigin= 'Anonymous'
        image.src= url

        image.onerror= (error)->
          reject error
        image.onload= ->
          context= document.createElement('canvas').getContext '2d'
          context.canvas.width= image.width
          context.canvas.height= image.height
          context.drawImage image,0,0

          imageData= context.getImageData 0,0,image.width,image.height
          images= [imageData]
          
          images.loopCount= -1
          resolve images

  # Node.js API
  load: (file)->
    type= @getType file
    extension= @getExtension file

    loaded=
      switch type
        when 'url'
          @request file
        when 'datauri'
          @datauri file
        else
          @readFile file

    loaded.spread (imageType,buffer)=>
      switch extension or imageType
        when 'jpg'  then @jpg buffer
        when 'jpeg' then @jpg buffer
        when 'png'  then @png buffer
        else
          @gif buffer

  request: (url,encoding=null)->
    new Promise (resolve,reject)->
      request {url,encoding},(error,response,buffer)->
        return reject error if error?

        resolve [null,buffer]

  readFile: (file)->
    new Promise (resolve)->
      buffer= fs.readFileSync file

      resolve [null,buffer]

module.exports= Pixel