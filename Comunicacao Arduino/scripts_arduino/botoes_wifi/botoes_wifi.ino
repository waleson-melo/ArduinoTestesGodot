#include <WiFi.h>

#define PIN_BUTTON 19
#define PIN_LED 23

const char *ssid = "redinha";
const char *pw = "12345678";

WiFiServer server(80);

int flag_btn = 0;

void setup() {
  pinMode(PIN_BUTTON, INPUT_PULLUP);
  pinMode(PIN_LED, OUTPUT);

  Serial.begin(9600);

  delay(1000);

  WiFi.begin(ssid, pw);

  while (WiFi.status() != WL_CONNECTED) {
    delay(1000);
  }

  Serial.println("Conectado");
  Serial.println(WiFi.localIP());
  server.begin();

}

void loop() {
  WiFiClient client = server.available();
  if (client) {
    while (client.connected()) {
      // Serial.println("Alguem esta conectado");
      if(deBounce(flag_btn, PIN_BUTTON) == LOW){
        if(flag_btn == 0){
          
        }
        // Serial.write("apertando\n");
        client.println("botao_pressionado");

        flag_btn = 1;
        
      }

      if(flag_btn == 1 && deBounce(flag_btn, PIN_BUTTON) == HIGH){
        //Serial.write("soltando\n");
        client.println("botao_liberado");
        flag_btn = 0;

      }

      while (client.available()) {
        String s = client.readStringUntil('\n');

        if (s == "ligar") {
          digitalWrite(PIN_LED, HIGH);
        } else if (s == "desligar") {
          digitalWrite(PIN_LED, LOW);
        }
      }

    }

  }

}


int deBounce(int state, int pin){
  int current_state = digitalRead(pin);

  if(state != current_state){
    delay(10);
    current_state = digitalRead(pin);

  }
  
  return current_state;
}
