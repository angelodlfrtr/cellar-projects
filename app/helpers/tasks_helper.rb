module TasksHelper

  def task_label name, hex_color
    hex_color  = hex_color.gsub('#', '')
    rgb        = hex_color.scan(/../).map { |color| color.hex }
    rgb[0]     = (rgb[0].to_i).round
    rgb[1]     = (rgb[1].to_i).round
    rgb[2]     = (rgb[2].to_i).round
    text_color = nil

    if (rgb[0] * 0.299 + rgb[1] * 0.587 + rgb[2] * 0.114) > 186
      text_color = '#000000'
    else
      text_color = '#ffffff'
    end

    return [
      '<label class="label label-primary" style="background-color: #',
      hex_color, '; color: ', text_color, ';">',
      name,
      '</label>'
    ].join('').html_safe
  end

end
