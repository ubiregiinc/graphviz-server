require 'sinatra'
require 'uri'
require 'open-uri'
require 'open3'

get '/' do
  body = <<~EOH
digraph g{
login_3[
  style = "filled";
]
graph[
  layout = dot;
]
"login_2" -> "login_1";
"login_3" -> "login_1";
"login_4" -> "login_2";
}
  EOH
  cmd = ['dot', '-Tpng']
  out, err, status =  Open3.capture3(*cmd, binmode: true, stdin_data: body)
  content_type "image/png"
  return out
end
