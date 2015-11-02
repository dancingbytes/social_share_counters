module SocialShareCounters

  class Respond

    class << self

      def vk(req)

        resp = new(req)

        r = (resp.result || "").match(/VK.Share.count\(1, (?<count>\d+)\);/)
        to_int(r ?  r["count"] : 0)

      end # vk

      def fb(req)

        resp = new(req)

        r = ::Oj.load((resp.result || "{}"), mode: :null)
        to_int(r["shares"])

      end # fb

      def twitter(req)

        resp = new(req)

        r = ::Oj.load((resp.result || "{}"), mode: :null)
        to_int(r["count"])

      end # twitter

      def mailru(req)

        resp = new(req)

        r = ::Oj.load((resp.result || "{}"), mode: :null)
        to_int(r.empty? ? 0 : r.to_a[0][1]["shares"])

      end # mailru

      def ok(req)

        resp = new(req)

        r = (resp.result || "").match(/ODKL.updateCountOC\('odklocs0','(?<count>\d+)','0','0'\);/)
        to_int(r ?  r["count"] : 0)

      end # ok

      def pinterest(req)

        resp = new(req)

        r = (resp.result || "").match(/"count":(?<count>\d+)/)
        to_int(r ?  r["count"] : 0)

      end # pinterest

      def linkedin(req)

        resp = new(req)

        r = ::Oj.load((resp.result || "{}"), mode: :null)
        to_int(r["count"])

      end # linkedin

      def gplus(req)

        resp = new(req)

        r = ::Oj.load((resp.result || "{}"), mode: :null)
        to_int(r.empty? ? 0 : r['result']['metadata']['globalCounts']['count'])

      end # gplus

      private

      def to_int(obj)
        String(obj).to_i
      end # to_int

    end # class << self

    def initialize(request)

      @error  = nil
      @result = nil

      if request.is_a?(::Net::HTTPOK)
        prepare_http(request)
      else
        prepare_error(request)
      end

      debug_info

    end # new

    def success?
      @error.nil?
    end # success?

    def failure?
      !@error.nil?
    end # failure?

    alias :error? :failure?

    def error
      @error
    end # error

    def result
      @result
    end # result

    private

    def prepare_http(http)

      @error  = nil
      @result = http.body

    end # prepare_http

    def prepare_error(http)

      @error  = http
      @result = nil

    end # prepare_error

    def debug_info

      return unless ::SocialShareCounters.debug?

      puts "-> Result"
      puts "-> #{(success? ? result : error)}"

    end # debug_info

  end # Respond

end # SocialShareCounters
