var size=5
var max_iter= 150

function setup() 
{
	max_iter = 150
	size =5
	createCanvas(400,400);
	colorMode(RGB,255,255,255);
	noLoop()
}


function draw()
{
	noStroke()
  for(var y=0;y<floor(height/size);y++)
  { 

	  //print("test")
	  for(var x=0;x<floor(width/size);x++)
	  {
		  real=y/70.8
		  imagi= x/100
		  
		  cr = real
		  ci = imagi

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
		light_ = map(sqrt(bright), 0, 1, 0, 255);
		fill(light_,light_,light_)
		//print(x+" "+y)
		rect(x*size,y*size,size,size)
		
	  }
  }

}