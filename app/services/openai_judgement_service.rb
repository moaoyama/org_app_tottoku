class OpenaiJudgementService
  def self.judge_and_save(document)
    client = OpenAI::Client.new

    prompt = <<~TEXT
      あなたは文書管理の専門家です。以下の文書タイトルについて、業務や法的な観点から最も適切な保管方法を1つ選んでください。
      
      【選択肢（必ずどれか1つ）】
      1. 紙で保管が必要
      2. データ保管でOK
      3. 処分してOK

      ● 「紙で保管が必要」と判断する条件：
        - 法律や契約で原本提出が義務づけられている場合
        - 将来的に紙の原本を提出する必要が高いと判断される場合
        - 紙の保管が記録の真正性や証拠として重要な場合 

      ● 「データ保管でOK」と判断する条件：
        - 「データ保管でOK」とは「電子保存が適切」という意味を含みます
        - 電子保存が法律や社内ルールで認められている場合
        - 原本提出が通常求められず、電子データで十分な場合  
        - 電子的に管理・検索しやすい文書で業務効率化が図れる場合
        
      ● 「処分してOK」と判断する条件：
        - 業務的・法的価値がなく、感情的・一時的な価値のみの文書
        - 個人の趣味や娯楽に関連する書類
        - 保管する実益がないと判断されるもの

      ● 特に注意すべき点：
        - 曖昧な文書は慎重に判断すること
        - 個別例外がある場合は人間の判断を優先すること

      タイトル: #{document.title}

      【判定】：（上記3つのうち必ずどれか1つ）
      【理由】：（簡潔に1文で述べてください）
    TEXT

    response = client.chat(
      parameters: {
        model: "gpt-3.5-turbo", # もしくは gpt-4
        messages: [
          { role: "system", content: "あなたは書類の保管方法に詳しい専門家AIです。ユーザーが入力した文書名に対し、保管すべきかどうかを法律・実務の観点から合理的に判断してください。" },
          { role: "user", content: prompt }
        ],
        temperature: 0.2
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
