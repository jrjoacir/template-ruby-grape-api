RSpec.configure do |config|
  def clear_database
    Models::App.dataset.destroy
  end

  config.before(:suite) do
    clear_database
  end

  config.before(:each) do
    clear_database
  end

  config.before(:each) do
    clear_database
  end

  config.after(:each) do
    clear_database
  end
end
