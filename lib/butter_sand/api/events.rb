require 'butter_sand/event'
require 'butter_sand/parser'
require 'date'

module ButterSand
  module API
    module Events
      PATH_SAIJI = '/contents/shop/saiji/'

      # Returns list of all event information listed on the page. When there is no event information to be held, returns empty array.
      #
      # @return [Array<ButterSand::Event>] event information listed on the page
      def all
        ButterSand::Parser.to_array(get(PATH_SAIJI)).map {|event| ButterSand::Event.new(event)}
      end

      # Returns list of event information being held. When there is no corresponding data, returns empty array.
      #
      # @return [Array<ButterSand::Event>] event information being held
      def on_sale
        all.select {|event| (event.starts..event.ends) === (@date_for_test || Date.today)}
      end

      # Returns list of event information that starts today. When there is no corresponding data, returns empty array.
      #
      # @return [Array<ButterSand::Event>] event information that starts today
      def starts_today
        all.select {|event| event.starts == (@date_for_test || Date.today)}
      end

      # Returns list of event information that ends today. When there is no corresponding data, returns empty array.
      #
      # @return [Array<ButterSand::Event>] event information that ends today
      def ends_today
        all.select {|event| event.ends == (@date_for_test || Date.today)}
      end

      # Returns list of event information selected with given prefecture name. When there is no corresponding data, returns empty array.
      #
      # @raise [ArgumentError] Error raised when supplied prefecture name is not valid
      # @param name [String] prefecture name
      # @return [Array<ButterSand::Event>] event information selected with given prefecture name
      def find_by_prefecture(name)
        raise ArgumentError , 'Illegal argument' unless name.kind_of? String
        all.select {|event| event.prefecture == name}
      end
    end
  end
end