class Build
  module Messages
    def result_key(data)
      state, previous, current = data.symbolize_keys.values_at(:state, :previous_result, :result)

      if current.nil?
        :pending
      elsif previous.nil?
        current == 0 ? :passed : :failed
      elsif previous.to_i == 0
        current == 0 ? :passed : :broken
      elsif previous.to_i == 1
        current == 0 ? :fixed : :failing
      end
    end

    # TODO extract to I18n

    RESULT_MESSAGES = {
      :pending => 'Pending',
      :passed  => 'Passed',
      :failed  => 'Failed',
      :broken  => 'Broken',
      :fixed   => 'Fixed',
      :failing => 'Still Failing'
    }

    RESULT_MESSAGE_SENTENCES = {
      :pending => 'The build is pending.',
      :passed  => 'The build passed.',
      :failed  => 'The build failed.',
      :broken  => 'The build was broken.',
      :fixed   => 'The build was fixed.',
      :failing => 'The build is still failing.'
    }

    def result_message(data = nil)
      RESULT_MESSAGES[result_key(data || self.attributes)]
    end

    def human_result_message(data = nil)
      RESULT_MESSAGE_SENTENCES[result_key(data || self.attributes)]
    end
  end
end
