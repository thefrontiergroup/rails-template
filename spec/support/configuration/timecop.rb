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
      freeze_time_at = freeze_time.kind_of?(Time) ? freeze_time : Time.zone.now.change(nsec: 0)
      Timecop.freeze(freeze_time_at) do
        ex.run
      end
    else
      ex.run
    end
  end

end
