class CommentsController < ApplicationController

  def create

    @post = Post.find(params[:post_id])
    @comment = Comment.create(comment_params)
    @post.comments << @comment

    @comment.save
    redirect_to post_path(@post)
  end

  private 

  def comment_params
    params.require(:comment).permit(:content)
  end

end