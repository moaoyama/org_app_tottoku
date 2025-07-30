class DocumentsController < ApplicationController
  before_action :require_login
  before_action :set_document, only: [:show, :edit, :update, ]
  
  def new
    @document = Document.new
  end

  def create
    @document = current_user.documents.build(document_params)
    # @document.user = current_user  # ログイン中のユーザーにひもづけ（要ログイン機能）
    if @document.save
      redirect_to result_document_path(@document)
    else
      flash[:alert] = "保存に失敗しました"
      redirect_to home_path
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
    @document = Document.find(params[:id])
    # 判定結果や理由は @document の属性や関連モデルから取る想定
  end

  def show
    @document = Document.find(params[:id])
  end

  def index
    @documents = Document.all.order(created_at: :desc)
  end

  private

  def set_document
    @document = Document.find(params[:id])
  end

  def document_params
    params.require(:document).permit(:name, :title, :ai_decision, :storage_decision, :reason, :memo, :image)
  end
end
