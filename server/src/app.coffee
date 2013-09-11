express    = require 'express'
http       = require 'http'
api        = require './scripts/api'
routes     = require './scripts/routes'
{resp}     = require './scripts/response'
{cache}    = require './scripts/cache'

app = module.exports = express.createServer()
cache.init()

# Configuration
app.configure ->
    app.set('views', __dirname + '/views')
    app.set('view engine', 'jade')
    app.use express.bodyParser()
    app.use express.methodOverride()
    app.use express.cookieParser()
    app.use express.favicon(__dirname + '/../../client/gen/assets/images/favicon.ico')
    app.use(express.static(__dirname + '/../../client/gen'))

app.configure 'development', ->
    app.use(express.errorHandler({ dumpExceptions: true, showStack: true }))

app.configure 'production', ->
    app.use(express.errorHandler())

# TODO make authentication function
authenticate = (req, res, next) ->
    
    if req.query.muffin != '2'
        # if not authorized
        resp.error res, resp.UNAUTHORIZED, 'unauthorized'
    else
        next()

# Routes
app.get '/', routes.index
app.get '/api/moods', authenticate, api.get_mood
app.post '/api/moods', authenticate, api.post_mood
# app.get '/api/dummy', api.populate_dummy
app.get '*', (req, res) -> resp.error res, resp.NOT_FOUND

# Heroku ports or 3000
port = process.env.PORT || 3000
app.listen port, ->
    console.log 'Express server listening on port %d in %s mode', app.address().port, app.settings.env

