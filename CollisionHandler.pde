class CollisionHandler
{
  PVector detectCollision(PShape shape1, PShape shape2)
  {
    float magnitude = 999999;
    PVector direction = new PVector();
    ArrayList<PVector> axes = new ArrayList<PVector>();
    axes.addAll(getAxes(shape1));
    axes.addAll(getAxes(shape2));
    
    for(int i = 0; i < axes.size(); ++i)
    {
      PVector axis = axes.get(i);
      
      PVector p1 = project(shape1, axis);
      PVector p2 = project(shape2, axis);
      
      if(isOverlap(p1, p2))
      {
        float overlap = getOverlap(p1, p2);
        
        if(overlap < magnitude)
        {
          magnitude = overlap;
          direction = axis;
        }
      }
      else
      {
        return null;
      }
    }
    
    return direction.mult(magnitude);
  }
  
  ArrayList<PVector> getAxes(PShape shape)
  {
    ArrayList<PVector> axes = new ArrayList<PVector>();
    
    for(int i = 0; i < shape.getVertexCount(); ++i)
    {
      PVector v1 = shape.getVertex(i);
      PVector v2 = shape.getVertex(i + 1 == shape.getVertexCount() ? 0 : i + 1);
      PVector edge = v2.sub(v1);
      PVector axis = new PVector(-edge.y, edge.x);
      axis.normalize();
      axes.add(axis);
    }
    
    return axes;
  }
  
  PVector project(PShape shape, PVector axis)
  {  
    float min = axis.dot(shape.getVertex(0));
    float max = min;
    
    for(int i = 1; i < shape.getVertexCount(); ++i)
    {
      float projection = axis.dot(shape.getVertex(i));
      
      if(projection < min)
      {
        min = projection;
      }
      else if(projection > max)
      {
        max = projection;
      }
    }
    
    return new PVector(min, max);
  }
  
  boolean isOverlap(PVector p1, PVector p2)
  {
    return p1.x < p2.y && p1.y > p2.x;
  }
  
  float getOverlap(PVector p1, PVector p2)
  {
    return p1.x < p2.y ? p1.y - p2.x : p2.y - p1.x;
  }
}