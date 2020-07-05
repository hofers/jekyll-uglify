require "jekyll/uglify/version"

require 'jekyll'
require 'rubygems'
require 'uglifier'

module Jekyll
  module Uglify
    class Error < StandardError; end
    # Uglify given JS files or directories.
    # Ignores files with `.min.js` extensions.
    # Gets Uglifier configuration settings from `_config.yml`
    # 
    # Syntax: jekyll uglify FILEPATH [ADDITIONAL_FILEPATHS]  [or]
    #         bundle exec jekyll uglify FILEPATH [ADDITIONAL_FILEPATHS]
    # Arguments:
    #         FILEPATH  path to file or directory to be uglified
    class UglifyJS < Jekyll::Command
      def self.init_with_program(prog)
        prog.command(:uglify) do |c|
          c.syntax "uglify FILEPATH [ADDITIONAL_FILEPATHS]"
          c.description 'Uglifies given JS files or directories. Ignores minified files.'

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
            args.each do |dir|
              if !(dir.start_with? "/") then dir = "/" + dir end
              if ((dir.end_with? ".js") && !(dir.end_with? ".min.js"))
                filepath = Dir.pwd + dir
                output = Uglifier.compile(File.open(filepath, 'r'), config)
                File.open(filepath, 'w').write(output)
                next
              end
              if !(dir.end_with? "/") then dir = dir + "/" end
              Dir.foreach(Dir.pwd + dir) do |file|
                next if file == '.' or file == '..' or file.include? '.min.js'
                next unless file.include? '.js'
                filepath = Dir.pwd + dir + file
                output = Uglifier.compile(File.open(filepath, 'r'), config)
                File.open(filepath, 'w').write(output)
              end
            end
          end
        end
      end
    end
  end
end
