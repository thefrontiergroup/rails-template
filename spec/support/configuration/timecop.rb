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

  config.around(:each, freeze_time: true) do |ex|
    freeze_time = ex.example.metadata[:freeze_time]

    if freeze_time.present?
      # If freeze_time is specifically set to true it means that freeze_time was passed with
      # no args.
      if freeze_time == true
        freeze_time = Time.zone.now
      end

      # Time and ActiveSupport::TimeWithZone will both return true here
      if freeze_time.kind_of?(Time) || freeze_time.kind_of?(Date) || freeze_time.kind_of?(DateTime)
        Timecop.freeze(freeze_time) { ex.run }
      else
        raise(ArgumentError, "freeze_time value must be a kind of Date, DateTime, or Time. Value is a #{freeze_time.class.name}")
      end
    else
      ex.run
    end
  end

end
