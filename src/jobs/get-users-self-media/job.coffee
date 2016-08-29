http   = require 'http'
_      = require 'lodash'
Instagram = require('node-instagram').default

class GetUsersSelfMedia
  constructor: ({@encrypted}) ->
    @instagram = new Instagram {
      clientId: process.env.ENDO_INSTAGRAM_INSTAGRAM_CLIENT_ID
      accessToken: @encrypted.secrets.credentials.secret
    }

  do: ({data}, callback) =>

    { count, min, max } = data

    @instagram.get 'users/self/media/recent', { count: count, MIN_ID: min, MAX_ID: max }, (error, results) =>
      return callback error if error?
      return callback null, {
        metadata: results.meta
        data: results.data
      }

  _userError: (code, message) =>
    error = new Error message
    error.code = code
    return error

module.exports = GetUsersSelfMedia
