class Api::V1::TicketsController < ApplicationController
  def get_completion
    prompt = <<~PROMPT
Summarize the text delimited by triple backticks \ 
into a single sentence.
```#{params[:prompt]}```
PROMPT
    result = OpenAiClient.new.get_completion(prompt)

    render json: {
      summary: result
    }
  end
end
