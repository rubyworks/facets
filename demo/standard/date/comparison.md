## Time#<=>, Date#<=>, DateTime#<=>

    require 'facets/date/cmp'

Allows Times, Dates and DateTimes to be compared with each other. This is useful
if you've got an array of Date, DateTime and Time instances and want to sort
them correctly (see Loading YAML below for an example of where this can happen).

    [Time.now - 10, Date.today, DateTime.now + 10].sort
    => [#<Date: 2016-10-08 ((2457670j,0s,0n),+0s,2299161j)>,
        2016-10-08 17:29:25 +1300,
        #<DateTime: 2016-10-18T17:29:35+13:00 ((2457680j,16175s,182784000n),+46800s,2299161j)>]

Otherwise, you'll get ArgumentError.

When comparing a Date with a Time, both are converted to DateTime instances
using #to_datetime. The behavior of this is according to the Ruby standard
library which assumes no timezone offset for a given date.

### Loading YAML

When loading YAML, it's possible that you get back instances of Date and Time
depending on the text format.

    YAML::load("#{Date.today.to_s}").class
    => Date
    YAML::load("#{DateTime.now.to_s}").class
    => Time
    YAML::load("#{Time.now.to_s}").class
    => Time

It's nice to have some way to sort these entries correctly without having to
impose limits on the format of the YAML document.