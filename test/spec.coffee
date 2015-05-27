# Dependencies
Pixel= require '../src'

fs= require 'fs'
U8CA= Uint8ClampedArray ? Uint8Array
Blob= window?.Blob ? require './blob.mock'
Image= window?.Image ? require './image.mock'

# Environment
jasmine.DEFAULT_TIMEOUT_INTERVAL= 3000

# Specs
describe 'Pixel',->
  describe '.getType/.getExtension',->
    it 'url/gif',->
      arg= 'https://59naga.github.io/fixtures/fixture.GIF'

      type= Pixel::getType arg
      extension= Pixel::getExtension arg,type

      expect(type).toBe 'url'
      expect(extension).toBe 'gif'

    it 'datauri/gif',->
      arg= 'data:image/gif;base64,'
      arg+= fs.readFileSync(__dirname+'/fixture.GIF').toString('base64')

      type= Pixel::getType arg
      extension= Pixel::getExtension arg,type

      expect(type).toBe 'datauri'
      expect(extension).toBe 'gif'

    it 'path/gif',->
      arg= __dirname+'/fixture.GIF'

      type= Pixel::getType arg
      extension= Pixel::getExtension arg,type

      expect(type).toBe 'path'
      expect(extension).toBe 'gif'

    it 'blob/gif',->
      arg= fs.readFileSync __dirname+'/fixture.GIF'
      arg= new Blob [new U8CA arg],{type:'image/gif'}

      type= Pixel::getType arg
      extension= Pixel::getExtension arg,type

      expect(type).toBe 'blob'
      expect(extension).toBe 'gif'

    it 'buffer/gif',->
      arg= fs.readFileSync __dirname+'/fixture.GIF'

      type= Pixel::getType arg
      extension= Pixel::getExtension arg,type

      expect(type).toBe 'buffer'
      expect(extension).toBe 'gif'

    it 'image/jpg',(done)->
      arg= new Image
      arg.src= 'https://59naga.github.io/fixtures/fixture.JPEG'
      arg.onload= ->
        type= Pixel::getType arg
        extension= Pixel::getExtension arg,type

        expect(type).toBe 'image'
        expect(extension).toBe 'jpg'
        done()

  describe '.parse',->
    it 'url',(done)->
      arg= 'https://59naga.github.io/fixtures/fixture.GIF'

      Pixel.parse arg
      .then (images)->
        expect(images.loopCount).toBe -1
        
        image= images[0]

        expect(image.width).toBe 112
        expect(image.height).toBe 112
        expect(image.data instanceof U8CA).toBe true
        expect(image.data?.length).toBe image.width*image.height*4

        done()

    it 'datauri',(done)->
      arg= 'data:image/gif;base64,'
      arg+= fs.readFileSync(__dirname+'/fixture.GIF').toString('base64')

      Pixel.parse arg
      .then (images)->
        expect(images.loopCount).toBe -1
        
        image= images[0]

        expect(image.width).toBe 112
        expect(image.height).toBe 112
        expect(image.data instanceof U8CA).toBe true
        expect(image.data?.length).toBe image.width*image.height*4

        done()

    it 'file',(done)->
      arg= __dirname+'/fixture.GIF'

      Pixel.parse arg
      .then (images)->
        expect(images.loopCount).toBe -1
        
        image= images[0]

        expect(image.width).toBe 112
        expect(image.height).toBe 112
        expect(image.data instanceof U8CA).toBe true
        expect(image.data?.length).toBe image.width*image.height*4

        done()

    it 'blob',(done)->
      arg= fs.readFileSync __dirname+'/fixture.GIF'
      arg= new Blob [new U8CA arg],{type:'image/gif'}

      Pixel.parse arg
      .then (images)->
        expect(images.loopCount).toBe -1
        
        image= images[0]

        expect(image.width).toBe 112
        expect(image.height).toBe 112
        expect(image.data instanceof U8CA).toBe true
        expect(image.data?.length).toBe image.width*image.height*4

        done()

    it 'buffer',(done)->
      arg= fs.readFileSync __dirname+'/fixture.GIF'

      Pixel.parse arg
      .then (images)->
        expect(images.loopCount).toBe -1
        
        image= images[0]

        expect(image.width).toBe 112
        expect(image.height).toBe 112
        expect(image.data instanceof U8CA).toBe true
        expect(image.data?.length).toBe image.width*image.height*4

        done()

    it 'image',(done)->
      arg= new Image
      arg.crossOrigin= 'Anonymous'
      arg.src= 'https://59naga.github.io/fixtures/fixture.JPEG'
      
      Pixel.parse arg
      .then (images)->
        expect(images.loopCount).toBe -1
        
        image= images[0]

        expect(image.width).toBe 256
        expect(image.height).toBe 192
        expect(image.data instanceof U8CA).toBe true
        expect(image.data?.length).toBe image.width*image.height*4

        done()

    describe 'url',->
      it '.jpg', (done)->
        arg= 'https://59naga.github.io/fixtures/fixture.JPEG'

        Pixel.parse arg
        .then (images)->
          expect(images.loopCount).toBe -1

          image= images[0]
          expect(image.width).toBe 256
          expect(image.height).toBe 192
          expect(image.data instanceof U8CA).toBe true
          expect(image.data?.length).toBe image.width*image.height*4

          done()
        
      it '.png (RGB 3ch)', (done)->
        arg= 'https://59naga.github.io/fixtures/fixture.PNG'

        Pixel.parse arg
        .then (images)->
          expect(images.loopCount).toBe -1
          
          image= images[0]

          expect(image.width).toBe 96
          expect(image.height).toBe 96
          expect(image.data instanceof U8CA).toBe true
          expect(image.data?.length).toBe image.width*image.height*4

          done()
        
      it '.gif', (done)->
        arg= 'https://59naga.github.io/fixtures/fixture.GIF'

        Pixel.parse arg
        .then (images)->
          expect(images.loopCount).toBe -1
          
          image= images[0]

          expect(image.width).toBe 112
          expect(image.height).toBe 112
          expect(image.data instanceof U8CA).toBe true
          expect(image.data?.length).toBe image.width*image.height*4

          done()

      it '.gif (Anime)', (done)->
        arg= 'https://59naga.github.io/fixtures/animated.GIF'

        Pixel.parse arg
        .then (images)->
          expect(images.loopCount).toBe 0 # Infinite
          
          image= images[0]

          expect(image.width).toBe 73
          expect(image.height).toBe 73
          expect(image.data instanceof U8CA).toBe true
          expect(image.data?.length).toBe image.width*image.height*4
          expect(images.length).toBe 34

          done()