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

   mid_point = point_on_circ(height,angle,point_c.x,point_c.y)

   /*ellipse(point_a.x,point_a.y,3,3)
   ellipse(point_b.x,point_b.y,3,3)
   ellipse(point_c.x,point_c.y,3,3)
   
   ellipse(mid_point.x, mid_point.y, 3, 3)*/


   curve_(point_a,mid_point,-width,angle,height,percentage_max)
   curve_(point_b,mid_point,width,angle,height,percentage_max)
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


  for(let lay=0;lay<4;lay++)
  {
	fill((170+lay*20)%360,50,50,1)
	flower_layer(4,500/lay,150-lay*20,lay*45,4)
  }
  
  stroke(255)
  ellipse(width/2, height/2, circ_size, circ_size)
}