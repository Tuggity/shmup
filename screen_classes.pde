class ScreenObject {
  public void render(){
  }
  
  public void update(float dt){
    
  }
}

class Menu extends ScreenObject{
  Controller controller;
  float timer;
  
  Menu(){
  }
  
  Menu(Controller setController){
    controller = setController;
  }
  
  void render(){
    //Skifter baggrundsfarve på menuen
    timer += dt;
    if(timer>0.017*15){
    background(random(255),random(255),random(255));
    timer=0;
  }
  }
  
  void update(float dt){
  }
  
  Controller getController(){
    return controller;
  }
}

class MenuDecorator extends Menu{
  Menu decoratedMenu;
  
  MenuDecorator(Menu set){
    decoratedMenu = set;
  }
  
  public void render(){
    decoratedMenu.render();
  }
  
  public void update(float dt){
    decoratedMenu.update(dt);
  }
  
  Controller getController(){
    return decoratedMenu.getController();
  }
}

class QuitButton extends MenuDecorator{
  PVector pos;
  PVector size;
  boolean selected = false;
  
  QuitButton(Menu set, float setX, float setY){
    super(set);
    pos = new PVector(setX, setY);
    size = new PVector(500,125);
  }
  
  boolean overButton(){
    if (mouseX > pos.x && mouseX < pos.x + size.x && mouseY > pos.y && mouseY < pos.y + size.y)
      return true;
    return false; 
  }
  
  public void render(){
    super.render();
    if (selected)
      fill(255,0,0);
    else
      fill(255,100,100);
      
    rect(pos.x, pos.y, size.x, size.y);
  }
  
  public void update(float dt){
    super.update(dt);
    
    if (overButton()){
      selected = true;
      if (getController() != null) {
        if (getController().getSTATE() == 1){
          exit();
        }
      }
    } else {
      selected = false;
    }
  }
  
  Controller getController(){
    return super.getController();
  }
}

class StartButton extends MenuDecorator{
  PVector pos;
  PVector size;
  boolean selected = false;
  
  StartButton(Menu set, float setX, float setY){
    super(set);
    pos = new PVector(setX, setY);
    size = new PVector(500,125);
  }
  
  boolean overButton(){
    if (mouseX > pos.x && mouseX < pos.x + size.x && mouseY > pos.y && mouseY < pos.y + size.y)
      return true;
    return false; 
  }
  
  public void render(){
    super.render();
    if (selected)
      fill(0,255,0);
    else
      fill(100,255,100); 
      
    rect(pos.x, pos.y, size.x, size.y);
  }
  
  public void update(float dt){
    super.update(dt);
    
    if (overButton()){
      selected = true;
      if (getController() != null) {
        if (getController().getSTATE() == 1){
          currentGame = new Game();
          screenController = currentGame;
        }
      }
    } else {
      selected = false;
    }
  }
  
  Controller getController(){
    return super.getController();
  }
}

class GUI extends ScreenObject{
  PFont font;
  
  
  
  void render() {
    pushMatrix();
    fill(255);
    font = createFont("LDFComicSansLight.ttf", 50);
    textFont(font);
    text("HP " + currentGame.player1.HP, 50, 100);
    popMatrix();
  }
}

class SplashScreen extends ScreenObject {
  float timer = 0;
  PImage logo = loadImage("coin.jpg");
  
  public void render(){
    background(0);
    imageMode(CENTER);
    image(this.logo,width/2,height/2);
  }
  
  void update(float dt){
    timer+= dt;
    
    if (timer >= 5){
      Menu newMenu = new Menu(player1Controller);
      newMenu = new QuitButton(newMenu, 100, 350);
      newMenu = new StartButton(newMenu, 100, 175);
      
      screenController = newMenu;
    }
  }
}