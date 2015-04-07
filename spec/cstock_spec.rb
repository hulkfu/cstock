require 'cstock'
require 'spec_helper'

describe CStock::Stock do
  describe 'quote' do
    stock = CStock::Stock.quote('600000') do |s|
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
end