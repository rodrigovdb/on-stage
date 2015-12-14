module ApplicationHelper
  def duration_to_human(seconds)
    Time.at(seconds).utc.strftime('%H:%M:%S')
  end
end
