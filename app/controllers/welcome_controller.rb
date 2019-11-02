class WelcomeController < ApplicationController
  def index_bak
    flash[:notice] = "早安！你好！"
    flash[:alert] = "晚安！该睡了！"
    flash[:warning] = "这是 warning 信息！"
    @groups = [
        {
            title: "test title one", description: "test description two"
        },
        {
            title: "test title one", description: "test description two"
        }
    ]
  end
end
