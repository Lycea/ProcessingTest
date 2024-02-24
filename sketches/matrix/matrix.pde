function setup() 
{
	createCanvas(256*2,400);
	colorMode(HSL,360,100,100);
	//textFont("Courier new")
	//textSize(10)
}

let letter_list = '!#$%&()*+,-/0123456789<=>?@ABCDEFGHIJKLMNOPQRSTUVWXYZ[\\]abcdefghijklmnopqrstuvwxyz{|}~'
class MatrixLine
{
	reset_parts()
	{
		this.part_list = []
		for (let i=0;i < this.num_parts;i++)
		{
			this.part_list.push(letter_list[floor(random(0,letter_list.length))])
		}
	}

	constructor()
	{
		this.pos = floor(random(0, width/10))
		//console.log(this.pos)
		this.num_parts = floor(random(7,15))
		this.part_list = []
		this.part_timer = 10

		this.pos_y = 0
		//pixel speed speed
		this.speed = random(3,10)

		//tile speed
		//this.speed = random(1,3)
		this.frame_count = 0
		this.color = random(0,50)

		this.reset_parts()
	}

	update()
	{
		this.pos_y += this.speed	/2
		
		if (this.frame_count == this.part_timer)
		{
			this.reset_parts()
			this.frame_count = 0
		}

		
		this.frame_count+=1

		if (this.pos_y  > height )
		{
			return -1
		}

		//this.color +=5
		//this.color %=360
		return 0
	}

	show()
	{
		
		//stroke(100,50,50)
		noStroke()
		//fill(100, 60,60)

		/*rect(this.pos*10,
			 this.pos_y - this.num_parts*10,
			 10,
			this.num_parts * 10)
		*/
		let part_num  = 100 / this.num_parts

		for(var part = 0; part < this.num_parts;part++)
		{
			
			fill(this.color,
				 100 - part *part_num,
				50,//100 - part * part_num,
				1- ((part * part_num)/100)* 1.01)
			
			/*rect(this.pos*10,
				this.pos_y - (part+1)*13,
				10,
				10)
			*/

			//var my_char =letter_list[floor(random(0,letter_list.length))]
			//console.log(my_char)
			text(this.part_list[part],
				 this.pos*10 ,
				 this.pos_y - (part+1)*13)
		}
	}
}


var lines = []
function spawn_line()
{
	if(random(0, 1000) > 500)
	{
		lines.push(new MatrixLine())
	}
}

var h_scale = 1
function draw()
{
	scale(h_scale,1)
	spawn_line()
	background(0)

	let rm_list = []

	for (idx=0; idx<lines.length;idx++)
	{
		if (lines[idx].update() == -1)
		{
			rm_list.push(idx)
		}

		lines[idx].show()
	}
	rm_list.reverse()

	for ( idx = 0; idx< rm_list.length;idx++ )
	{
		lines.splice(rm_list[idx],1)
	}
	scale(1,1)
}