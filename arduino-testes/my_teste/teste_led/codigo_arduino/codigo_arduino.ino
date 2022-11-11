
#define LED_D13 13  // led integrado na placa - pino D13

void setup() {
  Serial.begin(9600);
  pinMode(10, OUTPUT);
}

void loop() {
  int teste = 0;

  if (Serial.available()) {
    teste = Serial.read();
  }


  if (teste == 49) {
    digitalWrite(10, HIGH);  // liga o Led
  } else if (teste == 48){
    digitalWrite(10, LOW);   // desliga o Led
  }
}
