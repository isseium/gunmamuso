require 'net/https'
require 'pp'

class FbClient
  Endpoint = 'https://graph.facebook.com'
  #Endpoint = 'http://graph.facebook.com'

  def initialize(access_token)
    if $DEBUG
      pp access_token
    end
    @access_token = access_token
  end

  def access(path, params = {}, method = 'get', uri = Endpoint)
    # URI設定
    uri = URI.parse(uri + path)
    pp uri if $DEBUG

    # パラメタを作成
    data_string = params.map{|key, value|
      URI.encode(key.to_s) + '=' + URI.encode(value.to_s)
    }.join('&')

    pp data_string if $DEBUG

    # メソッドによる分岐
    # TODO: GETパラメタのチェックしていない
    if method == 'post'
      request = Net::HTTP::Post.new(uri.path)
      request.set_form_data(params)
    else
      request = Net::HTTP::Get.new(uri.path + "?" + data_string)
    end
    request.set_content_type 'application/x-www-form-urlencoded'

    http = Net::HTTP.new(uri.host, uri.port)
    http.verify_mode = OpenSSL::SSL::VERIFY_NONE
    http.use_ssl = true
    return http.request(request)
  end

  public
  def postOwnFeed(message)
    res = self.access '/me/feed/', {:message => message, :access_token => @access_token}, 'post'
    pp res.body if $DEBUG
    return res.body
  end

end

# 以下、テスト
if $DEBUG
  fbc = FbClient.new( 'BAAD0SnLxRv8BAG66WTBJQG8jbcvxiGzw9NOfUIo1grZChfkAdIqqG9ZCSNqmE78GZA9ruPZApHN2q5qWonn9hZAx2wodijBttezScCC8giklt3sOsHphwuEgw8l45Pp0ZD' )
  fbc.postOwnFeed 'This is <a href="http://w3c.org/">w3c</a>'
end
