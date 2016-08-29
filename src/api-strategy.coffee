_ = require 'lodash'
PassportInstagram = require 'passport-instagram'

class InstagramStrategy extends PassportInstagram
  constructor: (env) ->
    throw new Error('Missing required environment variable: ENDO_INSTAGRAM_INSTAGRAM_CLIENT_ID')     if _.isEmpty process.env.ENDO_INSTAGRAM_INSTAGRAM_CLIENT_ID
    throw new Error('Missing required environment variable: ENDO_INSTAGRAM_INSTAGRAM_CLIENT_SECRET') if _.isEmpty process.env.ENDO_INSTAGRAM_INSTAGRAM_CLIENT_SECRET
    throw new Error('Missing required environment variable: ENDO_INSTAGRAM_INSTAGRAM_CALLBACK_URL')  if _.isEmpty process.env.ENDO_INSTAGRAM_INSTAGRAM_CALLBACK_URL

    options = {
      clientID:     process.env.ENDO_INSTAGRAM_INSTAGRAM_CLIENT_ID
      clientSecret: process.env.ENDO_INSTAGRAM_INSTAGRAM_CLIENT_SECRET
      callbackURL:  process.env.ENDO_INSTAGRAM_INSTAGRAM_CALLBACK_URL
      scope: ["public_content", "follower_list", "comments", "relationships", "likes"]
    }

    super options, @onAuthorization

  onAuthorization: (accessToken, refreshToken, profile, callback) =>

    callback null, {
      id: profile.id
      username: profile.username
      secrets:
        credentials:
          secret: accessToken
          refreshToken: refreshToken
    }

module.exports = InstagramStrategy
