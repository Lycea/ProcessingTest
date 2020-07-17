

//states
//0 dead
//1 alive


var DEAD  = 0
var ALIVE = 1

var alive_chance =30

//rule set
 //smaller than that is lonely
var lonely = 3
 
//between them it is allive
var alive_min = 3
var alive_max = 3

//greater then this dies
var over_popu = 3

//to become alive
var revive =3



var cell_size =4

function modu(val,mod)
{
	var tmp
	tmp =((val % mod) + mod) % mod
	return  tmp
}

class pixel
{	

	constructor(x,y,state)
	{
		print("creating pixel...")
		this.cur_neighbours =[]
		this.aliveNeigh= 0

		this.state     = state
		this.prevState = state
		this.newState  = state

		this.pos_x =x
		this.pos_y =y

		this.show_states =[this.dummy_show,this.real_show]
		//print(this.pos_x,this.pos_y)
		//print(this.neighbours)
	}

	count_neigh()
	{
		var num=0;
		for(var i=0;i<8;i++)
		{
			//print(this)
			num+=this.cur_neighbours[i].state
		}
		return num
	}

	check_state()
	{
		var alive = this.count_neigh()
		
		if (this.state == DEAD)
		{
			if(alive == revive)
			{
				return ALIVE
			}
		
			return DEAD
		}
		else
		{
			if(alive < lonely)
			{
				return DEAD
			}
			else if(alive>over_popu)
			{
				return DEAD
			}

			return ALIVE
		}
	}

	
	init_neighbours()
	{
		print("Initialising neighbours...")
		var n_count=0

		for(var i =-1;i<=1;i++)
		{
			for(var j=-1;j<=1;j++)
			{
				if(i == 0 && j == 0)
				{
					continue
				}
				var x = modu(this.x+j,pix_width-1)
				var y = modu(this.y+i,pix_height-1)
				
				//print(this.x,this.y)
				//print(x,y)
				
				//print(grid[y][x])
				//print(this.neighbours)
				this.neighbours[n_count]=grid[y][x]

				/*if(this.activeState == ALIVE)
				{
					this.neighbours[n_count].increase_alive()
				}
				*/
				
				n_count++
			}
		}
	}


	increase_alive()
	{
		this.aliveNeigh++
	}

	decreae_alive()
	{
		this.aliveNeigh++
	}

	get activeState()
	{
		return this.state
	}


	
	
	get neighbours()
	{
		return this.cur_neighbours
	}

	set x(data)
	{
		this.pos_x=data
	}
	
	set y(data)
	{
		this.pos_y=data
	}

	get x()
	{
		
		return this.pos_x
	}

	get y()
	{
		
		return this.pos_y
	}

	update()
	{
		
		this.newState = this.check_state()
	}

	real_show(x,y)
	{
		//print("drawing")
		rect(x*cell_size,y*cell_size,cell_size,cell_size)
		//print(x,y)
		
	}
	dummy_show()
	{

	}

	show()
	{
		var neigh_change=[-1,+1]
		//now that all were processed set the states
		this.prevState = this.state
		this.state = this.newState
		
		
		if(this.state != this.prevState)
		{
			for(var j=0;j<this.neighbours.length;j++)
			{
				this.neighbours[j].aliveNeigh =this.neighbours[j].aliveNeigh+ neigh_change[this.state]
			}
		}

		this.show_states[this.prevState](this.x,this.y)
	}
}



var grid = []
var pix_width = 100
var pix_height = 100

function ini_grid()
{
	for(var i=0;i<pix_height;i++)
	{
		grid[i]=[]
		for(var j=0;j<pix_width;j++)
		{
			var set_state=DEAD
			if(random(0,100)<=alive_chance)
			{
				set_state=ALIVE
			}
			grid[i][j]= new pixel(j,i,set_state)
		}
	}

	for(var i=0;i<pix_height;i++)
	{
		for(var j=0;j<pix_width;j++)
		{
			//check cell state and set neighbours
			grid[i][j].init_neighbours()
		}
	}
}

function setup() 
{
	createCanvas(400,400);
	colorMode(HSL,360,100,100);
	
	noSmooth()
	noStroke()

	ini_grid()
}


function draw()
{
	fill(0,100,100)
	rect(0,0,width,height)
	fill(0,100,50)
	print("start cycle...")
	for(var i=0;i<pix_height;i++)
	{
		for(var j=0;j<pix_width;j++)
		{
			//check cell state and set neighbours
			grid[i][j].update()
			grid[i][j].show()
		}
	}

}
