require 'sinatra'
require 'digest'

class App < Sinatra::Application
  set :bind, '0.0.0.0'

  helpers do
    def stylesheets
      'app.css'
    end

    def javascripts
      'app.js'
    end
  end

  get '/' do
    erb :index
  end
end

__END__

@@ index
<!doctype html>
<html>
<head>
  <link rel="stylesheet" href="<%= stylesheets %>">
</head>
<body>
  <div id="action"></div>
  <script src="<%= javascripts %>"></script>
</body>
</html>
