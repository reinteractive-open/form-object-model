PROJECT_ROOT = File.expand_path(File.join(File.dirname(__FILE__), '..')).freeze
$LOAD_PATH << File.join(PROJECT_ROOT, 'lib')

require "form_object_model"

RSpec.configure do |config|
  config.include FormObjectModel::Helper
end

