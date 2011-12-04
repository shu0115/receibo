require "vendor/heroku/okjson"

module Heroku
  module Helpers
    def home_directory
      running_on_windows? ? ENV['USERPROFILE'].gsub("\\","/") : ENV['HOME']
    end

    def running_on_windows?
      RUBY_PLATFORM =~ /mswin32|mingw32/
    end

    def running_on_a_mac?
      RUBY_PLATFORM =~ /-darwin\d/
    end

    def display(msg="", new_line=true)
      if new_line
        puts(msg)
      else
        print(msg)
        STDOUT.flush
      end
    end

    def redisplay(line, line_break = false)
      display("\r\e[0K#{line}", line_break)
    end

    def deprecate(version)
      display "!!! DEPRECATION WARNING: This command will be removed in version #{version}"
      display
    end

    def error(msg)
      STDERR.puts(msg)
      exit 1
    end

    def confirm_billing
      display
      display "This action will cause your account to be billed at the end of the month"
      display "For more information, see http://devcenter.heroku.com/articles/billing"
      display "Are you sure you want to do this? (y/n) ", false
      if ask.downcase == 'y'
        heroku.confirm_billing
        return true
      end
    end

    def confirm(message="Are you sure you wish to continue? (y/n)?")
      display("#{message} ", false)
      ask.downcase == 'y'
    end

    def confirm_command(app = app)
      raise(Heroku::Command::CommandFailed, "No app specified.\nRun this command from app folder or set it adding --app <app name>") unless app

      confirmed_app = extract_option('--confirm', false)
      if confirmed_app
        unless confirmed_app == app
          raise(Heroku::Command::CommandFailed, "Confirmed app #{confirmed_app} did not match the selected app #{app}.")
        end
        return true
      else
        display
        output_with_bang "WARNING: Potentially Destructive Action"
        output_with_bang "This command will affect the app: #{app}"
        output_with_bang "To proceed, type \"#{app}\" or re-run this command with --confirm #{app}"
        display
        display "> ", false
        if ask.downcase != app
          output_with_bang "Input did not match #{app}. Aborted."
          false
        else
          true
        end
      end
    end

    def format_date(date)
      date = Time.parse(date) if date.is_a?(String)
      date.strftime("%Y-%m-%d %H:%M %Z")
    end

    def ask
      STDIN.gets.strip
    end

    def shell(cmd)
      FileUtils.cd(Dir.pwd) {|d| return `#{cmd}`}
    end

    def run_command(command, args=[])
      Heroku::Command.run(command, args)
    end

    def retry_on_exception(*exceptions)
      retry_count = 0
      begin
        yield
      rescue *exceptions => ex
        raise ex if retry_count >= 3
        sleep 3
        retry_count += 1
        retry
      end
    end

    def has_git?
      %x{ git --version }
      $?.success?
    end

    def git(args)
      return "" unless has_git?
      flattened_args = [args].flatten.compact.join(" ")
      %x{ git #{flattened_args} 2>&1 }.strip
    end

    def time_ago(elapsed)
      if elapsed < 60
        "#{elapsed.floor}s ago"
      elsif elapsed < (60 * 60)
        "#{(elapsed / 60).floor}m ago"
      else
        "#{(elapsed / 60 / 60).floor}h ago"
      end
    end

    def truncate(text, length)
      if text.size > length
        text[0, length - 2] + '..'
      else
        text
      end
    end

    @@kb = 1024
    @@mb = 1024 * @@kb
    @@gb = 1024 * @@mb
    def format_bytes(amount)
      amount = amount.to_i
      return '(empty)' if amount == 0
      return amount if amount < @@kb
      return "#{(amount / @@kb).round}k" if amount < @@mb
      return "#{(amount / @@mb).round}M" if amount < @@gb
      return "#{(amount / @@gb).round}G"
    end

    def quantify(string, num)
      "%d %s" % [ num, num.to_i == 1 ? string : "#{string}s" ]
    end

    def create_git_remote(app, remote)
      return unless has_git?
      return if git('remote').split("\n").include?(remote)
      return unless File.exists?(".git")
      git "remote add #{remote} git@#{heroku.host}:#{app}.git"
      display "Git remote #{remote} added"
    end

    def app_urls(name)
      "http://#{name}.heroku.com/ | git@heroku.com:#{name}.git"
    end

    def longest(items)
      items.map { |i| i.to_s.length }.sort.last
    end

    def display_table(objects, columns, headers)
      lengths = []
      columns.each_with_index do |column, index|
        header = headers[index]
        lengths << longest([header].concat(objects.map { |o| o[column].to_s }))
      end
      display_row headers, lengths
      display_row lengths.map { |length| "-" * length }, lengths
      objects.each do |row|
        display_row columns.map { |column| row[column] }, lengths
      end
    end

    def display_row(row, lengths)
      row.zip(lengths).each do |column, length|
        format = column.is_a?(Fixnum) ? "%#{length}s  " : "%-#{length}s  "
        display format % column, false
      end
      display
    end

    def json_encode(object)
      Heroku::OkJson.encode(object)
    rescue Heroku::OkJson::ParserError
      nil
    end

    def json_decode(json)
      Heroku::OkJson.decode(json)
    rescue Heroku::OkJson::ParserError
      nil
    end

    def set_buffer(enable)
      return unless $stdin.tty?

      if enable
        `stty icanon echo`
      else
        `stty -icanon -echo`
      end
    rescue
      # fails on windows
    end

    def get_terminal_environment
      { "TERM" => ENV["TERM"], "COLUMNS" => `tput cols`, "LINES" => `tput lines` }
    rescue
      { "TERM" => ENV["TERM"] }
    end

    def fail(message)
      raise Heroku::Command::CommandFailed, message
    end

    ## DISPLAY HELPERS

    def action(message)
      output_with_arrow("#{message}... ", false)
      Heroku::Helpers.enable_error_capture
      yield
      Heroku::Helpers.disable_error_capture
      display "done", false
      display(", #{@status}", false) if @status
      display
    end

    def status(message)
      @status = message
    end

    def output(message="", new_line=true)
      return if message.to_s.strip == ""
      display("       " + message.split("\n").join("\n       "), new_line)
    end

    def output_with_arrow(message="", new_line=true)
      return if message.to_s.strip == ""
      display("-----> " + message.split("\n").join("\n       "), new_line)
    end

    def output_with_bang(message="", new_line=true)
      return if message.to_s.strip == ""
      display(" !     " + message.split("\n").join("\n !     "), new_line)
    end

    def error_with_failure(message)
      display "failed"
      output_with_bang(message)
      exit 1
    end

    def self.included_into
      @@included_into ||= []
    end

    def self.extended_into
      @@extended_into ||= []
    end

    def self.included(base)
      included_into << base
    end

    def self.extended(base)
      extended_into << base
    end

    def self.enable_error_capture
      included_into.each do |base|
        base.send(:alias_method, :error_without_failure, :error)
        base.send(:alias_method, :error, :error_with_failure)
      end
      extended_into.each do |base|
        class << base
          alias_method :error_without_failure, :error
          alias_method :error, :error_with_failure
        end
      end
    end

    def self.disable_error_capture
      included_into.each do |base|
        base.send(:alias_method, :error, :error_without_failure)
      end
      extended_into.each do |base|
        class << base
          alias_method :error, :error_without_failure
        end
      end
    end
  end
end
