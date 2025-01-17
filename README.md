## MuJoCo-wasm3

Load and Run MuJoCo 3.2.6 Models using JavaScript and WebAssembly.

This repo is a fork of [@zalo 's repository](https://github.com/zalo/mujoco_wasm), updated to MuJoCo 3.2.6.

## Building

**1. Install emscripten**

**2. Build the mujoco_wasm Binary**

On Linux, use:
```bash
mkdir build
cd build
emcmake cmake ..
make
```

On Windows, run `build_windows.bat`.

## JavaScript API

```javascript
import load_mujoco from "./mujoco_wasm.js";

// Load the MuJoCo Module
const mujoco = await load_mujoco();

// Set up Emscripten's Virtual File System
mujoco.FS.mkdir('/working');
mujoco.FS.mount(mujoco.MEMFS, { root: '.' }, '/working');
mujoco.FS.writeFile("/working/scene.xml", await (await fetch("url/to/your/mujoco/scene.xml")).text());

// Load in the state from XML
let model       = new mujoco.Model("/working/scene.xml");
let state       = new mujoco.State(model);
let simulation  = new mujoco.Simulation(model, state);
```

Typescript definitions are available.
