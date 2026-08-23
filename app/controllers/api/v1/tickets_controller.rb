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

  def inferring
    prompt = <<~PROMPT
    Identify the following items from the review text: 
- Sentiment (positive or negative)
- Is the reviewer expressing anger? (true or false)
- Item purchased by reviewer
- Company that made the item

The review is delimited with triple backticks. \
Format your response as a JSON object with \
"Sentiment", "Anger", "Item" and "Brand" as the keys.
If the information isn't present, use "unknown" \
as the value.
Make your response as short as possible.
Format the Anger value as a boolean.

Review text: '''#{params[:prompt]}'''
PROMPT

    result = OpenAiClient.new.get_completion(prompt)

    render json: {
      summary: result
    }
  end
end
