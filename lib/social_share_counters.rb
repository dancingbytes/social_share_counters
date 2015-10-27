require "net/http"
require "uri"
require "oj"

require "social_share_counters/version"
require "social_share_counters/request"
require "social_share_counters/respond"

module SocialShareCounters

  extend self

  VK_LINK       = 'http://vk.com/share.php?act=count&index=1&url=%{url}'.freeze
  FB_LINK       = 'http://graph.facebook.com/?id=%{url}'.freeze
  TWITTER_LINK  = 'http://cdn.api.twitter.com/1/urls/count.json?url=%{url}'.freeze
  MAILRU_LINK   = 'http://connect.mail.ru/share_count?url_list=%{url}'.freeze
  OK_LINK       = 'http://www.odnoklassniki.ru/dk?st.cmd=extOneClickLike&uid=odklocs0&ref=%{url}'.freeze
  LINKEDIN      = 'http://www.linkedin.com/countserv/count/share?url=%{url}&format=json'.freeze
  GPLUS         = 'https://clients6.google.com/rpc?key={key}'.freeze
  PINTEREST_LINK  = 'http://api.pinterest.com/v1/urls/count.json?callback=&url=%{url}'.freeze

  def vk(url)

    Respond.vk(
      Request.get(VK_LINK % { url: URI::encode(url) })
    )

  end # vk

  def fb(url)

    Respond.fb(
      Request.get(FB_LINK % { url: URI::encode(url) })
    )

  end # fb

  def ok(url)

    Respond.ok(
      Request.get(OK_LINK % { url: URI::encode(url) })
    )

  end # ok

  def pinterest(url)

    Respond.pinterest(
      Request.get(PINTEREST_LINK % { url: URI::encode(url) })
    )

  end # pinterest

  def linkedin(url)

    Respond.linkedin(
      Request.get(LINKEDIN % { url: URI::encode(url) })
    )

  end # linkedin

  def gplus(url, key = 'AIzaSyCKSbrvQasunBoV16zDH9R33D88CeLr9gQ')

    Respond.gplus(

      Request.post(GPLUS % { key: key }, {

        "method":   "pos.plusones.get",
        "id":       "p",
        "params":{
          "nolog":  "true",
          "id":     URI::encode(url),
          "source": "widget",
          "userId": "@viewer",
          "groupId":"@self"
        },
        "jsonrpc":  "2.0",
        "key":      "p",
        "apiVersion":"v1"

      })

    )

  end # gplus

  def mailru(url)

    Respond.mailru(
      Request.get(MAILRU_LINK % { url: URI::encode(url) })
    )

  end # mailru

  def twitter(url)

    Respond.twitter(
      Request.get(TWITTER_LINK % { url: URI::encode(url) })
    )

  end # twitter

  def timeout(t = nil)

    @timeout = t.abs if t.is_a?(::Numeric)
    @timeout

  end # timeout

  def debug?
    @debug == true
  end # debug?

  def debug(d = false)
    @debug = d === true
  end # debug

  def user_agent(str = nil)

    return @user_agent if str.nil?
    @user_agent = str

  end # user_agent

end # SocialShareCounters

require "social_share_counters/defaults"

SSC = SocialShareCounters
