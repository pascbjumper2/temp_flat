module AdminHelper

  def catcount_to_cat(catcount)
    hash = { 1 => "About", 2 => "Advantages", 3 => "Tech Specs", 4 => "Usage", 5 => "FAQ" }
    hash[catcount]
  end

  def cat_to_active(catcount)
    if catcount == 1
      "active"
    end
  end

  def img_to_col_count(catcount)
    galcat = 12
    Content.where(:category => catcount).each do |x|
      if x.galleries.count != 0
        galcat = "6"
      end
    end
    galcat
  end

  def complete_to_color(complete)
    if complete == true
      "green"
    else
      "red"
    end
  end

  def complete_to_context(complete)
    if complete == true
      "Complete"
    else
      "Outstanding"
    end
  end

end
