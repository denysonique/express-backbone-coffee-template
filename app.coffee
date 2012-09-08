
express = require("express")
http = require 'http'
routes = require("./routes")
assets = require 'connect-assets'
jade = require 'jade'
path = require 'path'

assets.jsCompilers.jade =
  match: /\.jade$/
  compileSync: (sourcePath, source)->
    fileName = path.basename sourcePath, '.jade'
    directoryName = (path.dirname sourcePath).replace "#{__dirname}/assets/templates", ""
    jstPath = if directoryName then "#{directoryName}/#{fileName}" else fileName
    jstPath = jstPath.replace(/^\//, '')
    ""
    "define(function(require) {
      jade = require('jade');
      
      return #{jade.compile(source, client: true)}
    })"
    





fs = require('fs')
app = module.exports = express()
app.configure ->
  app.set "views", __dirname + "/views"
  app.set "view engine", "jade"
  app.set "view options", layout: "layout"
  app.use express.bodyParser()
  app.use express.methodOverride()
  app.use require("stylus").middleware(src: __dirname + "/public")
  app.use app.router
  app.use express.static(__dirname + "/public")
  app.use require('connect-assets')()
#  app.use assets()

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


http.createServer(app).listen 3001, ->
  console.log "listening on http://l:3001"
