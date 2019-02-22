let points
let some_point


var num_seeds = 15
var runs = 100
var percent =0.6
var col = 0

function restart()
{
	points=[]

	some_point = createVector(random(width),random(height))
	for(i=0;i<num_seeds;i++)
	{
		let tmp =[]
		tmp = createVector(random(width),random(height))
		points.push(tmp)

		rect(tmp.x,tmp.y,2,2)
	}


}


function setup() 
{
	createCanvas(400,400);
	colorMode(HSL,360,100,100);

	restart()
}


function draw()
{
	
	for(i=1;i<runs;i++)
	{
		
		base =floor(random(points.length))
		
		stroke((360/num_seeds)*base,50,50,0.1)


		//stroke(points[base].dist(some_point),50,50) //distance to point
		some_point.lerp(points[base],percent)
		rect(some_point.x,some_point.y,0.5,0.5)
	}

	//col=(col+1)%360

}