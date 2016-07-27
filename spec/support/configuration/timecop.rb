# You can freeze time using Timecop in one of two ways:
#
# 1. Without a specific time (uses Time.zone.now):
#
#   it "runs your test", :freeze_time do
#   end
#
# 2. With a specific time:
#
#   it "runs your test", freeze_time: Time.zone.parse("11:00pm") do
#   end
#
RSpec.configure do |config|

  config.around(:each) do |ex|
    freeze_time = ex.example.metadata[:freeze_time]

    if freeze_time.present?
      # Time and ActiveSupport::TimeWithZone will both return true here
      if freeze_time.kind_of?(Time)
        Timecop.freeze(freeze_time) { ex.run }
      else
        raise(ArgumentError, "freeze_time must be a kind of Time, is a #{freeze_time.class.name}")
      end
    else
      ex.run
    end
  end

end
