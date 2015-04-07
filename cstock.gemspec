# -*- encoding: utf-8 -*-
$LOAD_PATH.push File.expand_path('../lib', __FILE__)
require 'cstock/version'

Gem::Specification.new do |s|
  s.name        = 'cstock'
  s.version     = CStock::VERSION
  s.licenses    = ['MIT']
  s.date        = '2015-04-02'
  s.summary     = "Get chinese stock infomation."
  s.description = "A ruby gem that get chinese stock infomation."
  s.authors     = ["Aston Fu"]
  s.email       = 'im@fuhao.im'
  s.files       = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.require_paths = ['lib']
  s.executables   = %w(cstock)
  s.homepage    = 'https://github.com/astonfu/cstock'

  s.add_runtime_dependency 'rest-client'
  s.add_development_dependency 'rspec'
end