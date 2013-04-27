LevelHUD
========

A front-end for exploring LevelDB stores. Uses websockets to stream data to the browser on the fly.

    npm install levelhud

Requires [levelup](http://github.com/rvagg/levelup). Since only one connection to LevelDB can be open at a time, 
the LeveHUD server must be started from within your app to share the client instance:

    var levelup  = require('levelup')
      , levelgui = require('levelup-gui')

    var poneys = levelup('/etc/leveldb/poneys', { encoding: 'json' })

    new levelgui().use(poneys).listen(4420)

    // var app = express()
    // yada yada yada...

Point your browser to `localhost:4420`. That is all.

### Using multiple databases

    new levelgui(poneys).listen(4420)
    new levelgui(unicorns).listen(4421)

![screenshot](http://f.cl.ly/items/1i253S0n3o3C0C0T3M3R/Image%202013.04.22%205%3A48%3A40%20PM.png)

License
-------

http://ricardo.mit-license.org