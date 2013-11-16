nodemailer = require 'nodemailer'
{conf}     = require './stealth/conf'

exports.email = (subject, message) ->
    smtpTransport = nodemailer.createTransport("SMTP", conf.mail.config)
    mailOptions = {
        from: conf.mail.sender,
        to: conf.mail.receiver,
        subject: "#{subject}",
        html: "<pre><code>#{message}</code></pre>"
    }
    smtpTransport.sendMail mailOptions, (error, response) ->
        if error
            console.log("error sending mail")
        smtpTransport.close()