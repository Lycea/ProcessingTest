


function setup() 
{
	
	createCanvas(400,400);
	colorMode(HSL,360,100,100);
	start_radius = (width+height)/2

	if(stable == false)
	{
		return
	}

	for(var i=0;i< num_bubbles;i++)
	{
		bubbles.push(newBubble())
	}

	noStroke()
}

var bubbles =[]

var stable = false
var num_bubbles = 100


var start_radius=0

function newBubble()
{
	tmp=[]//tmp bubble

	
	tmp.angle = random(0,3600)/10
	tmp.color = random(0,1800)/10
	tmp.speed = random(1,3)
	tmp.size  = random(10,20)

	tmp.spin = random(-1,1)
	if(stable)
	{
		tmp.rad = random(tmp.size,start_radius)
	}
	else
	{
		tmp.rad = start_radius
	}


	return tmp
}

function draw()
{
	if(stable)
	{
		background(0)
		
		for(var idx = bubbles.length-1;idx>0;idx--)
		{	
			var x = bubbles[idx].rad*sin(radians( bubbles[idx].angle))+width/2
			var y = bubbles[idx].rad*cos(radians( bubbles[idx].angle))+height/2
			
			stroke(bubbles[idx].color,50,50)
			fill(bubbles[idx].color,50,50,0.25)

			ellipse(x, y, bubbles[idx].size, bubbles[idx].siz)
		}
	}
	else
	{
		background(0,0.05)
		var new_bubbles = floor(random(0, 100)/100*1.5) 
		for(var i=0;i<new_bubbles;i++)
		{
			bubbles.push(newBubble())
		}
		//print(thing)
		
		for(var idx = bubbles.length-1;idx>0;idx--)
		{	
			bubbles[idx].angle +=bubbles[idx].spin * bubbles[idx].speed
			bubbles[idx].rad-=bubbles[idx].speed
			

			var x = bubbles[idx].rad*sin(radians( bubbles[idx].angle))+width/2
			var y = bubbles[idx].rad*cos(radians( bubbles[idx].angle))+height/2
			
			stroke(bubbles[idx].color,50,50)
			fill(bubbles[idx].color,50,50,0.25)
			if(bubbles[idx].rad <=bubbles[idx].size/2)
			{
				bubbles.splice(idx,1)
				continue
			}
			ellipse(x, y, bubbles[idx].size, bubbles[idx].siz)
		}
	}

}