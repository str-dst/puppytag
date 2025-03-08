$fn=32;

puppy_name="your_name";
nfc_pocket=false;
center_name=false;

module base(name, center){
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
          if(center){
            translate([0,25,0]){
              text( name, size= 13, font="Saira Stencil One", halign="center");
            }
          }
          else{
            text( name, size= 13, font="Saira Stencil One", halign="center");
            translate([0,22,0]){
              square([30,30], center=true);
            }
          }
        }
        translate([0,54,0]){
          circle(7.5);
        }
      }
    }
  }
}

module paw_cutout(){
  translate([-30,4,1.8]){
    linear_extrude(3){
      scale([0.12,0.12,1]){
        import("./paw.svg");
      }
    }
  }
}
  
module name_cutout(name, center){
  if(center){
    translate([0,25,2.4]){
      linear_extrude(3){
        text( name, size= 13, font="Saira Stencil One", halign="center");
      }
    }
  }
  else{
    translate([0,0,2.4]){
      linear_extrude(3){
        text( name, size= 13, font="Saira Stencil One", halign="center");
      }
    }
  }
}

module keyhole(){
  linear_extrude(0.01){
    translate([0,54,0]){
      circle(2.8);
    }
  }
}

module pylon()
{
  translate([0,0,2.6]){
  cylinder(0.4, d1=0.8, d2=0, $fn=10);
  }
  translate([0,0,0.4]){
  cylinder(h=2.2,d1=0.8,d2=0.8,$fn=10);
  }
  cylinder(0.4, d1=0, d2=0.8, $fn=10);
}

module tag(){
  if(center_name){
    difference(){
      union(){
        difference(){
          minkowski(){
            pylon();
            difference(){
              base(puppy_name, center_name);
              keyhole();
            }
          }
          paw_cutout();
        }
        translate([0,25,0]){
          linear_extrude(3){
            union(){
              offset(1.2){
                text( puppy_name, size= 13, font="Saira Stencil One", halign="center");
              }
              translate([0,5,0]){
                square([42,10], center=true);
              }
            }
          }
        }
      }
      name_cutout(puppy_name, center_name);
    }
  }
  else{
    difference(){
      minkowski(){
        pylon();
        difference(){
          base(puppy_name, center_name);
          keyhole();
        }
      }
      union(){
        paw_cutout();
        name_cutout(puppy_name, center_name);
      }
    }
  }
}

if(nfc_pocket){
  difference(){
    tag();
    if(center_name){
      translate([0,32,0.8]){
        linear_extrude(0.2){
          square([22,14], center=true);
        }
      }
    }
    else {
      translate([0,20,0.8]){
        linear_extrude(0.2){
          square([22,14], center=true);
        }
      }
    }
  }
}
else {
  tag();
}
