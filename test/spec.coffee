# Dependencies
Pixel= require '../src'

fs= require 'fs'

jasmine.DEFAULT_TIMEOUT_INTERVAL= 5000

# Specs
describe 'Pixel',->
  describe 'Parser',->
    it '.jpg', (done)->
      url= 'https://59naga.github.io/fixtures/fixture.JPEG'

      Pixel.parse url
      .then (images)->
        expect(images.loopCount).toBe -1

        image= images[0]
        expect(image.width).toBe 256
        expect(image.height).toBe 192
        expect(image.data instanceof Uint8Array).toBe true
        expect(image.data?.length).toBe image.width*image.height*4

        done()
      
    it '.png (RGB 3ch)', (done)->
      url= 'https://59naga.github.io/fixtures/fixture.PNG'

      Pixel.parse url
      .then (images)->
        expect(images.loopCount).toBe -1
        
        image= images[0]

        expect(image.width).toBe 96
        expect(image.height).toBe 96
        expect(image.data instanceof Uint8Array).toBe true
        expect(image.data?.length).toBe image.width*image.height*4

        done()
      
    it '.gif', (done)->
      url= 'https://59naga.github.io/fixtures/fixture.GIF'

      Pixel.parse url
      .then (images)->
        expect(images.loopCount).toBe -1
        
        image= images[0]

        expect(image.width).toBe 112
        expect(image.height).toBe 112
        expect(image.data instanceof Uint8Array).toBe true
        expect(image.data?.length).toBe image.width*image.height*4

        done()

    it '.gif (Anime)', (done)->
      url= 'https://59naga.github.io/fixtures/animated.GIF'

      Pixel.parse url
      .then (images)->
        expect(images.loopCount).toBe 0 # Infinite
        
        image= images[0]

        expect(image.width).toBe 73
        expect(image.height).toBe 73
        expect(image.data instanceof Uint8Array).toBe true
        expect(image.data?.length).toBe image.width*image.height*4
        expect(images.length).toBe 34

        done()

  describe 'parse',->
    it 'file',(done)->
      file= __dirname+'/fixture.GIF'

      Pixel.parse file
      .then (images)->
        expect(images.loopCount).toBe -1
        
        image= images[0]

        expect(image.width).toBe 112
        expect(image.height).toBe 112
        expect(image.data instanceof Uint8Array).toBe true
        expect(image.data?.length).toBe image.width*image.height*4

        done()

    it 'url',(done)->
      url= 'https://59naga.github.io/fixtures/fixture.GIF'

      Pixel.parse url
      .then (images)->
        expect(images.loopCount).toBe -1
        
        image= images[0]

        expect(image.width).toBe 112
        expect(image.height).toBe 112
        expect(image.data instanceof Uint8Array).toBe true
        expect(image.data?.length).toBe image.width*image.height*4

        done()

    it 'datauri',(done)->
      datauri= 'data:image/gif;base64,'
      datauri+= fs.readFileSync(__dirname+'/fixture.GIF').toString('base64')

      Pixel.parse datauri
      .then (images)->
        expect(images.loopCount).toBe -1
        
        image= images[0]

        expect(image.width).toBe 112
        expect(image.height).toBe 112
        expect(image.data instanceof Uint8Array).toBe true
        expect(image.data?.length).toBe image.width*image.height*4

        done()
