require 'net/http'

module SinaStock
  class Crawler
    BASE_HOST = "hq.sinajs.cn"
    CURRENT_INFO = "/list="
    def query(code)
      Net::HTTP.get(BASE_HOST, CURRENT_INFO + code)
    end
  end

  class Stock
    attr_accessor :code, :name, :cur_price, :max_price, :min_price
  end
end

