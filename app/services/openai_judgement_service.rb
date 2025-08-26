class OpenaiJudgementService
  def self.judge_and_save(document)
    client = OpenAI::Client.new

    prompt = <<~TEXT
      あなたは文書管理の専門家です。以下の文書タイトルについて、業務や法的観点から最も適切な保管方法を**必ず1つ**選び、理由を**1文、20〜30字程度**で簡潔に述べてください。
      
      
      【判定手順（必ず従うこと）】
      1. 法律や契約で原本提出が義務づけられているか確認
      2. 電子保存が可能で法的に提出不要な場合はデータ保管を優先
      3. 過去の古い文書や業務的価値が低い場合は処分を検討
      4. 文書名の単語だけで判断せず、条件に基づいて総合的に判断

      【選択肢（必ずどれか1つ）】
      1. 紙で保管が必要
      2. データ保管でOK
      3. 処分してOK

      ● 「紙で保管が必要」と判断する条件：
        - 法律や契約で原本提出が義務づけられている場合
        - 将来的に紙の原本を提出する必要が高いと判断される場合
        - 紙の保管が記録の真正性や証拠として重要な場合 
        - 業務上の証拠や将来提出の可能性がある場合

      ● 「データ保管でOK」と判断する条件：
        - 「データ保管でOK」とは「電子保存が適切」という意味を含みます
        - 電子保存が法律や社内ルールで認められている場合
        - 原本提出が通常求められず、電子データで十分な場合  
        - 電子的に管理・検索しやすい文書で業務効率化が図れる場合
        - 電子保存が可能で法的提出不要の場合
        
      ● 「処分してOK」と判断する条件：
        - 業務的・法的価値がなく、感情的・一時的な価値のみの文書
        - 個人の趣味や娯楽に関連する書類
        - 保管する実益がないと判断されるもの
        - 過去の古い文書で、業務や法的価値がない場合

      ● 特に注意すべき点：
        - 曖昧な文書は慎重に判断すること
        - 個別例外がある場合は人間の判断を優先すること

      タイトル: #{document.title}

      （上記3つのうち必ずどれか1つ）
      （20〜30字程度で簡潔に）
    TEXT

    response = client.chat(
      parameters: {
        model: "gpt-4o-mini", # もしくは gpt-4
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
    gpt_result = GptResult.create(
      storage_decision: decision,
      reason: reason
    )

    document.update!(
      gpt_result_id: gpt_result.id,
      ai_decision: decision
    )

    # 書類に保存
    if gpt_result.persisted?
      document.update(
        ai_decision: decision,
        gpt_result_id: gpt_result.id 
      )
    else
      Rails.logger.error "GptResultの保存に失敗: #{gpt_result.errors.full_messages.join(', ')}"
    end

    gpt_result
  end
end
