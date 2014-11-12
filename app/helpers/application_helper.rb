module ApplicationHelper
  def title(value)
    unless value.nil?
      @title = "#{value} | CargaMasiva"      
    end
  end
end
