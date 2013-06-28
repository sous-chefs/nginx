require 'foodcritic'

FoodCritic::Rake::LintTask.new do |t|
    t.options = { :fail_tags => ['any'] }
end

task :default => [:foodcritic]
