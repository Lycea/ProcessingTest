/// <reference types="p5" />


let cell_size = 20;

class HexPoint {
    constructor(x, y) {
        this.x = x;
        this.y = y;
    }
}



class HexLine{
	constructor(p1,p2)
	{
		  this.p1 = p1;
		  this.p2 = p2;

		  this.p =[this.p1, this.p2]
	}

  draw()
  {
      line(this.p1.x,this.p1.y, this.p2.x,this.p2.y);
      
  }

  

  set_neighbours(list)
  {
	this.neightbours = list
  }
}


function const_vertical_line(x,y)
{
	var new_line = HexLine( new HexPoint(x,y),
					            new HexPoint(x + cell_size, y)  );
}

function const_vertical_up(x,y)
{
	var new_line = HexLine( new HexPoint(x,y),
					            new HexPoint(x + cell_size, y)  );
	
	new_line.set_neighbours([ 
		[

		], //left point
		[

		]  // right point
	 ])

	 return new_line
}

function const_vertical_down(x,y)
{
    var new_line = HexLine(new HexPoint(x, y + cell_size),
					             new HexPoint(x + cell_size, y + cell_size)  );
	return new_line
}



function const_diagonal_tl(x,y) 
{
	var new_line = HexLine( new HexPoint(x,y),
					            new HexPoint(x + cell_size, y + cell_size)  );

	new_line.set_neighbours([ 
		[
			{}
		], //left point
		[

		]  // right point
	])

	return new_line
}

function const_diagonal_tr(x,y)
{
	var new_line = HexLine(  new HexPoint(x , y + cell_size)  ,
							new HexPoint(x + cell_size,y));
}


class HexGrid{
	constructor()
	{
		let crea_table = [
			[const_diagonal_tr, const_vertical_up, const_diagonal_tl,const_vertical_down],
			[const_diagonal_tl, const_vertical_down, const_diagonal_tr,const_vertical_up]
		];

		  this.grid = [];

		for(var i = 0;i< SketchSettings.height /cell_size;i++)
		{
			  let line_y_1 = i*cell_size;
			  this.grid.push([]);
			  for(var j = 0;j<SketchSettings.width / cell_size ;j++ )
			  {
				    let line_x_1 = j*cell_size;
				    if( i%2 == 1 )
				    {
					      this.grid[i].push( crea_table[0][j%4](line_x_1, line_y_1) );
				    }
				    else
				    {
					      this.grid[i].push( crea_table[1][j%4](line_x_1, line_y_1) );
				    }
			  }
		}
	}
    
	draw()
	{
      for( var y = 0; y < this.grid.length; y++ )
      {
		      stroke(100* (y%2), 50,50,0.5);
          for( var x = 0; x < this.grid[y].length; x++ )
          {
              this.grid[y][x].draw();
          }
      }
	}
}



let grid = null;

function setup() 
{
	createCanvas(SketchSettings.width,SketchSettings.height);
	colorMode(HSL,360,100,100);
	  grid = new HexGrid();
	  console.log(grid);
}


function draw()
{
	  SketchSettings.prepare();
    background(0);
	  stroke(50,50,50);
	  grid.draw();
	
}
