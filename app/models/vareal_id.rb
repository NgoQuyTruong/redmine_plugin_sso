# frozen_string_literal: true

class VarealId < ActiveRecord::Base
  EVENT_START_TIME_LABEL = 'Start time'
  TITLE_TRACKER_MEETING = 'Meeting'
  EVENT_END_TIME_LABEL = 'End time'
  TIME_ZONE_LABEL = 'Time zone'
  RECURRENCE_LABEL= 'Recurrence'
  AUTHORIZATION_URI = 'https://accounts.google.com/o/oauth2/auth'
  TOKEN_CREDENTIAL_URI = 'https://accounts.google.com/o/oauth2/token'
end
