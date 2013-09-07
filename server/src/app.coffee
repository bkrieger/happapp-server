express    = require 'express'
http       = require 'http'
api        = require './scripts/api'
{resp}     = require './scripts/response'
{cache}    = require './scripts/cache'

app = module.exports = express.createServer()
cache.init()

# Configuration
app.configure ->
    app.use express.bodyParser()
    app.use express.methodOverride()

app.configure 'development', ->
    app.use(express.errorHandler({ dumpExceptions: true, showStack: true }))

app.configure 'production', ->
    app.use(express.errorHandler())

# TODO make authentication function
authenticate = (req, res, next) ->
    # if not authorized
    # resp.error res, resp.UNAUTHORIZED, 'unauthorized'
    next()

# Routes
app.get '/api/moods', authenticate, api.get_mood
app.get '/api/test', api.test
app.post '/api/moods', authenticate, api.post_mood
app.get '/api/multi', api.multi
app.get '*', (req, res) -> resp.error res, resp.NOT_FOUND

# Heroku ports or 3000
port = process.env.PORT || 3000
app.listen port, ->
    console.log 'Express server listening on port %d in %s mode', app.address().port, app.settings.env

