require 'butter_sand'

module ButterSand
  class Event
    attr_reader :shop, :prefecture, :phone, :starts, :ends

    def initialize(options={})
      @shop       = options[:shop]
      @prefecture = options[:prefecture]
      @phone      = options[:phone]
      @starts     = options[:starts]
      @ends       = options[:ends]
    end
  end
end