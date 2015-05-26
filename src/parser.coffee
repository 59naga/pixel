# Dependencies
Promise= require 'bluebird'

GifReader= (require 'omggif').GifReader

unless window?
  jpeg= require 'jpeg-js'
  pngparse= require 'pngparse'

# Public
class Parser
  getExtension: (file)->
    (file.match /.\w+$/)?[0].toLowerCase().slice(1)
    
  getType: (file)->
    type= 'url' if file.match /^https?:\/\//
    type= 'datauri' if file.match /^data:image\//
    type?= 'file'
    type

  datauri: (datauri)->
    new Promise (resolve)->
      buffer= new Buffer (datauri.slice datauri.indexOf(',')+1),'base64'
      imageType= (datauri.match /^data:image\/(\w+);/)[1]

      resolve [imageType,buffer]

  # http://stackoverflow.com/questions/4998908/convert-data-uri-to-file-then-append-to-formdata
  createObjectURL: (datauri)->
    binary= atob datauri.slice datauri.indexOf(',')+1
    mimeType= datauri.match(/image\/\w*/)?[0]

    arrayBuffer= new ArrayBuffer binary.length
    data= new Uint8Array arrayBuffer
    data[i]= binary.charCodeAt i for i in [0..binary.length]

    URL.createObjectURL new Blob [data],{type:mimeType}

  # http://www.html5.jp/canvas/ref/method/getImageData.html
  createImageData: (width,height)->
    if document?
      context= document.createElement('canvas').getContext '2d'

      ImageData= context.createImageData width,height
    else
      {}

  gif: (buffer)->
    new Promise (resolve)=>
      reader= new GifReader buffer

      images=
        for i in [0...reader.numFrames()]

          image= @createImageData reader.width,reader.height
          image[key]= value for key,value of reader.frameInfo i
          image.delay= image.delay*10 if image.delay # bugfix
          image.data= new Uint8Array reader.width * reader.height * 4
          reader.decodeAndBlitFrameRGBA i,image.data

          image

      images.loopCount= reader.loopCount()
      images.loopCount?= -1
      resolve images

  jpg: (buffer)->
    new Promise (resolve)->
      images= [jpeg.decode buffer]

      images.loopCount= -1
      resolve images

  png: (buffer)->
    new Promise (resolve,reject)->
      pngparse.parse buffer,(error,image)->
        return reject error if error?

        image.data= Parser.to4ch image.data,image.channels
        images= [image]
        
        images.loopCount= -1
        resolve images

  @to4ch: (data,channels)->
    if channels<4
      frame= []

      i= 0
      while data[i]
        switch channels
          when 1
            value= data[i]

            [r,g,b,a]= [value,value,value,255]

          when 2
            value= data[i]
            alpha= data[i+1]

            [r,g,b,a]= [value,value,value,alpha]

          when 3
            r= data[i]
            g= data[i+1]
            b= data[i+2]
            [r,g,b,a]= [r,g,b,255]

        frame.push r
        frame.push g
        frame.push b
        frame.push a

        i+= channels

      frame

    else
      frame= data

    frame

module.exports= Parser