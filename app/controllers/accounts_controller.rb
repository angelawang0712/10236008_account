class AccountsController < ApplicationController
  before_action :set_account, only: [:show, :edit, :update, :destroy]

  # GET /accounts
  # GET /accounts.json
  def index
    @accounts = Account.order(:deadline)
    @grouped_months = @accounts.group_by { |r| r.deadline.beginning_of_month}
    @all_total =  Account.sum(:price)
    @months = []
    (1..12).each {|m| @months << m}
    @month_details = []
    @month_costs = []
    (0..11).each do |i|
    @month_details[i] = Account.where(["date_part('month',deadline) = ? and date_part('year',deadline) = ?" , @months[i],2015]).order('deadline desc')
    # @month_costs[i] = Account.where(["date_part('month',deadline) = ? and date_part('year',deadline) = ?" , @months[i],2015]).sum(:price)
   end
    
  end

  # GET /accounts/1
  # GET /accounts/1.json
  def show
  end

  # GET /accounts/new
  def new
    @account = Account.new
  end

  # GET /accounts/1/edit
  def edit
  end

  # POST /accounts
  # POST /accounts.json
  def create
    @account = Account.new(account_params)

    respond_to do |format|
      if @account.save
        # format.html { redirect_to @account, notice: 'Account was successfully created.' }
        format.json { render :show, status: :created, location: @account }
        format.html { redirect_to accounts_url, tab: 2 , notice: 'Account was successfully created.'}
      else
        format.html { render :new }
        format.json { render json: @account.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /accounts/1
  # PATCH/PUT /accounts/1.json
  def update
    respond_to do |format|
      if @account.update(account_params)
        format.html { redirect_to @account, notice: 'Account was successfully updated.' }
        format.json { render :show, status: :ok, location: @account }
      else
        format.html { render :edit }
        format.json { render json: @account.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /accounts/1
  # DELETE /accounts/1.json
  def destroy
    @account.destroy
    respond_to do |format|
      format.html { redirect_to accounts_url, notice: 'Account was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_account
      @account = Account.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def account_params
      # params[:account]
      params.require(:account).permit(:deadline, :title, :price ,:title_id)
    end
end
