
int pushbutton1 = 8;
int flag_btn_1 = 0;

void setup(){
  Serial.begin(500000);
  pinMode(pushbutton1, INPUT_PULLUP);

}

void loop(){
  // Button 1
  if(deBounce(flag_btn_1, pushbutton1) == LOW){
    if(flag_btn_1 == 0){
      Serial.write("apertando\n");

    }
    flag_btn_1 = 1;
    
  }

  if(flag_btn_1 == 1 && deBounce(flag_btn_1, pushbutton1) == HIGH){
    Serial.write("soltando\n");
    flag_btn_1 = 0;

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