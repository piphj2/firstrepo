//comment

import gab.opencv.*;
import processing.video.*;
import java.awt.Rectangle;

OpenCV opencvFace;
OpenCV opencvNose;
OpenCV opencvFlow;
Capture cam;
Rectangle[] faces;
Rectangle[] noses;





void setup() 
{
  size(10, 10);
  
  initCamera();
  opencvFace = new OpenCV(this, cam.width, cam.height);
  opencvNose = new OpenCV(this, cam.width, cam.height);
  opencvFlow = new OpenCV(this, cam.width, cam.height);
  
  surface.setResizable(true);
  surface.setSize(opencvFace.width, opencvFace.height);
  opencvFace.loadCascade(OpenCV.CASCADE_FRONTALFACE);
  opencvNose.loadCascade(OpenCV.CASCADE_NOSE);
  
}

void draw() 
{
  if(cam.available())
  {    
    cam.read();
    cam.loadPixels();
    opencvFace.loadImage((PImage)cam);
    opencvNose.loadImage((PImage)cam);
    opencvFlow.loadImage((PImage)cam);
    image(opencvFace.getInput(), 0, 0);

    // you should write most of your computer vision code here 
    
    
    // CODE
     
     faces = opencvFace.detect();
     
  
     
     image(opencvFace.getInput(), 0, 0);
     
     
     
     for (int i = 0; i < faces.length; i++){
       
       
       opencvNose.setROI(faces[i].x, faces[i].y, faces[i].width, faces[i].height);
       noses = opencvNose.detect();
       
       for (int j = 0; j < noses.length; j++){
         noFill();
         stroke(255,0,0);
         strokeWeight(3);
         rect((faces[i].x + noses[j].x), (faces[i].y + noses[j].y), noses[j].width, noses[j].height);
       }
     }
     
   opencvFlow.calculateOpticalFlow();  
   PVector aveFlow =  opencvFlow.getAverageFlow();
   println(aveFlow);
   
    // if(
       
       
    
    // end code
  }
  }




void initCamera()
{
  String[] cameras = Capture.list();
  if (cameras.length != 0) 
  {
    println("Using camera: " + cameras[0]); 
    cam = new Capture(this, cameras[0]);
    cam.start();    
    
    while(!cam.available()) print();
    
    cam.read();
    cam.loadPixels();
  }
  else
  {
    println("There are no cameras available for capture.");
    exit();
  }
}
