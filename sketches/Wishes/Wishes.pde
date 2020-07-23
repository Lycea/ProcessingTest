function setup() 
{
	createCanvas(400,400);
	colorMode(HSL,360,100,100);


	pg = createGraphics(width,height)

	pg.background(255)

	pg.stroke(2)
	pg.fill(2)
	pg.textSize(65);
	pg.textFont("Lucida Handwriting")
	pg.text('Merry ', 95, 80);
	pg.text("Christmas",10,150)

	noStroke();
	background(0)
}


function star(x, y, radius1, radius2, npoints) {
	var angle = TWO_PI / npoints;
	var halfAngle = angle/2.0;
	beginShape();
	for (var a = 0; a < TWO_PI; a += angle) {
	  var sx = x + cos(a) * radius2;
	  var sy = y + sin(a) * radius2;
	  vertex(sx, sy);
	  sx = x + cos(a+halfAngle) * radius1;
	  sy = y + sin(a+halfAngle) * radius1;
	  vertex(sx, sy);
	}
	endShape(CLOSE);
  }


function draw()
{
	background(0)
	//image(pg,0,0)
	//for(i=0;i<100;i++)
	count=0
	
	while(count <500)
	{
		strokeWeight(2)
		var x =random(0,width)
		var y = random(40,height/4*2)
		col =pg.get(x,y)
		if (col[1]!=255)
		{
			
			num =random(0,100)
			if (num <50)
			{
				fill(100,320,50)
				//stroke(100,320,50)
				stroke("beige")
				//ellipse(x, y, 5, 5);
				line(x,y,x+3,y+3)
				line(x,y+3,x+3,y)

			}
			else
			{
				fill("green")
				stroke("red")
				//ellipse(x, y, 6, 6);
				line(x,y,x+3,y+3)
				line(x,y+3,x+3,y)
			}
			count++;
			
			
		}
		else
		{
		
		}
		
	}

	noStroke()
	fill("green")
		change_h = 40

		triangle(width/2, height/2, width/3, height -height/3, width -width/3, height-height/3);
		triangle(width/2, height/2+change_h, width/3.5, height -height/3 +change_h, width -width/3.5, height-height/3+change_h);
		triangle(width/2, height/2+change_h*2, width/4, height -height/3 +change_h*2, width -width/4, height-height/3+change_h*2);

	fill("brown")
	rect(width/2-20,height -height/3 +change_h*2,40,40)

	fill("yellow")
	star(width/2, height/2-10, 10, 20, 6); 

	//draw some lights

	points =[[180,250],
		[200,260],
		[210,240],
		[170,280],
		[200,280],
		[170,310],
		[200,320]
	]

	//text(mouseX+" "+mouseY,mouseX,mouseY)
	//ellipse(mouseX,mouseY,5,5)

	



	
}