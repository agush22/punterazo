class FieldsController < ApplicationController
load_and_authorize_resource

  # GET /fields
  # GET /fields.json
  def index
    @fields = Field.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @fields }
    end
  end

  def homepage
    @fields = Field.all

    respond_to do |format|
      format.html
      format.json { render json: @fields }
    end
  end

  # GET /fields/1
  # GET /fields/1.json
  def show
    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @field }
    end
  end

  # GET /fields/new
  # GET /fields/new.json
  def new
    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @field }
    end
  end

  # GET /fields/1/edit
  def edit
  end

  # POST /fields
  # POST /fields.json
  def create
    if current_user
      @field.user = current_user
      respond_to do |format|
        if @field.save
          format.html { redirect_to @field, notice: 'Field was successfully created.' }
          format.json { render json: @field, status: :created, location: @field }
        else
          format.html { render action: "new" }
          format.json { render json: @field.errors, status: :unprocessable_entity }
        end
      end
    elsif verify_recaptcha(:model => @field, :message => "Escribe las letras de la imagen de nuevo") && @field.save
      redirect_to @field, notice: 'Field was successfully created.'
    else
      render action: "new"
    end
  end

  # PUT /fields/1
  # PUT /fields/1.json
  def update
    respond_to do |format|
      if @field.update_attributes(params[:field])
        format.html { redirect_to @field, notice: 'Field was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @field.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /fields/1
  # DELETE /fields/1.json
  def destroy
    @field.destroy

    respond_to do |format|
      format.html { redirect_to fields_url }
      format.json { head :no_content }
    end
  end

  def pending
    @fields = Field.pending
    respond_to do |format|
      format.html { render :action => 'index'}
    end
  end
  def accepted
    @Fields = Field.accepted
    respond_to do |format|
      format.html { render :action => 'index'}
    end
  end
  def rejected
    @Fields = Field.rejected
    respond_to do |format|
      format.html {render :action => 'index'}
    end
  end

  def accept
    @field.accept
    respond_to do |format|
      format.html { render :action => 'show'}
    end
  end
  def reject
    @field.reject
    respond_to do |format|
      format.html { render :action => 'show'}
    end
  end
  def reset
    @field.reset
    respond_to do |format|
      format.html { render :action => 'show'}
    end
  end
end
