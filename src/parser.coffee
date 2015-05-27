# Dependencies
Utility= require './utility'

Promise= require 'bluebird'
GifReader= (require 'omggif').GifReader

unless window?
  jpeg= require 'jpeg-js'
  pngparse= require 'pngparse'

U8CA= Uint8ClampedArray ? Uint8Array

# Public
class Parser extends Utility
  gif: (buffer)->
    new Promise (resolve)=>
      reader= new GifReader buffer

      images=
        for i in [0...reader.numFrames()]

          image= @createImageData reader.width,reader.height
          image[key]= value for key,value of reader.frameInfo i
          image.delay= image.delay*10 if image.delay # bugfix
          image.data= new U8CA reader.width * reader.height * 4
          reader.decodeAndBlitFrameRGBA i,image.data

          image

      images.loopCount= reader.loopCount()
      images.loopCount?= -1
      resolve images

  jpg: (buffer)->
    new Promise (resolve)->
      image= jpeg.decode buffer
      image.data= new U8CA image.data

      images= [image]

      images.loopCount= -1
      resolve images

  png: (buffer)->
    new Promise (resolve,reject)=>
      pngparse.parse buffer,(error,image)=>
        return reject error if error?

        image.data= @to4ch image.data,image.channels
        image.data= new U8CA image.data
        images= [image]
        
        images.loopCount= -1
        resolve images

  datauri: (datauri)->
    new Promise (resolve)->
      resolve new Buffer (datauri.slice datauri.indexOf(',')+1),'base64'

  to4ch: (data,channels)->
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