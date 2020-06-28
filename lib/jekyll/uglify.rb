require "jekyll/uglify/version"

require 'jekyll'
require 'rubygems'
require 'uglifier'

module Jekyll
  module Uglify
    class Error < StandardError; end
      class UglifyJS < Jekyll::Command
      # Uglify all JS files in a given directory. 
      # Ignores files with `.min.js` extensions.
      # Gets Uglifier configuration settings from `_config.yml`
      # 
      # Syntax: jekyll uglify DIRECTORY  [or]
      #         bundle exec jekyll uglify DIR
      #
      def self.init_with_program(prog)
        prog.command(:uglify) do |c|
          c.syntax "uglify DIRECTORY"
          c.description 'Uglifies JS files in a given directory. Ignores minified files.'

          c.action do |args, options|
            config_raw = Jekyll.configuration()["jekyll-uglify"]
            config = Hash.new
            config_raw.each do |k,v|
              if v.is_a?(Hash)
                tmp = Hash.new
                v.each do |ik,iv|
                  tmp[ik.to_sym] = iv
                end
                config[k.to_sym] = tmp
              else
                config[k.to_sym] = v
              end
            end
            Dir.foreach(Dir.pwd + args[0]) do |file|
              next if file == '.' or file == '..' or file.include? '.min.js'
              filepath = Dir.pwd + args[0] + file
              output = Uglifier.compile(File.open(filepath, 'r'), config)
              File.open(filepath, 'w').write(output)
            end
          end
        end
      end
    end
  end
end
