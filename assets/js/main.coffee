#define (require)->
#  Router = require 'router'
require.config
  paths:
    underscore: 'vendor/underscore'
    backbone: 'vendor/backbone'
#    lodash: 'vendor/lodash'
    jquery: 'vendor/jquery'
    jade: 'vendor/jade-runtime'

  shim:
    underscore:
      deps: []
      exports: '_'
    backbone:
      deps: ['underscore']
      exports: 'Backbone'
    jade:
      deps: []
      exports: 'jade'

define (require)->
  $        = require 'jquery'
  Backbone = require 'backbone'
  Router   = require 'router'

  router = new Router pushState: false

  Backbone.history.start()
  Backbone.history.on 'route', ->




  
#  window.Backbone = require 'backbone'
