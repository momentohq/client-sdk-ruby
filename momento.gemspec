# frozen_string_literal: true

require_relative "lib/momento/version"

Gem::Specification.new do |spec|
  spec.name = "momento"
  spec.version = Momento::VERSION
  spec.authors = ["Momento"]
  spec.email = ["eng-deveco@momentohq.com"]

  spec.summary = "Client for Momento Serverless Cache"
  spec.description = "Momento is a fast, simple, pay-as-you-go caching solution."
  spec.homepage = "https://github.com/momentohq/client-sdk-ruby"
  spec.required_ruby_version = ">= 2.7.0"
  spec.license = "Apache-2.0"

  spec.metadata["homepage_uri"] = spec.homepage
  spec.metadata['rubygems_mfa_required'] = 'true'
  spec.metadata["source_code_uri"] = "https://github.com/momentohq/client-sdk-ruby"

  # Specify which files should be added to the gem when it is released.
  # The `git ls-files -z` loads the files in the RubyGem that have been added into git.
  spec.files = Dir.chdir(__dir__) do
    `git ls-files -z`.split("\x0").reject do |f|
      (f == __FILE__) || f.match(%r{\A(?:(?:bin|test|spec|features)/|\.(?:git|travis|circleci)|appveyor)})
    end
  end
  spec.bindir = "exe"
  spec.executables = spec.files.grep(%r{\Aexe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_development_dependency 'bundler', "~> 2.3"
  spec.add_development_dependency 'factory_bot', "~> 6.2.1"
  spec.add_development_dependency 'faker', "~> 3.0"
  spec.add_development_dependency "rspec", "~> 3.12"
  spec.add_development_dependency "rubocop", "~> 3.18"
  spec.add_development_dependency 'rubocop-performance', '~> 1.15'
  spec.add_development_dependency 'rubocop-rake', '~> 0.6.0'
  spec.add_development_dependency 'rubocop-rspec', '~> 2.15'
  spec.add_development_dependency 'simplecov', '~> 0.21'

  spec.add_dependency "grpc", '~> 1'
  spec.add_dependency 'jwt', '~> 2'
end
