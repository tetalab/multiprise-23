/*
 * an arduino sketch to interface with a ps/2 keyboard.
 * Also uses serial protocol to talk back to the host
 * and report what it finds. Used the ps2 library.
 */

#include <ps2.h>
#include <NewSoftSerial.h>
boolean ctrl = false;
NewSoftSerial mySerial(2, 9); //TX only
byte gauche = 8;
byte droite = 9;
byte bas = 10;
byte haut = 11;
byte debutDeLigne = 13;
byte hautGauche = 30;
byte hautGaucheEfface = 12;
byte separateurDeSousArticle = 31;
byte remplissageEspace = 24; //Remplit le reste da la rangée avec des espaces

/*
 * Pin 5 is the ps2 data pin, pin 6 is the clock pin
 * Feel free to use whatever pins are convenient.
 */

//PS2 kbd(5, 6); //blanc vert
PS2 kbd(7, 8); //blanc vert

byte codebar[90] = {
  0,0,0,0,0,
  0,0,0,0,0,
  0,0,0,0,0,
  0,0,0,0,0,
  0,0,0,0,0,
  0,0,0,0,0,
  0,0,0,0,0,
  0,0,0,0,0,
  0,0,0,0,0,
  0,0,0,0,0,
  0,0,0,0,0,
  0,0,0,0,0,
  0,0,0,0,0,
  0,0,0,0,0,
  0
}; // data to write on startup





byte code1001[81] = {
  42,2,240,130,240,170,42,11,240,139,240,170,42,11,240,139,240,170,42,2,240,130,240,170,42,11,240,139,240,170,42,11,240,139,240,170,42,11,240,139,240,170,42,11,240,139,240,170,42,11,240,139,240,170,42,11,240,139,240,170,42,11,240,139,240,170,42,11,240,139,240,170,42,7,240,135,240,170,28,240,156
};

byte code1002[81] = {
  42,2,240,130,240,170,42,11,240,139,240,170,42,11,240,139,240,170,42,3,240,131,240,170,42,11,240,139,240,170,42,11,240,139,240,170,42,11,240,139,240,170,42,11,240,139,240,170,42,11,240,139,240,170,42,11,240,139,240,170,42,11,240,139,240,170,42,11,240,139,240,170,42,4,240,132,240,170,28,240,156
};

byte code1003[81] = {
  42,2,240,130,240,170,42,11,240,139,240,170,42,11,240,139,240,170,42,4,240,132,240,170,42,11,240,139,240,170,42,11,240,139,240,170,42,11,240,139,240,170,42,11,240,139,240,170,42,11,240,139,240,170,42,11,240,139,240,170,42,11,240,139,240,170,42,11,240,139,240,170,42,11,240,139,240,170,28,240,156
};

byte code1004[81] = {
  42,2,240,130,240,170,42,11,240,139,240,170,42,11,240,139,240,170,42,5,240,133,240,170,42,11,240,139,240,170,42,11,240,139,240,170,42,11,240,139,240,170,42,11,240,139,240,170,42,11,240,139,240,170,42,11,240,139,240,170,42,11,240,139,240,170,42,11,240,139,240,170,42,8,240,136,240,170,28,240,156
};
byte code1005[81] = {
  42,2,240,130,240,170,42,11,240,139,240,170,42,11,240,139,240,170,42,6,240,134,240,170,42,11,240,139,240,170,42,11,240,139,240,170,42,11,240,139,240,170,42,11,240,139,240,170,42,11,240,139,240,170,42,11,240,139,240,170,42,11,240,139,240,170,42,11,240,139,240,170,42,5,240,133,240,170,28,240,156
};

byte code1006[81] = {
  42,2,240,130,240,170,42,11,240,139,240,170,42,11,240,139,240,170,42,7,240,135,240,170,42,11,240,139,240,170,42,11,240,139,240,170,42,11,240,139,240,170,42,11,240,139,240,170,42,11,240,139,240,170,42,11,240,139,240,170,42,11,240,139,240,170,42,11,240,139,240,170,42,2,240,130,240,170,28,240,156
};

byte code1007[81] = {
  42,2,240,130,240,170,42,11,240,139,240,170,42,11,240,139,240,170,42,8,240,136,240,170,42,11,240,139,240,170,42,11,240,139,240,170,42,11,240,139,240,170,42,11,240,139,240,170,42,11,240,139,240,170,42,11,240,139,240,170,42,11,240,139,240,170,42,11,240,139,240,170,42,9,240,137,240,170,28,240,156
};

byte code1008[81] = {
  42,2,240,130,240,170,42,11,240,139,240,170,42,11,240,139,240,170,42,9,240,137,240,170,42,11,240,139,240,170,42,11,240,139,240,170,42,11,240,139,240,170,42,11,240,139,240,170,42,11,240,139,240,170,42,11,240,139,240,170,42,11,240,139,240,170,42,11,240,139,240,170,42,6,240,134,240,170,28,240,156
};

byte code1009[81] = {
  42,2,240,130,240,170,42,11,240,139,240,170,42,11,240,139,240,170,42,10,240,138,240,170,42,11,240,139,240,170,42,11,240,139,240,170,42,11,240,139,240,170,42,11,240,139,240,170,42,11,240,139,240,170,42,11,240,139,240,170,42,11,240,139,240,170,42,11,240,139,240,170,42,3,240,131,240,170,28,240,156
};

byte code1010[81] = {
  42,2,240,130,240,170,42,11,240,139,240,170,42,2,240,130,240,170,42,11,240,139,240,170,42,11,240,139,240,170,42,11,240,139,240,170,42,11,240,139,240,170,42,11,240,139,240,170,42,11,240,139,240,170,42,11,240,139,240,170,42,11,240,139,240,170,42,11,240,139,240,170,42,9,240,137,240,170,28,240,156
};


/*
char texte1[]  = "Tu vois ce que je veux dire";
char texte2[]  = "lève les bras, balance toi";
char texte4[]  = "attend toi au prévisible";
char texte5[]  = "ne sois pas surpris par l'inattendu";
char texte6[]  = "travaille dur, tu seras récompensé";
char texte7[]  = "tu n'as rien oublié";
char texte8[]  = "essaye encore!";
char texte9[]  = "continue dans cette voie";
char texte10[]  = "si tu veux être apprécié, meurs ou voyage";
*/


char texte1[]   = "      Tu vois ce que je veux dire";
char texte2[]   = "       Leve les bras, balance toi";
char texte4[]   = "        Attend toi au previsible";
char texte5[]   = "   Ne sois pas surpris par l'inattendu";
char texte6[]   = "   Travaille dur, tu seras recompense";
char texte7[]   = "          Tu n'as rien oublie";
char texte8[]   = "            Essaye encore!";
char texte9[]   = "        Continue dans cette voie";
char texte10[]  = "Si tu veux etre apprecie meurs ou voyage";
char texte3[]   = {B00100000,B00100000,B00100000,B00100000,B00100000,B00100000,B00100000,B00100000,B00100000,B01010100,B01000101,B01010100,B01000001,B01010100,B01001100,B01000001,B01000010,B00100000,B00111010,B00100000,B01010111,B01000101,B00100000,B01001101,B01000001,B01001011,B01000101,B00100000,B01010000,B01001111,B01010010,B01001110};
int index = 0;
int i = 0;

boolean thesame1 = true;
boolean thesame1001 = true;
boolean thesame1002 = true;
boolean thesame1003 = true;
boolean thesame1004 = true;
boolean thesame1005 = true;
boolean thesame1006 = true;
boolean thesame1007 = true;
boolean thesame1008 = true;
boolean thesame1009 = true;
boolean thesame1010 = true;
int led = 13;


void setup()
{



  Serial.begin(9600);
  Serial.println("coucou");
  pinMode(led, OUTPUT);     
  mySerial.begin(1200);
  mySerial.print(12,BYTE);
  pinMode(6, OUTPUT);     
  pinMode(5, OUTPUT);     
  pinMode(4, OUTPUT);     
  pinMode(3, OUTPUT);     

  digitalWrite(3, LOW);   // set the LED on
  digitalWrite(4, LOW);   // set the LED on
  digitalWrite(5, LOW);   // set the LED on
  digitalWrite(6, LOW);   // set the LED on



}

/*
 * get a keycode from the kbd and report back to the
 * host via the serial line.
 */
void loop()
{
  unsigned char code;
  for (;;)
  { /* ever */
    code = kbd.read();
    /* send the data back up */
    codebar [index] = code;
    index++;
    i = 0;
    Serial.print(code,DEC);
    Serial.print(",");

    if (code == 156 ) 
    {
      Serial.println("go");
      while (i<index)
      {
        //    if (codebar[i] != fortune1[i]) thesame1 = false;
        if (codebar[i] != code1001[i]) 
        {
          //        Serial.println("");
          //        Serial.print("Comparaison pas bonne entre ");
          //        Serial.print(codebar[i],DEC);
          //        Serial.print(" et ");
          //        Serial.print(code1001[i],DEC);
          //        Serial.print(" a l index ");
          //        Serial.println(i);
          thesame1001 = false;
        }         



        if (codebar[i] != code1002[i]) thesame1002 = false;
        if (codebar[i] != code1003[i]) thesame1003 = false;
        if (codebar[i] != code1004[i]) thesame1004 = false;
        if (codebar[i] != code1005[i]) thesame1005 = false;
        if (codebar[i] != code1006[i]) thesame1006 = false;
        if (codebar[i] != code1007[i]) thesame1007 = false;
        if (codebar[i] != code1008[i]) thesame1008 = false;
        if (codebar[i] != code1009[i]) thesame1009 = false;
        if (codebar[i] != code1010[i]) thesame1010 = false;
        int a = 0;

        if (codebar[i] == 156)
        {


          if (thesame1001)
          {
            serialprint7(12);
            serialprint7(7);
            serialprint7(bas);
            serialprint7(bas);
            serialprint7(bas);
            serialprint7(bas);
            serialprint7(bas);
            serialprint7(bas);
            serialprint7(bas);
            serialprint7(bas);
            serialprint7(bas);
            serialprint7(bas);

            for (a=0;a<sizeof(texte1);a++)
            {
              serialprint7(texte1[a]);
            }

            Serial.println("code 1001");
            digitalWrite(3, HIGH);   // set the LED on
            digitalWrite(4, LOW);   // set the LED on
            digitalWrite(5, LOW);   // set the LED on
            digitalWrite(6, LOW);   // set the LED on


          }

          if (thesame1002)
          {
            serialprint7(12);
            serialprint7(7);
            serialprint7(bas);
            serialprint7(bas);
            serialprint7(bas);
            serialprint7(bas);
            serialprint7(bas);
            serialprint7(bas);
            serialprint7(bas);
            serialprint7(bas);
            serialprint7(bas);
            serialprint7(bas);

            Serial.println("code 1002");
            for (a=0;a<sizeof(texte2);a++)
            {
              serialprint7(texte2[a]);
            }
            digitalWrite(3, LOW);   // set the LED on
            digitalWrite(4, HIGH);   // set the LED on
            digitalWrite(5, LOW);   // set the LED on
            digitalWrite(6, LOW);   // set the LED on
          }


          if (thesame1003)   
          {
            Serial.println("code 1003");
            serialprint7(12);
            serialprint7(7);
            serialprint7(bas);
            serialprint7(bas);
            serialprint7(bas);
            serialprint7(bas);
            serialprint7(bas);
            serialprint7(bas);
            serialprint7(bas);
            serialprint7(bas);
            serialprint7(bas);
            serialprint7(bas);

            for (a=0;a<sizeof(texte3);a++)
            {
              serialprint7(texte3[a]);
            }
            
			
			
			
			
			
			
			digitalWrite(3, HIGH);   // set the LED on
            digitalWrite(4, HIGH);   // set the LED on
            digitalWrite(5, LOW);   // set the LED on
            digitalWrite(6, LOW);   // set the LED on
          }
          if (thesame1004)
          {
            digitalWrite(3, LOW);   // set the LED on
            digitalWrite(4, LOW);   // set the LED on
            digitalWrite(5, HIGH);   // set the LED on
            digitalWrite(6, LOW);   // set the LED on
            serialprint7(12);
            serialprint7(7);
            
            serialprint7(bas);
            serialprint7(bas);
            serialprint7(bas);
            serialprint7(bas);
            serialprint7(bas);
            serialprint7(bas);
            serialprint7(bas);
            serialprint7(bas);
            serialprint7(bas);
            serialprint7(bas);
            
            
            
            Serial.println("code 1004");
            for (a=0;a<sizeof(texte4);a++)
            {
              serialprint7(texte4[a]);
            }

          }
          if (thesame1005)
          {

            digitalWrite(3, HIGH);   // set the LED on
            digitalWrite(4, LOW);   // set the LED on
            digitalWrite(5, HIGH);   // set the LED on
            digitalWrite(6, LOW);   // set the LED on
            serialprint7(12);
            serialprint7(7);
            serialprint7(bas);
            serialprint7(bas);
            serialprint7(bas);
            serialprint7(bas);
            serialprint7(bas);
            serialprint7(bas);
            serialprint7(bas);
            serialprint7(bas);
            serialprint7(bas);
            serialprint7(bas);

            Serial.println("code 1005");
            for (a=0;a<sizeof(texte5);a++)
            {
              serialprint7(texte5[a]);
            }

          }
          if (thesame1006) 
          {
            digitalWrite(3, LOW);   // set the LED on
            digitalWrite(4, HIGH);   // set the LED on
            digitalWrite(5, HIGH);   // set the LED on
            digitalWrite(6, LOW);   // set the LED on
            serialprint7(12);
            serialprint7(7);
            serialprint7(bas);
            serialprint7(bas);
            serialprint7(bas);
            serialprint7(bas);
            serialprint7(bas);
            serialprint7(bas);
            serialprint7(bas);
            serialprint7(bas);
            serialprint7(bas);
            serialprint7(bas);

            Serial.println("code 1006");
            for (a=0;a<sizeof(texte6);a++)
            {
              serialprint7(texte6[a]);
            }
          }
          if (thesame1007)
          {
            digitalWrite(3, HIGH);   // set the LED on
            digitalWrite(4, HIGH);   // set the LED on
            digitalWrite(5, HIGH);   // set the LED on
            digitalWrite(6, LOW);   // set the LED on
            serialprint7(12);
            serialprint7(7);
            serialprint7(bas);
            serialprint7(bas);
            serialprint7(bas);
            serialprint7(bas);
            serialprint7(bas);
            serialprint7(bas);
            serialprint7(bas);
            serialprint7(bas);
            serialprint7(bas);
            serialprint7(bas);

            Serial.println("code 1007");
            for (a=0;a<sizeof(texte7);a++)
            {
              serialprint7(texte7[a]);
            }
          }
          if (thesame1008) 
          {
            digitalWrite(3, LOW);   // set the LED on
            digitalWrite(4, LOW);   // set the LED on
            digitalWrite(5, LOW);   // set the LED on
            digitalWrite(6, HIGH);   // set the LED on
            serialprint7(12);
            serialprint7(7);
            serialprint7(bas);
            serialprint7(bas);
            serialprint7(bas);
            serialprint7(bas);
            serialprint7(bas);
            serialprint7(bas);
            serialprint7(bas);
            serialprint7(bas);
            serialprint7(bas);
            serialprint7(bas);

            Serial.println("code 1008");
            for (a=0;a<sizeof(texte8);a++)
            {
              serialprint7(texte8[a]);
            }
          }
          if (thesame1009)
          {
            digitalWrite(3, HIGH);   // set the LED on
            digitalWrite(4, LOW);   // set the LED on
            digitalWrite(5, LOW);   // set the LED on
            digitalWrite(6, HIGH);   // set the LED on
            serialprint7(12);
            serialprint7(7);
            serialprint7(bas);
            serialprint7(bas);
            serialprint7(bas);
            serialprint7(bas);
            serialprint7(bas);
            serialprint7(bas);
            serialprint7(bas);
            serialprint7(bas);
            serialprint7(bas);
            serialprint7(bas);

            Serial.println("code 1009");
            for (a=0;a<sizeof(texte9);a++)
            {
              serialprint7(texte9[a]);
            }
          }
          if (thesame1010)
          {
            digitalWrite(3, LOW);   // set the LED on
            digitalWrite(4, HIGH);   // set the LED on
            digitalWrite(5, LOW);   // set the LED on
            digitalWrite(6, HIGH);   // set the LED on
            serialprint7(12);
            serialprint7(7);
            serialprint7(bas);
            serialprint7(bas);
            serialprint7(bas);
            serialprint7(bas);
            serialprint7(bas);
            serialprint7(bas);
            serialprint7(bas);
            serialprint7(bas);
            serialprint7(bas);
            serialprint7(bas);

            Serial.println("code 1010");
            for (a=0;a<sizeof(texte10);a++)
            {
              serialprint7(texte10[a]);
            }
          }
          if (!thesame1001 &&!thesame1002 &&!thesame1003 &&!thesame1004 &&!thesame1005 &&!thesame1006 &&!thesame1007 &&!thesame1008 &&!thesame1009 &&!thesame1010) Serial.println("inconnu !!!");









          //          delay(1000);  
        }      
        i++;
      }
      index = 0;
      thesame1001 = true;
      thesame1002 = true;
      thesame1003 = true;
      thesame1004 = true;
      thesame1005 = true;
      thesame1006 = true;
      thesame1007 = true;
      thesame1008 = true;
      thesame1009 = true;
      thesame1010 = true;
    }
  }
}

void serialprint7(byte bite)
{
  boolean  i = false;
  for(int j = 0; j<8;j++)
  {
    if (bitRead(bite,j)==1) i =!i;
  }

  if (i) bitWrite(bite,7,1);
  else bitWrite(bite,7,0);
  mySerial.print(bite);
}




