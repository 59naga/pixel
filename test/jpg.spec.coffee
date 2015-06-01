# Dependencies
pixel= require '../src'

# Environment
fixture= require 'fixture-images'

# Specs
describe 'Jpeg',->
  describe 'static',->
    it 'url',(done)->
      url= fixture.https.still.jpg

      pixel.parse url
      .then (images)->
        image= images[0]

        expect(image.width).toBe 256
        expect(image.height).toBe 192
        expect(image.data.length).toBe 256*192*4
        done()

    it 'datauri',(done)->
      datauri= 'data:image/jpeg;base64,'
      datauri+= fixture.still.jpg.toString 'base64'

      pixel.parse datauri
      .then (images)->
        image= images[0]

        expect(image.width).toBe 256
        expect(image.height).toBe 192
        expect(image.data.length).toBe 256*192*4
        done()

    it 'path',(done)->
      path= fixture.path.still.jpg

      pixel.parse path
      .then (images)->
        image= images[0]

        expect(image.width).toBe 256
        expect(image.height).toBe 192
        expect(image.data.length).toBe 256*192*4
        done()

    it 'binary',(done)->
      binary= fixture.still.jpg.toString 'binary'

      pixel.parse binary
      .then (images)->
        image= images[0]

        expect(image.width).toBe 256
        expect(image.height).toBe 192
        expect(image.data.length).toBe 256*192*4
        done()

    itFuture= if Blob? then it else xit
    itFuture 'blob',(done)->
      blob= new Blob [fixture.still.jpg],{type:'image/jpeg'}

      pixel.parse blob
      .then (images)->
        image= images[0]

        expect(image.width).toBe 256
        expect(image.height).toBe 192
        expect(image.data.length).toBe 256*192*4
        done()

    it 'buffer',(done)->
      buffer= fixture.still.jpg

      pixel.parse buffer
      .then (images)->
        image= images[0]

        expect(image.width).toBe 256
        expect(image.height).toBe 192
        expect(image.data.length).toBe 256*192*4
        done()

    itFuture= if Image? then it else xit
    itFuture 'image',(done)->
      image= new Image
      image.src= fixture.https.still.jpg

      pixel.parse image
      .then (images)->
        image= images[0]

        expect(image.width).toBe 256
        expect(image.height).toBe 192
        expect(image.data.length).toBe 256*192*4
        done()
