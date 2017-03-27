class Bullet extends GameObject {
  Bullet() {
  }

  Bullet(PVector origin, float setSpeed) {
    size = new PVector(3, 3);
    setDir(new PVector(0, -1));

    setPos(new PVector(origin.x, origin.y));

    setSpeed(setSpeed);
  }

  // origin has to refenrence the ships pos!!!
  Bullet(PVector origin, float setSpeed, boolean isFriendly) {
    size = new PVector(3, 3);

    setDir(new PVector(0, -1));
    friendly = isFriendly;

    setPos(new PVector(origin.x, origin.y));

    setSpeed(setSpeed);
  }

  void update(float dt) {

    //move bullet
    setX(getX()+getDir().x*getSpeed());
    setY(getY()+getDir().y*getSpeed());

    if (getX() < 0 || getY() < 0 || getY() > height || getX() > width) {
      this.remove = true;
    }
  }

  void render() {
    fill(255, 0, 0);
    ellipse(getX(), getY(), getSize().x, getSize().y);
  }

  void effect(Ship target) {
    target.setHp(-1);
  }
}

class Weapon extends ScreenObject {
  PVector weaponOffset;
  boolean isShooting;
  PVector origin;
  PVector dir;
  int b = 0;

  Weapon(PVector setOrigin) {
    origin = setOrigin;
    dir = new PVector(0, -5);
  }
  
  void setWeaponOffset(PVector offset){
    weaponOffset.x = 0;
    weaponOffset.y = -offset.y/2;
    
    
  }

  Weapon(PVector setOrigin, PVector setDir) {
    origin = setOrigin;
    dir = setDir;
  }
  
  boolean fire() {

    isShooting = true;

    if (b == 10 || isShooting == false) {
      b = 0;
    }

    if (b == 0 && isShooting == true) {
      currentGame.gameObjects.add(new Bullet(origin, dir.y));
    }

    if (isShooting == true) {
      b++;
    }
    return isShooting;
  }

  boolean ceaseFire() {
    isShooting = false;
    return isShooting;
  }

  void update(float dt) {
    
  }

  void setOrigin(PVector set) {
    origin = set;
  }
}

class BasicPlayerWeapon extends Weapon {

  BasicPlayerWeapon(PVector setOrigin) {
    super(setOrigin);
  }

  BasicPlayerWeapon(PVector setOrigin, PVector setDir, PVector setOffset) {
    super(setOrigin, setDir);
    weaponOffset = setOffset;
  }
  boolean fire() {
    
    
    if (b >= 20 || isShooting == false) {
      currentGame.gameObjects.add(new Bullet(new PVector(origin.x + weaponOffset.x, origin.y + weaponOffset.y), dir.y, true));
      b=0;
    }
    
      b++;
 
    isShooting = true;
    return isShooting;
  }
}