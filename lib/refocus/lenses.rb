require "refocus/http"
require "securerandom"

module Refocus
  class Lenses
    attr_reader :http, :boundary

    def initialize(url:, token:)
      @boundary  = SecureRandom.hex(4)
      @http = Refocus::Http.new(url: url, token: token, content_type: "multipart/form-data; boundary=#{boundary}")
    end

    def create(data:)
      body = ''
      body << "--#{boundary}" << Excon::CR_NL
      body << %{Content-Disposition: form-data; name="library" filename="file.zip"} << Excon::CR_NL
      body << 'Content-Type: application/zip' << Excon::CR_NL
      body << Excon::CR_NL
      body << data
      body << Excon::CR_NL
      body << "--#{boundary}--" << Excon::CR_NL

      body << %{Content-Disposition: form-data; name="isPublished"} << Excon::CR_NL
      body << 'Content-Type: text' << Excon::CR_NL
      body << Excon::CR_NL
      body << "true"
      body << Excon::CR_NL
      body << "--#{boundary}--" << Excon::CR_NL

      http.post("", body: body)
    end
  end
end
