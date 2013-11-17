apn         = require 'apn'
https       = require 'https'
{database}  = require './database' 
{conf}      = require './stealth/conf'

exports.send = (phone_numbers) ->
    database.get_devices phone_numbers, (rows) ->
        androids = []
        for row in rows
            if row.pn_token
                if row.os == '0'  #ios
                    apnConnection = apn.Connection()
                    device = new apn.Device(row.pn_token)
                    note = new apn.Notification()
                    note.badge = 1;
                    note.alert = "Someone has shared with you on Happ!"
                    apnConnection.pushNotification(note, device)
                else if row.os == '1' #android
                    androids.push row.pn_token

        # android
        if androids.length > 0
            payload =
                registration_ids: androids
                data: "Yo what's up"
            androidGcmPost payload


androidGcmPost = (payload) ->
    post_options = 
        host: "android.googleapis.com"
        path: "/gcm/send"
        method: 'POST'
        headers:
            key: conf.gcm.api_key
            'Content-Type': 'application/json'

    req = https.request post_options, (res) ->
        res.setEncoding('utf8')
        res.on 'data', (chunk) -> 
            console.log('Response: ' + chunk)

    req.write(payload.toString())
    req.end()
            


