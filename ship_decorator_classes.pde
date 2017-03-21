class ShipDecorator extends Ship{
  Ship decoratedShip;
  
  ShipDecorator(Ship set){
    decoratedShip = set;
  }
  
  public void render(){
    decoratedShip.render();
  }
  
  public void update(float dt){
    decoratedShip.update(dt);
  }
  
   Weapon getWeapon(){
    return decoratedShip.getWeapon();
  }
  
  Controller getController(){
    return decoratedShip.getController();
  }
  
  void setSize(PVector setSize){
    decoratedShip.setSize(setSize);
  }
  
  PVector getSize(){
     return decoratedShip.getSize();
   }
  
  PVector getPos(){
     return decoratedShip.getPos();
   }
   
  void setSprite(PImage set){
     decoratedShip.setSprite(set);
   }
   
   boolean getRemove(){
     return decoratedShip.getRemove();
   }
   
  void setHp(int hitpoints){
    decoratedShip.setHp(hitpoints);
  }
  
  int getHp(){
    return decoratedShip.getHp();
   }
}

class MakeBig extends ShipDecorator{
  PVector pos;
  PVector size;
  boolean selected = false;
  
  MakeBig(Ship set){
    super(set);
    HP = 10;
    setSize(new PVector(getSize().x*2,getSize().y*2));
    setSprite(loadImage("Player.png"));
    //setSprite(new PImage((int)getSize().x,(int)getSize().y));
  }
}