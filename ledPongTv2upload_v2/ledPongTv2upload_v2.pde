import processing.serial.*;
boolean disp = true;
int mintime=4000; //min time in ms
int theloop=0;

int curFrame = 0;
//
int pal []=new int [128];
int[] cls;
///----------
// The serial port:
Serial myPort;
import gifAnimation.*;
// Number of columns and rows in our system
int cols, rows;
int delais;

String ledCol;
String ledWallMsg;


PImage[] animation;
Gif loopingGif;
Gif nonLoopingGif;
boolean pause = false;

int flagFrame = 0;
int i=0;
int curFileIndex=0;

String[] files;

void setup() {
  
  
  
 java.io.File folder = new java.io.File(dataPath(""));
  files = folder.list();
  
  println(files);

    size( 270, 160);
   //  loopingGif = new Gif(this, files[int(random(files.length))]);
   nextImage();
     i++;
     //loopingGif.play();
  

  // Initialize columns and rows
  cols = width/10;
  rows = height/10;
    println(Serial.list());
    myPort = new Serial(this, "COM3", 38400);
     // myPort = new Serial(this, "/dev/ttyACM3", 38400);

 background(255);
 

 
}

void draw() {

    frame.setVisible(disp); 



     fill (0); 
  //stroke(188, 178, 146); 
 // PImages test[] = 
  //loopingGif.frames;
  if (flagFrame >= animation.length){
    flagFrame=0;
      if (theloop == 0)
      {
       nextImage();
      }
      else
      {
        theloop--;
      }
  
  }else{
    flagFrame++;
    animation[flagFrame-1].resize(27,16);
    //image(animation[flagFrame-1], 0,0,width,height);
    delay(delais);  
  
  
  //println(loopingGif.currentFrame());

  


  //----------
  
  //-----------------------------------------------------------------
  //--processing2ledWall
  //-----------------------------------------------------------------
  
 // loadPixels();

  ledWallMsg ="";
  // Begin loop for columns
  for (int i = 0; i < cols; i++) {
    // Begin loop for rows
    ledCol = "";
    for (int j = 0; j < rows; j++) {
      
      // Where are we, pixel-wise?
      int x = i*10;
      int y = j*10;
      // Looking up the appropriate color in the pixel array
//      color c = pixels[x+ y*270];
      color c = animation[flagFrame-1].pixels[i+j*27];
      
      
      int value = (int)brightness(c);  // get the brightness
      fill(value);
      //println(hex(value/16,1));
      
      ledCol += hex(value/16,1); 
      //fill(c);
//      stroke(255);
    
      
      rect(x,y,10,10);
      
      /*
      if (fort) {
        byteFort=value;
        byteFort = byteFort << 4;
        byteFort = byteFort&0xF0;

      } else {
        
        byteFaible=char(value/16);
        byteFaible=byteFaible&0x0F;
        buffer=(byteFort&byteFaible);
        message[t]=buffer;
        fort=true;
        t++;
        bitFort=0;
      }*/
      
      
       
    }
   ledWallMsg += ledCol;
   // updatePixels();
  }
  //send pix to the Led Wall
//println(ledWallMsg);
  //println("Z"+ledWallMsg);
 // myPort.write("");
  myPort.write("Z"+ledWallMsg);
 // print("debut frame num ");
 // println(curFrame);
  curFrame++;
  
  if (curFrame <= animation.length)
  {
  for (int toto=0; toto<432; toto++)
  {
 
   
 // print("'")  ;
  print(ledWallMsg.charAt(toto));
 // print("',")  ;
  }
  }
  else 
  {
    println("");
    println("fini, faire le copier coller !!!");
  
  }
  
  
  
  
  //  delay(100);
 
}

}

void nextImage(){
//    if (curFileIndex == files.length){
//     curFileIndex=0;
//    }
//    println(files[curFileIndex]);
//    loopingGif = new Gif(this, files[curFileIndex]);
//     curFileIndex++;
  
 String fileName = files[int(random(files.length))];
 println(fileName);
 //loopingGif.stop();
 animation = Gif.getPImages(this, fileName);
 delais = Gif.getDelay(this, fileName);
 print("longueur =");
 println(animation.length);
  print("temps d'une image =");
println(delais);
if (delais==0)
    delais=40;

if ((delais*animation.length) < mintime)
    {
      //on loope x fois
      theloop=mintime/(delais*animation.length);
    }
    else
    {
      theloop=0;
    }
 //println("nb img"+animation.length);
 //loopingGif = new Gif(this, fileName);
 //loopingGif = new Gif(this, fileName);
 //oopingGif.loop();

   i++;
  // println(i);
 //println (Runtime.getRuntime().freeMemory());
}

void keyPressed() {
  if (key == ' '){
    disp= !disp;
  }
}
