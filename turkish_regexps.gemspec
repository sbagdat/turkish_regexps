# frozen_string_literal: true

require_relative 'lib/turkish_regexps/version'

lib = File.expand_path('lib', __dir__)
$LOAD_PATH.prepend(lib) unless $LOAD_PATH.include?(lib)

Gem::Specification.new do |spec|
  spec.name          = 'turkish_regexps'
  spec.version       = TurkishRegexps::VERSION
  spec.authors       = ['Sıtkı Bağdat']
  spec.email         = ['sbagdat@gmail.com']
  spec.summary       = 'Let your regular expressions to speak in Turkish '
  spec.description   = 'Regular expression meet Turkish language. You can use ' \
                       'character classes and meta characters in your regexps ' \
                       'without worrying about Turkish support.'
  spec.homepage      = 'https://github.com/sbagdat/turkish_regexps'
  spec.license       = 'MIT'
  spec.required_ruby_version = Gem::Requirement.new('>= 2.7.0')

  spec.metadata['homepage_uri']    = spec.homepage
  spec.metadata['source_code_uri'] = spec.homepage
  spec.metadata['changelog_uri']   = "#{spec.homepage}/blob/main/CHANGELOG.md"

  spec.files = Dir.chdir(File.expand_path(__dir__)) do
    `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  end
  spec.bindir        = 'bin'
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.require_paths = ['lib']

  spec.add_runtime_dependency 'turkish_ranges', '~> 0.1'

  spec.add_development_dependency 'rake', '~> 13.0'
  spec.add_development_dependency 'rspec', '~> 3.10'
  spec.add_development_dependency 'turkish_ranges', '~> 0.1'
end
