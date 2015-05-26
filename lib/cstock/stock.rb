require 'rubygems'
require 'rest-client'

module CStock
  class Stock
    FIELDS = %w(code name open_price yesterday_close_price current_price high_price low_price bid_price ask_price volume turnover
      bid_volume_1 bid_price_1 bid_volume_2 bid_price_2 bid_volume_3 bid_price_3 bid_volume_4 bid_price_4 bid_volume_5 bid_price_5
      ask_volume_1 ask_price_1 ask_volume_2 ask_price_2 ask_volume_3 ask_price_3 ask_volume_4 ask_price_4 ask_volume_5 ask_price_5
      date time)

    FIELDS_ZH = %w(代码 股票名 开盘价 昨日收盘价 当前价 今日最高 今日最低 买一价 卖一价 成交量 成交额
      买一挂单 买一价 买二挂单 买二价 买三挂单 买三价 买四挂单 买四价 买五挂单 买五价
      卖一挂单 卖一价 卖二挂单 卖二价 卖三挂单 卖三价 卖四挂单 卖四价 卖五挂单 卖五价
      日期 时间)

    FIELDS.each_with_index do |field, index|
      __send__(:attr_accessor, field.to_sym)
      __send__(:alias_method, FIELDS_ZH[index].to_sym,  field.to_sym)
    end

    def initialize(stock_code, data=nil)
      @code = stock_code
      data = self.class.quote(stock_code)[0] if data == nil
      FIELDS[1..-1].each_with_index do |field, index|
        instance_variable_set("@#{field}", ((data.nil? or data[index].nil?) ? nil : data[index]))
      end
      yield self if block_given?
    end


    def description
      FIELDS_ZH.each do |field|
        puts field + " : " + self.send(field).to_s
      end
    end

    def refresh
      self.class.refresh(self)
    end

    ##
    # with the given data to set the stock field values except the fires filed -- code.
    def set_fields(data)
      FIELDS[1..-1].each_with_index do |field, index|
        self.send("#{field}=".to_sym, ((data.nil? or data[index].nil?) ? nil : data[index]))
      end
    end

    class << self
      ##
      # block can yield after each stock refresh
      def refresh(stocks)
        stocks = [stocks] if not stocks.respond_to?(:each)
        stock_codes = stocks.map(&:code)
        # one quote return muti stocks data. So it saves time.
        quote(stock_codes) do |datas|
          datas.each_with_index do |data, index|
            stock = stocks[index]
            stock.set_fields data
            yield stock if block_given?
          end
        end
        stocks
      end

      PREFIX_URL = "http://hq.sinajs.cn/list="
      def quote(stock_codes)
        parsed_stock_codes_str = ''
        stock_codes = [stock_codes] if not stock_codes.respond_to?(:each)

        stock_codes.each do |stock_code|
          parsed_stock_codes_str += "#{parse_stock_code(stock_code)},"
        end

        url = PREFIX_URL + parsed_stock_codes_str

        RestClient::Request.execute(:url => url, :method => :get) do |response|
          if response.code == 200
            datas = parse(response.force_encoding("GBK").encode("UTF-8").strip!)
            yield(datas) if block_given?
            return datas
          else
            nil
          end
        end
      end

      def parse_stock_code(stock_code)
        return "sz0" if /^\d{6}$/.match(stock_code).nil?  # so it can continue quote and return nil
        prefix = (stock_code.to_i < 600000) ? "sz" : "sh"
        prefix + stock_code.to_s
      end

      def parse(datas)
        return nil if datas.nil?
        datas = datas.split(';').map do |data|
          return nil if data.nil?
          data = data.split('=')
          if data[1].length < 10
            nil
          else
            data = data[1].split(',')[0..-2]
            data[0] = data[0][1..-1]  # fix name string
            data
          end
        end
      end

      def exists?(stock_code)
        quote(stock_code)[0] ? true : false
      end
    end
  end
end
