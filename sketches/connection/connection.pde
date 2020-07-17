let circles =[]

let cols_ =[]
let speed_min = -2
let speed_max = 2


let min_counts = 999
let max_counts = 0

let collisions = []


function calc_point(x,y,r,angle)
{
	var point = createVector(0,0)

	point.x = r*cos(angle) +x
	point.y = r*sin(angle) +y
	return point
}

class circle
{
   constructor()
  {
    this.d = random(5,width/20)
    this.r = this.d/2
    this.x = random(this.r,width-this.r)
    this.y = random(this.r,height-this.r)
    
    this.pos= createVector(this.x,this.y)
    this.collides = false
    this.collisions =[]
    
    this.x_speed = random(-1,1)
    this.y_speed = random(-1,1)
  }
  
  show()
  {


	stroke(30)
	ellipse(this.pos.x,this.pos.y,this.d,this.d)
    //ellipse(this.pos.x,this.pos.y,this.d,this.d)
    
    this.collides = false
    this.pos.x+=this.x_speed
    this.pos.y+=this.y_speed
    
    if(this.pos.x -this.r <=0 || this.pos.x +this.r>= width || this.pos.y -this.r<=0 || this.pos.y +this.r>=height)
    {
      this.d = random(5,width/20)
      this.r = this.d/2
      this.pos.x= random(0+this.r,width-this.r)
      this.pos.y= random(0+this.r,height-this.r)
      
      this.x_speed = random(-1,1)
      this.y_speed = random(-1,1)
    }
   
    
  }
  
  collides_with(circ)
  {


		//the distance 
		var dist_ =this.pos.dist(circ.pos)
		
		if(dist_<(this.r+circ.r) && dist_ > abs(this.r -circ.r))
		{




			//get the angle
			var angle_to_circ2 = atan2(circ.pos.y-this.pos.y,circ.pos.x-this.pos.x)
			var angle_to_circ1 = atan2(this.pos.y-circ.pos.y,this.pos.x-circ.pos.x) //rad


			//calculate the points on the circles...
			var point_circ1 =calc_point(this.pos.x,this.pos.y,this.r,angle_to_circ2)
			var point_circ2 =calc_point(circ.pos.x,circ.pos.y,circ.r,angle_to_circ1)

			//get the middle point between these points

			//calculate the special mid point beween the intersections 
			var dist_point_to_mid = (pow(this.r,2)-pow(circ.r,2)+pow(dist_,2))/(2*dist_)
			var mid = calc_point(this.pos.x,this.pos.y,dist_point_to_mid,angle_to_circ2)
			
			
			var gen_angle =degrees(angle_to_circ1)


			//distanc p1 to mid
			var dist_to_circ = circ.pos.dist(mid)


			/*push()
				stroke(50,100,50)
				line(this.pos.x,this.pos.y,mid.x,mid.y)
			pop()*/

			var height_ = sqrt( pow(circ.r,2)-pow(dist_to_circ,2))

			

			var left = calc_point(mid.x,mid.y,height_,radians(gen_angle-90))
			var right =calc_point(mid.x,mid.y,height_,radians(gen_angle+90))

			//draw collision points
     
			var c1 =cols_[floor(left.y)][floor(left.x)]
			var c2 =cols_[floor(right.y)][floor(right.x)]
			
			cols_[floor(left.y)][floor(left.x)]+=1
			cols_[floor(right.y)][floor(right.x)]+=1
			


			collisions.push({targets:{from:this,to:circ},time:200})
      
		}
  }
}



function setup()
{
  createCanvas(800,600)
  colorMode(HSL,360,100,100);
  //setFrameRate(30)
  noFill()
  
  for(var i=0;i<=height;i++)
  {
    cols_[i]=[]
    for(var j=0;j<=width;j++)
    {
        cols_[i][j]=0
    }
  }
  
  for(var i=0;i<100;i++)
  {
      circles.push(new circle())
  }
  
  background(0)
}


let frame_count = 0


function draw()
{
  
  
  frame_count+=1
  background(255)

  if(frame_count %5 == 0)
  {
    //background(0)
    
    
    
  }
  
  for(var c=0;c<1;c++)
  {
    for(var i = 0;i<100;i++)
    {
      for(var j = 0;j<100;j++)
      {
          if(i!=j && j>i)
          {

            circles[i].collides_with(circles[j])

          }
      }

      circles[i].show()    
    }
  }

  for(var i=0;i<collisions.length;i++)
  {
	 var coli = collisions[i].targets

	 stroke(map(collisions[i].time,0,200,255,0))
	 collisions[i].time-=1
	 line(coli.from.pos.x,coli.from.pos.y,coli.to.pos.x,coli.to.pos.y)

	 if(collisions[i].time < 0 )
	 {
		 collisions.slice(i,1)
	 }
  }
  
  
}