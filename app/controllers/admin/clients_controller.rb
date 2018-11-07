# frozen_string_literal: true

class Admin::ClientsController < Admin::BaseController
  before_action :set_client, only: %i[update show destroy edit]

  def index
    @clients = Client.all
  end

  def new
    @client = Client.new
  end

  def create
    @client = Client.new(client_params)

    if @client.save
      flash[:notice] = 'successfully added client'
      redirect_to admin_clients_path
    else
      render 'new'
    end
  end

  def update
    if @client.update(client_params)
      redirect_to admin_client_path(@client)
    else
      render 'edit'
    end
  end

  def show; end

  def destroy
    @client.destroy
    redirect_to admin_clients_path
  end

  def edit; end

  private

  def client_params
    params.require(:client).permit(:name)
  end

  def set_client
    @client = Client.find(params[:id])
  end
end
