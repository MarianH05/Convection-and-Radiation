
# Rod Cooling Simulation

This project simulates the cooling of a cylindrical rod considering **convection and radiation**.
It features a **MATLAB app** with sliders to adjust:

- Initial temperature (T0) 
- Convection coefficient (h) 
- Radiation emissivity (eps) 
- Animation runtime (s) 

The simulation shows:

- **2D temperature vs. time plots** for convection-only and convection+radiation cases. 
- **3D cylinder visualization** with real-time temperature coloring. 

## File Structure

'''
├── README.md
├── report
│ ├── Report.pdf # Detailed report of the project
│ └── Report.tex
├── results
│ ├── rod_cooling.gif # Animation output
│ ├── WithoutRadiation.png
│ └── WithRadiation.png
└── src
├── heatTransferApp.m # Main MATLAB UI script
├── odeFunction.m # ODE for rod cooling
├── Terminal.m # Event function for ODE termination
└── updatePlot.m # Plotting and animation function
'''


## Usage

1. Open `heatTransferApp.m` in MATLAB. 
2. Adjust sliders to set initial temperature, convection coefficient, radiation emissivity, and animation runtime. 
3. Press **Update Plot** to run the simulation. 

## Requirements

- MATLAB R2022a or later (supports `uifigure`, `uiaxes`, `uislider`) 
- No additional toolboxes required. 


