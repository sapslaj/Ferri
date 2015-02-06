require 'fssm'
require 'sass'
require './build_js'

desc 'build css'
task :buildcss do
  puts 'Generating CSS...'
  File.open('public/app.css', "w") do |io|
    io.write(Sass.compile_file('app/stylesheets/app.scss'))
  end
end

desc 'build js'
task :buildjs do
  puts 'Generating JS...'
  File.open('public/app.js', "w") do |io|
    @builder = BuildJS::Builder.new('app', lib_root: 'app/javascripts', verbose: true)

    io.write @builder.build
  end
end

desc 'build app'
task :build => [:buildcss, :buildjs]

desc 'auto build app'
task :autobuild do
  FSSM.monitor do
    path 'app/javascripts' do
      def action
        puts `rake buildjs`
      end

      update {|base, relative| action}
      delete {|base, relative| action}
      create {|base, relative| action}
    end

    path 'app/stylesheets' do
      def action
        puts `rake buildcss`
      end

      update {|base, relative| action}
      delete {|base, relative| action}
      create {|base, relative| action}
    end
  end
end
