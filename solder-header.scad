//烙铁头收纳
each_row = 2; //每样行数量
max_item_col = 10; //最大物件列数
gap = 3.5; //物品间隙

//T12烙铁头
t12_d = 6;
t12_h = 70;

//936烙铁头
936_d = 6.8;
936_h = 16;

//玻璃瓶子
bottle_d = 22.2;
bottle_h = 15;

$fn = 100;

/*
minkowski(){
    cube([10,10,10],center=true);
    sphere(1);
    }
*/
/*
hull(){
    cube([10,10,10],center=true);
    cylinder(r=2,h=10);
    }
*/

//margin_x = 5;
//margin_y = 5;
bottom_th = 3;
max_h = max(t12_h,936_h,bottle_h);
max_d = max(t12_d,936_d,bottle_d);
base_w = max_d*max_item_col+gap*(max_item_col-1);
base_h = each_row * (t12_d+936_d+bottle_d) + gap*(each_row*3-1);

module bottles(row=2,col=10,center= true){
    if(center){
        w = col*bottle_d+gap*(col-1);
        h = row*bottle_d+gap*(row-1);
        translate([(-w+bottle_d)/2,(-h+bottle_d)/2,0]){
            for(r = [0:row-1])
                for(i=[0:col-1])
                    translate([(i*bottle_d)+i*gap,r*bottle_d+r*gap,bottom_th]) cylinder(d=bottle_d,h=max_h,center=true);
            }
        }else{
        for(r = [0:row-1])
            for(i=[0:col-1])
                translate([(i*bottle_d)+i*gap,r*bottle_d+r*gap,bottom_th]) cylinder(d=bottle_d,h=max_h,center=true);
        }
    }
    
//bottles();
    
module 936header(row=2,center= true){
    maxw = max_d*max_item_col+gap*(max_item_col-1);
    col = floor(maxw/(936_d+gap));
    w = col*936_d+gap*(col-1);
    h = row*936_d+gap*(row-1);
    //echo(col);
    if(center){
        translate([(-w+936_d)/2,(-h+936_d)/2,0]){
            for(r = [0:row-1]){
                for(i = [0:col-1]){
                    translate([(i*936_d)+i*gap,r*936_d+r*gap,bottom_th]) cylinder(d=936_d,h=max_h,center=true);
                    }
                }
            }
        }
    else{
            for(r = [0:row-1]){
                for(i = [0:col-1]){
                    translate([(i*936_d)+i*gap,r*936_d+r*gap,bottom_th]) cylinder(d=936_d,h=max_h,center=true);
                    }
                }
        }
    }


difference(){
    minkowski(){
        cube([base_w,base_h,max_h+bottom_th],center=true);
        cylinder(r=5);
        }
    // bottles
    translate([0,-base_h/2+bottle_d,0]) bottles(each_row,max_item_col);
    //#cube([base_w+300,(bottle_d+gap)*2,0],center=true);
    //936 header
    translate([0,936_d*2+gap/2,0]) 936header();
    //t12 header
        
    }
    