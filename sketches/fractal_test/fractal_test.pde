var size=5
var max_iter= 150

function setup() 
{
	max_iter = 150
	size =5
	createCanvas(400,400);
	colorMode(HSL,360,100,100);
	noLoop()
}


function draw()
{
  for(var y=0;y<floor(height/size);y++)
  { 

	  //print("test")
	  for(var x=0;x<floor(width/size);x++)
	  {
		  real=y*15
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
		var light = map(tries,0,max_iter,0,1)
		light = map(sqrt(light), 0, 1, 0, 255);
		fill(light,light,light)
		//print(x+" "+y)
		rect(x*size,y*size,size,size)
	  }
  }

}