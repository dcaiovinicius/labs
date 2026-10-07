# frozen_string_literal: true

require 'openai'

# IABackendService class to call the Open Router API
class IABackendService
  def initialize(messages:)
    @messages = messages
    @client = OpenAI::Client.new(
      api_key: ENV['OPENAI_API_KEY']
    )
  end

  def call
    response = @client.chat.completions.create(
      model: 'openrouter/free',
      messages: @messages
    )

    response.choices.first.message.content
  end

  def stream
    stream = @client.chat.completions.stream(
      model: 'openrouter/free',
      messages: @messages
    )

    stream.each do |event|
      case event
      when OpenAI::Streaming::ChatContentDeltaEvent
        print event.delta
        $stdout.flush
      end
    end

    puts
  end
end

puts IABackendService.new(
  messages: [
    { role: 'system', content: 'You are a helpful assistant' },
    { role: 'user', content: 'How to install Ruby' }
  ]
).stream
