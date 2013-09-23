express    = require 'express'
http       = require 'http'
schedule   = require 'node-schedule'
api        = require './scripts/api/v0'
api_v1     = require './scripts/api/v1'
hidden     = require './scripts/hidden'
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
    app.use(express.errorHandler({ dumpExceptions: true, showStack: true }))

# Routes
app.get '/', routes.index
app.get '/api/moods', hidden.authenticate, api.get_mood
app.post '/api/moods', hidden.authenticate, api.post_mood
app.get '/api/dummy', api.populate_dummy

# API v1
app.get '/api/v1/getmoods', hidden.authenticate, api_v1.get_mood
app.post '/api/v1/postmood', hidden.authenticate, api_v1.post_mood

app.get '*', (req, res) -> resp.error res, resp.NOT_FOUND

# Analytics
rule = new schedule.RecurrenceRule()
rule.hour = 5
job = schedule.scheduleJob rule, () ->
    cache.info (val) ->
        hidden.email val

# Heroku ports or 3000
port = process.env.PORT || 3000
app.listen port, ->
    console.log 'Express server listening on port %d in %s mode', app.address().port, app.settings.env

