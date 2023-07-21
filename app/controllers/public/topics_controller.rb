class Public::TopicsController < ApplicationController
  def index
    @topic = Topic.all
  end
end
