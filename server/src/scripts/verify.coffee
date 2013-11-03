exports.verify_ios = (req, res) ->
    verificationCode = req.query.code
    res.redirect "happ://#{verificationCode}"
