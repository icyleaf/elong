require 'elong'

require 'date'
require 'rexml/document'


RSpec.configure do |config|
  config.before :all do
    @user      = ''
    @appKey    = ''
    @secretKey = ''

    @client = Elong::Client.new(@user, @appKey, @secretKey)
  end
end
