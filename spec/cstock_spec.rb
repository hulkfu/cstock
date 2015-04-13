require 'cstock'
require 'spec_helper'

describe CStock::Stock do
  describe 'initialize' do
    stock = CStock::Stock.new('600000') do |s|
      puts "***" + s.name
    end
    stock.description

    it "get stock info" do
      expect(stock.name).to eq("浦发银行")
    end

    it "set stock code" do
      expect(stock.code).to eq("600000")
    end
  end

  describe "refresh" do
    before :each do
      @s = CStock::Stock.new('600000', %w(name open_price yesterday_close_price cur_price high_price low_price bid_price_1 ask_price_1 volume turnover
      bid_volume_1 bid_price_1 bid_volume_2 bid_price_2 bid_volume_3 bid_price_3 bid_volume_4 bid_price_4 bid_volume_5 bid_price_5
      ask_volume_1 ask_price_1 ask_volume_2 ask_price_2 ask_volume_3 ask_price_3 ask_volume_4 ask_price_4 ask_volume_5 ask_price_5
      date time))

      @s2 = CStock::Stock.new('002385', %w(name open_price yesterday_close_price cur_price high_price low_price bid_price_1 ask_price_1 volume turnover
      bid_volume_1 bid_price_1 bid_volume_2 bid_price_2 bid_volume_3 bid_price_3 bid_volume_4 bid_price_4 bid_volume_5 bid_price_5
      ask_volume_1 ask_price_1 ask_volume_2 ask_price_2 ask_volume_3 ask_price_3 ask_volume_4 ask_price_4 ask_volume_5 ask_price_5
      date time))

      @stocks = [@s, @s2]
    end

    it "class method update stock attr" do
      expect(@s.name).to eq("name")
      CStock::Stock.refresh(@s)
      expect(@s.name).to eq('浦发银行')
    end

    it "instance method update stock attr" do
      expect(@s.name).to eq("name")
      @s.refresh
      expect(@s.name).to eq('浦发银行')
    end

    it "refresh muti stocks at one quote" do
      expect(@s.name).to eq("name")
      expect(@s2.name).to eq("name")
      CStock::Stock.refresh(@stocks) do |s|
        expect(s.name).not_to eq("name")
      end.each do |stock|
        expect(@s.name).to eq("浦发银行")
        expect(@s2.name).to eq("大北农")
      end
      expect(@s.name).to eq("浦发银行")
      expect(@s2.name).to eq("大北农")
    end
  end
end
