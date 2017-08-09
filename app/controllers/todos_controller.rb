class TodosController < ApplicationController
  include ParamsHelper
  before_action :find_todo

  def index
    page   = parse_page(params[:page])
    @todos = current_user.todos.page(page)

    # Parse done
    if params[:done] && params[:done] == '1'
      @todos = @todos.where(done: true)
    else
      @todos = @todos.where(done: false)
    end

    # Order by deadline
    @todos = @todos.order(deadline: :asc)

    @todos = @todos.page(page)
    @todo  = Todo.new
  end

  def create
    @todo         = Todo.new(todo_params)
    @todo.user_id = current_user.id

    if @todo.save
      redirect_to todos_path
    else
      render action: :index
    end
  end

  def done
    @todo.done!
    redirect_to todos_path
  end

  def edit
  end

  def update
  end

  def destroy
  end

  private

    def todo_params
      params.require(:todo).permit(:title, :content)
    end

    def find_todo
      @todo = current_user.todos.find(params[:id]) if params[:id]
    end
end
