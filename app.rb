require 'sinatra'
require 'uri'
require 'open-uri'
require 'open3'

get '/' do
  cmd = ['dot', '-Tpng']
  out, err, status =  Open3.capture3(*cmd, binmode: true, stdin_data: params[:body])
  case status.to_i
  when 0
    content_type "image/png"
    out
  else
    content_type "text/plain"
    <<~EOH
      エラーになりました
      -----------------
      #{err}
    EOH
  end
end
