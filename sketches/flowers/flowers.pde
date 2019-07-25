

function point_on_circ(radius,angle,offset_x,offset_y)
{
	let x = radius*sin(radians(angle))+offset_x
	let y = radius*cos(radians(angle))+offset_y

	return createVector(x, y)
}

let circ_size = 20
let circ_rad = circ_size/2

class flower 
{
	constructor(x,y,size)
	{
		
		if(x == null){x=width/2}
		if(y == null){y=height/2}
		if(size==null){size=10}
		this.x = x
		this.y = y
		this.size = size

		//petal gen_settings
		this.layers = 1
		this.num_petals = 5
		this.width_petal = 20
		this.height_petal = 40
		this.hight_point_petal = 1.5
		this.offset_angle = 0


		//color settings
		this.base_hue   = 20
		this.base_sat   = 50
		this.base_bright  = 50

		//changes per layer
		this.hue_shift_layer   = 20
		this.sat_shift_layer   = 0
		this.light_shift_layer = 0
		this.petal_change_layer =0
		this.width_change_layer = 5
		this.height_change_layer = 10
		this.angle_off_change_layer = 0
		this.percentage_change = 0


		//secret options
		this.layer_do_multicolor= false
		this.layer_multicolor_diff_hue=0  //color difference between the two
		this.layer_multicolor_diff_sat = 0
		this.layer_multicolor_diff_bright = 0

		this.color_layers = 1
	}




	setGeneralSettings(layers,num_petals,width_petal,height_petal,hight_point_petal,angle_offset)
	{
		this.layers = layers
		this.num_petals = num_petals
		this.width_petal = width_petal
		this.height_petal = height_petal
		this.hight_point_petal = hight_point_petal
		this.offset_angle = angle_offset
	}

	curve_(from,to,chitter,angle,height,max_perc)
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
	petal(point_a,point_b,point_c,angle,width,height,percentage_max)
	{

	//stroke(160,100,50)
	//fill(255,50,50)
	

	let height_diff_per_layer = height/this.color_layers

	if(height_diff_per_layer == height)
	{
		height_diff_per_layer = 0
	}

	for(let layer=0;layer<this.color_layers;layer++)
	{
		let height_diff = layer*height_diff_per_layer

		let mid_point = point_on_circ(height-height_diff,angle,point_c.x,point_c.y) //the tip
		let mid_height =point_on_circ((height-height_diff)*percentage_max,angle-180,mid_point.x,mid_point.y)

		let chitter_left  = point_on_circ(-width,angle-90,mid_height.x,mid_height.y)
		let chitter_right = point_on_circ(width,angle-90,mid_height.x,mid_height.y)
		
		let hue =this.base_hue+this.__actual_layer*this.hue_shift_layer +layer*this.layer_multicolor_diff_hue
		let sat =this.base_sat+this.__actual_layer*this.sat_shift_layer +layer*this.layer_multicolor_diff_sat
		let bright =this.base_bright+this.__actual_layer*this.light_shift_layer +layer*this.layer_multicolor_diff_bright
		fill(hue,sat,bright)
		

		print(mid_point,mid_height,chitter_left,chitter_right)
		//ellipse(mid_point.x,mid_point.y,5,5)
		
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
	}

	print("************")
	}

	flower_layer(petals,width_,height_,angle_off,percentage_max)
	{
		this.rad = this.size/2

		let num_petals = petals
		let angle_offset = 0
		if(angle_off!= null)
		{
			angle_offset = angle_off
		}

		let angle_per =360/num_petals

		for(var i=0;i<num_petals;i++)
		{

			let left =point_on_circ(this.rad,angle_per*i+angle_offset,this.x,this.y) 
			let right =point_on_circ(this.rad,angle_per*(i+1)+angle_offset,this.x,this.y) 
			let mid =point_on_circ(this.rad,angle_per*(i+0.5)+angle_offset,this.x,this.y) 

			
			this.petal(left,right,mid,angle_per*(i+0.5)+angle_offset,width_,height_,percentage_max)
		}

	}

	show()
	{
		for(let lay=0;lay<this.layers;lay++)
		{
		  //fill((170+lay*20)%360,50,50,1)
		  //stroke((170+lay*20)%360,50,60,1)
		  this.__actual_layer = lay
		  fill((this.base_hue+lay*this.hue_shift_layer)%360,this.base_sat,this.base_bright)
		  //stroke((this.base_hue+lay*this.hue_shift_layer)%360,this.base_sat,this.base_bright)

		  this.flower_layer(this.num_petals-this.petal_change_layer*lay,
							this.width_petal-this.width_change_layer*lay,
							this.height_petal -this.height_change_layer*lay,
							this.offset_angle -this.angle_off_change_layer*lay,
							this.hight_point_petal -this.percentage_change*lay)
	  
		}
		
		
		//stroke(255)
		fill(255)
		ellipse(this.x, this.y, this.size, this.size)
	}
}






d



let flower_test = 0
function setup()
{
  createCanvas(400,400)
  colorMode(HSL,360,100,100);
  setFrameRate(1)
  noStroke()
  
  flower_ = new flower(width/2,height/2,20)
  
}


function draw()
{
	background(0)
	//flower_.num_petals= max(3,(flower_.num_petals+1)%10)
	flower_.base_hue = 10
	flower_.base_sat = 50
	flower_.base_bright = 50

	flower_.layers =10
	flower_.petal_change_layer=0
	flower_.height_petal = 200
	flower_.hight_point_petal = 1
	flower_.percentage_change = 0
	flower_.height_change_layer =30
	flower_.width_petal = 50
	flower_.width_change_layer = 3
	flower_.angle_off_change_layer=15

	flower_.hue_shift_layer = 10

	flower_.layer_multicolor_diff_bright = -2
	flower_.color_layers = 20


	flower_.show()

}