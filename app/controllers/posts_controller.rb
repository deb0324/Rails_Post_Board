class PostsController < ApplicationController

  def index
    @posts = Post.all
  end

  def show
    @post = Post.find(params[:id])
    @comment = Comment.new
  end

  def new
    @post = Post.new
  end

  def create
    post = Post.create(title: params[:title], content: params[:content])
    post.user = current_user

    all_cat = Category.all.pluck(:title) #get all current category titles
    user_cat = params[:categories].split(",") #parse all user categories input

    #trim any white spaces
    user_cat.each do |cat|
      cat.strip!
    end

    #For existing categories associate it with the post
    (all_cat & user_cat).each do |cat|
      post.categories << Category.find_by_title(cat)
    end

    #For new categories create the category and associate it with post
    (user_cat - all_cat).each do |cat|
      post.categories << Category.create(title: cat)
    end

    if post.save
      redirect_to posts_path
    else
      render :new
    end
  end
  
  def edit
    @post = Post.find(params[:id])
  end

  def update
    post = Post.find(params[:id])

    if post.update(post_params)
      redirect_to post
    else
      render :edit
    end
  end

  def destroy
    @post = Post.find(params[:id])
    @post.destroy

    @post.comments.each do |comment|
      comment.destroy
    end
    
    redirect_to posts_path
  end

  private

  def post_params
    params.require(:post).permit(:title, :content, category_ids: [])
  end
end