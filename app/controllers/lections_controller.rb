class LectionsController < ApplicationController
  before_action :set_lection, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user!, except: [:show, :index,]
  # GET /lections
  # GET /lections.json
  def index
    @lections = Lection.all
  end

  def tag_cloud
    @tags = Lection.tag_counts_on(:tags)
  end
  def tagged
    if params[:tag].presence
      @tag = params[:tag]
      @lections = Lection.tagged_with(@tag)
    else
      @lections = Lection.all
    end
  end
  def search
    @query= params[:search_lections].presence && params[:search_lections][:query]
    if @query
      @lections=LectionsIndex.query(multi_match: {fields: ['title','description','body','user','comments'], query: @query, type: "phrase_prefix"}).objects
      if @lections.to_i > 0
        @lections
      else
        redirect_to root_path
      end
    end
  end

  def show
    @current_user = current_user
    @rating=Rating.new
    @comment = Comment.new
    @comments = @lection.comments.order( "updated_at DESC")
  end
  # GET /lections/new
  def new
    if current_user.admin and admin_as_user
      @new_user = User.find(admin_as_user)
      @lection =  @new_user.lections.new
    else
      @lection =  current_user.lections.new
    end
  end
  
  def create
    @lection = Lection.new(lection_params)
    if new_user = User.find_by(username: params[:commit].split().last)
      @lection = new_user.lections.new(lection_params)
    else
      @lection = current_user.lections.new(lection_params)
    end
    respond_to do |format|
      if @lection.save
        format.html { redirect_to @lection, notice: 'Lection was successfully created.' }
        format.json { render :show, status: :created, location: @lection }
      else
        format.html { render :new }
        format.json { render json: @lection.errors, status: :unprocessable_entity }
      end
    end
  end
  # GET /lections/1/edit
  def edit
  end

  # PATCH/PUT /lections/1
  # PATCH/PUT /lections/1.json
  def update
    respond_to do |format|
      if @lection.update(lection_params)
        format.html { redirect_to @lection, notice: 'Lection was successfully updated.' }
        format.json { render :show, status: :ok, location: @lection }
      else
        format.html { render :edit }
        format.json { render json: @lection.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /lections/1
  # DELETE /lections/1.json
  def destroy
    @lection.destroy
    respond_to do |format|
      format.html { redirect_to lections_url, notice: 'Lection was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private

  def admin_as_user
    params[:admin_as_user]
  end
  # Use callbacks to share common setup or constraints between actions.
  def set_lection
    @lection = Lection.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def lection_params
    params.require(:lection).permit(:title, :description, :speciality, :body, :tag_list)
  end

end
