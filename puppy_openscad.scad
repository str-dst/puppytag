$fn=32;

puppy_name="your_name";
nfc_pocket=false;

module paw(name){
  difference(){
    // base
    minkowski(){
      Pylon();
      linear_extrude(0.01){
        offset(r=-3){
          union(){
            offset(r=+5.6){
              translate([-30,4,0]){
                scale([0.12,0.12,1]){
                  import("./paw.svg");
                }
              }
            }
            offset(r=+4.6){
              text( name, size= 13, font="Saira Stencil One", halign="center");
            }
            translate([0,22,0]){
              square([40,40], center=true);
            }
            translate([0,54,0]){
              circle(7.5);
            }
          }
        }
      }   
    }
    // cutouts
    union(){
      translate([-30,4,1.8]){
        linear_extrude(3){
          scale([0.12,0.12,1]){
              import("./paw.svg");
            }
          }
      }
      translate([0,0,2.4]){
        linear_extrude(3){
          text( name, size= 13, font="Saira Stencil One", halign="center");
        }
      }
      translate([0,54,0]){
        linear_extrude(6){
          circle(2.5);
        }
      }
    }
  }
}

module Pylon()
{
  translate([0,0,2.6]){
  cylinder(0.4, d1=0.8, d2=0, $fn=10);
  }
  translate([0,0,0.4]){
  cylinder(h=2.2,d1=0.8,d2=0.8,$fn=10);
  }
  cylinder(0.4, d1=0, d2=0.8, $fn=10);
}

if(nfc_pocket){
  difference(){
    paw(puppy_name);
    translate([0,20,0.8]){
      linear_extrude(0.2){
        square([22,14], center=true);
      }
    }
  }
}
else {
  paw(puppy_name);
}
