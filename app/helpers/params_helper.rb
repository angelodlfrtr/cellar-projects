module ParamsHelper

  def parse_page page
    return 1 if page.nil?
    page.to_i == 0 ? 1 : page.to_i
  end

  def parse_per per
    return 10 if per.nil?
    per.to_i == 0 ? 10 : per.to_i
  end
end
