class SalesAssociates::StoresController < ApplicationController
  before_action :set_store, only: [:show, :create_position, :new_position,:finish_position]
  before_action :authenticate_sales_associate!

  def index
    @stores = Store.order("address").all

    render template: "sales_associates/stores/index"
  end

  def show
  end

  def create_position
    unless Position.exists?(sales_associate: current_sales_associate, store: @store)
      @position = Position.new(sales_associate: current_sales_associate, store: @store, role: params[:role], start_date: params[:start_date])
        unless @position.save
          flash[:alert] = I18n.t('sales_associates.create_position.failed_position')
        end
    else
      flash[:alert] = I18n.t('sales_associates.create_position.exists_position')
    end
    redirect_to sales_associate_stores_path(sales_associate_id: current_sales_associate)
  end

  def new_position
  end

  def finish_position
  end

  def undo_position
    if position = current_sales_associate.old_positions.where(store_id: params[:id]).first
      position.update_attribute(:end_date, nil)
    end
    redirect_to sales_associate_stores_path(sales_associate_id: current_sales_associate)
  end

  def destroy_position
    if position = current_sales_associate.positions.where(store_id: params[:id]).first
      position.update_attribute(:end_date, params[:end_date])
    end
    redirect_to sales_associate_stores_path(sales_associate_id: current_sales_associate)
  end

  private
  # Use callbacks to share common setup or constraints between actions.
  def set_store
    @store = Store.find(params[:id])
  end

end
