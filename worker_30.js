var bgm;

var worker;
var bg;
var loaded;

function preload()
{
	worker=new Animation("animation/worker_",50);
	bg=new Slide("photo/rodong_");
	bgm=loadSound("source/sagye.mp3");
}

function setup()
{
	createCanvas(windowWidth,windowHeight);
	background(255);
	frameRate(28.54167);
	bgm.play();
	loaded=millis();
}

function draw()
{
	background(255);
	bg.display();
	worker.display(width/2-190,height-500);
	if(millis()>123000+loaded) noLoop();
}

function Animation(prefix, count)
{
	this.sprite=[];
	this.imageCount=count;
	for(var i=0;i<this.imageCount;i++)
	{
		var filename=prefix+(i+1)+".png";
		this.sprite[i]=loadImage(filename);
	}
	this.frame=0;
	this.display=function(x,y)
	{
		this.frame=(this.frame+1)%this.imageCount;
		image(this.sprite[this.frame],x,y);
	}
}

function Slide(prefix)
{
	this.sprite=[];
	this.imageCount=15;
	this.cutFrames=[0,4747,11721,18727,25734,34144,49738,56253, 63297,70653,79869,94023,100824,108214,111717,115256,121000];
	this.frame=-1;
	this.bef=0;
	this.aft=this.cutFrames[0];
	for(var i=0;i<this.imageCount;i++)
	{
		var filename=prefix+(i+1)+".jpg";
		this.sprite[i]=loadImage(filename);
		var p=loadImage(filename);
		var resol=this.sprite[i].width*1.0/this.sprite[i].height;
		var canvasRes=width*1.0/height;
		console.log(this.sprite[i].width, this.sprite[i].height, resol, canvasRes, p.width);
		if(resol>canvasRes) this.sprite[i].resize(int(height*resol),height);
		else this.sprite[i].resize(width,int(width/resol));
	}
	this.display=function()
	{
		if(millis()-loaded>this.aft)
		{
			this.frame++;
			this.bef=this.aft;
			this.aft=this.cutFrames[this.frame+1];
		}
		if(this.frame>=0)
		{
			image(this.sprite[this.frame],(width-this.sprite[this.frame].width)/2,(height-this.sprite[this.frame].height)/2)
		}
	}
}
