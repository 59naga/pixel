# Dependencies
PixelUtil= (require 'pixel-util').PixelUtil
gif= require 'pixel-gif'
jpeg= require 'pixel-jpg'
png= require 'pixel-png'
bmp= require 'pixel-bmp'

# Public
class Pixel extends PixelUtil
  parse: (file)->
    @detect file
    .then (types)->
      switch types?.ext
        when 'gif' then gif.parse file
        when 'png' then png.parse file
        when 'jpg' then jpeg.parse file
        when 'bmp' then bmp.parse file
        else
          @Promise.reject types.ext+' is Unsupported type.'

module.exports= new Pixel
module.exports.Pixel= Pixel