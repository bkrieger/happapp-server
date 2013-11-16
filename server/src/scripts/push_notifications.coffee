apn         = require 'apn'
{database}  = require './database' 

exports.push_notifications = 
    
    send: (phone_numbers) ->
        database.get_devices phone_numbers, (rows) ->
            for row in rows
                if row.pn_token
                    if row.os == '0'  #ios
                        apnConnection = apn.Connection()
                        device = new apn.Device(row.pn_token)
                        note = new apn.Notification()
                        note.badge = 1;
                        note.alert = "Someone has shared with you on Happ!"
                        apnConnection.pushNotification(note, device)
