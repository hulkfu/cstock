require 'cstock'
require 'spec_helper'

describe CStock::Stock do
  describe 'quote' do
    it "get stock info" do
      stock = CStock::Stock.quote('sh600000')
      expect(stock.name).to eq("浦发银行")
    end
  end
end