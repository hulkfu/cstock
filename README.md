cstock
----------------

Quote chinese stock infomation.

It crawl infomation from "hq.sinajs.cn/list=", and include the below info:

股票代码 股票名 开盘价 昨日收盘价 当前价 今日最高 今日最低 买一价 卖一价 成交量 成交额

买一挂单 买一价 买二挂单 买二价 买三挂单 买三价 买四挂单 买四价 买五挂单 买五价

卖一挂单 卖一价 卖二挂单 卖二价 卖三挂单 卖三价 卖四挂单 卖四价 卖五挂单 卖五价

日期 时间

**as**

code name open_price yesterday_close_price cur_price high_price low_price bid_price_1 ask_price_1 volume turnover

bid_volume_1 bid_price_1 bid_volume_2 bid_price_2 bid_volume_3 bid_price_3 bid_volume_4 bid_price_4 bid_volume_5 bid_price_5

ask_volume_1 ask_price_1 ask_volume_2 ask_price_2 ask_volume_3 ask_price_3 ask_volume_4 ask_price_4 ask_volume_5 ask_price_5

date time

# usage

```ruby
gem install cstock

require 'cstock'

stock = CStock::Stock.new('600000')
stock.name  #=> 浦发银行
stock.股票名 #=> 浦发银行
stock. open_price #=> 16.00
```

## in terminal

```bash
% cstock 600000

股票代码 : 600000
股票名 : 浦发银行
开盘价 : 16.00
收盘价 : 16.18
当前价 : 16.20
今日最高 : 16.29
今日最低 : 15.93
买一价 : 16.20
卖一价 : 16.21
成交量 : 320361507
成交额 : 5171219071
买一挂单 : 12400
买一价 : 16.20
买二挂单 : 532100
买二价 : 16.19
买三挂单 : 815459
买三价 : 16.18
买四挂单 : 574500
买四价 : 16.17
买五挂单 : 358300
买五价 : 16.16
卖一挂单 : 773560
卖一价 : 16.21
卖二挂单 : 1226841
卖二价 : 16.22
卖三挂单 : 1063620
卖三价 : 16.23
卖四挂单 : 1037567
卖四价 : 16.24
卖五挂单 : 2292649
卖五价 : 16.25
日期 : 2015-04-03
时间 : 15:04:04
```
# TODO

* stock code without 'sh' or 'ss'
* more indicator