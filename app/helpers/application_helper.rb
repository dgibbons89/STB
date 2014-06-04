module ApplicationHelper


	def sortable(column, title = nil)
  		title ||= column.titleize
  		css_class = column == sort_column ? "current #{sort_direction}" : nil
  		direction = column == sort_column && sort_direction == "asc" ? "desc" : "asc"
  		link_to title, params.merge(:sort => column, :direction => direction, :page => nil), {:class => css_class}
	end

	def display_month_with_increment(inc=nil)
	    month = sanitize_month(inc)
	    Date::MONTHNAMES[month]
  	end

  def sanitize_month(inc=nil)
    month = Date.current.month
    if inc.present?
      month += inc
      month = (month+1)%13 if month > 12
    end
    month
  end
end
