# frozen_string_literal: true

require 'openai'

# It's a backend service for OpenAI API that uses nvidia/nemotron-3-ultra-550b-a55b:free
class IABackendService
  MODEL = 'nvidia/nemotron-3-ultra-550b-a55b:free'

  def initialize(messages:)
    @messages = messages

    @client = OpenAI::Client.new(
      api_key: ENV.fetch('OPENAI_API_KEY')
    )
  end

  def call
    response = @client.chat.completions.create(
      model: MODEL,
      messages: @messages,
      response_format: response_format
    )

    puts response.choices.first.message.content
  end

  def stream
    @client.chat.completions.stream(
      model: MODEL,
      messages: @messages
    ) do |event|
      case event
      when OpenAI::Streaming::ChatContentDeltaEvent
        print event.delta
        $stdout.flush
      end
    end

    puts
  end

  private

  def response_format
    {
      type: 'json_schema',
      json_schema: {
        name: 'response',
        strict: true,
        schema: {
          type: 'object',
          properties: {
            title: { type: 'string' },
            explanation: { type: 'string' },
            example: { type: 'string' }
          },
          required: %w[title explanation example],
          additionalProperties: false
        }
      }
    }
  end
end

response = IABackendService.new(
  messages: [
    {
      role: 'system',
      content: 'You are a helpful assistant.'
    },
    {
      role: 'user',
      content: 'What is the capital of France?'
    }
  ]
).call

puts response
