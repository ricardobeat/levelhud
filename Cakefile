flour = require 'flour'

task 'dev', ->
    flour.minifiers.disable 'js'
    flour.minifiers.disable 'css'

task 'build:vendor', ->
    bundle [
        'assets/vendor/underscore.js'
        'assets/vendor/zepto.js'
        'assets/vendor/backbone.js'
        'assets/vendor/foundation/js/foundation/foundation.js'
        'assets/vendor/foundation/js/foundation/foundation.dropdown.js'
    ], 'public/scripts/vendor.js'

    bundle [
        'assets/vendor/foundation/css/normalize.css'
        'assets/vendor/foundation/css/foundation.css'
    ], 'public/styles/base.css'

task 'build:coffee', ->
    bundle [
        'assets/*.coffee'
    ], 'public/scripts/app.js'

task 'build:styl', ->
    bundle [
        'assets/app.styl'
    ], 'public/styles/app.css'

task 'build:main', ->
    compile 'index.coffee', 'index.js'

task 'build', ->
    invoke 'build:vendor'
    invoke 'build:coffee'
    invoke 'build:styl'
    invoke 'build:main'

task 'watch', ->
    invoke 'build'
    watch 'assets/vendor/*', -> invoke 'build:vendor'
    watch 'assets/*.coffee', -> invoke 'build:coffee'
    watch 'assets/*.styl',   -> invoke 'build:styl'
    watch 'index.coffee',    -> invoke 'build:main'
