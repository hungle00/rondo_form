# frozen_string_literal: true

require_relative "lib/rondo_form/version"

Gem::Specification.new do |spec|
  spec.name = "rondo_form"
  spec.version = RondoForm::VERSION
  spec.authors = ["hungle00"]
  spec.email = ["hungle2048@gmail.com"]

  spec.summary = "Cocoon, but with Stimulus JS"
  spec.description = "Handle nested forms using Stimulus JS"
  spec.homepage = "https://github.com/hungle00/rondo_form".freeze
  spec.license = "MIT"
  spec.required_ruby_version = ">= 2.6.0"

  spec.metadata["homepage_uri"] = spec.homepage
  spec.metadata["source_code_uri"] = spec.homepage

  # Specify which files should be added to the gem when it is released.
  # The `git ls-files -z` loads the files in the RubyGem that have been added into git.
  spec.files = Dir.chdir(File.expand_path(__dir__)) do
    `git ls-files -z`.split("\x0").reject do |f|
      (f == __FILE__) || f.match(%r{\A(?:(?:bin|test|spec|features)/|\.(?:git|travis|circleci)|appveyor)})
    end
  end
  spec.bindir = "exe"
  spec.executables = spec.files.grep(%r{\Aexe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  # Uncomment to register a new dependency of your gem
  spec.add_runtime_dependency 'railties', '>= 6.0'
  spec.add_development_dependency 'bundler', '>= 1.17', '<= 3'
  spec.add_development_dependency 'rake', '>= 7.0', '<= 20.0'
  # For more information and examples about making a new gem, check out our
  # guide at: https://bundler.io/guides/creating_gem.html
end
