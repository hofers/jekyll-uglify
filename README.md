# [jekyll-uglify](https://rubygems.org/gems/jekyll-uglify)
[![Gem Version](https://badge.fury.io/rb/jekyll-uglify.svg)](https://badge.fury.io/rb/jekyll-uglify)

A Jekyll command plugin for uglifying given JS files or directories using [Uglifier](https://github.com/lautis/uglifier), a Ruby wrapper for UglifyJS by [lautis](https://github.com/lautis).

## Installation
``` 
gem install jekyll-uglify
```

## Set Up
In `Gemfile`
``` ruby
...
group :jekyll_plugins do
  ...
  gem 'jekyll-uglify'
end
```

## Configuration
You can configure `jekyll-uglify` in `_config.yml`. The default configuration options can be found below.
To enable experimental ES6 support, enable Harmony mode with `harmony: true`.
``` yaml
jekyll-uglify:
  output:
    ascii_only: true         # Escape non-ASCII characters
    comments: :copyright     # Preserve comments (:all, :jsdoc, :copyright, :none, Regexp (see below))
    inline_script: false     # Escape occurrences of </script in strings
    quote_keys: false        # Quote keys in object literals
    max_line_len: 32768      # Maximum line length in minified code
    bracketize: false        # Bracketize if, for, do, while or with statements, even if their body is a single statement
    semicolons: true         # Separate statements with semicolons
    preserve_line: false     # Preserve line numbers in outputs
    beautify: false          # Beautify output
    indent_level: 4          # Indent level in spaces
    indent_start: 0          # Starting indent level
    width: 80                # Specify line width when beautifier is used (only with beautifier)
    preamble: ~              # Preamble for the generated JS file. Can be used to insert any code or comment.
    wrap_iife: false         # Wrap IIFEs in parenthesis. Note: this disables the negate_iife compression option.
    shebang: true            # Preserve shebang (#!) in preamble (shell scripts)
    quote_style: 0           # Quote style, possible values auto (default), single, double, original
    keep_quoted_props: false # Keep quotes property names
  mangle:                    # Mangle variable and function names, set to false to skip mangling
    eval: false              # Mangle names when eval of when is used in scope
    reserved: [ $super ]     # Argument names to be excluded from mangling
    sort: false              # Assign shorter names to most frequently used variables. Often results in bigger output after gzip.
    toplevel: false          # Mangle names declared in the toplevel scope
    properties: false        # Mangle property names
    keep_fnames: false       # Do not modify function names          
  mangle_properties:         # Mangle property names, disabled by default
    regex: ~                 # A regular expression to filter property names to be mangled
    ignore_quoted: false     # Only mangle unquoted property names
    debug: false             # Mangle names with the original name still present                            
  compress:                  # Apply transformations to code, set to false to skip
    sequences: true          # Allow statements to be joined by commas
    properties: true         # Rewrite property access using the dot notation
    dead_code: true          # Remove unreachable code
    drop_debugger: true      # Remove debugger; statements
    unsafe: false            # Apply "unsafe" transformations
    unsafe_comps: false      # Reverse < and <= to > and >= to allow improved compression. This might be unsafe when an at least one of two operands is an object with computed values due the use of methods like get, or valueOf. This could cause change in execution order after operands in the comparison are switching. Compression only works if both comparisons and unsafe_comps are both set to true.
    unsafe_math: false       # Optimize numerical expressions like 2 * x * 3 into 6 * x, which may give imprecise floating point results.
    unsafe_proto: false      # Optimize expressions like Array.prototype.slice.call(a) into [].slice.call(a)
    conditionals: true       # Optimize for if-s and conditional expressions
    comparisons: true        # Apply binary node optimizations for comparisons
    evaluate: true           # Attempt to evaluate constant expressions
    booleans: true           # Various optimizations to boolean contexts
    loops: true              # Optimize loops when condition can be statically determined
    unused: true             # Drop unreferenced functions and variables
    toplevel: false          # Drop unreferenced top-level functions and variables
    top_retain: []           # prevent specific toplevel functions and variables from `unused` removal
    hoist_funs: true         # Hoist function declarations
    hoist_vars: false        # Hoist var declarations
    if_return: true          # Optimizations for if/return and if/continue
    join_vars: true          # Join consecutive var statements
    collapse_vars: false     # Collapse single-use var and const definitions when possible.
    reduce_funcs: false      # Inline single-use functions as function expressions. Depends on reduce_vars.
    reduce_vars: false       # Collapse variables assigned with and used as constant values.
    negate_iife: true        # Negate immediately invoked function expressions to avoid extra parens
    pure_getters: false      # Assume that object property access does not have any side-effects
    pure_funcs: ~            # List of functions without side-effects. Can safely discard function calls when the result value is not used
    drop_console: false      # Drop calls to console.* functions
    keep_fargs: false        # Preserve unused function arguments
    keep_fnames: false       # Do not drop names in function definitions
    passes: 1                # Number of times to run compress. Raising the number of passes will increase compress time, but can produce slightly smaller code.
    keep_infinity: false     # Prevent compression of Infinity to 1/0
    side_effects: true       # Pass false to disable potentially dropping functions marked as "pure" using pure comment annotation. See UglifyJS documentation for details.
    switches: true           # De-duplicate and remove unreachable switch branches                         
  parse: 
    bare_returns: false      # Allow top-level return statements.
    expression: false        # Parse a single expression, rather than a program (for parsing JSON).
    html5_comments: true     # Ignore HTML5 comments in input
    shebang: true            # support #!command as the first line
    strict: false
  define: []                 # Define values for symbol replacement
  enclose: false             # Enclose in output function wrapper, define replacements as key-value pairs
  keep_fnames: false         # Generate code safe for the poor souls relying on Function.prototype.name at run-time. Sets both compress and mangle keep_fnames to true.
  source_map: 
    map_url: false           # Url for source mapping to be appended in minified source
    url: false               # Url for original source to be appended in minified source
    sources_content: false   # Include original source content in map
    filename: ~              # The filename of the input file
    root: ~                  # The URL of the directory which contains filename
    output_filename: ~       # The filename or URL where the minified output can be found
    input_source_map: ~      # The contents of the source map describing the input
  error_context_lines: 8     # How many context lines surrounding the error line. Env var ERROR_CONTEXT_LINES overrides this option
  harmony: false             # Enable ES6/Harmony mode (experimental). Disabling mangling and compressing is recommended with Harmony mode.
```
`jekyll-uglify` uses version 4.2.0 of [Uglifier](https://github.com/lautis/uglifier); all default configuration options from that release are retained here.

## Usage
```
bundle exec jekyll uglify FILEPATH [ADDITIONAL_FILEPATHS]
```
You can list any number of files or directories to be uglified. Include this command in your build process to uglify JS at build time.

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).

## Code of Conduct

Everyone interacting in the jekyll-uglify project's codebases, issue trackers, chat rooms and mailing lists is expected to follow the [code of conduct](https://github.com/hofers/jekyll-uglify/blob/master/CODE_OF_CONDUCT.md).
