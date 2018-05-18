class SecuritiesController < ApplicationController
  before_action :set_security, only: [:show, :edit, :update, :destroy]

  # GET /securities
  # GET /securities.json
  def index
    @securities = Security.all
  end

  # GET /securities/1
  # GET /securities/1.json
  def show
  end

  # GET /securities/new
  def new
    @security = Security.new
  end

  # GET /securities/1/edit
  def edit
  end

  # POST /securities
  # POST /securities.json
  def create
    @security = Security.new(security_params)

    respond_to do |format|
      if @security.save
        format.html { redirect_to @security, notice: 'Security was successfully created.' }
        format.json { render :show, status: :created, location: @security }
      else
        format.html { render :new }
        format.json { render json: @security.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /securities/1
  # PATCH/PUT /securities/1.json
  def update
    respond_to do |format|
      if @security.update(security_params)
        format.html { redirect_to @security, notice: 'Security was successfully updated.' }
        format.json { render :show, status: :ok, location: @security }
      else
        format.html { render :edit }
        format.json { render json: @security.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /securities/1
  # DELETE /securities/1.json
  def destroy
    @security.destroy
    respond_to do |format|
      format.html { redirect_to securities_url, notice: 'Security was successfully destroyed.' }
      format.json { head :no_content }
    end
  end
  
  def get_list
    pages = Intrinio.instance.companies().parsed_response['total_pages']
    (1...pages).each do |page|
      options = {query: {page_number: page}}
      companies = Intrinio.instance.companies(options).parsed_response['data']
      companies.each do |company|
        @security = Security.new
        @security.load_security(company)
        
      end
    end
    redirect_to securities_path
  end
  
  
  private
    # Use callbacks to share common setup or constraints between actions.
    def set_security
      @security = Security.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def security_params
      params.require(:security).permit(:symbol)
    end
end
