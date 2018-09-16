CollisionHandler collisionHandler;
Polygon polygon1, polygon2;
boolean up, down, left, right, rotateLeft, rotateRight;

void setup()
{
  size(800, 600);
  
  collisionHandler = new CollisionHandler();
  
  polygon1 = new Polygon(new PVector(width / 2, height / 2), 4, 200, 140, radians(45));
  polygon2 = new Polygon(new PVector(width / 2, height / 2), 3, 200, 200, radians(90));
}

void draw()
{
  background(51);
  
  if(up)
  {
    polygon1.move(polygon1.position.x, polygon1.position.y -= 3);
  }
  
  if(down)
  {
    polygon1.move(polygon1.position.x, polygon1.position.y += 3);
  }
  
  if(left)
  {
    polygon1.move(polygon1.position.x -= 3, polygon1.position.y);
  }
  
  if(right)
  {
    polygon1.move(polygon1.position.x += 3, polygon1.position.y);
  }
  
  if(rotateLeft)
  {
    polygon1.rotate(-radians(1));
  }
  
  if(rotateRight)
  {
    polygon1.rotate(radians(1));
  }
  
  // Uncomment to auto rotate
  //polygon1.rotate(radians(1));
  //polygon2.rotate(radians(1));
  
  PVector mtv = collisionHandler.detectCollision(polygon1.shape, polygon2.shape);
  
  if(mtv != null)
  {
    polygon1.move(polygon1.position.x - mtv.x, polygon1.position.y - mtv.y);
    
    println("Collision detected");
    polygon1.setColour(color(0, 0, 255, 127));
    polygon2.setColour(color(255, 0, 0, 127));
  }
  else
  {
    println("No Collision");
    polygon1.setColour(color(255, 127));
    polygon2.setColour(color(255, 127));
  }

  polygon1.render();
  polygon2.render();
}

void keyPressed()
{
  switch(keyCode)
  {
    case UP:
    {
      up = true;
      break;
    }
    
    case DOWN:
    {
      down = true;
      break;
    }
    
    case LEFT:
    {
      left = true;
      break;
    }
    
    case RIGHT:
    {
      right = true;
      break;
    }
    
    case 'N':
    {
      rotateLeft = true;
      break;
    }
    
    case 'M':
    {
      rotateRight = true;
      break;
    }
  }
}

void keyReleased()
{
  switch(keyCode)
  {
    case UP:
    {
      up = false;
      break;
    }
    
    case DOWN:
    {
      down = false;
      break;
    }
    
    case LEFT:
    {
      left = false;
      break;
    }
    
    case RIGHT:
    {
      right = false;
      break;
    }
    
    case 'N':
    {
      rotateLeft = false;
      break;
    }
    
    case 'M':
    {
      rotateRight = false;
      break;
    }
  }
}