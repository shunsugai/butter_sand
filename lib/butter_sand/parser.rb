require 'butter_sand'
require 'core_ext/string'
require 'core_ext/array'
require 'nokogiri'

module ButterSand
  class Parser
    class << self
      # @return [Array<Hash>]
      def to_array(body)
        shops = []
        raw_events(Nokogiri::HTML(body)).each do |elem|
          str_elems = elem.split(/\n\s+/)

          next if str_elems.length < 4
          next unless str_elems[3].strip.phone_number?
          begin
            dates = str_elems[0].date_to_ary
          rescue ArgumentError => e
            print e.message, "\n"
            next
          end

          shops << {
            :shop       => str_elems[2],
            :prefecture => str_elems[1],
            :phone      => str_elems[3].strip,
            :starts     => dates[0],
            :ends       => dates[1]
          }
        end
        shops
      end

      private

      # @return [Array<String>]
      def raw_events(body)
        each_state = state_names.map {|state| body.css(state).map(&:text).remove_at(0)}
        each_state.flatten(lv = 1)
      end

      # @return [Array<String>]
      def state_names
        states = %w(tohoku kanto tokai kansai chugoku kyushu)
        states.map {|state| "table.#{state} tr"}
      end
    end
  end
end