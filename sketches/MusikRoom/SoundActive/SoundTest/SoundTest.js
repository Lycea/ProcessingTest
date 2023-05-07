let fft;
let mic;
let canv_halve;

//sample rate has to be a value between 16 and 1024
//and a power of two so lets set it like that (4 - 10)
let samples = Math.pow(2,10);
let multiplier = 1; //unused
let color = 0;

//sample number for sample size in the graph
//if calc is set it is overwritten
let pixel_per_sample=5;
let calc_pps = true;

let stroke_size = 3


function setup()
{
    //color setup
	  let cnv = createCanvas(1920,1080);
    cnv.mousePressed(userStartAudio);
	  colorMode(HSL,360,100,100);

    canv_halve = height/3;
    strokeWeight(stroke_size)

    if(calc_pps == true)
    {
        pixel_per_sample = width / samples ;
    }

    //sound setup ...
    mic = new p5.AudioIn();    
    mic.start();

    fft = new p5.FFT(1, samples );
    fft.setInput(mic);

    //frameRate(10)
    //noLoop();
}

function draw()
{
    background(0,0,0,1);
    stroke(color%360,100,50);
    noFill();

    wave = fft.waveform();
    //console.log(fft.waveform())
    let last_line = {x : 0,
                     y : canv_halve};
    
    for(let i = 0 ; i<wave.length; i++)
    {
        let pt = {x : i*pixel_per_sample ,
                  y : canv_halve + wave[i] * canv_halve }
//        ellipse(pt.x , pt.y, 3,3)

        line(last_line.x, last_line.y,
             pt.x, pt.y)

        last_line = pt
    }
    color += 0.5
} 

function mousePressed()
{
    userStartAudio();
}
