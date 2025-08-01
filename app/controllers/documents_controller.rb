class DocumentsController < ApplicationController
  before_action :require_login
  before_action :set_document, only: [:show, :edit, :update, :result]
  
  def new
    @document = Document.new
  end

  def create
    @document = current_user.documents.new(document_params)
    # @document.user = current_user  # ログイン中のユーザーにひもづけ（要ログイン機能）
    if @document.save
      begin
        gpt_result = OpenaiJudgementService.judge_and_save(@document)
        @document.update(
          gpt_result_id: gpt_result.id,
          ai_decision: gpt_result.storage_decision,
          reason: gpt_result.reason
        )
      rescue StandardError => e
        Rails.logger.error "OpenAI判定でエラー発生: #{e.message}"
        # 必要ならフラッシュメッセージなども追加
      end
      render :result
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
  end

  def update
    if @document.update(document_params)
      redirect_to @document, notice: "書類が更新されました。"
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def result
  end

  def show
  end

  def index
    @documents = Document.all.order(created_at: :desc)
  end

  private

  def set_document
    @document = Document.find(params[:id])
  end

  def document_params
    params.require(:document).permit(:title, :location, :category_id, :user_override, :expires_at, :user_comment)
  end
end
