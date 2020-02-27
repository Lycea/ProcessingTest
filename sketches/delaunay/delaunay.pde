


class cTriangle
  {
    constructor(p1,p2,p3)
    {
      print("new triangle")
      print(p1,p2,p3)
      this.p1 = p1
      this.p2 = p2
      this.p3 = p3
      
      this.calc_circum()
      
      this.is_super = false
      
      this.edges =[
        [this.p1,this.p2],
        [this.p2,this.p3],
        [this.p3,this.p1]
      ]
    }
    
    
    contains_edge(edge)
    {
      //edge is defined by two points
      for(var edge_id=0;edge_id<this.edges.length;edge_id++)
      {
          var tmp_e =this.edges[edge_id]
          if( (tmp_e[0].equals(edge[0])  || tmp_e[0].equals(edge[1]) == true) &&  (tmp_e[1].equals(edge[0])  || tmp_e[1].equals(edge[1])))
          {
            return true
          }
	  }
	  return false
    }
    
    
    line_from_points(p1,p2)
    {
      line(p1.x,p1.y,p2.x,p2.y)
    }
    
    slope(p1,p2)
    {
      return (p2.y - p1.y) / (p2.x - p1.x)
    }
    
    y_indent(p,m)
    {
      return p.y-m*p.x
    }
    
    line_itersection(l1p1, l1p2,l2p1,l2p2) 
    {
      	var a1 = l1p2.y-l1p1.y
        var b1 = l1p1.x-l1p2.x
        var a2 = l2p2.y-l2p1.y
        var b2 = l2p1.x-l2p2.x
	      var c1 = a1*l1p1.x+b1*l1p1.y
        var c2 = a2*l2p1.x+b2*l2p1.y
	      var det = a1*b2 - a2*b1
        
        if(det==0)
        { 
          return false
        }
        var x = (b2*c1-b1*c2)/det
        var y = (a1*c2-a2*c1)/det
       
        return createVector(x,y)
    }
    
    
    calc_circum()
    {
		
		
		//debug mid points
		var p1_p2 = p5.Vector.lerp(this.p1,this.p2,0.5)
		var p2_p3 = p5.Vector.lerp(this.p2,this.p3,0.5)
		var p3_p1 = p5.Vector.lerp(this.p3,this.p1,0.5)
		
		stroke(0,50,50)
		

		
		var slope_1 = -1/this.slope(this.p1,this.p2)
		var slope_2 = -1/this.slope(this.p2,this.p3)
		var slope_3 = -1/this.slope(this.p3,this.p1)
		//now get angle and
		
		var y_id1 = this.y_indent(p1_p2,slope_1)
		var y_id2 = this.y_indent(p2_p3,slope_2)
		var y_id3 = this.y_indent(p3_p1,slope_3)
		
		
		noFill()
		
		var circumc = this.line_itersection(p1_p2,createVector(0,y_id1),p2_p3,createVector(0,y_id2))
		print("circ",circumc)
		
		
		stroke(250,50,50)

		
		var rad = circumc.dist(this.p3)
		

		
		
		this.circumc = circumc
		this.circ_rad = rad
	   
		//ellipse(point[0],point[1],10,10)
		//ellipse(point2[0],point2[1],5,5)
    }
    
    
    
    show()
    {
      fill(120,50,50,0.1)
      stroke(120,50,50)
 
      //line(this.p1.x,this.p1.y,this.p2.x,this.p2.y)
      //line(this.p2.x,this.p2.y,this.p3.x,this.p3.y)
	  //line(this.p1.x,this.p1.y,this.p3.x,this.p3.y)

	triangle(this.p1.x, this.p1.y,this.p2.x,this.p2.y,this.p3.x,this.p3.y)
	

	

    }
    
    debug_circum()
    {
      //debug normal lines
      this.line_from_points(this.p1,this.p2)
      this.line_from_points(this.p2,this.p3)
      this.line_from_points(this.p3,this.p1)
      
      
      //debug mid points
      var p1_p2 = p5.Vector.lerp(this.p1,this.p2,0.5)
      var p2_p3 = p5.Vector.lerp(this.p2,this.p3,0.5)
      var p3_p1 = p5.Vector.lerp(this.p3,this.p1,0.5)
      
      stroke(0,50,50)
      
      ellipse(p1_p2.x,p1_p2.y,10)
      ellipse(p3_p1.x,p3_p1.y,10)
      ellipse(p2_p3.x,p2_p3.y,10)
      
      var slope_1 = -1/this.slope(this.p1,this.p2)
      var slope_2 = -1/this.slope(this.p2,this.p3)
      var slope_3 = -1/this.slope(this.p3,this.p1)
      //now get angle and
      
      var y_id1 = this.y_indent(p1_p2,slope_1)
      var y_id2 = this.y_indent(p2_p3,slope_2)
      var y_id3 = this.y_indent(p3_p1,slope_3)
      
      
      //line(p1_p2.x,p1_p2.y,0,y_id1)
      //line(p2_p3.x,p2_p3.y,0,y_id2)
      //var point = this.x_intersect(slope_1,y_id1,slope_2,y_id2)
      //var point2 = this.x_intersect(slope_2,y_id2,slope_3,y_id3)
      
      noFill()
      
      var circumc = this.line_itersection(p1_p2,createVector(0,y_id1),p2_p3,createVector(0,y_id2))
      print("circ",circumc)
      
      ellipse(circumc.x,circumc.y,5,5)
      stroke(250,50,50)
      //line(circumc.x,circumc.y,p1_p2.x,p1_p2.y)
      line(circumc.x,circumc.y,p2_p3.x,p2_p3.y)
      //line(circumc.x,circumc.y,p3_p1.x,p3_p1.y)
      
      var rad = circumc.dist(this.p3)
      
      ellipse(circumc.x,circumc.y,rad*2,rad*2)
      
      
      this.circumc = circumc
      this.circ_rad = rad
     
      //ellipse(point[0],point[1],10,10)
      //ellipse(point2[0],point2[1],5,5)
    }
  }



var triangles =[]
var new_points =[]



function vec(x,y)
{
  return createVector(x,y)
}

function setup()
{
  createCanvas(400,400)
  colorMode(HSL,360,100,100);
  setFrameRate(30)
  noStroke()
  
  
  //first big triangle
  //spans over canvas...
  //triangles.push( new cTriangle(vec(-width,0),vec(width,0),vec(height*2)))
  
  triangles.push(new cTriangle(vec(0,0),vec(width-30,0),vec(width-30,height-30)))
  triangles[0].is_super = true
  
  noLoop()

  
}

var selected = 0


function draw(only_tri)
{
	//fill(160,50,50)
	background(0)

	if(only_tri == true)
	{
		var tri =triangles[selected]

		triangle(tri.p1.x,tri.p1.y,tri.p2.x,tri.p2.y,tri.p3.x,tri.p3.y)
		return
	}
   

  
  //iterate the new points
   
   for(var idx = 0;idx<new_points.length;idx++)
   {
       print("iterating point "+idx)
       var tmp_pt = new_points[idx]
      
       ellipse(tmp_pt.x,tmp_pt.y,5,5)
        
       var bad_triangles = []
       
       //iterate the triangles...
       for(var tri_i =0;tri_i <triangles.length;tri_i++)
       {  
           print("testing circ...")
           print(tmp_pt,triangles[tri_i])
           if(tmp_pt.dist(triangles[tri_i].circumc)< triangles[tri_i].circ_rad )
           {
               print("Found bad triangle...")
               bad_triangles.push(tri_i)
               
           }
       }
        
       //list of new edges
       var polygon_list =[]
        
       //iterate all the bad triangles to fix them ?
       if(bad_triangles.length == 1)
       {
           print(bad_triangles)
           for(var edge_id=0;edge_id<3;edge_id++)
           {
             polygon_list.push(triangles[bad_triangles[0]].edges[edge_id])
           }
       }
       else
       {
         //iterate all bad triangles
         for(var idx_bad=0;idx_bad<bad_triangles.length;idx_bad++)
         {
            //iterate all the edges of it
            for(var edge_id=0;edge_id<3;edge_id++)
           {
             var contains = false
             //check if edge is in one of the other bad triangles
             for(var other_bad=0;other_bad<bad_triangles.length;other_bad++)
             {
               //if it is not the current
               if(idx_bad!= other_bad)
               {  
                   //other triangle contains edge ?
                   var tmp_c =triangles[bad_triangles[other_bad]].contains_edge(triangles[bad_triangles[idx_bad]])
                   print(tmp_c)
                   //does so set to true
                   if(tmp_c == true){contains=true}
               }
               //pre exit check if true
               if(contains == true)
               {
                   break
               }
             }
             
             //not contained in other rect soooo ad to the list ...
             if(contains == false)
             {
                 polygon_list.push(triangles[bad_triangles[idx_bad]].edges[edge_id])
             }
            
           }
         }//iterate bad tris end
         
         
       }//if more then one tri in bad end
       
       
      //now we got all new edges
      //iterate all edges and create new triangles from them
      for(var edge_id=0;edge_id<polygon_list.length;edge_id++)
      {
        triangles.push(new cTriangle(polygon_list[edge_id][0],polygon_list[edge_id][1],tmp_pt))
      }
     
      for(var bad_tri=0;bad_tri<bad_triangles.length;bad_tri++)
      {
        triangles.splice(bad_triangles[bad_tri],1)
      }
   }
  new_points =[]

  
  for(var id_tri=0;id_tri<triangles.length;id_tri++)
  {
    triangles[id_tri].show()
  }
}




function mousePressed()
{
  new_points.push(createVector(mouseX, mouseY))
  
  draw()
}

function draw_tri()
{
	draw(true)
}

//setInterval(draw_tri,200)