class Todo
  DONE_MARKER = 'X'
  UNDONE_MARKER = ' '

  attr_accessor :title, :description, :done

  def initialize(title, description='')
    @title = title
    @description = description
    @done = false
  end

  def done!
    self.done = true
  end

  def done?
    done
  end

  def undone!
    self.done = false
  end

  def to_s
    "[#{done? ? DONE_MARKER : UNDONE_MARKER}] #{title}"
  end

  def ==(otherTodo)
    title == otherTodo.title &&
      description == otherTodo.description &&
      done == otherTodo.done
  end
end

require 'colorize'

class TodoList
  attr_accessor :title

  def initialize(title)
    @title = title
    @todos = []
  end

  def <<(todo)
    raise TypeError, 'Can only add Todo objects.' unless todo.instance_of? Todo
    @todos << todo
  end
  alias_method :add, :<<

  def size
    @todos.size
  end
  
  def first
    @todos.first
  end

  def last
    @todos.last
  end
  
  def to_a
    @todos.clone
  end
  
  def done?
    @todos.all? { |todo| todo.done? }
  end
  
  def item_at(todo)
    @todos.fetch(todo)
  end 
  
  def mark_done_at(todo)
    @todos.fetch(todo).done!
  end

  def mark_undone_at(todo)
    @todos.fetch(todo).undone!
  end

  def done!
    @todos.map { |todo| todo.done! }
  end

  def shift
    @todos.shift
  end
  
  def pop
    @todos.pop
  end
  
  def remove_at(todo)
    @todos.delete(item_at(todo))
  end
  
  def each
    @todos.each { |todo| yield(todo) }
    self
  end
  
  def select
    list = TodoList.new(title)
    each { |todo| list.add(todo) if yield(todo) }
    list
  end
  
  def find_by_title(title_search)
    select { |todo| todo.title == title_search }.first
  end
  
  def all_done
    select { |todo| todo.done? }
  end
  
  def all_not_done
    select { |todo| !todo.done? }
  end
  
  def mark_done(done_todo)
    each { |todo| todo.done! if todo.title == done_todo }
  end
  
  def mark_all_done
    each { |todo| todo.done! }
  end
  
  def mark_all_undone
    each { |todo| todo.undone! }
  end

  def to_s
    output = "---- Today's Todos ----\n"
    @todos.each { |todo| output << "#{todo}\n" }
    output << "\n"
  end
end


todo1 = Todo.new("Buy milk")
todo2 = Todo.new("Clean room")
todo3 = Todo.new("Go to gym")

list = TodoList.new("Today's Todos")
list.add(todo1)
list.add(todo2)
list.add(todo3)

p list.find_by_title("Buy milk")
p list.find_by_title("Do laundry")
list.mark_done_at(1)
p list.all_done
p list.all_not_done
list.mark_undone_at(1)
list.mark_done("Clean room")
puts list
list.mark_all_done
puts list
list.mark_all_undone
puts list