class OpenaiJudgementService
  def self.judge_and_save(document)
    client = OpenAI::Client.new

    prompt = <<~TEXT
      以下の文書タイトルについて、次の3つのうちから最も適切な保管方法を1つ選んでください：
      
      1. 紙で保管が必要
      2. データ保管でOK
      3. 処分してOK

      回答は必ず上記のどれかの文言で返してください。
      また、その理由も一文で教えてください。

      タイトル: #{document.title}
    TEXT

    response = client.chat(
      parameters: {
        model: "gpt-3.5-turbo", # もしくは gpt-4
        messages: [
          { role: "system", content: "あなたは文書整理の専門家です。" },
          { role: "user", content: prompt }
        ],
        temperature: 0.3
      }
    )
    
    content = response.dig("choices", 0, "message", "content")&.strip

    # Rails.logger.debug "OpenAI response content: #{content.inspect}"
    # 回答を分解（例：「保管すべき 理由：税務関連の書類だから」）
    decision = case content
      when /紙で保管が必要/
        "紙で保管が必要"
      when /データ保管でOK/
        "データ保管でOK"
      when /処分してOK/
        "処分してOK"
      else
       "判定不能"
    end

    reason = content&.gsub(/(紙で保管が必要|データ保管でOK|処分してOK)/, '')
    reason = reason&.gsub(/\A\d+\.\s*.*理由[:：]\s*/, '')
    reason = reason&.strip

    # GPT結果を保存
    gpt_result = GptResult.create!(
      storage_decision: decision,
      reason: reason
    )

    # 書類に保存
    document.update!(
      ai_decision: decision,
      gpt_result_id: gpt_result.id 
    )

    gpt_result
  end
end
