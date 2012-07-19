//  delay(1000);

/*
for (int maxindex=0; maxindex < maxnb; maxindex++)
 {
 
 SendCol(address[maxindex], 0x10, colDataRien);
 
 
 }
 delay(100);
 
 */


#include <Wire.h>
#include <SD.h>

File myFile;



// code for max7313
// initial code from eric toering
// modification for driving a lot of MAX7313 boards Lionel D. 24/02/2010
// Protocol implementation Fabrice F. 13/03/2010
// READ THE MAX7313 DATASHEET !!!!

// Using the Wire library (created by Nicholas Zambetti)
// On the Arduino board, Analog In 4 is SDA, Analog In 5 is SCL


void Send(byte addr, byte reg, byte data);
byte address[] = {
  0x11,0x12,0x13,0x14,0x15,0x16,0x17,0x18,0x19,0x1A,0x1B,0x20,0x21,0x22,0x23,0x24,0x25,0x26,0x27,0x28,0x29,0x2A,0x2B,0x2C,0x2D,0x2E,0x2F};
//byte address[] = {0x1B,0x20,0x21,0x22,0x23,0x24,0x25,0x26,0x27,0x28,0x29,0x2A,0x2B,0x2C,0x2D,0x2E,0x2F};
// adresses of max chips
//   byte address[] = {0x11, 0X12, 0x13};      // adresses of max chips

#define maxnb 27

//int maxnb = 27;    // total nb of max7313
//int timer = 1; // timer used to slow down the full test (K2000 effect speed)
int intensity = 0xff; // intensity
//int maxRow = 16;
#define maxRow 16

//char serString[433]; // lenght of the serial message maxnb *16
int valid = 0;
//long memIndex = 0;
//size_t memIndex = 0;
int fileindex = 1;



void setup()
{
  pinMode(3, INPUT);  
  pinMode(4, INPUT);  
  pinMode(5, INPUT);  
  pinMode(6, INPUT);  

  Wire.begin(); // join i2c bus (address optional for master)
  Serial.begin(115200); // (DEBUG)
  Serial.println("Hello !!!");


  Serial.print("Initializing SD card...");
  // On the Ethernet Shield, CS is pin 4. It's set as an output by default.
  // Note that even if it's not used as the CS pin, the hardware SS pin 
  // (10 on most Arduino boards, 53 on the Mega) must be left as an output 
  // or the SD library functions will not work. 
  pinMode(10, OUTPUT);

  //  if (!SD.begin(4)) {
  if (!SD.begin(10)) {
    Serial.println("initialization failed!");
    return;
  }
  Serial.println("initialization done.");



  //Serial.begin(38400); // (DEBUG)

  //  print("check");
  int maxindex; // index of array
  for (int maxindex=0; maxindex < maxnb; maxindex++){     // Max 7313 - Init phase
    Send(address[maxindex], 0xf, 0x10); // blink 0 aan, 0x10 is glob uit
    Send(address[maxindex], 0x6, 0x00); // input en output config.
    Send(address[maxindex], 0x7, 0x00); // oninterresante getallen, afblijven!!
    Send(address[maxindex], 0x2, 0xff); // global intensity reg.
    Send(address[maxindex], 0x3, 0xff);
    Send(address[maxindex], 0xe, 0xff); // config bit
  }
}



void loop()
{


  byte readremote;
  readremote = 0;


  if (digitalRead(3)) readremote = readremote + 1;
    if (digitalRead(4)) readremote = readremote + 2;
    if (digitalRead(5)) readremote = readremote + 4;
    if (digitalRead(6)) readremote = readremote + 8;



    switch (readremote) {
  case 1:
    displayGif(1,21,100);

    break;
  case 2:
    displayGif(2,49,10);

    break;

  case 3:
    displayGif(3,1,1);
    break;

  case 4:
    displayGif(4,6,100);

    break;

  case 5:
    displayGif(5,20,150);

    break;

  case 6:
    displayGif(6,14,180);

    break;

  case 7:
    displayGif(7,10,50);

    break;

  case 8:
    displayGif(8,34,40);

    break;

  case 9:
    displayGif(9,38,1);

    break;

  case 10:
    displayGif(10,16,50);

    break;









//  default: 
    // if nothing else matches, do the default
    // default is optional
  }






  /*
  if (numGif == 1) myFile = SD.open("1-21-100.txt");
   if (numGif == 2) myFile = SD.open("2-49-70.txt");
   if (numGif == 4) myFile = SD.open("4-6-120.txt");
   if (numGif == 5) myFile = SD.open("5-20-100.txt");
   if (numGif == 6) myFile = SD.open("6-14-100.txt");
   if (numGif == 7) myFile = SD.open("7-10-100.txt");
   if (numGif == 8) myFile = SD.open("8-34-100.txt");
   if (numGif == 9) myFile = SD.open("9-38-20.txt");
   if (numGif == 10) myFile = SD.open("10-16-50.txt");
   void displayGif(int nbloop, int numGif, int nbframe, int interframe)
   displayGif(2,4,6,120);
   displayGif(2,5,20,100);
   displayGif(2,6,14,100);
   displayGif(2,7,10,100);
   displayGif(2,8,34,100);
   displayGif(2,9,38,100);
   displayGif(2,10,16,50);
   
   
   
   
   
   
   displayGif(1,21,100);
   displayGif(1,21,100);
   displayGif(1,21,100);
   displayGif(1,21,100);
   displayGif(1,21,100);
   
   displayGif(2,49,10);
   displayGif(2,49,10);
   displayGif(2,49,10);
   displayGif(2,49,10);
   displayGif(2,49,10);
   
   displayGif(4,6,100);
   displayGif(4,6,100);
   displayGif(4,6,100);
   displayGif(4,6,100);
   
   displayGif(5,20,150);
   displayGif(5,20,150);
   displayGif(5,20,150);
   displayGif(5,20,150);
   displayGif(5,20,150);
   
   displayGif(6,14,180);
   displayGif(6,14,180);
   displayGif(6,14,180);
   displayGif(6,14,180);
   displayGif(7,10,50);
   displayGif(7,10,50);
   displayGif(7,10,50);
   displayGif(7,10,50);
   displayGif(8,34,40);
   displayGif(8,34,40);
   displayGif(8,34,40);
   displayGif(8,34,40);
   
   
   displayGif(9,38,1);
   displayGif(9,38,1);
   displayGif(9,38,1);
   displayGif(9,38,1);
   displayGif(10,16,50);
   displayGif(10,16,50);
   displayGif(10,16,50);
   displayGif(10,16,50);
   
   
   
   
   
   
   
   */

}


void displayGif(int numGif, int nbframe, int interframe)
{
  //  long stringIndex=0;
  int maxindex; // index of array
  byte colData[8];
  //  byte colDataRien[8] = {255,255,255,255,255,255,255,255  };
  byte Pos1;
  byte Pos2;
  byte k=0;
  byte t =0;
  boolean fort=true;
  byte frame = 0;


  switch (numGif) {
  case 1:
    myFile = SD.open("1.txt");
    break;
  case 2:
    myFile = SD.open("2.txt");
    break;
  case 3:
    myFile = SD.open("3.txt");
    break;
  case 4:
    myFile = SD.open("4.txt");
    break;
  case 5:
    myFile = SD.open("5.txt");
    break;
  case 6:
    myFile = SD.open("6.txt");
    break;
  case 7:
    myFile = SD.open("7.txt");
    break;
  case 8:
    myFile = SD.open("8.txt");
    break;
  case 9:
    myFile = SD.open("9.txt");
    break;
  case 10:
    myFile = SD.open("10.txt");
    break;

  default: 
    myFile = SD.open("3.txt");
  }

  for (frame = 0; frame<nbframe;frame++){

    // stringIndex = 0;
    for (int maxindex=0; maxindex < maxnb; maxindex++){
      for (int row=0; row < maxRow; row++){
        if (fort){
          Pos1=myFile.read();
          fort=false;
          k++;
        }
        else{
          k++;
          Pos2=myFile.read();
          colData[t]=Read2HEXtoDEC(Pos1,Pos2);
          fort=true;
          t++;
        }
        // stringIndex++;
      }
      SendCol(address[maxindex], 0x10, colData);
      t=0;
    }
    delay(interframe);
  }

  myFile.close();

}




//}
// Send I2C data
void SendCol(byte addr, byte reg, byte colData[])
{

  Wire.beginTransmission(addr);
  Wire.write( reg);
  //     Serial.print("Maxaddress :");
  //     Serial.print(addr,HEX); // debug


    for (int i=0;i<8;i++){
    Wire.write( colData[i]);
    //     Serial.println(i,DEC); // debug
    //     Serial.print("< N Ligne / HEX Value : ");    //     Serial.println(colData[i],HEX); // debug
  }
  Wire.endTransmission();
}

// Send I2C data
void Send(byte addr, byte reg, byte data)
{

  Wire.beginTransmission(addr);
  Wire.write( reg);
  Wire.write( data);
  Wire.endTransmission();
}


// Reads a 2 byte HEX from the serial port and converts it to DEC
// The incomming data stream is build up as follows
// Example:  15 06      A3      FF      00      ... etc.

int Read2HEXtoDEC(byte Pos2,byte Pos1)
{

  // Now convert the HEX to DEC

  int DECval = 0;

  if(Pos2 <= 57) // Convert Pos2 from 16 base to 10 base
  {
    DECval = DECval + Pos2-48;
  }
  else
  {
    DECval = DECval + Pos2-55;
  }

  if(Pos1 <= 57) // Convert Pos1 from 16 base to 10 base
  {
    DECval = DECval + 16*(Pos1-48);
  }
  else
  {
    DECval = DECval + 16*(Pos1-55);
  }

  return ~DECval;
}


