
let base_w = 256
let base_h = 128

let scale = 10

let col_base = 32

let pix_list= []





function ini_array()
{

	for(let r = 0;r<col_base;r++)
	{
		for(let g = 0;g<col_base;g++)
		{
			for(let b = 0;b<col_base;b++)
			{
				let tmp={}
				
				tmp.r=r
				tmp.g=g
				tmp.b=b

				pix_list.push(tmp)
				
			}
		}
	}
}



function setup() 
{
	let col_num = col_base*col_base*col_base
	print(col_num,sqrt(col_num))
	if(col_base != 32)
	{
		base_w = sqrt(col_num)
		base_h = sqrt(col_num)
	}
	createCanvas(base_w*scale,base_h*scale);
	colorMode(RGB,col_base-1,col_base-1,col_base-1);

	background(0)
	noLoop()

	ini_array()

	print(pix_list)
}



function get_color_idx(x,y)
{
	return random(0,min(pix_list.length,x))
}

function draw()
{
	for(let y = 0; y< base_h;y++)
	{
		for(let x = 0;x<base_w;x++)
		{
			let col = pix_list.splice(get_color_idx(x,y),1)[0]

			//let div = 12
			//let col = pix_list.splice( floor((pix_list.length / div) *( (x+y) % div)) ,1)[0]

				//print(col)

			fill(col.r,col.g,col.b)
			stroke(col.r,col.g,col.b)
			rect(x*scale,y*scale,scale,scale)
			
		}
	}
}



