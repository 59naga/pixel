# Dependencies
Parser= require './parser'

Promise= require 'bluebird'
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

  # Browser API
  fetch: (file)->
    type= @getType file
    extension= @getExtension file

    if extension is 'gif'
      new Promise (resolve,reject)=>
        xhr= new XMLHttpRequest
        xhr.open 'GET',file,true
        xhr.responseType= 'arraybuffer'
        xhr.overrideMimeType 'application/binary' if xhr.overrideMimeType
        xhr.send()

        xhr.onerror= (error)->
          console.log error
        xhr.onload= =>
          @gif new Uint8Array xhr.response
          .then (images)->
            resolve images
    else
      new Promise (resolve)=>
        url= file
        url= @createObjectURL file if type is 'datauri'

        image= new Image
        image.crossOrigin= 'Anonymous'
        image.src= url

        image.onerror= (error)->
          console.log error
        image.onload= ->
          context= document.createElement('canvas').getContext '2d'
          context.canvas.width= image.width
          context.canvas.height= image.height
          context.drawImage image,0,0

          resolve [context.getImageData 0,0,image.width,image.height]

module.exports= Pixel