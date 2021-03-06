module Travis
  module Event
    class Handler
      class Trail < Handler
        EVENTS = [/^((?!event|log|worker).)*$/] # i.e. does not include "log"

        def handle?
          Features.feature_active?(:event_trail)
        end

        def handle
          ::Event.create!(:source => object, :repository => repository, :event => event, :data => data)
        end

        private

          def repository
            object.is_a?(Repository) ? object : object.repository
          end

          def data
            data = {}
            data[:commit]  = object.commit.try(:commit)      if object.respond_to?(:commit)
            data[:type]    = object.request.try(:event_type) if object.respond_to?(:request)
            data[:number]  = object.number  if object.respond_to?(:number)
            data[:result]  = object.result  if object.respond_to?(:result)
            data[:message] = object.message if object.respond_to?(:message)
            data
          end
      end
    end
  end
end
