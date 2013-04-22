LevelUp GUI
===========

A front-end for exploring data stored in LevelDB. Uses websockets to stream data to the browser on the fly.

    npm install levelup-gui

Requires [levelup](http://github.com/rvagg/levelup). Since only one connection to LevelDB can be open at a time, 
the GUI must be started from within your app so that it can share the `levelup` instance:

    var levelup  = require('levelup')
      , levelgui = require('levelup-gui')

    var poneys = levelup('/etc/leveldb/poneys', { encoding: 'json' })

    levelgui.use(poneys).listen(4420)

    // var app = express()
    // yada yada yada...

Point your browser to `localhost:4420`. That is all.

![screenshot](http://f.cl.ly/items/1i253S0n3o3C0C0T3M3R/Image%202013.04.22%205%3A48%3A40%20PM.png)