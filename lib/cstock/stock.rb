require 'rubygems'
require 'rest-client'

module CStock
  class Stock
    FIELDS = %w(code name open_price close_price cur_price high_price low_price bid_price_1 ask_price_1 volume turnover
      bid_volume_1 bid_price_1 bid_volume_2 bid_price_2 bid_volume_3 bid_price_3 bid_volume_4 bid_price_4 bid_volume_5 bid_price_5
      ask_volume_1 ask_price_1 ask_volume_2 ask_price_2 ask_volume_3 ask_price_3 ask_volume_4 ask_price_4 ask_volume_5 ask_price_5
      date time)

    FIELDS_ZH = %w(代码 股票名 开盘价 收盘价 当前价 今日最高 今日最低 买一价 卖一价 成交量 成交额
      买一挂单 买一价 买二挂单 买二价 买三挂单 买三价 买四挂单 买四价 买五挂单 买五价
      卖一挂单 卖一价 卖二挂单 卖二价 卖三挂单 卖三价 卖四挂单 卖四价 卖五挂单 卖五价
      日期 时间)

    FIELDS.each_with_index do |field, index|
      __send__(:attr_accessor, field.to_sym)
      __send__(:alias_method, FIELDS_ZH[index].to_sym,  field.to_sym)
    end

    def initialize(stock_code, data)
      @code = stock_code
      return nil if data == nil
      FIELDS[1..-1].each_with_index do |field, index|
        instance_variable_set("@#{field}", (data[index].nil? ? nil : data[index]))
      end
    end

    def description
      FIELDS_ZH.each do |field|
        puts field + " : " + self.send(field)
      end
    end

    PREFIX_URL = "http://hq.sinajs.cn/list="
    def self.quote(stock_code)
      parsed_stock_code = parse_stock_code(stock_code)
      url = PREFIX_URL + parsed_stock_code

      RestClient::Request.execute(:url => url, :method => :get) do |response|
        if response.code == 200
          s = Stock.new(stock_code, parse(response.force_encoding("GBK").encode("UTF-8")))
          yield(s) if block_given?
          return s
        else
          nil
        end
      end
    end

    def self.parse_stock_code(stock_code)
      prefix = (stock_code.to_i < 600000) ? "sz" : "sh"
      prefix + stock_code.to_s
    end

    def self.parse(data)
      data = data.split('=')
      if data[1].length < 10
        return nil
      else
        data = data[1].split(',')[0..-2]
        data[0] = data[0][1..-1]
        return data
      end
    end
  end
end
