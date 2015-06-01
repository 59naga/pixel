# Dependencies
pixel= require '../src'

# Environment
fixture= require 'fixture-images'

# Specs
describe 'Png',->
  describe 'animated',->
    it 'url',(done)->
      url= fixture.https.animated.png

      pixel.parse url
      .then (images)->
        image= images[0]

        expect(image.width).toBe 73
        expect(image.height).toBe 73
        expect(image.data.length).toBe 73*73*4
        done()

    it 'datauri',(done)->
      datauri= 'data:image/png;base64,'
      datauri+= fixture.animated.png.toString 'base64'

      pixel.parse datauri
      .then (images)->
        image= images[0]

        expect(image.width).toBe 73
        expect(image.height).toBe 73
        expect(image.data.length).toBe 73*73*4
        done()

    it 'path',(done)->
      path= fixture.path.animated.png

      pixel.parse path
      .then (images)->
        image= images[0]

        expect(image.width).toBe 73
        expect(image.height).toBe 73
        expect(image.data.length).toBe 73*73*4
        done()

    it 'binary',(done)->
      binary= fixture.animated.png.toString 'binary'

      pixel.parse binary
      .then (images)->
        image= images[0]

        expect(image.width).toBe 73
        expect(image.height).toBe 73
        expect(image.data.length).toBe 73*73*4
        done()

    itFuture= if Blob? then it else xit
    itFuture 'blob',(done)->
      blob= new Blob [fixture.animated.png],{type:'image/png'}

      pixel.parse blob
      .then (images)->
        image= images[0]

        expect(image.width).toBe 73
        expect(image.height).toBe 73
        expect(image.data.length).toBe 73*73*4
        done()

    it 'buffer',(done)->
      buffer= fixture.animated.png

      pixel.parse buffer
      .then (images)->
        image= images[0]

        expect(image.width).toBe 73
        expect(image.height).toBe 73
        expect(image.data.length).toBe 73*73*4
        done()

    itFuture= if Image? then it else xit
    itFuture 'image',(done)->
      image= new Image
      image.src= fixture.https.animated.png

      pixel.parse image
      .then (images)->
        image= images[0]

        expect(image.width).toBe 73
        expect(image.height).toBe 73
        expect(image.data.length).toBe 73*73*4
        done()

  describe 'static',->
    it 'url',(done)->
      url= fixture.https.still.png

      pixel.parse url
      .then (images)->
        image= images[0]

        expect(image.width).toBe 96
        expect(image.height).toBe 96
        expect(image.data.length).toBe 96*96*4
        done()

    it 'datauri',(done)->
      datauri= 'data:image/png;base64,'
      datauri+= fixture.still.png.toString 'base64'

      pixel.parse datauri
      .then (images)->
        image= images[0]

        expect(image.width).toBe 96
        expect(image.height).toBe 96
        expect(image.data.length).toBe 96*96*4
        done()

    it 'path',(done)->
      path= fixture.path.still.png

      pixel.parse path
      .then (images)->
        image= images[0]

        expect(image.width).toBe 96
        expect(image.height).toBe 96
        expect(image.data.length).toBe 96*96*4
        done()

    it 'binary',(done)->
      binary= fixture.still.png.toString 'binary'

      pixel.parse binary
      .then (images)->
        image= images[0]

        expect(image.width).toBe 96
        expect(image.height).toBe 96
        expect(image.data.length).toBe 96*96*4
        done()

    itFuture= if Blob? then it else xit
    itFuture 'blob',(done)->
      blob= new Blob [fixture.still.png],{type:'image/png'}

      pixel.parse blob
      .then (images)->
        image= images[0]

        expect(image.width).toBe 96
        expect(image.height).toBe 96
        expect(image.data.length).toBe 96*96*4
        done()

    it 'buffer',(done)->
      buffer= fixture.still.png

      pixel.parse buffer
      .then (images)->
        image= images[0]

        expect(image.width).toBe 96
        expect(image.height).toBe 96
        expect(image.data.length).toBe 96*96*4
        done()

    itFuture= if Image? then it else xit
    itFuture 'image',(done)->
      image= new Image
      image.src= fixture.https.still.png

      pixel.parse image
      .then (images)->
        image= images[0]

        expect(image.width).toBe 96
        expect(image.height).toBe 96
        expect(image.data.length).toBe 96*96*4
        done()
