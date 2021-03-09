class ForumThreadsController < ApplicationController
  before_action :authenticate_user!, only: [:new, :create]

  def index
    if params[:search]
      @threads = ForumThread.where('title ilike ?', "%#{params[:search]}%").paginate(per_page: 5, page: params[:page])
    else
    	@threads = ForumThread.order(sticky_order: :asc).order(id: :desc).paginate(per_page: 5, page: params[:page])
    end
  end

  def show
  	@threads = ForumThread.friendly.find(params[:id])
    @post = ForumPost.new
    @posts = @threads.forum_posts.paginate(per_page: 3, page: params[:page])
  end

  def new
  	@threads = ForumThread.new
  end

  def create
  	@threads = ForumThread.new(call)
  	@threads.user = current_user
  	
  	if @threads.save
  		redirect_to root_path
  	else
  		render 'new'
  	end
  end

  def edit
    @threads = ForumThread.friendly.find(params[:id])
    authorize @threads
  end

  def update
    @threads = ForumThread.friendly.find(params[:id])
    authorize @threads

    if @threads.update(call)
      redirect_to root_path
    else
      render 'edit'
    end
  end

  def destroy
    @threads = ForumThread.friendly.find(params[:id])
    authorize @threads

    @threads.destroy

    redirect_to root_path
  end

  def pinit
    @threads = ForumThread.friendly.find(params[:id])
    @threads.pinit!
    redirect_to root_path
  end

  private

  def call
  	params.require(:forum_thread).permit(:title, :content)
  end
end
