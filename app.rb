require 'sinatra'
require 'open3'
require 'base64'

get '/' do
  content_type :js
  response = {}
  if params[:body].nil?
    set_response_for_empty_params(response)
  else
    cmd = ['dot', '-Tpng']
    out, err, status =  Open3.capture3(*cmd, binmode: true, stdin_data: params[:body])
    case status.to_i
    when 0
      response[:encoded_png] = Base64.strict_encode64(out)
    else
      response[:error_msg] = <<~EOH
        エラーになりました
        -----------------
        #{err}
      EOH
    end
  end
  "#{params[:callback]}(#{response.to_json})"
end

def set_response_for_empty_params(res)
  res[:error_msg] = <<~EOH
    bodyパラメータが空です.下記のようなテキストを bodyパラメータ に渡してください
    -----------------
    http://HOST/?body=digraph%20g%7B%0D%0A%20%20%22login_2%22%20-%3E%20%22login_1%22%3B%0D%0A%20%20%22login_3%22%20-%3E%20%22login_1%22%3B%0D%0A%20%20%22login_4%22%20-%3E%20%22login_2%22%3B%0D%0A%7D%0D%0A
    -----------------
    digraph g{
      "login_2" -> "login_1";
      "login_3" -> "login_1";
      "login_4" -> "login_2";
    }
  EOH
end
