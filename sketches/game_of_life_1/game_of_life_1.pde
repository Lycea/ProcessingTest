

//states
//0 dead
//1 alive


var DEAD  = 0
var ALIVE = 1

var alive_chance =30

//rule set
 //smaller than that is lonely
var lonely = 2

//between them it is allive
var alive_min = 2
var alive_max = 3

//greater then this dies
var over_popu = 3

//to become alive
var revive =3



var cell_size =5

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
		this.neighbours =[]
		this.aliveNeigh= 0

		this.state     = state
		this.prevState = state
		this.newState  = state

		this.x =x
		this.y =y

		this.show_states =[this.dummy_show,this.real_show]
		
	}

	check_state()
	{
		if (this.state == DEAD)
		{
			if(this.aliveNeigh == revive)
			{
				return ALIVE
			}
		
			return DEAD
		}
		else
		{
			if(this.aliveNeigh < lonely)
			{
				return DEAD
			}
			else if(this.aliveNeigh>= alive_min && this.aliveNeigh<= alive_max)
			{
				return ALIVE
			}
			else if(this.aliveNeigh>=over_popu)
			{
				return DEAD
			}
		}
	}

	
	init_neighbours()
	{

	}

	get activeState()
	{
		return this.state
	}

	set neighbours(data)
	{
		this.neighbours = data
	}
	get neighbours()
	{
		return this.aliveNeigh
	}

	update()
	{
		this.newState = this.check_state()	
	}

	real_show()
	{
		rect(this.x,this.y,cell_size,cell_size)
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

		this.show_states[this.state]
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
		for(var j=;j<pix_width;j++)
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
		for(var j=;j<pix_width;j++)
		{
			
		}
	}
}

function setup() 
{
	createCanvas(400,400);
	colorMode(HSL,360,100,100);

	ini_grid()

}


function draw()
{


}
