require 'butter_sand/event'
require 'butter_sand/parser'
require 'date'

module ButterSand
  module API
    module Events
      PATH_SAIJI = '/contents/shop/saiji/'

      # @return [Array<ButterSand::Event>]
      def all
        ButterSand::Parser.to_array(get(PATH_SAIJI)).map {|event| ButterSand::Event.new(event)}
      end

      def on_sale
        all.select {|event| (event.starts..event.ends) === (@date_for_test || Date.today)}
      end

      # @return [Array<ButterSand::Event>]
      def starts_today
        all.select {|event| event.starts == (@date_for_test || Date.today)}
      end

      # @return [Array<ButterSand::Event>]
      def ends_today
        all.select {|event| event.ends == (@date_for_test || Date.today)}
      end

      # @return [Array<ButterSand::Event>]
      def find_by_prefecture(name)
        raise ArgumentError , 'Illegal argument' unless name.kind_of? String
        all.select {|event| event.prefecture == name}
      end
    end
  end
end