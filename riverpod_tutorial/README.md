Hello everyone
Today we are going to deep dive into Flutter’s riverpod package and providers.
So, what is riverpod
If you have been active in flutter coding, you already know that there are several state management libraries available.
Each has some benefits and, some drawbacks.
You might ask why should we use these libraries? Flutter’s inbuild state management system is quite fine.
Well. That’s not quite true.
Let’s see an example
Here we have a simple page with a scaffold that contains an app bar and a body that contains our FirstWidget.
The FirstWidget, is a state full widget that contains an integer variable as count and three methods for incrementing, decrementing, and updating this count.
We have a Text widget that displays the current count and our SecondWidget.
Second widget is a stateless widget that takes the count and two functions for incrementing and decrementing the count. It also contains two buttons for calling those functions, and our ThirdWidget.
The ThirdWidget also takes the count and an update function for updating the count. It contains a TextFormField that you can manually enter a number. And upon pressing the update button, the update function will be called with the new count value.
Notice that the update function is passing throw the SecondWidget to the third widget.
Now imagine we have a couple of more functions and a lot more widgets. That would create a mess and requires a lot of work to pass functions and variables down the widget tree.
One solution might be to wrap our count variable and all our functions in a ChangeNotifier class. Change notifier class provides a way to listen to changes of the variables. All listeners are notified of the change by calling notifyListeners method.
In this way we can listen for changes of the count and update our display text. Also, we can pass the instance of our CounterNotifier instead of all the functions and count variable.
The problem with this approach is that we must maintain an instance of our CountNotifier throughout the app.
Now imagine we have multiple ChangeNotifiers and some of them need to listen to changes on the others.
I’m sure you can imagine the mess and amount of effort required for this example.
There are several other solutions for this pitfall. But almost all of them have two downsides.
First, we are bound to the lifecycle of our parent widget and it’s BuildContext.
And the second, limited performance optimization due to unnecessary rebuilds.
The Riverpod package eliminates these limitations by completely separating the state management from the flutter code. It is also excellent for performance optimization and testing.
Wrapping a piece of state in a provider have several benefits.
It allows easily accessing that state in multiple locations. Providers are a complete replacement for patterns like Singletons, Service Locators, Dependency Injection or InheritedWidgets.
You can install riverpod package by running this command inside your terminal.
For using riverpod in you flutter application, you should wrap your MaterialApp widget inside a ProviderScope widget.
There are different types of providers for various purposes. We can use a StateProvider.
A StateProvider takes a variable of your desired type, which in our case is an integer, and makes it available throughout the riverpod system.
We can access this variable inside our widget tree by extending the Consumer widget.
Notice the WidgetRef parameter inside the build function.
We can use WidgetRef’s read function to read the current state of out count provider. Or we can use the watch method to listen to any state changes.
We have the option to use the notifier part of our StateProvider instance to modify its current state.
Notice that the current state of our countProvider is available inside the update function.
Another option is to use the ChangeNotifierProvider.
We can place our CounterNotifier class inside the ChangeNotifierProvider and use our old CounterNotifier without previously mentioned restrictions.
There is another type of provider for more complex states. It is called StateNotifierProvider.
It takes two types. One for the StateNotifier and one for the State.
Imagine that you want to store the time that the count is changed.
We can create an immutable State which contains the count and date variables.
And then, we extend the StateNotifier class to create our custom StateNotifier. It contains all our old functions and a little tweak to store the date as well. Updating the state inside our StateNotifier will cascade through the widget tree.
