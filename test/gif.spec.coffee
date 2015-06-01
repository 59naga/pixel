# Dependencies
pixel= require '../src'

# Environment
fixture= require 'fixture-images'

# Specs
describe 'Gif',->
  describe 'animated',->
    it 'url',(done)->
      url= fixture.https.animated.gif

      pixel.parse url
      .then (images)->
        image= images[0]

        expect(image.width).toBe 73
        expect(image.height).toBe 73
        expect(image.data.length).toBe 73*73*4
        done()

    it 'datauri',(done)->
      datauri= 'data:image/gif;base64,'
      datauri+= fixture.animated.gif.toString 'base64'

      pixel.parse datauri
      .then (images)->
        image= images[0]

        expect(image.width).toBe 73
        expect(image.height).toBe 73
        expect(image.data.length).toBe 73*73*4
        done()

    it 'path',(done)->
      path= fixture.path.animated.gif

      pixel.parse path
      .then (images)->
        image= images[0]

        expect(image.width).toBe 73
        expect(image.height).toBe 73
        expect(image.data.length).toBe 73*73*4
        done()

    it 'binary',(done)->
      binary= fixture.animated.gif.toString 'binary'

      pixel.parse binary
      .then (images)->
        image= images[0]

        expect(image.width).toBe 73
        expect(image.height).toBe 73
        expect(image.data.length).toBe 73*73*4
        done()

    itFuture= if Blob? then it else xit
    itFuture 'blob',(done)->
      blob= new Blob [new Uint8Array(fixture.animated.gif)],{type:'image/gif'}

      pixel.parse blob
      .then (images)->
        image= images[0]

        expect(image.width).toBe 73
        expect(image.height).toBe 73
        expect(image.data.length).toBe 73*73*4
        done()

    it 'buffer',(done)->
      buffer= fixture.animated.gif

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
      image.src= fixture.https.animated.gif

      pixel.parse image
      .then (images)->
        image= images[0]

        expect(image.width).toBe 73
        expect(image.height).toBe 73
        expect(image.data.length).toBe 73*73*4
        done()

  describe 'static',->
    it 'url',(done)->
      url= fixture.https.still.gif

      pixel.parse url
      .then (images)->
        image= images[0]

        expect(image.width).toBe 112
        expect(image.height).toBe 112
        expect(image.data.length).toBe 112*112*4
        done()

    it 'datauri',(done)->
      datauri= 'data:image/gif;base64,'
      datauri+= fixture.still.gif.toString 'base64'

      pixel.parse datauri
      .then (images)->
        image= images[0]

        expect(image.width).toBe 112
        expect(image.height).toBe 112
        expect(image.data.length).toBe 112*112*4
        done()

    it 'path',(done)->
      path= fixture.path.still.gif

      pixel.parse path
      .then (images)->
        image= images[0]

        expect(image.width).toBe 112
        expect(image.height).toBe 112
        expect(image.data.length).toBe 112*112*4
        done()

    it 'binary',(done)->
      binary= fixture.still.gif.toString 'binary'

      pixel.parse binary
      .then (images)->
        image= images[0]

        expect(image.width).toBe 112
        expect(image.height).toBe 112
        expect(image.data.length).toBe 112*112*4
        done()

    itFuture= if Blob? then it else xit
    itFuture 'blob',(done)->
      blob= new Blob [fixture.still.gif],{type:'image/gif'}

      pixel.parse blob
      .then (images)->
        image= images[0]

        expect(image.width).toBe 112
        expect(image.height).toBe 112
        expect(image.data.length).toBe 112*112*4
        done()

    it 'buffer',(done)->
      buffer= fixture.still.gif

      pixel.parse buffer
      .then (images)->
        image= images[0]

        expect(image.width).toBe 112
        expect(image.height).toBe 112
        expect(image.data.length).toBe 112*112*4
        done()

    itFuture= if Image? then it else xit
    itFuture 'image',(done)->
      image= new Image
      image.src= fixture.https.still.gif

      pixel.parse image
      .then (images)->
        image= images[0]

        expect(image.width).toBe 112
        expect(image.height).toBe 112
        expect(image.data.length).toBe 112*112*4
        done()
