class Polygon
{
  PVector position;
  PShape shape;
  int w, h, halfW, halfH;
  color c;
  ArrayList<PVector> vertexOffsets;
  
  Polygon(PVector position, int numVertices, int w, int h, float rotation)
  {
    this.position = position;
    this.w = w;
    this.h = h;
    this.halfW = w / 2;
    this.halfH = h / 2;
    this.c = color(255);
    vertexOffsets = new ArrayList<PVector>();
    
    if(numVertices < 3) numVertices = 3;
    
    shape = createShape();
    shape.beginShape();
    shape.fill(255);
    shape.stroke(255);
    for(int i = 0; i < numVertices; ++i)
    {
      PVector vertex = new PVector(position.x + cos(rotation) * halfW, position.y + sin(rotation) * halfH);
      shape.vertex(vertex.x, vertex.y);
      rotation += TWO_PI / numVertices;
      
      PVector vertexOffset = vertex.sub(position);
      vertexOffsets.add(vertexOffset);
    }
    shape.endShape(CLOSE);
  }
  
  void move(float x, float y)
  {
    position.set(x, y);
    
    for(int i = 0; i < shape.getVertexCount(); ++i)
    {
      PVector vertexOffset = vertexOffsets.get(i);
      shape.setVertex(i, position.x + vertexOffset.x, position.y + vertexOffset.y);
    }
  }
  
  void rotate(float angle)
  {
    for(int i = 0; i < shape.getVertexCount(); ++i)
    {
      PVector vertexOffset = vertexOffsets.get(i);
      vertexOffset.rotate(angle);
      shape.setVertex(i, position.x + vertexOffset.x, position.y + vertexOffset.y);
    }
  }
  
  void setColour(color c)
  {
    this.c = c;
  }
  
  void render()
  {
    shape.setFill(c);
    shape(shape);
  }
}