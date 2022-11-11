#include <Servo.h>

const int pinoPOT = A5;

Servo servo1;

int ang;

float angulo = 0;

void setup() {
  Serial.begin(9600);

  pinMode(pinoPOT, INPUT);

  servo1.attach(50);
  ang = 0;

  servo1.write(ang);

}

void loop() {
  int potencio = 0;
  angulo = map(analogRead(pinoPOT), 0, 1023, 0, 300);
  //Serial.println(angulo);

  if(Serial.available()){
    int teste = Serial.parseInt();
    //String teste2 = Serial.readStringUntil("\n");

    Serial.write((char)teste);
    //Serial.print(teste + "\n");

    ang = map(teste, 0, 179, 0, 180);
    servo1.write(ang);

  }
  potencio = map(analogRead(pinoPOT), 0, 1023, 0, 255);
  //Serial.println(potencio);
  //delay(1000);
}




/* 

#include <Servo.h>

#define pinoPOT A5

Servo servo1;

int ang;

void setup() {
  Serial.begin(9600);

  servo1.attach(50);
  ang = 0;

  servo1.write(ang);

}

void loop() {
  ang = map(analogRead(pinoPOT), 0, 1023, 0, 180);
  servo1.write(ang);
  delay(100);

}

 
*/
