module SocialShareCounters

  class Request

    USER_AGENT  = 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_11_1) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/46.0.2490.80 Safari/537.36'.freeze
    ACCEPT      = 'text/html,application/xhtml+xml,application/xml;q=0.9,image/webp,*/*;q=0.8'.freeze

    def self.get(url)
      new(url).get
    end # self.get

    def self.post(url, params = {})
      new(url).post(params)
    end # self.post

    def initialize(url)

      @uri    = URI(url)
      @http   = ::Net::HTTP.new(@uri.host, @uri.port)
      set_http_params

    end # new

    def get

      @request = ::Net::HTTP::Get.new(@uri.request_uri)

      set_request_params
      call

    end # get

    def post(params = {})

      @request = ::Net::HTTP::Post.new(@uri.request_uri)
      @request.set_form_data(params)

      set_request_params
      call

    end # post

    private

    def call

      begin
        @http.request(@request)
      rescue => ex
        ex
      end

    end # call

    def set_http_params

      @http.set_debug_output($stdout) if ::SocialShareCounters.debug?
      @http.open_timeout = ::SocialShareCounters.timeout
      @http.read_timeout = ::SocialShareCounters.timeout

      self

    end # set_http_params

    def set_request_params

      @request['User-Agent']   = USER_AGENT
      @request['Accept']       = ACCEPT

      self

    end # set_request_params

  end # Request

end # SocialShareCounters
