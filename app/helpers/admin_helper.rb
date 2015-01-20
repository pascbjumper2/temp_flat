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
    if Gallery.where(:content_id => catcount).count == 0
      "6"
    else
      "12"
    end
  end


end
