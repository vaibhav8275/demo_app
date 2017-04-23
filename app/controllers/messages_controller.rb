class MessagesController < ApplicationController
  before_action :set_message, only: [:show, :edit, :update, :destroy]

  # GET /messages
  # GET /messages.json
  def index
    @sent_messages = current_user.sent_messages
    @recieved_messages = current_user.recieved_messages
    options = {}
    sent_messages_serialization = ActiveModelSerializers::SerializableResource.new(@sent_messages, options)
    options = {}
    recieved_messages_serialization = ActiveModelSerializers::SerializableResource.new(@recieved_messages, options)
    
    respond_to do |format|
      format.html
      format.json { 
                    render json: { 
                      "sent_messages" => sent_messages_serialization.to_json ,
                      "recieved_messages" => recieved_messages_serialization.to_json
                    }.to_json
                  }
    end 
  end

  # GET /messages/1
  # GET /messages/1.json
  def show
    respond_to do |format|
      format.html
      format.json { render json: @message }
    end 
  end

  # GET /messages/new
  def new
    @message = Message.new
  end

  # GET /messages/1/edit
  def edit
  end

  # POST /messages
  # POST /messages.json
  def create
    @message = Message.new(message_params)
    @message.sent_by_id = current_user.id

    respond_to do |format|
      if @message.save
        format.html { redirect_to @message, notice: 'Message was successfully created.' }
        format.json { render :show, status: :created, location: @message }
      else
        format.html { render :new }
        format.json { render json: @message.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /messages/1
  # PATCH/PUT /messages/1.json
  def update
    respond_to do |format|
      if @message.update(message_params)
        format.html { redirect_to @message, notice: 'Message was successfully updated.' }
        format.json { render :show, status: :ok, location: @message }
      else
        format.html { render :edit }
        format.json { render json: @message.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /messages/1
  # DELETE /messages/1.json
  def destroy
    @message.destroy
    respond_to do |format|
      format.html { redirect_to messages_url, notice: 'Message was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_message
      @message = Message.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def message_params
      params.require(:message).permit(:message, :message_detail, :sent_by_id, :recieved_by_id)
    end
end
