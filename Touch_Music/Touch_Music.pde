/* Creation & Computation Experiment 03 Tangible Interface
 OCAD U - Fall 2020
 Touch Music
 By Patricia Mwenda
 Created Nov 6th 2020
 Based on:
 Nick Puckett - listSerialPorts.pde
 Minim Sound Library 
 Teekay Music Visualizer 02 - https://pastebin.com/JtAn1mV5 */

 
import processing.serial.*; // import the Processing serial library
import processing.sound.*; // import the Processing sound library

Serial myPort;              // The serial port

int bottle1;
int bottle2;

float k1;
float k2;

//MUSIC  
import ddf.minim.*;
import ddf.minim.signals.*;
Minim minim;
AudioPlayer mySound1;
AudioPlayer mySound2;

  
//MAIN SETUP
void setup () {
  fullScreen(P3D);
  
// List all the available serial ports in the console
  printArray(Serial.list());
//The serial port microcontroller is attached to.
  String portName = Serial.list()[1];
  myPort = new Serial(this, portName, 9600);
// read incoming bytes to a buffer
  myPort.bufferUntil('\n');
  
  noCursor();
  smooth();
  frameRate(24);
 
//MUSIC | mp3 file
  minim = new Minim(this);
  mySound1 = minim.loadFile("Jahera.mp3"); //Music By Lisa Oduor Noah 
  mySound2 = minim.loadFile("Niambie.mp3"); //Music by Xenia Manasseh
  mySound1.pause();
  mySound2.pause();
}
 
void draw () {
  
  background(0);
  fill(0,50);  
  noStroke();
  rect(0, 0, width, height);
  translate(width/2, height/2);
   
  
  for (int i = 0; i < mySound1.bufferSize() - 1; i++) {

    float angle = cos(i+k1)* 10; 
    float angle2 = sin(i+k2)* 100; 

    float x = tan(radians(i))*(angle2+30); 
    float y = cos(radians(i))*(angle2+30);

    float x3 = sin(radians(i))*(500/angle); 
    float y3 = tan(radians(i))*(500/angle);



if (bottle1==0) {
    fill (77,0,75); //Purple
    rect(x, y, mySound2.right.get(i)*10, mySound2.left.get(i)*10);
    
    fill(124,65,120);//Purple
    rect(x3, y3, mySound2.right.get(i)*5, mySound2.right.get(i)*5);
    mySound1.loop();
    
}

 else {
     fill (249,166,2);//Gold
     ellipse(x, y, mySound1.left.get(i)*10, mySound1.left.get(i)*10);
 
    fill (255,253,208);//Cream
    ellipse(x3, y3, mySound1.left.get(i)*20, mySound1.left.get(i)*10);
 
  }
 }
 
  for (int i = 0; i < mySound2.bufferSize() - 1; i++) {

    float angle = tan(i+k1)* 10; 
    float angle2 = sin(i+k2)* 300; 

    float x = tan(radians(i))*(angle2+30); 
    float y = cos(radians(i))*(angle2+30);

    float x3 = sin(radians(i))*(500/angle); 
    float y3 = tan(radians(i))*(500/angle);
    
   if (bottle2==0) {     
    fill(255, 223, 1);//Golden Yellow
    rect(x, y, mySound1.right.get(i)*10, mySound1.left.get(i)*10);
    
    fill (255, 204, 1);//Tangerine Yellow
    ellipse(x3, y3, mySound1.right.get(i)*10, mySound1.right.get(i)*20);
    mySound2.loop();
    
   }
   
    else {
    fill (150,79,145);//Purple
    ellipse(x, y, mySound2.left.get(i)*20, mySound2.left.get(i)*20);
    
    fill (215,181,216);//Purple
    rect(x3, y3, mySound2.left.get(i)*15, mySound2.left.get(i)*15);
  }

  k1 += 0.007;
  k2 += 0.05;
  }
}
  void serialEvent(Serial myPort) {
  // read the serial buffer:
  String myString = myPort.readStringUntil('\n');
  if (myString != null) {
    // println(myString);
    myString = trim(myString);

    int sensors[] = int(split(myString, ','));
    for (int sensorNum = 0; sensorNum < sensors.length; sensorNum++) {
      print("Sensor " + sensorNum + ": " + sensors[sensorNum] + "\t");
    }
    println();
    bottle1 = sensors[0];  
    bottle2 = sensors[11];
    
    
  }
  delay(100);
}
