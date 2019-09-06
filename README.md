# Vehicle Intersection Management - Heuristic Approach

- Md. Mushfiqur Rahman (160041011)
- Kazi Raiyan Mahmud (160041058)

### Dependencies
- MiniZinc
- Python Notebook
- iminizinc library *(for integrating minizinc with python)*
- drawSVG *(for visualizing data)*

### Description
The IntersectionManagement.mzn file contains the model of the AI. The file takes in an array of old paths named "oldPaths" and an array with the old queue conditions named "WaitingQueue". As output, the model creates a new "paths" array and a "NewWaitingQueue" array. These two arrays are used for the next iteration.
The python notebook doesn't work yet. To run the system, the model needs to be manually called repeatedly.

### Instruction
#### Install MiniZinc
For linux-based OS please use the following code on terminal
	sudo apt-get update
	sudo apt-get install minizinc

For Mac
- Launch Terminal by pressing *command*+*space*, type terminal and hit Enter key.
- Run
	ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)" < /dev/null 2> /dev/null
- Run
	brew install minizinc

For Windows
The python and minizinc integration is still at an early stage. And windows support is still not properly available yet.

#### Install Python Notebook
Use any python notebook. Jupyter notebook can be installed through anaconda[https://www.anaconda.com/].

#### Install iminizinc library
Run the following code to install iminizinc[https://github.com/MiniZinc/iminizinc] extension
	pip install -U iminizinc
Make sure that the mzn2fzn binary and the solvers are at the PATH when running iminizinc on python notebook.

#### Install drawSVG
Run the following code in terminal to install drawSVG[https://pypi.org/project/drawSvg/]
	pip install drawSVG
