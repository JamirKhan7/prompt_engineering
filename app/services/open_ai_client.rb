class OpenAiClient
  def initialize
    @client = OpenAI::Client.new(
      access_token: ENV["OPENAI_API_KEY"]
    )
  end

  def get_completion(prompt, model = "gpt-4.1-mini")
    response = @client.chat(
      parameters: {
        model: model,
        messages: [
          {
            role: "user",
            content: prompt
          }
        ]
      }
    )

    response.dig("choices", 0, "message", "content")
  end
end
