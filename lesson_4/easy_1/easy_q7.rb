What is the default return value of to_s when invoked on an object? Where could you go to find out if you want to be sure?

It depends on the object it is called on. Custom classes will return the name of the objects class and an encoding of the object ID. Check Ruby Docs.