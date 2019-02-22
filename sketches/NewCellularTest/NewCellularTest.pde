

let grid_width = 50
let grid_height = 50
let grid =[];

let alive_cells=[];
let to_flip=[];

let screen_width = 200
let screen_height = 200

let cell_width = 0
let cell_height = 0

let cell_off_x = 1
let cell_off_y = 1

class cell
{
  constructor(x,y)
  {
	this.prev_state =0;
	this.state = 0;
	this.next_state = 0;
	this.type="normal"
	this.x = x
	this.y = y
  }
}

function ini_grid()
{
	for(height_idx=0;height_idx<grid_height;height_idx++)
	{
		grid[height_idx]=[];
		for(width_idx =0;width_idx<grid_width;width_idx++)
		{
			grid[height_idx][width_idx]=new cell(width_idx,height_idx);
			//print(grid[height_idx][width_idx])

			grid[height_idx][width_idx].state = floor(random(0,1)+0.2)
		}
	}
}

function init()
{
	ini_grid()
	cell_width =floor((screen_width - cell_off_x*grid_width) /grid_width);
	cell_height =floor((screen_height - cell_off_x*grid_height) /grid_height)

	frameRate(2)

}

function setup() 
{
	createCanvas(400,400);
	colorMode(HSL,360,100,100);
	fill(255)

	init()
}



function get_neighbour_count(x,y)
{
	let neigh_pos=[
		[-1,-1], //top left
		[-1,0],
		[-1,1],
		[0,-1],
		[0,1],
		[1,-1],
		[1,0],
		[1,1]
	]
	let neighbours =0;

	for(var idx_pos=0;idx_pos<neigh_pos.length;idx_pos++)
	{
		var tmp_new_pos=[x+neigh_pos[idx_pos][0],y+neigh_pos[idx_pos][1]]
		if(tmp_new_pos[0]<=-1)
		{
			tmp_new_pos[0]=grid_width-1
		}
		else if(tmp_new_pos[0]>=grid_width)
		{
			tmp_new_pos[0]=0
		}

		if(tmp_new_pos[1]<=-1)
		{
			tmp_new_pos[1]=grid_height-1
		}
		else if(tmp_new_pos[1]>=grid_height)
		{
			tmp_new_pos[1]=0
		}
		
		
		if(grid[tmp_new_pos[1]][tmp_new_pos[0]].state != 0)
		{
			neighbours++;
		}
	}
	return neighbours
}



function update_grid()
{
	to_flip =[]
	alive_cells=[]

	
	for(height_idx=0;height_idx<grid_height;height_idx++)
	{
		for(width_idx =0;width_idx<grid_width;width_idx++)
		{
			neigh =get_neighbour_count(width_idx,height_idx);
			//print(width_idx,height_idx,neigh)
			//define the rules

			if(grid[height_idx][width_idx].state == 0)//dead state
			{
				if (neigh >= 2)
				{
					grid[height_idx][width_idx].next_state = 1

					to_flip.push([width_idx,height_idx])
					alive_cells.push([width_idx,height_idx])
					continue
				}

				//does not need to be flipped and is not alive
				//just set prev state to active state...

				grid[height_idx][width_idx].prev_state = grid[height_idx][width_idx].next_state.state
			}
			else //allive state   TODO if needed add more states
			{
				//will the cell die?
				if(neigh== 0 || neigh >= 7 )
				{
					grid[height_idx][width_idx].next_state = 0
					to_flip.push([width_idx,height_idx])
					continue
				}

				if(grid[height_idx][width_idx].state == 1 && neigh >= 3)//child cell handler
				{
					grid[height_idx][width_idx].next_state = 2 //grow
					to_flip.push([width_idx,height_idx])

					alive_cells.push([width_idx,height_idx])
					continue
				}

				//cell is still alive so push to allive array
				//also no flip is needed just set prev to the actial state...
				grid[height_idx][width_idx].prev_state=grid[height_idx][width_idx].state
				alive_cells.push([width_idx,height_idx])
			}
		}
	}

	
	//you have to flip the changed ones seperately else the ca works wrong ...
	
	for(idx_flip=0;idx_flip <=to_flip.length-1;idx_flip++)
	{
		let pos = to_flip[idx_flip]
		
		grid[pos[1]][pos[0]].prev_state = grid[pos[1]][pos[0]].state
		grid[pos[1]][pos[0]].state = grid[pos[1]][pos[0]].next_state
	}

	for(idx_alive=0;idx_alive <=alive_cells.length-1;idx_alive++)
	{
		fill(150,50,50)
		let pos = alive_cells[idx_alive]
		rect(pos[0]*cell_width+cell_off_x*pos[0],pos[1]*(cell_height+cell_off_y),cell_width,cell_height);
		fill(0)
	}

}


function draw()
{
	background(255)
	update_grid()
	
}