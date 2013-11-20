{conf}   = require './stealth/conf'
mysql    = require 'mysql'

exports.database =

    create: ->
        return mysql.createConnection({
            host : conf.sql.host,
            user : conf.sql.user,
            password : conf.sql.password,
            database : conf.sql.db_name,
            dateStrings : true
        })

    put_device: (phone_number, os, pn_token, callback) ->
        connection = @create()
        connection.query "INSERT INTO users (phone_number, os, pn_token) VALUES (?,?,?)", phone_number, os, pn_token, (err, result) ->
            connection.end()
            if err
                console.log("SQL INSERT Error in put_device")
                console.log(err)
                callback(err)
            else
                callback()

    #phone_numbers is an array of strings representing phone numbers
    get_devices: (phone_numbers, callback) ->
        connection = @create()
        connection.query "SELECT * FROM users WHERE phone_number in(#{connection.escape(phone_numbers)})", (err, result) ->
            connection.end()
            if err
                console.log("SQL SELECT error in get_devices")
                console.log(err)
            else
                # result is an array of js objects, one for each row returned
                callback result

    increment_happs: ->
        connection = @create()
        # First update happs_by_day
        connection.query "SELECT * FROM happs_by_day WHERE day = CURDATE()", (err, result) ->
            if err
                console.log("SQL SELECT error in increment_happs happs_by_day")
                console.log(err)
            else
                if result && result.length > 0
                    # We need to update the value in the row
                    connection.query "UPDATE happs_by_day SET counter=counter+1 WHERE id = #{result[0].id}"
                else
                    # We need to insert a new row for today
                    connection.query "INSERT INTO happs_by_day (day,counter) VALUES (CURDATE(), 1)"
            # Now update happs_within_day
            now = new Date()
            period = now.getHours()*4 + Math.floor(now.getMinutes()/15)
            connection.query "UPDATE happs_within_day SET counter=counter+1 WHERE period = #{period}", (err2, result2) ->
                connection.end()





