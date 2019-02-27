function setup() 
{
	createCanvas(400,400,WEBGL);
	colorMode(HSL,360,100,100);
}

let rotation_x = 0;
let rotation_y = 0;
let rotation_z = 0;


function draw()
{
	background(40,0,0,0.5);

	for (i=0;i<10;i++)
	{
	fill(sin((rotation_x+rotation_y+rotation_z)/3*0.1)*350+i*10 ,50,50);
	
	push()
		translate(-width/2+30,-height/2+30)
		translate(i* 50,i*50,i*-10*sin(rotation_x))
		rotateX(rotation_x);
		rotateY(rotation_y);
		rotateZ(rotation_z);
		
		box(30);
	pop()

	push()
		translate(width/2-30,-height/2+30)
		translate(-i*50,i*50)
		rotateX(-rotation_x);
		rotateY(-rotation_y);
		rotateZ(-rotation_z);
		
		box(25);
	pop()

	rotation_x+=0.03/10;
	rotation_y+=0.05/10;
	rotation_z+=0.07/10;
	}
}