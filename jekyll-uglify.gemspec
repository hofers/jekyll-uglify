require_relative 'lib/jekyll/uglify/version'

Gem::Specification.new do |spec|
  spec.name          = "jekyll-uglify"
  spec.version       = Jekyll::Uglify::VERSION
  spec.authors       = ["Sean Hofer"]
  spec.email         = ["me@seanhofer.com"]

  spec.summary       = "A Jekyll command plugin for uglifying JS files in a given directory"
  spec.description   = "A Jekyll command plugin for uglifying JS files in a given directory"
  spec.homepage      = "https://github.com/hofers/jekyll-uglify"
  spec.license       = "MIT"
  spec.required_ruby_version = Gem::Requirement.new(">= 2.3.0")

  spec.metadata["homepage_uri"] = spec.homepage
  spec.metadata["source_code_uri"] = "https://github.com/hofers/jekyll-uglify"

  # Specify which files should be added to the gem when it is released.
  # The `git ls-files -z` loads the files in the RubyGem that have been added into git.
  spec.files         = Dir.chdir(File.expand_path('..', __FILE__)) do
    `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) or f.match(/^jekyll-uglify-\d\.\d\.\d\.gem$/) }
  end
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_runtime_dependency 'uglifier', '~> 4.2.0'
end
