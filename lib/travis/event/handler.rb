module Travis
  module Event
    class Handler
      autoload :Archive,  'travis/event/handler/archive'
      autoload :Campfire, 'travis/event/handler/campfire'
      autoload :Email,    'travis/event/handler/email'
      autoload :Github,   'travis/event/handler/github'
      autoload :Irc,      'travis/event/handler/irc'
      autoload :Pusher,   'travis/event/handler/pusher'
      autoload :Webhook,  'travis/event/handler/webhook'
      autoload :Worker,   'travis/event/handler/worker'

      class << self
        def notify(event, object, data = {})
          new(event, object, data).notify
        end
      end

      include Logging

      attr_reader :event, :object, :data

      def initialize(event, object, data = {})
        @event = event
        @object = object
        @data = data
      end
    end
  end
end
