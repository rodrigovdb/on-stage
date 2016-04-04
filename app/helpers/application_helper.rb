module ApplicationHelper
  def duration_to_human(seconds)
    return if seconds.blank?

    time    = Time.at(seconds)
    hours   = time.utc.strftime('%H')
    format  = hours == '00' ? '%M:%S' : '%H:%M:%S'

    time.utc.strftime format
  end
end
