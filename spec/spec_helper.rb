require 'pry'
require 'rspec'
require 'simple_bdd/rspec'
require 'vimrunner'
require 'vimrunner/rspec'

Vimrunner::RSpec.configure do |config|
  config.reuse_server = true
  config.start_vim do
    vim = Vimrunner.start

    plugin_path = File.expand_path('../..', __FILE__)
    vim.add_plugin(plugin_path, 'plugin/simple-bdd.vim')

    vim
  end
end

RSpec.configure do |config|
  config.order = :random
end
