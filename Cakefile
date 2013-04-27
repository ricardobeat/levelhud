flour = require 'flour'

task 'dev', ->
    flour.minifiers.disable 'js'
    flour.minifiers.disable 'css'

task 'build', ->
    bundle [
        'assets/vendor/underscore.js'
        'assets/vendor/zepto.js'
        'assets/vendor/backbone.js'
        'assets/vendor/foundation/js/foundation/foundation.js'
        'assets/vendor/foundation/js/foundation/foundation.dropdown.js'
    ], 'public/scripts/vendor.js'

    bundle [
        'assets/*.coffee'
    ], 'public/scripts/app.js'

    bundle [
        'assets/vendor/foundation/css/normalize.css'
        'assets/vendor/foundation/css/foundation.css'
    ], 'public/styles/base.css'

    bundle [
        'assets/app.styl'
    ], 'public/styles/app.css'

    compile 'index.coffee', 'index.js'

task 'watch', ->
    invoke 'build'
    watch 'assets/*', -> invoke 'build'