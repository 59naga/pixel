# Dependencies
Promise= require 'bluebird'

GifReader= (require 'omggif').GifReader

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

  gif: (buffer)->
    new Promise (resolve)->
      reader= new GifReader buffer

      images=
        for i in [0...reader.numFrames()]

          frame= reader.frameInfo i
          frame.data= new Uint8Array reader.width * reader.height * 4
          reader.decodeAndBlitFrameRGBA 0,frame.data

          frame

      resolve images

  jpg: (buffer)->
    new Promise (resolve)->
      resolve [jpeg.decode buffer]

  png: (buffer)->
    new Promise (resolve,reject)->
      pngparse.parse buffer,(error,image)->
        return reject error if error?

        image.data= Parser.to4ch image.data,image.channels
        resolve [image]

  gifTest: (buffer)->
    reader= new GifReader buffer

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