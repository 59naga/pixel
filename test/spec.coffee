# Dependencies
pixel= require '../src'

fs= require 'fs'

# Environment
jasmine.DEFAULT_TIMEOUT_INTERVAL= 3000

# Specs
describe 'pixel',->
  describe '.getType/.getExtension',->
    it 'url/gif',->
      arg= 'https://59naga.github.io/fixtures/fixture.GIF'

      type= pixel.getType arg
      extension= pixel.getExtension arg,type

      expect(type).toBe 'url'
      expect(extension).toBe 'gif'

    it 'datauri/gif',->
      arg= 'data:image/gif;base64,'
      arg+= fs.readFileSync(__dirname+'/fixture.GIF').toString('base64')

      type= pixel.getType arg
      extension= pixel.getExtension arg,type

      expect(type).toBe 'datauri'
      expect(extension).toBe 'gif'

    it 'path/gif',->
      arg= __dirname+'/fixture.GIF'

      type= pixel.getType arg
      extension= pixel.getExtension arg,type

      expect(type).toBe 'path'
      expect(extension).toBe 'gif'

    it 'blob/gif',->
      return unless Blob?

      arg= fs.readFileSync __dirname+'/fixture.GIF'
      arg= new Blob [new Uint8Array arg],{type:'image/gif'}

      type= pixel.getType arg
      extension= pixel.getExtension arg,type

      expect(type).toBe 'blob'
      expect(extension).toBe 'gif'

    it 'buffer/gif',->
      arg= fs.readFileSync __dirname+'/fixture.GIF'

      type= pixel.getType arg
      extension= pixel.getExtension arg,type

      expect(type).toBe 'buffer'
      expect(extension).toBe 'gif'

    it 'image/jpg',(done)->
      return done() unless Image?

      arg= new Image
      arg.src= 'https://59naga.github.io/fixtures/fixture.JPEG'
      arg.onload= ->
        type= pixel.getType arg
        extension= pixel.getExtension arg,type

        expect(type).toBe 'image'
        expect(extension).toBe 'jpg'
        done()

  describe '.parse',->
    it 'url',(done)->
      arg= 'https://59naga.github.io/fixtures/fixture.GIF'

      pixel.parse arg
      .then (images)->
        expect(images.loopCount).toBe -1
        
        image= images[0]

        expect(image.width).toBe 112
        expect(image.height).toBe 112
        expect(image.data?.length).toBe image.width*image.height*4

        done()

    it 'datauri',(done)->
      arg= 'data:image/gif;base64,'
      arg+= fs.readFileSync(__dirname+'/fixture.GIF').toString('base64')

      pixel.parse arg
      .then (images)->
        expect(images.loopCount).toBe -1
        
        image= images[0]

        expect(image.width).toBe 112
        expect(image.height).toBe 112
        expect(image.data?.length).toBe image.width*image.height*4

        done()

    it 'file',(done)->
      arg= __dirname+'/fixture.GIF'

      pixel.parse arg
      .then (images)->
        expect(images.loopCount).toBe -1
        
        image= images[0]

        expect(image.width).toBe 112
        expect(image.height).toBe 112
        expect(image.data?.length).toBe image.width*image.height*4

        done()

    it 'blob',(done)->
      return done() unless Blob?

      arg= fs.readFileSync __dirname+'/fixture.GIF'
      arg= new Blob [new Uint8Array arg],{type:'image/gif'}

      pixel.parse arg
      .then (images)->
        expect(images.loopCount).toBe -1
        
        image= images[0]

        expect(image.width).toBe 112
        expect(image.height).toBe 112
        expect(image.data?.length).toBe image.width*image.height*4

        done()

    it 'buffer',(done)->
      arg= fs.readFileSync __dirname+'/fixture.GIF'

      pixel.parse arg
      .then (images)->
        expect(images.loopCount).toBe -1
        
        image= images[0]

        expect(image.width).toBe 112
        expect(image.height).toBe 112
        expect(image.data?.length).toBe image.width*image.height*4

        done()

    it 'image',(done)->
      return done() unless Image?

      arg= new Image
      arg.crossOrigin= 'Anonymous'
      arg.src= 'https://59naga.github.io/fixtures/fixture.JPEG'
      
      pixel.parse arg
      .then (images)->
        expect(images.loopCount).toBe -1
        
        image= images[0]

        expect(image.width).toBe 256
        expect(image.height).toBe 192
        expect(image.data?.length).toBe image.width*image.height*4

        done()

    describe 'url',->
      it '.jpg', (done)->
        arg= 'https://59naga.github.io/fixtures/fixture.JPEG'

        pixel.parse arg
        .then (images)->
          expect(images.loopCount).toBe -1

          image= images[0]
          expect(image.width).toBe 256
          expect(image.height).toBe 192
          expect(image.data?.length).toBe image.width*image.height*4

          done()
        
      it '.png (RGB 3ch)', (done)->
        arg= 'https://59naga.github.io/fixtures/fixture.PNG'

        pixel.parse arg
        .then (images)->
          expect(images.loopCount).toBe -1
          
          image= images[0]

          expect(image.width).toBe 96
          expect(image.height).toBe 96
          expect(image.data?.length).toBe image.width*image.height*4

          done()
        
      it '.gif', (done)->
        arg= 'https://59naga.github.io/fixtures/fixture.GIF'

        pixel.parse arg
        .then (images)->
          expect(images.loopCount).toBe -1
          
          image= images[0]

          expect(image.width).toBe 112
          expect(image.height).toBe 112
          expect(image.data?.length).toBe image.width*image.height*4

          done()

      it '.gif (Anime)', (done)->
        arg= 'https://59naga.github.io/fixtures/animated.GIF'

        pixel.parse arg
        .then (images)->
          expect(images.loopCount).toBe 0 # Infinite
          
          image= images[0]

          expect(image.width).toBe 73
          expect(image.height).toBe 73
          expect(image.data?.length).toBe image.width*image.height*4
          expect(images.length).toBe 34

          done()