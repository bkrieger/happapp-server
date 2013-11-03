exports.verify_ios = (req, res) ->
    verificationCode = req.query.verify
    res.redirect "http://www.google.com"
