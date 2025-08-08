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
        @document.reload

        flash[:notice] = "判定を保存しました"
        redirect_to result_document_path(@document)
      rescue StandardError => e
        Rails.logger.error "OpenAI判定でエラー発生: #{e.message}"
        render :new, status: :unprocessable_entity
        # 必要ならフラッシュメッセージなども追加
      end
    else
      render :new, status: :unprocessable_entity
    end
  end


  def upload_image
    @document = Document.find(params[:id])
  
    if params[:image].present?
      @image = @document.images.build
      @image.file.attach(params[:image])
      @image.save
    end

    redirect_to document_path(@document)
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

  def update_location
    @document = Document.find(params[:id])
    if @document.update(location: params[:document][:location])
      redirect_to document_path(@document), notice: "保管場所のメモを保存しました。"
    else
      render :show, alert: "保存に失敗しました。"
    end
  end

  def update_user_comment
    @document = Document.find(params[:id])
    if @document.update(user_comment_params)
      redirect_to @document, notice: "メモを保存しました。"
    else
      render :show, alert: "保存に失敗しました。"
    end
  end

  def update_judgement
    @document = Document.find(params[:id])
    if @document.update(user_override: params[:document][:user_override])
      redirect_to document_path(@document), notice: "判定を更新しました。"
    else
      logger.debug @document.errors.full_messages
      render :show, alert: "更新に失敗しました。"
    end
  end
  
  def result
    @document = Document.find(params[:id])
    @document.reload
    @gpt_result = @document.gpt_result
  end

  def show
    @document = Document.find(params[:id])
    @gpt_result = @document.gpt_result
  end

  def index
    @documents = Document.all.order(created_at: :desc)
  end

  def destroy
    @document = Document.find(params[:id])
    @document.destroy
    redirect_to documents_path, notice: "書類を削除しました"
  end

  def delete_image
    document = Document.find(params[:id])
    image = document.images.find(params[:image_id])
    image.destroy
    redirect_to document_path(document), notice: '画像を削除しました'
  end
  
  private

  def set_document
    @document = Document.find(params[:id])
  end

  def document_params
    params.require(:document).permit(:title, :location, :category_id, :user_override, :expires_at, :user_comment, :ai_decision)
  end

  def user_comment_params
    params.require(:document).permit(:user_comment)
  end
end
