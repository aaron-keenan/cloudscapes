class Cyanometer {
  color[] colours = {
    #EDF5F9,
    #EDE6D6,
    #E5E1D0,
    #E3DFD0,
    #D0E4F2,
    #B7B5AE,
    #E1E0D7,
    #D2D3D2,
    #CBD4D3,
    #BBC6CB,
    #B5BFC4,
    #AEBECA,
    #A7B3C2,
    #AFBBC5,
    #A2B5C2,
    #A1B4C6,
    #8CA4B7,
    #7D9BB6,
    #7594B6,
    #7091B4,
    #6889AC,
    #658BB4,
    #5C7FAC,
    #5479A9,
    #496792,
    #40638E,
    #46638B,
  };
  color lightest;
  color darkest;
  
  Cyanometer() {
    lightest = colours[4];
    darkest = colours[26];
  }
}
