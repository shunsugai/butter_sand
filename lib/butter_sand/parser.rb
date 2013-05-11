require 'butter_sand'
require 'core_ext/string'
require 'core_ext/array'
require 'nokogiri'

module ButterSand
  class Parser
    class << self

      KEY_DATE_INFO  = 0
      KEY_PREFECTURE = 1
      KEY_SHOP_NAME  = 2
      KEY_PHONE_NUM  = 3

      KEY_DATE_STARTS = 0
      KEY_DATE_ENDS   = 1

      # @return [Array<Hash>]
      def to_array(body)
        valid_infos = raw_events(Nokogiri::HTML(body)).select { |elem| valid_data? elem }
        valid_infos.map { |elem| shop_data_hash(elem.split(/\n\s+/)) }
      end

      private

      # @retrn [Hash]
      def shop_data_hash(list)
        dates = list[KEY_DATE_INFO].date_to_ary
        {
          :shop       => list[KEY_SHOP_NAME],
          :prefecture => list[KEY_PREFECTURE],
          :phone      => list[KEY_PHONE_NUM].strip,
          :starts     => dates[KEY_DATE_STARTS],
          :ends       => dates[KEY_DATE_ENDS]
        }
      end

      # @return [Boolean]
      def valid_data?(raw_data)
        str_elems = raw_data.split(/\n\s+/)
        return false if str_elems.length < 4
        return false unless str_elems[KEY_PHONE_NUM].strip.phone_number?
        begin
          str_elems[KEY_DATE_INFO].date_to_ary
        rescue ArgumentError => e
          print e.message, "\n"
          return false
        end
        true
      end

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