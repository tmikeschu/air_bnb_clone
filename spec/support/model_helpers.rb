module ModelHelpers

  def to_date_picker_format
    self.strftime("%m/%d/%Y")
  end
end
