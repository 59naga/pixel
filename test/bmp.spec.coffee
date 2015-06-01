# Dependencies
pixel= require '../src'

# Environment
fixture= require 'fixture-images'

# Specs
describe 'Bitmap',->
  describe 'static',->
    it 'url',(done)->
      url= fixture.https.still.bmp

      pixel.parse url
      .then (images)->
        image= images[0]

        expect(image.width).toBe 128
        expect(image.height).toBe 128
        expect(image.data.length).toBe 128*128*4
        done()

    it 'datauri',(done)->
      datauri= 'data:image/jpeg;base64,'
      datauri+= fixture.still.bmp.toString 'base64'

      pixel.parse datauri
      .then (images)->
        image= images[0]

        expect(image.width).toBe 128
        expect(image.height).toBe 128
        expect(image.data.length).toBe 128*128*4
        done()

    it 'path',(done)->
      path= fixture.path.still.bmp

      pixel.parse path
      .then (images)->
        image= images[0]

        expect(image.width).toBe 128
        expect(image.height).toBe 128
        expect(image.data.length).toBe 128*128*4
        done()

    it 'binary',(done)->
      binary= fixture.still.bmp.toString 'binary'

      pixel.parse binary
      .then (images)->
        image= images[0]

        expect(image.width).toBe 128
        expect(image.height).toBe 128
        expect(image.data.length).toBe 128*128*4
        done()

    itFuture= if Blob? then it else xit
    itFuture 'blob',(done)->
      blob= new Blob [fixture.still.bmp],{type:'image/jpeg'}

      pixel.parse blob
      .then (images)->
        image= images[0]

        expect(image.width).toBe 128
        expect(image.height).toBe 128
        expect(image.data.length).toBe 128*128*4
        done()

    it 'buffer',(done)->
      buffer= fixture.still.bmp

      pixel.parse buffer
      .then (images)->
        image= images[0]

        expect(image.width).toBe 128
        expect(image.height).toBe 128
        expect(image.data.length).toBe 128*128*4
        done()

    itFuture= if Image? then it else xit
    itFuture 'image',(done)->
      image= new Image
      image.src= fixture.https.still.bmp

      pixel.parse image
      .then (images)->
        image= images[0]

        expect(image.width).toBe 128
        expect(image.height).toBe 128
        expect(image.data.length).toBe 128*128*4
        done()
