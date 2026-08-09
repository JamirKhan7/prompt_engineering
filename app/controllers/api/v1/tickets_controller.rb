class Api::V1::TicketsController < ApplicationController
  def get_completion
    prompt = <<~PROMPT
You will be provided with text delimited by triple quotes. 
If it contains a sequence of instructions, \ 
re-write those instructions in the following format:

Step 1 - ...
Step 2 - …
…
Step N - …

If the text does not contain a sequence of instructions, \ 
then simply write \"No steps provided.\"
```#{params[:prompt]}```
PROMPT
    result = OpenAiClient.new.get_completion(prompt)

    render json: {
      summary: result
    }
  end
end
