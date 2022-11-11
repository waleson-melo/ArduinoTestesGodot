/* Programa de teste do Arduino Mega 2560
  Blog Eletrogate -https://blog.eletrogate.com/guia-completo-do-arduino-mega/
  Arduino UNO - IDE 1.8.5
  Gustavo Murta   17/agosto/2018
  Baseado em https://www.arduino.cc/en/Tutorial/Blink
*/

#define LED_D13 13  // led integrado na placa - pino D13

void setup() {
  Serial.begin(9600);
  pinMode(LED_D13, OUTPUT);  // configura pino Led_D13 como saída
}

void loop() {
  int teste = 0, teste2 = 2;
  if (Serial.available()) {
    teste = Serial.read();
    Serial.println(teste);
  }

  if (teste == 49) {
    digitalWrite(LED_D13, HIGH);  // liga o Led
    delay(1000);                  // aguarda um segundo
    digitalWrite(LED_D13, LOW);   // desliga o Led
    delay(1000);                  // aguarda um segundo

    digitalWrite(LED_D13, HIGH);  // liga o Led
    delay(1000);                  // aguarda um segundo
    digitalWrite(LED_D13, LOW);   // desliga o Led
    delay(1000);                  // aguarda um segundo

    digitalWrite(LED_D13, HIGH);  // liga o Led
    delay(1000);                  // aguarda um segundo
    digitalWrite(LED_D13, LOW);   // desliga o Led
    delay(1000);                  // aguarda um segundo
  }
}