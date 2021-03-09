# 1. How do we create an object in Ruby? Give an example of the creation of an object.
#   - Objects are instantiated using classes by using the #new method.

# class MyClass
# end

# obj = MyClass.new


# 2. What is a module? What is its purpose? How do we use them with our classes? Create a module for the class you created in exercise 1 and include it properly.
#     - A module is a collection of behaviors that is usable in other classes via mixins. Modules are used in classes using #include

# def MyModule
# end

# class MyClass
#   include MyModule
# end

# obj = MyClass.new