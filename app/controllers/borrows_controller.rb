class BorrowsController < ApplicationController
  before_action :set_borrow, only: %i[ destroy ]
  before_action :authenticate_user!
  before_action :authorize_user, only: %i[ create destroy ]

  # POST /borrows
  def create
    @borrow = Borrow.new(borrow_params)
    @borrow.borrow_date = Date.today
    @borrow.due_date = Date.today + 2.weeks

    respond_to do |format|
      if @borrow.save
        format.html { redirect_to root_path, notice: "Book was successfully borrowed." }
        format.json { redirect_to root_path, status: :created, location: @borrow }
      else
        format.html { redirect_to root_path, status: :unprocessable_entity }
        format.json { render json: @borrow.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /borrows/1
  def destroy
    @borrow.destroy!

    respond_to do |format|
      format.html { redirect_to root_path, status: :see_other, notice: "Book was successfully
returned." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_borrow
      @borrow = Borrow.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def borrow_params
      params.require(:borrow).permit(:book_id, :user_id)
    end

    def authorize_user
      borrow = @borrow || Borrow
      authorize borrow
    end
end
