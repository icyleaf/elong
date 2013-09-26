require 'elong'

require 'date'
require 'rexml/document'


RSpec.configure do |config|
  config.before :all do
    @user      = '1'
    @appKey    = '2'
    @secretKey = '3'

    @today = Time.now.to_i
    @tomorrow = DateTime.strptime((@today + 24*3600).to_s, '%s').to_time.strftime('%Y-%m-%d')
    @theDayAfterTomorrow = DateTime.strptime((@today + 2*24*3600).to_s, '%s').to_time.strftime('%Y-%m-%d')

    @cityId = '0101'

    @client = Elong::Client.new(@user, @appKey, @secretKey)
  end
end
