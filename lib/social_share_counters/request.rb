module SocialShareCounters

  class Request

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
      set_request_params

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

      @request['User-Agent']   = ::SocialShareCounters.user_agent
      @request['Accept']       = "*/*"
      @request['Content-Type'] = "text/json; charset=UTF-8"

      self

    end # set_request_params

=begin
    def block_run

      error     = false
      try_count = ::IbateleSms::RETRY

      begin



          ::Net::HTTP.start(
            ::IbateleSms::HOST,
            ::IbateleSms::PORT,
            :use_ssl => ::IbateleSms::USE_SSL
          ) do |http|
            yield(http)
          end


      rescue ::Errno::ECONNREFUSED

        if try_count > 0
          try_count -= 1
          sleep ::IbateleSms::WAIT_TIME
          retry
        else
          error = ::IbateleSms::ConnectionError.new("Прервано соедиение с сервером")
        end

      rescue ::Timeout::Error

        if try_count > 0
          try_count -= 1
          sleep ::IbateleSms::WAIT_TIME
          retry
        else
          error = ::IbateleSms::TimeoutError.new("Превышен интервал ожидания #{::IbateleSms::TIMEOUT} сек. после #{::IbateleSms::RETRY} попыток")
        end

      rescue => e
        error = ::IbateleSms::UnknownError.new(e.message)
      end

      error

    end # block_run

    def request

      try_count = ::IbateleSms::RETRY
      headers   = {
        "Content-Type" => "text/xml; charset=utf-8"
      }

      res = yield(headers)
      while(try_count > 0 && res.code.to_i >= 300)

        log("[retry] #{try_count}. Wait #{::IbateleSms::WAIT_TIME} sec.")

        res = yield(headers)
        try_count -= 1
        sleep ::IbateleSms::WAIT_TIME

      end # while

      res

    end # request
=end

  end # Request

end # SocialShareCounters
