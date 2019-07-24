function setup()
{
  createCanvas(400,400)
  colorMode(HSL,360,100,100);
  setFrameRate(30)
  noStroke()
  noLoop()
}

function point_on_circ(radius,angle,offset_x,offset_y)
{
	let x = radius*sin(radians(angle))+offset_x
	let y = radius*cos(radians(angle))+offset_y

	return createVector(x, y)
}



function curve_(from,to,chitter,angle,height,max_perc)
{
	
	stroke(20,100,50)
    mid =point_on_circ(height*max_perc,angle-180,to.x,to.y)

	chitter_off = point_on_circ(chitter,angle-90,mid.x,mid.y)
	//get the middle point
	
	
	//ellipse(chitter_off.x,chitter_off.y,5,5)

	
	
	stroke(160,100,50)
	curve(chitter_off.x,chitter_off.y, from.x,from.y, to.x, to.y, chitter_off.x, chitter_off.y)
}



/**
 * 
 * @param point_a "Left" point of the petal
 * @param point_b "Right" point of the petal
 * @param point_c "Middle" point of the petal
 * @param angle direction of the petal from the point
 * @param width most with of the petal
 * @param height most height of the petal
 */
function petal(point_a,point_b,point_c,angle,width,height,percentage_max)
{

   //stroke(160,100,50)
   //fill(255,50,50)
    
   mid_point = point_on_circ(height,angle,point_c.x,point_c.y) //the tip
   mid_height =point_on_circ(height*percentage_max,angle-180,mid_point.x,mid_point.y)

   chitter_left  = point_on_circ(-width,angle-90,mid_height.x,mid_height.y)
   chitter_right = point_on_circ(width,angle-90,mid_height.x,mid_height.y)

	beginShape()
		//start point
		curveVertex(point_a.x,point_a.y)
		curveVertex(point_a.x,point_a.y)

		curveVertex(chitter_left.x,chitter_left.y)
		curveVertex(mid_point.x,mid_point.y)
		curveVertex(chitter_right.x,chitter_right.y)

		curveVertex(point_b.x,point_b.y)
		curveVertex(point_b.x,point_b.y)

	endShape()

   /*ellipse(point_a.x,point_a.y,3,3)
   ellipse(point_b.x,point_b.y,3,3)
   ellipse(point_c.x,point_c.y,3,3)
   
   ellipse(mid_point.x, mid_point.y, 3, 3)*/

   
   //curve_(point_a,mid_point,-width,angle,height,percentage_max)
   //curve_(point_b,mid_point,width,angle,height,percentage_max)
   print("************")
}


function flower_layer(petals,width_,height_,angle_off,percentage_max)
{
	num_petals = petals
	let angle_offset = 0
	if(angle_off!= null)
	{
		angle_offset = angle_off
	}

	let angle_per =360/num_petals

	for(var i=0;i<num_petals;i++)
	{

		let left =point_on_circ(circ_rad,angle_per*i+angle_offset,width/2,height/2) 
		let right =point_on_circ(circ_rad,angle_per*(i+1)+angle_offset,width/2,height/2) 
		let mid =point_on_circ(circ_rad,angle_per*(i+0.5)+angle_offset,width/2,height/2) 

		
		petal(left,right,mid,angle_per*(i+0.5)+angle_offset,width_,height_,percentage_max)
		
		
	}

}



let circ_size = 20
let circ_rad = circ_size/2
function draw()
{
  
  background(0)


  for(let lay=0;lay<10;lay++)
  {
	fill((170+lay*20)%360,50,50,1)
	stroke((170+lay*20)%360,50,60,1)
	flower_layer(5,40/lay,150-lay*20,0+lay*10,0.5)

	fill((200+lay*20)%360,70,50,1)
	stroke((200+lay*20)%360,70,60,1)
	flower_layer(5,20/lay,150-lay*20,40+lay*10,1)
  }
  
  stroke(255)
  ellipse(width/2, height/2, circ_size, circ_size)
}