utils = require './utils'
{resp} = require './response'

exports.err_android = (req, res) ->
    utils.email "Android Crash Report", "You have received the following crash report:</br>#{JSON.stringify(req.body, null, 2)}"
    resp.success res, 'ok'