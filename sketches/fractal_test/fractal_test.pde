var size=1
var max_iter= 250
var ci = 0.8
var cr = 0

function setup() 
{
	max_iter = 100
	size =2

	ci = 0.156
	cr = -0.8
	createCanvas(400,400);
	colorMode(HSL,255,255,255);
	
}



function draw()
{

	var xoff = -200
	var yoff = -300


	var real_div  = 70.8
	var imagi_div = 100


	

	noStroke()
  for(var y=yoff;y<floor(height/size);y++)
  { 

	  //print("test")
	  for(var x=xoff;x<floor(width/size);x++)
	  {
		  real=y/real_div
		  imagi= x/imagi_div
		  
		 	//real = map(y,0,width,-0.5,0.5)
			//imagi = map(x,0,height,-0.5,0.5)
			

		  tries = 0

		  while(tries<max_iter)
		  {
			  //calculate (x²+c)
			  var real_adapted = real*real-imagi*imagi
			  var imagi_addapted = 2* real*imagi
			  
			  real = real_adapted+cr
			  imagi = imagi_addapted+ci
			  if(real*real +imagi*imagi > 16)
			  {
				  break
			  }
			  tries+=1
		  }
		var bright = map(tries,0,max_iter,0,1)
		light_ = map(sqrt(bright), 0, 1, 50, 160);
		fill(light_,255,255/2)
		//print(x+" "+y)
		rect(x*size-xoff,y*size-yoff,size,size)
		
	  }
  }

}


