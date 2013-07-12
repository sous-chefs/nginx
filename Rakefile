require 'foodcritic'

FoodCritic::Rake::LintTask.new do |t|
    t.options = {
      :fail_tags => ['any'],
      :tags      => ['~FC015', '~FC043']
    }
end

task :default => [:foodcritic]
