# Elong

> 项目**不再**维护开发。欢迎 PR，我会尽快合并发布新版本。

[艺龙](http://www.elong.com) [OpenAPI](http://open.elong.com/) for Ruby

## 安装

在你项目的 `Gemfile` 文件添加下行内容:

    gem 'elong'

保存后执行:

    $ bundle

或者直接执行下行命令安装:

    $ gem install elong

## 用法

### 初始化

    user      = ''
    appKey    = ''
    secretKey = ''

    client = Elong::Client.new(user, appKey, secretKey)

### API 调用

#### 查看国内酒店指定时间段北京（Id：0101）地区的房源信息

    respone = client.house.list(CityId: '0101',
                                ArrivalDate: '2013-10-1',
                                DepartureDate: '2013-10-7',
                                PageSize: 20))

#### 取消国内酒店指定 id 的订单

    response = client.hotel.order.cancel(OrderId:'237864278346',
                                         CancelCode:'对酒店相关条件不满意')


 > 无需在意文档中某些接口必须调用 `https` 协议的接口，代码已经帮你处理好了，调用就行了！


### API 返回

#### 查看 HTTP 状态码

    puts response.status

#### 查看 OpenAPI 状态码

    puts response.code

#### 查看返回的数据内容

    puts response
    puts response.body
    puts response.to_s

以上方式均可。

#### 返回 JSON 结构化数据(基于 [mutli_json](https://github.com/intridea/multi_json))

    jsonData = response.to_json

#### 返回 XML 解析数据格式（基于 [mutli_xml](https://github.com/sferik/multi_xml)）

    xmlDom = response.to_xml

支持 ox, libxml, nokogiri, rexml 解析器，比如：

    xmlDom = response.to_xml(:nokogiri)


## 测试用例

使用中对代码有疑惑，请浏览源码中 spec 中的代码，里面包含了大量的代码用例。
填写 `spec/spec_hepler.rb` 中必要的 API 设定可以跑通完整的测试用例。


## 贡献代码

1. Fork 本仓库
2. 创建你自己的 feature 分支 (`git checkout -b my-new-feature`)
3. 提交你的代码 (`git commit -am 'Add some feature'`)
4. 提交你的分支 (`git push origin my-new-feature`)
5. 创建一个新的 Pull Request
