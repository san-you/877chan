class BoardsController < ApplicationController
  before_action :set_board, only: [:show, :edit, :update, :destroy]
  before_action :sign_in_required, only: [:index]

  # GET /boards
  # GET /boards.json
  def index
    @boards = Board.all.page(params[:page]).per(5)
  end

  # GET /boards/1
  # GET /boards/1.json
  def show
    @comment = Comment.new
    @category_settings = @board.category_settings
  end

  # GET /boards/new
  def new
    @board = Board.new
    @categories = Category.all
  end

  # GET /boards/1/edit
  def edit
  end

  # POST /boards
  # POST /boards.json
  def create
    @board = Board.new(board_params)
    @categories = Category.all

    if categories_params[:categories]
      categories_params[:categories].each do |category_id|
        @category_setting = CategorySetting.new
        @category_setting.board = @board
        @category_setting.category = Category.find(category_id)
        @category_setting.save
      end
    end

    respond_to do |format|
      if @board.save
        format.html { redirect_to @board, notice: 'スレッドが作成されました' }
        format.json { render :show, status: :created, location: @board }
      else
        format.html { render :new }
        format.json { render json: @board.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /boards/1
  # PATCH/PUT /boards/1.json
  def update
    respond_to do |format|
      if @board.update(board_params)
        format.html { redirect_to @board, notice: 'スレッドが更新されました' }
        format.json { render :show, status: :ok, location: @board }
      else
        format.html { render :edit }
        format.json { render json: @board.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /boards/1
  # DELETE /boards/1.json
  def destroy
    @board.destroy
    respond_to do |format|
      format.html { redirect_to boards_url, notice: 'スレッドが削除されました。' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_board
      @board = Board.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def board_params
      params.require(:board).permit(:title)
    end

    def categories_params
      params.require(:board).permit(categories: [])
    end
end
