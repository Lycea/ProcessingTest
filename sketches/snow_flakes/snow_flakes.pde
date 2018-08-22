function setup() 
{
	createCanvas(400,400);
	colorMode(HSL,360,100,100);
}

var flakes =[]


function iterate(val,idx,ar)
{
	var flake =flakes[idx];
	if(flake[1]>400)
	{
		flakes.splice(idx,1);
	}
	else
	{	
		ellipse(flake[0],flake[1],7,7);
		flakes[idx][1] += flake[2];
	}
	
}

function draw()
{	
	rect(0, 0, 400, 400);
	
	var num = floor(random(0,3));
	for (var i=0;i< num;i++) 
	{
		var x=random(10,390);
		flakes[flakes.length]=[x,0,random(1,3)];
	}

	flakes.forEach(iterate);
	print(flakes.length)

}