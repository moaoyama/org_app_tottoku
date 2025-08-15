class ImagesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_document

  def create
    @image = @document.images.new(image_params)
    if @image.save
      redirect_to @document, notice: "画像をアップロードしました"
    else
      redirect_to @document, alert: "画像のアップロードに失敗しました"
    end
  end

  private

  def set_document
    @document = Document.find(params[:document_id])
  end

  def image_params
    params.require(:image).permit(:file)  # :fileはImageモデルの画像ファイルカラム
  end
end
