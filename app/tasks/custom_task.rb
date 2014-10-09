class CustomTask
  attr_reader :errors, :logger, :status_logger

  class CustomTaskError < StandardError; end

  def initialize(opts = {})
    setup_loggers(opts)
    init_params(opts)
  end

  def perform
    ActiveRecord::Base.transaction do
      begin
        run_task

        unless errors.empty?
          print_errors
          raise ActiveRecord::Rollback
        end
      rescue CustomTaskError => e
        print_errors
        raise ActiveRecord::Rollback
      rescue Exception => e
        logger.puts e.inspect
        logger.puts e.backtrace
        raise ActiveRecord::Rollback
      end
    end

    unsafe_post_process
  end

  def errors
    @errors ||= []
  end

  private

  def add_error(msg)
    errors << msg
  end

  def init_params(_)
    # default implementation of no-op, implement in subclass.
  end

  def print_errors
    errors.each do |e|
      logger.puts(e)
    end
  end

  def raise_error(msg)
    add_error(msg)
    raise CustomTaskError
  end

  def run_task
    raise NotImplementedError, "Must be implemented in sub class"
  end

  def setup_loggers(opts)
    @status_logger = opts.fetch(:status_logger, STDOUT)
    @logger = opts.fetch(:status_logger, STDOUT)
  end

  def unsafe_post_process
    # default no-op, implement in subclass if there is some post process that does
    # not need to rollback the transaction, i.e. printing out the task run time
  end
end

def custom_task(name, *args)
  namespace :custom do
    desc "Custom Task: #{name}"
    task name => :environment do
      name.to_s.camelize.constantize.new(*args).perform
    end
  end
end

