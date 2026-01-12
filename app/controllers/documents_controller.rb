# frozen_string_literal: true
class DocumentsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_document, only: [:show, :edit, :update, :result, :delete_image]
  before_action :authorize_user!, only: [:show, :edit, :update]
  
  def new
    @document = Document.new
  end

  def create
    @document = current_user.documents.new(document_params)

    if @document.save
      begin
        OpenaiJudgementService.judge_and_save(@document)
        @document.reload
        flash[:notice] = "判定を保存しました。"
        redirect_to result_document_path(@document)
      rescue StandardError => e
        Rails.logger.error "OpenAI判定でエラー発生: #{e.message}" 
        flash[:alert] = "OpenAI判定でエラーが発生しました"
        redirect_to home_path
      end
    else
      flash[:alert] = "書類名を入力してください" 
      if @document.errors[:title].present?
        redirect_to home_path
      end
    end
  end

  # 画像アップロード
  def upload_image
    @document = Document.find(params[:id])
    @document.attach_images(params[:images])
    redirect_to document_path(@document)
  end
  
  # 画像削除
  def delete_image
    image = @document.images.find(params[:image_id])
    @document.remove_image_by_id(params[:image_id])
    redirect_to document_path(@document), notice: '画像を削除しました'
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
    @document.assign_attributes(location_params)
    
    if @document.valid?(context: :location_update) && @document.save(context: :location_update)
      redirect_to @document, notice: "保管場所を更新しました。"
    else
      render :show, status: :unprocessable_entity
    end
  end

  def update_user_comment
    @document = Document.find(params[:id])
    @document.assign_attributes(user_comment_params)

    if @document.valid?(context: :comment_update) && @document.save(context: :comment_update)
      redirect_to @document, notice: "メモを保存しました。"
    else
      render :show, status: :unprocessable_entity
    end
  end

  def update_judgement
    @document = Document.find(params[:id])
    if @document.update(user_override: params[:document][:user_override])
      redirect_to document_path(@document), notice: "判定を更新しました。"
    else
      logger.debug @document.errors.full_messages
      flash.now[:alert] = "更新に失敗しました。"
      render :show, status: :unprocessable_entity
    end
  end
  
  def update_expiry
    @document = Document.find(params[:id])
    if @document.update(expires_at: new_expiry)
      redirect_to document_path(@document), notice: "保管期限を更新しました"
    else
      redirect_to document_path(@document), alert: "保管期限の更新に失敗しました"
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
    @documents = current_user.documents.recent
  end

  def destroy
    @document = Document.find(params[:id])
    @document.destroy
    redirect_to documents_path, notice: "書類を削除しました"
  end
  
  private

  def set_document
    @document = Document.find(params[:id])
  end

  def authorize_user!
    unless @document.user == current_user
      flash[:alert] = "他のアカウントのページにはアクセスできません"
      redirect_to home_path(current_user) 
    end
  end

  def document_params
    params.require(:document).permit(:title)
  end

  def location_params
    params.require(:document).permit(:location)
  end

  def user_comment_params
    params.require(:document).permit(:user_comment)
  end
end