
// Below libraries will connect and send, receive the values from wekinator
import oscP5.*;  
import netP5.*;

// Creating the instances
OscP5 oscP5;
NetAddress dest;

// These variables will be syncronized with the Arduino and they should be same on the Arduino side.
public int output;

// Variables to store images
PImage img, img1, img2;

void setup() 
{
  size(350, 300);
  
  // Loading the images in the sketch
  img = loadImage("nohand.png");
  img1 = loadImage("righthand.png");
  img2 = loadImage("lefthand.png");
 
  // Starting the communication with wekinator. listen on port 12000, return messages on port 6448
  oscP5 = new OscP5(this, 12000); 
  dest = new NetAddress("127.0.0.1", 6448);
}


// Recieve OSC messages from Wekinator
void oscEvent(OscMessage theOscMessage) {
  if (theOscMessage.checkAddrPattern("/wek/outputs") == true) {
    // Receiving the output from wekinator
    float value = theOscMessage.get(0).floatValue();  // First output
    
    // Converting the output to int type
      output = int(value);    
  }
}

void draw() 
{
  // Black background for output window
  background(0);
  
  // Matching the output from the wekinator
  if (output == 1)
  {
    image(img, 0, 0);  // Showing the first image in the output window
  }
  
  else if (output == 2)
  {
    image(img1, 0, 0);  // Showing the second image  in the output window
  }
  
  else if (output == 3)
  {
    image(img2, 0, 0);    // Showing the third image in the output window
  }
}
