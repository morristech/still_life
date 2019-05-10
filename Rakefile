# frozen_string_literal: true

require "bundler/gem_tasks"
require "rake/testtask"

Rake::TestTask.new(:test) do |t|
  t.libs << "test"
  t.libs << "lib"
  t.test_files = FileList['test/**/*_test.rb'] - FileList['test/dummy_app/test/**/*_test.rb']
  t.warning = true
  t.verbose = true
end

task default: :test
