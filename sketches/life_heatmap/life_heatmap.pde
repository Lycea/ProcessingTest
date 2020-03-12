
/*


*/



var grid =[]

var rows  = 0
var colls = 0

var cell_size=5

var dies =[
	true,true,false,
	false,true,true,
	true,true,true
]

var respawn=[
	false,false,false,
	true,false,false,
	false,false,false
]


var to_update =[]


function modu(val,mod)
{
	var tmp
	tmp =((val % mod) + mod) % mod
	return  tmp
}


class Pix
{
	constructor(x,y,state)
	{
		this.x  =x
		this.y  =y

		this.state =state
		this.next =this.state

		this.live =0
		this.neigh =[
			[modu(this.x -1,colls),modu(this.y-1,rows)],[modu(this.x,colls),modu(this.y-1,rows)], [modu(this.x +1,colls),modu(this.y-1,rows)],
			[modu(this.x -1,colls),modu(this.y,rows)], [modu(this.x +1,colls),modu(this.y,rows)],
			[modu(this.x -1,colls),modu(this.y+1,rows)],[modu(this.x,colls),modu(this.y+1,rows)], [modu(this.x +1,colls),modu(this.y+1,rows)]
		]
	}

	update()
	{
		var allive =0
		for(var idx=0;idx< this.neigh.length;idx++)
		{
			allive+=grid[this.neigh[idx][1]][this.neigh[idx][0]].state
		}
		this.last_allive =allive
		if(this.state == 1)
		{
			if(dies[allive]==true)
			{
				this.next = 0
				//this.live = 0
			}
		}
		else
		{
			if(respawn[allive]==true)
			{
				this.next=1
				this.live+=1
			}
		}

		if(this.state != this.next){ to_update.push([this.x,this.y])}
	}

	show()
	{	
		
			fill((this.live*10)%360,100,50)
			rect(this.x*cell_size, this.y*cell_size,cell_size,cell_size)
		
	}

	flip()
	{
		this.state = this.next
	}

}

function ini_grid()
{
	for(var y=0;y<rows;y++)
	{
		grid[y]=[]
		for(var x=0;x<colls;x++)
		{
			grid[y][x]=new Pix(x,y,floor(random(0,100))%2)
		}
	}
}

function setup() 
{
	createCanvas(800,600)
	colorMode(HSL,360,100,100)

	rows = height/cell_size
	colls =width/cell_size
	ini_grid()
}


function draw()
{
	background(0)
	to_update =[]
	
	for(var y=0;y<rows;y++)
	{
		for(var x=0;x<colls;x++)
		{
			grid[y][x].update()
		}
	}
	
	for(var idx=0;idx<to_update.length;idx++)
	{
		grid[to_update[idx][1]][to_update[idx][0]].show()
		grid[to_update[idx][1]][to_update[idx][0]].flip()

	}

	text(floor(frameRate()),0,10)
}