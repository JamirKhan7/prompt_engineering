module PizzaBot
  class OrderSummary
    def intialize(conversation)
      @conversation = conversation
    end

    def call
      OpenAiClient
        .new
        .call(
          messages,
          "gpt-4.1-mini",
          0
        )
    end

    private

    def messages
      coversation_messages + [
        {
          role: "system",
          content: SUMMARY_PROMPT
        }
      ]
    end

    def coversation_messages
      @conversation.messages.map.do |message|
        {
          role: message.role,
          content: message.content
        }
      end
    end

    SUMMARY_PROMPT = <<~PROMPT
      Create a JSON summary of the previous food order.
      
      Return ONLY valid JSON.
      
      Use this structure:
      {
        "items": [
          {
            "type": "pizza",
            "name": "",
            "size": "",
            "price": 0,
            "toppings": []
          }
        ],
        "drinks": [],
        "sides": [],
        "total_price": 0
      }
        
      Include the price for every item.
      
      Do not include markdown.
      Do not include explanations.
      Return only JSON.
    PROMPT
  end
end
