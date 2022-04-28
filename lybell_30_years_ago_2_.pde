import processing.sound.*;
SoundFile bgm;

Animation worker;
Slide bg;
int loaded;

void setup()
{
  size(1366,768);
  background(255);
  textAlign(CENTER);
  fill(0);
  text("LOADING...",width/2,height/2);
  frameRate(28.54167);
  worker=new Animation("animation/worker_",50);
  bg=new Slide("photo/rodong_");
  bgm=new SoundFile(this,"source/sagye.mp3");
  bgm.play();
  bgm.jump(1);
  loaded=millis();
}
void draw()
{
  background(255);
  bg.display();
  worker.display(width/2-190,height-500);
//  println(frameRate);
  if(millis()>123000+loaded) exit();
}

class Animation
{
  PImage[] sprite;
  int imageCount;
  int frame;
  Animation(String prefix, int count)
  {
    imageCount=count;
    sprite=new PImage[imageCount];
    for(int i=0;i<imageCount;i++)
    {
      String filename=prefix+(i+1)+".png";
      sprite[i]=loadImage(filename);
    }
  }
  void display(float x, float y)
  {
    frame=(frame+1)%imageCount;
    image(sprite[frame],x,y);
  }
}

class Slide
{
  PImage[] sprite;
  int imageCount;
  int[] cutFrames={0,4747,11721,18727,25734,34144,49738,56253,
  63297,70653,79869,94023,100824,108214,111717,115256,121000};
  int frame;
  int bef, aft;
  Slide(String prefix)
  {
    imageCount=15;
    sprite=new PImage[imageCount];
    for(int i=0;i<imageCount;i++)
    {
      String filename=prefix+(i+1)+".jpg";
      sprite[i]=loadImage(filename);
      println(sprite[i].width,sprite[i].height);
      float resol=sprite[i].width*1.0/sprite[i].height;
      float canvasRes=width*1.0/height;
      if(resol>canvasRes) sprite[i].resize(int(height*resol),height);
      else sprite[i].resize(width,int(width/resol));
      println(sprite[i].width,sprite[i].height);
    }
    bef=0;
    aft=cutFrames[0];
    frame=-1;
  }
  void display()
  {
    if(millis()-loaded>aft)
    {
      frame++;
      bef=aft;
      aft=cutFrames[frame+1];
    }
    if(frame>=0)
    {
      image(sprite[frame],(width-sprite[frame].width)/2,(height-sprite[frame].height)/2);
    }
  }
}
