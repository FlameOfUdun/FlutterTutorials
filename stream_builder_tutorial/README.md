Hello everyone.


Assume there is an event scheduled for near future, and you have a system that sends some data about newly signed up participants over a stream.

Let's see how we can display the incoming stream data in an app.

We have a participant model that contains name and email address of the participants.

Here we have a prebuilt list of imaginary participants.

And we have a service for broadcasting our list of participants over a stream.

You can see the service is created as a singleton class for ease of use.

There are multiple ways to create a stream. I like to use a stream controller.

The broadcast constructor of the StreamController class allows us to create a stream that can have multiple listeners.

The broadcasting flag is to prevent starting a new broadcast sequence while another one is active.

Our service contains two methods.

The broadcast method checks if the service is currently broadcasting and if true, it throws an error. Then, awaits for 1 second before sending each participant in our list through the stream.

The dispose method also checks if the service is currently broadcasting and if true, it throws an error. If not, the stream controller is closed.

Here we have a flutter app with basic default setup and just one page as it's home.

The home page consists of a scaffold which has an appbar and a body.

The body contains two custom widgets, one for control buttons and one for displaying participants data.

The ControlButtons widget contains two buttons, one for starting the broadcast and one for disposing the stream controller.

Notice the try catch block for error management, it catches any possible errors and display them as a snackbar.

The ParticipantViewer widget wraps a StreamBuilder .

The StreamBuilder  widget takes a stream of your desired type, which in our case is a stream of type Participant, and a builder function.

The builder function provides an AsyncSnapshot that contains useful data about out stream.

The connectionState property of the snapshot object can be used to determine the state of our stream and displaying appropriate widgets accordingly.

If the connectionState is active, it means that the StreamBuilder is receiving data from the stream.

Notice the StreamSnapshotViewer widget which takes the AsyncSnapshot and displays the corresponding data on screen.

AsyncSnapshot also has some helper functions.

For instance, you can use the has error getter to check if the snapshot contains an error, and if so, you can get and handle that error.

Now, let's comment out the stream part of the StreamBuilder and run the app.

The message says, 'No stream is attached'.

Now if we uncomment the stream part and you can see the app is waiting to receive data from the provided stream.

If we click on the broadcast button, our service will start to broadcast out list of participants over the stream, and the data are being shown in on the screen.

Notice that if you click on the broadcast button while the stream is active, you will get an error.

If you click on the dispose button after the stream is finished, the stream will be closed, and you will see the message on screen.
