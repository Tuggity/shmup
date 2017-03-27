class GameObject extends ScreenObject{
   boolean remove = false;
   boolean friendly = false;
  
   PVector pos;
   PVector size;
   
   PVector dir;
   
   float speed;
      
   float getX(){
     return pos.x;
   }
   float getY(){
     return pos.y;
   }
   void setX(float x){
     pos.x = x;
   }
   void setY(float y){
     pos.y = y;
   }
   void setPos(PVector set){
     pos = set;
   }
   PVector getPos(){
     return pos;
   }
   PVector getSize(){
     return size;
   }
   
   PVector getDir(){
     return dir;
   }
   
   void setDir(PVector d){
     dir = d;
   }
   
   boolean getRemove(){
     return remove;
   }
   
   float getSpeed(){
     return speed;
   }
   void setSpeed(float s){
     speed = s;
   }
   
   boolean collision(GameObject obj){
     if (obj.getPos().x-obj.getSize().x/2 < this.getPos().x+this.getSize().x/2 && 
        obj.getPos().x+obj.getSize().x/2 > this.getPos().x-this.getSize().x/2 &&
        obj.getPos().y-obj.getSize().y/2 < this.getPos().y+this.getSize().y/2 && 
        obj.getPos().y+obj.getSize().y/2 > this.getPos().y-this.getSize().y/2){
    
        return true;
     }
     return false;
   }
   
   boolean collision(ArrayList<GameObject> gameObjects){
     for (int i = gameObjects.size() - 1; i >= 0; i--) {
       GameObject obj = gameObjects.get(i);
       if (obj.friendly && obj.getPos().x-obj.getSize().x/2 < this.getPos().x+this.getSize().x/2 && 
          obj.getPos().x+obj.getSize().x/2 > this.getPos().x-this.getSize().x/2 &&
          obj.getPos().y-obj.getSize().y/2 < this.getPos().y+this.getSize().y/2 && 
          obj.getPos().y+obj.getSize().y/2 > this.getPos().y-this.getSize().y/2){
      
        obj.remove = true;
        return true;
       }
     }
     return false;
   }
   
   void effect(Ship target){
   }
}

class Ship extends GameObject{
  int HP;
  PImage sprite;
  
  Controller controller;
  Weapon weapon;
  
  color shipColor = color(0, 0, 0);
  
  Ship(){
  }
  
  Ship(Controller setController, float setX, float setY){
    controller = setController;
    sprite = new PImage(40,30);
    
    pos = new PVector(setX, setY);
    dir = new PVector(0, 0);
    size = new PVector(sprite.width, sprite.height);
    
    weapon = new Weapon(pos);
    
    setSpeed(1);
  }
  
  //placeholder constructer, player ship should be a subclass of ship
  Ship(Controller setController, String type){
    controller = setController;
    sprite = new PImage(40,30);
    
    pos = new PVector(0, 0);
    dir = new PVector(0, 0);
    size = new PVector(sprite.width, sprite.height);
    setSpeed(1);
    
    if (type == "player"){
       setSpeed(10);
       setHp(10);
       
       pos = new PVector(width/2, height-100);
       weapon = new BasicPlayerWeapon(pos, new PVector(0, 5), new PVector());
    } 
  }
  
  

  Ship(Controller setController, Weapon setWeapon){
    controller = setController;
    sprite = new PImage(40,30);
    
    pos = new PVector(0, 0);
    dir = new PVector(0, 0);
    size = new PVector(sprite.width, sprite.height);
    
     weapon = setWeapon;
    
    setSpeed(1);
  }
  
  void update(float dt){
    setDir(controller.getDir());
    

    //fire
    if (controller.getSTATE() == 1){
      getWeapon().fire();
    }
    
    if (controller.getSTATE() == 0){
      getWeapon().ceaseFire();
    }
    
    //move ship
    setX(getX()+getDir().x*getSpeed());
    setY(getY()+getDir().y*getSpeed());
    
    getController().update(getPos());
    
    weapon.update(dt);
  }
  
  void render(){
    size = new PVector(sprite.width, sprite.height);
    fill(shipColor);
    rectMode(CENTER);
    rect(getX(),getY(),sprite.width, sprite.height);
    //image(sprite, getX(), getY()); 
  }
  
  Controller getController(){
    return controller;
  }
  
  Weapon getWeapon(){
    return weapon;
  }
  
  void setSize(PVector setSize){
    size = setSize;
  }
  
  void setSprite(PImage set){
     sprite = set;
   }
   
     void setHp(int hitpoints){
    HP += hitpoints;
  }
  
  int getHp(){
    return HP;
   }
}



//--------------------------------------------------



class BasicEnemy extends Ship {
  
   BasicEnemy(Controller setController, float setX, float setY, PImage setSprite){
    controller = setController;
    sprite = setSprite;
    
    //loadImage("Minion.png");
    
    pos = new PVector(setX, setY);
    dir = new PVector(0, 0);
    size = new PVector(sprite.width, sprite.height);
    
    weapon = new Weapon(pos);
    
    setSpeed(1);
  }
 
  BasicEnemy(Controller setController, Weapon setWeapon, float setX, float setY, PImage setSprite) {
    controller = setController;
    weapon = setWeapon;
    pos = new PVector(setX, setY);
    sprite = setSprite;
    size = new PVector(sprite.width, sprite.height);
    
    setSpeed(1);
  }
  
  void render(){
    image(sprite, getPos().x, getPos().y);
  }
}

class Player extends Ship {
 PVector weaponOffset;
  Player(Controller setController, Weapon setWeapon, PImage setSprite) {
    controller = setController;
    sprite = setSprite;
    weapon = setWeapon;
    setSpeed(10);
    setHp(10);
       
    pos = new PVector(width/2, height-100);
    //weapon = new BasicPlayerWeapon(pos, new PVector(0, 5));
    size = new PVector(sprite.width*0.2, sprite.height*0.6);
    weaponOffset = new PVector(0,50);
    
    weapon.setOrigin(pos);
  }
  
  void render(){
    image(sprite, getPos().x, getPos().y);
  }
  void setX(float x){
   if(x>5&&x<width-5){
      pos.x = x;
     }else if(x<5){
     pos.x=6;
     }else{
     pos.x=width-6;
     }
   }
   
   void setY(float y){
     if(y>5&&y<height-5){
       pos.y = y;
       }else if(y<5){
       pos.y=6;
     }else{
       pos.y=height-6;
     }
  }
}