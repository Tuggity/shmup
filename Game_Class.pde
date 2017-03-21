//Main game loop, where you shoot the enemyships

class Game extends ScreenObject {
  GUI gui;
  
  Level currentLevel;
  Ship player1;

  PImage playerSprite = loadImage("Player.png");
  PImage minion = loadImage("Minion.png");
  
  
  ArrayList<GameObject> gameObjects = new ArrayList<GameObject>();
  ArrayList<GameObject> shipObjects = new ArrayList<GameObject>();
  
  Game(){
    
    player1 = new Player(player1Controller, new BasicPlayerWeapon(new PVector(), new PVector(0, 5), new PVector()), playerSprite);
    player1.getWeapon().setWeaponOffset(player1.getSize());
    playerSprite.resize(88,112);

    Ship bar = new BasicEnemy(new BasicEnemyController(player1.getPos()), width-101, 0, minion);
    
    //gameObjects.add(foo);
    shipObjects.add(bar);
    currentLevel = new Level(player1, shipObjects, gameObjects);
  }

  void update(float dt) {
    boolean hit = false;
    player1.shipColor = color(0, 0, 0);

    player1.update(dt);
    for (int i = gameObjects.size() - 1; i >= 0; i--) {
      GameObject obj = gameObjects.get(i);
      obj.update(dt);

      if (obj.collision(player1) && !obj.friendly) {
        obj.effect(player1);
        hit = true;
        obj.remove = true;
      }

      //placeholder code, register if ship is hit
      if (hit) {
        player1.shipColor = color(255, 0, 0);

         if(player1.getHp() <=0){
           currentLevel.levelComplete = true;
           screenController = new StartButton(new QuitButton(new Menu(player1Controller), 100, 350), 100, 175);
         }

      } else {
        player1.shipColor = color(0, 0, 0);
      }

      if (obj.remove) {
        gameObjects.remove(i);
      }
    }
    for (int i = shipObjects.size() - 1; i >= 0; i--) {
      GameObject obj = shipObjects.get(i);
      obj.update(dt);

      if (obj.collision(gameObjects)) {
        obj.remove = true;
      }

      if (obj.remove) {
        shipObjects.remove(i);
      }
    }
    currentLevel.update(dt);

    if (currentLevel.levelComplete == true) {

      gameObjects.clear();
      shipObjects.clear();

      currentLevel = currentLevel.nextLevel(player1, shipObjects, gameObjects);
    }
  }

  
  void render(){
    background(0);

    currentLevel.render();
    for (int i = gameObjects.size() - 1; i >= 0; i--) {
      GameObject obj = gameObjects.get(i);
      obj.render();
    }
    for (int i = shipObjects.size() - 1; i >= 0; i--) {
      GameObject obj = shipObjects.get(i);
      obj.render();
    }

    player1.render();
  }
}