class HTMLImageElement
  constructor: (@width,@height)->
    @complete= false
    
    Object.defineProperty this,'src',
      get: -> @_src
      set: (@_src)->
        process.nextTick =>
          @complete= true
          @onload() if @onload

  addEventListener: (name,listener)->
    this['on'+name]= listener

module.exports= HTMLImageElement