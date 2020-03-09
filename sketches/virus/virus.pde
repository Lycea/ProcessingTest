/*inspired by the current situation

 - Create a space with x *y points
 - at the start "infect" one at random                         (variable how many to infect)
 - remember the infected cell(s)
   - each run first try to infect x others of the neighbours   (variable how many test)
	- infection has a x percent chance to happen 			   (variable for infection chance)
   - then it will check if it will die  at some percent change (variable for lethality)
   - then if he didn't die check if time has run up and the cell is fine again (variable for virus life time)


Additional Ideas:
- add a random resistance factor to cells at the beginning to simulate different immune systems
- add a resisstance factor after the thing once hit a cell

- add a zombie state and make it a zombie infection (lol)

- add permutations to the "virus" also then it needs its own class ...
  - change all values randomly a bit by going from cell to cell to make it different
*/

//virus params
var start_infected = 1
var num_infection_check = 8
var infection_chance    =  0.7
var lethality           =  0.00
var max_life            = 50






//cell params
var allow_immunity =true


var cell_size = 5

var state_cols=[
	150,
	0,
	250
]

//array and its params, rows and colls are dynamically calculated on start...
var cells =[]
var rows =0
var colls = 0




function modu(val,mod)
{
	var tmp
	tmp =((val % mod) + mod) % mod
	return  tmp
}



class Virus
{
	constructor(p_infection_num,p_infection_chance,p_lethality,p_max_life)
	{
		this.infection_num =p_infection_num || num_infection_check
		this.infection_chance=p_infection_chance || infection_chance
		this.lethality = p_lethality || lethality
		this.max_life = p_max_life|| max_life
	}
}



class Cell
{
	constructor(x,y)
	{
		this.x = x
		this.y = y

		this.state = 0 // 0 fine, 1 infected, 2 dead

		this.next_state = 0
		
		this.immunity = false

		this.neigh =[
			[modu(this.x -1,colls),modu(this.y-1,rows)],[modu(this.x,colls),modu(this.y-1,rows)], [modu(this.x +1,colls),modu(this.y-1,rows)],
			[modu(this.x -1,colls),modu(this.y,rows)], [modu(this.x +1,colls),modu(this.y,rows)],
			[modu(this.x -1,colls),modu(this.y+1,rows)],[modu(this.x,colls),modu(this.y+1,rows)], [modu(this.x +1,colls),modu(this.y+1,rows)]
		]
	}

	show()
	{	
		if(this.state ==0)
		{
		fill(state_cols[this.state],100,50)
		}
		else
		{
			if(this.state == 1)
			{
				fill(map(this.virus_lt,0,this.virus.max_life,state_cols[0]-50,[state_cols[1]]),100,50 )
			}
			else
			{
				fill(0)
			}
		}
		rect(this.x*cell_size,this.y*cell_size,cell_size,cell_size)
	}

	infect(virus)
	{
		this.next_state = 1
		this.virus = virus
		this.virus_lt = this.virus.max_life
	}

	try_to_infect(virus)
	{	
		//if the cell is not infected or dead yet ...
		if(this.state ==0 && !this.immunity)
		{
			//if the cell now is infected
			if(random(0,100)<= virus.infection_chance*10)
			{
				this.infect(virus)
			}
		}
	}

	update()
	{
		if(this.state ==1)
		{	
			var num_list =[0,1,2,3,4,5,6,7]

			//first try to infect others
			for(var infection_tries =0;infection_tries< this.virus.infection_num;infection_tries++)
			{
				//get a number from the array
				//print(num_list.splice(floor(random(0,num_list.length)),1))
				var neigh_to_infect = num_list.splice(floor(random(0,num_list.length)),1)

				//try to enfect this cell
				var n = this.neigh[neigh_to_infect]
				cells[n[1]][n[0]].try_to_infect(this.virus)
			
			}

			//next check if this cell will die
			if(random(0,100)<=this.virus.lethality*10)
			{
				this.next_state=2
			}
			else
			{
				this.virus_lt-=1
				if(this.virus_lt<=0)
				{
					this.next_state =0
					this.immunity = random()>0.5
				}
			}

			
		}
	}

	change_state()
	{
		this.state = this.next_state
	}
}


function ini_cells()
{
	//calc rows and collumns
	cells=[]

	rows = floor(height/cell_size)
	colls = floor(width/cell_size)

	for(var y=0;y<rows;y++)
	{
		cells[y]=[]
		for(var x=0;x<colls;x++)
		{
			cells[y][x]= new Cell(x,y)
		}
	}

	//now infect some random ones ~

	cells[5][5].infect(new Virus())
	cells[5][5].state = 1
}

function setup() 
{
	createCanvas(800,600);
	colorMode(HSL,360,100,100);
	noStroke()
	ini_cells()
}


var show_neigh =false
var cell_to_show = [0,0]

function draw()
{
	background(0)
	if(frameCount%50 ==0)
	{
		cell_to_show =[
			floor(random(0,colls)),
			floor(random(0,rows))
		]
		//print(cell_to_show)
	}

	if(show_neigh==true)
	{
		cells[cell_to_show[1]][cell_to_show[0]].show()
	}
	else
	{
		for(var y=0;y<rows;y++)
		{
			
			for(var x=0;x<colls;x++)
			{
				cells[y][x].show()
				cells[y][x].update()
			}
		}

		for(var y=0;y<rows;y++)
		{
			
			for(var x=0;x<colls;x++)
			{

				cells[y][x].change_state()
			}
		}
	}

}