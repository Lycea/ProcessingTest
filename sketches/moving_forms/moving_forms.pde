var foreground = []
var background = []

var width = 600
var height = 600

var rec_w =50
var rec_h = 50

var act_c = 0

function setup() 
{
	
	createCanvas(600,600);
	colorMode(HSL,360,100,100);
	
	act_c =random(0,360) 
	
	for(var i=0; i<ceil(height/rec_h);i++)
	{
		print(height)
		foreground[i]=[]
		background[i]=[]
		for(var j=0; j<ceil(width/rec_w);j++)
		{
			foreground[i][j]=[rec_w,rec_h,act_c,0,0,random(10,30)/10]
			background[i][j]=[rec_w,rec_h,act_c-180,0,0,random(10,30)/10]
		}
	}

}




function draw()
{
	stroke(0,0,0,0)
	for(var i=0;i<foreground.length;i++)
	{
		for(var j=0;j<foreground[i].length;j++)
		{
			fill(background[i][j][2],50,50)
			rect(j*rec_w,i*rec_h,rec_w,rec_h)
			fill(foreground[i][j][2],50,50)
			rect(j*rec_w + foreground[i][j][3],i*rec_h+foreground[i][j][4],foreground[i][j][0],foreground[i][j][1])
		
				foreground[i][j][0]-=0.2*foreground[i][j][5]
				foreground[i][j][1]-=0.2*foreground[i][j][5]
				
				foreground[i][j][3]+=0.1*foreground[i][j][5]
				foreground[i][j][4]+=0.1*foreground[i][j][5]

			if(foreground[i][j][0] <= 0 || foreground[i][j][1]<=0)
			{	
				foreground[i][j]= background[i][j]
				//always use the same speed
				//background[i][j]=[rec_w,rec_h,(foreground[i][j][2]+50)%360,0,0,foreground[i][j][5]]
				//set some random speed each time
				background[i][j]=[rec_w,rec_h,(foreground[i][j][2]+50)%360,0,0,random(10,30)/10]
			}
		}
	}

}