## Time#<=>, Date#<=>, DateTime#<=>

    require 'facets/date/cmp'

Allows Times, Dates and DateTimes to be compared with each other. This is useful
if you've got an array of Date, DateTime and Time instances and want to sort
them correctly (see Loading YAML below for an example of where this can happen).

    list = [Time.utc(2016,10,8,12), Date.new(2016,10,8), DateTime.new(2016,10,18)]
    list.sort.map(&:class).assert == [Date, Time, DateTime]

Otherwise, you'll get ArgumentError.

When comparing a Date with a Time, both are converted to DateTime instances
using #to_datetime. The behavior of this is according to the Ruby standard
library which assumes no timezone offset for a given date.

### Loading YAML

When loading YAML, it's possible that you get back instances of Date and Time
depending on the text format.

    require 'yaml'

    YAML.unsafe_load("2016-10-08").class.assert == Date
    YAML.unsafe_load("2016-10-18T17:29:35+13:00").class.assert == Time
    YAML.unsafe_load("2016-10-08 17:29:25 +1300").class.assert == Time

It's nice to have some way to sort these entries correctly without having to
impose limits on the format of the YAML document.