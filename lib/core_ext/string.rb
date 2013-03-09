# coding: utf-8
require 'date'

class String
  # @return [Date]
  def parse_date
    self.scan(/(\d+)(月)(\d+)(日)/)
    month = $1.to_i
    day = $3.to_i
    today = Date.today
    year = today.month >= 10 && month == 1 ? today.year + 1 : today.year
    Date.parse("#{year}.#{month}.#{day}")
  end

  # @return [Array]
  def date_to_ary
    self.split("〜").map!(&:parse_date)
  end

  def phone_number?
    delete('-') =~ /^\d+$/
  end
end