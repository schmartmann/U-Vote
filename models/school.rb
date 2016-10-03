class School < ActiveRecord::Base

  def self.search(search)
    # where("instnm ilike ? OR stabbr ilike ? OR webaddr ilike ? OR countynm ilike?", "%#{search}%")
    where("instnm ilike ?", "%#{search}%")
    # .or(where("stabbr ilike ?", "%#{search}%"))
    # .or(where("webaddr ilike ?", "%#{search}%"))
    # .or(where("countynm ilike ?", "%#{search}%"))
  end
end
