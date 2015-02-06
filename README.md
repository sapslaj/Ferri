Ferri
----

Ferri is a Roguelike game engine based on rot.js

### WARNING
This code is still under heavily development. This is not ready for production use at all!

### Here how how we go
`src` is for main engine source files
`app` is for game/app specific files (maps, entities)
`public` is where compiled files go
`app.rb` and `config.ru` are two small files for hosting a Sinatra server to serve the static content
`build_js.rb` is a custom JavaScript build tool I made. Not that it's really needed, I just wanted my own JS build tool. Written in Ruby.
`Rakefile` is for raking stuff.
`README.md` is this thing you are reading
