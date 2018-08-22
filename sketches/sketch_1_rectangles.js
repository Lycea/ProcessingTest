var t= 0;
var canv;
function setup() {
	createCanvas(400,400);
	colorMode(HSL,360,100,100);
	t=second();
}


function draw() {
	if (second()>t)
	{
		var w= 400;
	  var h= 400;
		var base_col = random(0,360);
		var base_col2 = base_col-160;
	  for(var i=0;i<10;i++)
	  {
		//  fill(random(0,150))
		//  rect(0,0,w/(i+1),h/(i+1));
			
			if(i%2==0)
			{
				fill(base_col,100-i*5,50-i*5);
				w=w/1.3;
			}
			else
			{
				fill(base_col2,100,50-i*5);
				h=h/1.3;
			}
		  rect(0,0,w,h);
	  }
		t= second()
	}

}