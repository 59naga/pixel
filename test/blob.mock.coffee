class Blob
  constructor: (contents,options)->
    content= contents[0]
    content.type= options.type
    return content

module.exports= Blob