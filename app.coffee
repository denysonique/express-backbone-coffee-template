express = require("express")
routes = require("./routes")
assets = require 'connect-assets'
jade = require 'jade'
path = require 'path'

assets.jsCompilers.jade =
  match: /\.jst.jade$/
  compileSync: (sourcePath, source)->
    fileName = path.basename sourcePath, '.jst.jade'
    directoryName = (path.dirname sourcePath).replace "#{__dirname}/assets/templates", ""
    jstPath = if directoryName then "#{directoryName}/#{fileName}" else fileName
    console.log source
    """
    (function() {
      this.JST || (this.JST = {});
      this.JST['#{jstPath}'] = #{jade.compile source, client: true}
    }).call(this);
    """


fs = require('fs')
app = module.exports = express.createServer()
app.configure ->
  app.set "views", __dirname + "/views"
  app.set "view engine", "jade"
  app.use express.bodyParser()
  app.use express.methodOverride()
  app.use require("stylus").middleware(src: __dirname + "/public")
  app.use app.router
  app.use express.static(__dirname + "/public")
#  app.use require('connect-assets')()
  app.use assets()

app.configure "development", ->
  app.use express.errorHandler
    dumpExceptions: true
    showStack: true

app.configure "production", ->
  app.use express.errorHandler()

app.get "/", routes.index


app.post '/save', (req, res)->
  fs.writeFile '/tmp/test.css', req.body.contents, ->
    res.send()





app.listen 3001, ->
  console.log "Express server listening on port %d in %s mode", app.address().port, app.settings.env
