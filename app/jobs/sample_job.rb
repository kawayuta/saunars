class SampleJob < ApplicationJob
  queue_as :default

  def perform
    puts '--------------------------------'
    puts '------------  Test  ------------'
    puts '--------------------------------'
  end
end
