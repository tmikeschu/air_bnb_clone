module ApplicationHelper

  def display_time_and_date(datetime)
    datetime.strftime("%b %e, %l:%M %p")
  end
end
