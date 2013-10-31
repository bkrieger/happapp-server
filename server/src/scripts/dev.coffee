hidden = require './hidden'
{resp} = require './response'

exports.err_android = (req, res) ->
    console.log("crash report")
    hidden.email "Android Crash Report", "You have received the following crash report:</br>#{JSON.stringify(req.query, null, 2)}"
    resp.success res, 'ok'