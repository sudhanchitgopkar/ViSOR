<h1 align="center"><b>ViSOR</b></h1>
<p align="center"><b>An in-development visualization tool for Solids-of-Revolution.</b></p>
</br>

**Setup/Install:**
ViSOR uses Processing 4 for visualization. While executables are available for OSX (x86 + ARM), Windows (x86), and Linux (x86), much functionality including user parameter modification is currently only available by modiying source code. As such, it is **highly recommended** that users install Processing for their machine.

Processing 4 can be downloaded for OSX, Windows, and Linux [here](https://processing.org/download).

Once downloaded, clone this repository using either `https`:
```console
sudhan@osx:~ $ git clone https://github.com/sudhanchitgopkar/ViSOR.git
```
or `SSH`:
```console
sudhan@osx:~ $ git clone git@github.com:sudhanchitgopkar/ViSOR.git
```
open `SOR.pde` which should automatically start the Processing IDE.

**Parameter Tuning:**
ViSOR currently supports a variety of user tuning options, easily modified at the beginning of the `SOR.pde` document. In addition to specifying a function to graph, users may edit the following parameters:
- `ROTAXIS`: the axis of rotation for creating the Solid of Revoltion
- `END_PLANE`: the distance in each direction the coordinate plane should stretch
- `DELTA_R`: the distance between faces drawn during revolution
- `FR`: the framerate of the animation

1) `ROTAXIS`

This defines which axis to rotation the function around, and has two options: `x` representing rotation about the x-axis, and `y` representing rotation about the y-axis

2) `END_PLANE`

This determines how large the coordinate plane should be. For example, setting this value to 5 would create a coordinate plane that goes from [-5,5] in both the x and y.

3) `DELTA_R`

This defines the distance between each face being drawn as it revolves, meaning that lower distances push faces closer to one another. More accurate representations of solids of revolution will have lower `DELTA_R` values, though this may hurt performance.

4) `FR`

This sets the animation framerate and defaults to 60. It is recommended to use this default, though lower `FR` values will result in a slower animation being played

**Defining Functions:**
Functions may be defined by users using the `f` method.
```java
float f(float x) {
  float y = x*tan(x);
  return -1 * map(y,0,END_PLANE,0,height/2);
} //f
```
to use, simply modify the first line of the method to reflect your function. For example, using y=x^2+3sin(x) would be written as follows:
```java
float f(float x) {
  float y = (x*x) + (3 * sin(x));
  return -1 * map(y,0,END_PLANE,0,height/2);
} //f
```
**Note that unexpected behavior may occur through the use of many-to-one functions.**

**Animation Settings:**
ViSOR also has a variety of commands you can use during run-time to pause, view, or restart animations. At any time, `r` will reload the animation from the beginning. `p` toggles play an pause states for face revolution. Finally, the mouse may be used to view the coordinate plane in a variety of different angles, with a mouse-press pausing axis rotation.

**Disclaimer:**
```
ViSOR is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; 
without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. 
```
