http   = require 'http'
_      = require 'lodash'
Instagram = require('node-instagram').default

class GetMediaComments
  constructor: ({@encrypted}) ->
    @instagram = new Instagram {
      clientId: process.env.ENDO_INSTAGRAM_INSTAGRAM_CLIENT_ID
      accessToken: @encrypted.secrets.credentials.secret
    }

  do: ({data}, callback) =>
    # return callback @_userError(422, 'data.username is required') unless data.username?
    endpoint = 'media/' + data.media-id + '/comments'

    @instagram.get endpoint, (error, results) =>
      return callback error if error?
      return callback null, {
        metadata: results.meta
        data: results.data
      }

  _userError: (code, message) =>
    error = new Error message
    error.code = code
    return error

module.exports = GetMediaComments
