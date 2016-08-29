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

    { count, max_like_id } = data

    @instagram.get 'users/self/media/liked', { count: count, MAX_LIKE_ID: max_like_id }, (error, results) =>
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
