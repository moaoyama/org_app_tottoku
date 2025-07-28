class DocumentsController < ApplicationController
  def new
    @document = Document.new
  end

  def create
    @document = Document.new(document_params)
    @document.user = current_user  # ログイン中のユーザーにひもづけ（要ログイン機能）
    if @document.save
      redirect_to root_path, notice: "書類がアップロードされました！"
    else
      render :new, status: :unprocessable_entity
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

  def document_params
    params.require(:document).permit(:title, :file)
  end
end
