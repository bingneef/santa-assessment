
class ElvesController < ApplicationController
  respond_to :html

  def index
    @q = Elf.all.search params[:q]
    @elves = @q.result.page(params[:page])

    respond_with @elves, meta: pagination_meta(@elves)
  end

  def show
    @elf = Elf.find params[:id]
    respond_with @elf
  end

  def new
    @elf = Elf.new
  end

  def edit
    @elf = Elf.find params[:id]
    respond_with @elf
  end

  def create
    @elf = Elf.new(elf_params)
    @elf.save
    respond_with @elf
  end

  def update
    @elf = Elf.find params[:id]
    @elf.update(elf_params)
    respond_with @elf
  end

  def destroy
    @elf = Elf.find params[:id]
    @elf.destroy
    respond_with @elf
  end

  private

  def elf_params
    params.require(:elf).permit(
      :first_name,
      :last_name,
      :date_of_birth,
      :speciality
    )
  end
end
