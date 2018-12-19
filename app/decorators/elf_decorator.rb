module ElfDecorator

  def full_name
    [
      first_name,
      last_name
    ].join(' ')
  end
  def readable_date_of_birth
    'Sometime'
  end
end
