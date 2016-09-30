# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'schema_docs_generator/version'

Gem::Specification.new do |spec|
  spec.name          = "schema_docs_generator"
  spec.version       = SchemaDocsGenerator::VERSION
  spec.authors       = ["minkyu-jeon"]
  spec.email         = ["minkyu@huray.net"]
  spec.summary       = %q{Database Schema docs generator for Ruby on Rails.}
  spec.description   = %q{
    앞으로 할일.
    1. gem을 사용하는 rails application내 설정파일을 통해 시트 스타일 설정 가능 추가
    2. 엑셀 시트를 각 테이블마다가 아닌 그룹을 설정해서 한 시트 내에 여러 테이블을 묶을 수 있는 기능 추가
  }
  # spec.homepage      = "."
  spec.license       = "MIT"

  # Prevent pushing this gem to RubyGems.org. To allow pushes either set the 'allowed_push_host'
  # to allow pushing to a single host or delete this section to allow pushing to any host.
  if spec.respond_to?(:metadata)
    spec.metadata['allowed_push_host'] = "TODO: Set to 'http://mygemserver.com'"
  else
    raise "RubyGems 2.0 or newer is required to protect against public gem pushes."
  end

  spec.files         = `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.12"
  spec.add_development_dependency "rails", "~> 4.2.5"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "rspec", "~> 3.0"
  spec.add_development_dependency "axlsx", "~> 2.0.1"
end
