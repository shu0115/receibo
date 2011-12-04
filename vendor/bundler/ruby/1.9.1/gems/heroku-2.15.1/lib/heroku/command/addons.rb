require "launchy"
require "heroku/command/base"
require "heroku/pgutils"

module Heroku::Command

  # manage addon resources
  #
  class Addons < BaseWithApp
    include PgUtils

    # addons
    #
    # list installed addons
    #
    def index
      installed = heroku.installed_addons(app)
      if installed.empty?
        display "No addons installed"
      else
        available, pending = installed.partition { |a| a['configured'] }

        available.map do |a|
          if a['attachment_name']
            a['name'] + ' => ' + a['attachment_name']
          else
            a['name']
          end
        end.sort.each do |addon|
          display(addon)
        end

        unless pending.empty?
          display "\n--- not configured ---"
          pending.map { |a| a['name'] }.sort.each do |addon|
            display addon.ljust(24) + "http://#{heroku.host}/myapps/#{app}/addons/#{addon}"
          end
        end
      end
    end

    # addons:list
    #
    # list all available addons
    #
    def list
      addons = heroku.addons
      if addons.empty?
        display "No addons available currently"
      else
        available, beta = addons.partition { |a| !a['beta'] }
        display_addons(available)
        if !beta.empty?
          display "\n--- beta ---"
          display_addons(beta)
        end
      end
    end

    # addons:add ADDON
    #
    # install an addon
    #
    def add
      configure_addon('Adding') do |addon, config|
        heroku.install_addon(app, addon, config)
      end
    end

    # addons:upgrade ADDON
    #
    # upgrade an existing addon
    #
    def upgrade
      configure_addon('Upgrading') do |addon, config|
        heroku.upgrade_addon(app, addon, config)
      end
    end

    # addons:downgrade ADDON
    #
    # downgrade an existing addon
    #
    alias_method :downgrade, :upgrade

    # addons:remove ADDON
    #
    # uninstall an addon
    #
    def remove
      args.each do |name|
        messages = nil
        action("Removing #{name} from #{app}") do
          messages = addon_run { heroku.uninstall_addon(app, name, :confirm => options[:confirm]) }
        end
        output messages[:attachment] if messages[:attachment]
        output messages[:message]
      end
    end

    # addons:open ADDON
    #
    # open an addon's dashboard in your browser
    #
    def open
      addon = args.shift
      app_addons = heroku.installed_addons(app).map { |a| a["name"] }
      matches = app_addons.select { |a| a =~ /^#{addon}/ }

      case matches.length
      when 0 then
        if heroku.addons.any? {|a| a['name'] =~ /^#{addon}/ }
          error "Addon not installed: #{addon}"
        else
          error "Unknown addon: #{addon}"
        end
      when 1 then
        addon_to_open = matches.first
        display "Opening #{addon_to_open} for #{app}..."
        Launchy.open "https://api.#{heroku.host}/myapps/#{app}/addons/#{addon_to_open}"
      else
        error "Ambiguous addon name: #{addon}"
      end
    end

    private
      def display_addons(addons)
        grouped = addons.inject({}) do |base, addon|
          group, short = addon['name'].split(':')
          base[group] ||= []
          base[group] << addon.merge('short' => short)
          base
        end
        grouped.keys.sort.each do |name|
          addons = grouped[name]
          row = name.dup
          if addons.any? { |a| a['short'] }
            row << ':'
            size = row.size
            stop = false
            row << addons.map { |a| a['short'] }.sort.map do |short|
              size += short.size
              if size < 31
                short
              else
                stop = true
                nil
              end
            end.compact.join(', ')
            row << '...' if stop
          end
          display row.ljust(34) + (addons.first['url'] || '')
        end
      end

      def addon_run
        response = yield

        if response
          price = "(#{ response['price'] })" if response['price']

          if response['message'] =~ /(Attached as [A-Z0-9_]+)\n(.*)/m
            attachment = $1
            message = $2
          else
            attachment = nil
            message = response['message']
          end

          begin
            release = heroku.releases(app).last['name']
          rescue RestClient::RequestFailed => e
            release = nil
          end
        end

        status [ release, price ].compact.join(' ')
        { :attachment => attachment, :message => message }
      rescue RestClient::ResourceNotFound => e
        error e.response.to_s
      rescue RestClient::Locked => ex
        raise
      rescue RestClient::RequestFailed => e
        retry if e.http_code == 402 && confirm_billing
        error Heroku::Command.extract_error(e.http_body)
      end

      def configure_addon(label, &install_or_upgrade)
        addon = args.shift
        raise CommandFailed.new("Missing add-on name") if addon.nil? || ["--fork", "--follow"].include?(addon)

        config = parse_options(args)
        config.merge!(:confirm => app) if app == options[:confirm]
        raise CommandFailed.new("Unexpected arguments: #{args.join(' ')}") unless args.empty?

        translate_fork_and_follow(addon, config) if addon =~ /^heroku-postgresql/

        messages = nil
        action("#{label} #{addon} to #{app}") do
          messages = addon_run { install_or_upgrade.call(addon, config) }
        end
        output messages[:attachment] unless messages[:attachment].to_s.strip == ""
        output messages[:message]
      end

      def parse_options(args)
        {}.tap do |config|
          flag = /^--/
          args.size.times do
            peek = args.first
            next unless peek && (peek.match(flag) || peek.match(/=/))
            arg  = args.shift
            peek = args.first
            key  = arg.sub(flag,'')
            if key.match(/=/)
              key, value = key.split('=', 2)
            elsif peek.nil? || peek.match(flag)
              value = true
            else
              value = args.shift
            end
            value = true if value == 'true'
            config[key] = value
          end
        end
      end
  end
end
