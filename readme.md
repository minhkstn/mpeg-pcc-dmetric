
# MPEG-3DG mpeg-pcc-dmetric metric software

## Building

CMakeLists.txt is provided for cmake to generate makefiles. General practice using cmake should be followed in order to compile the program.

### Building script

Bash scripts can be use to build and clean mpeg-pcc-dmetric project:
- build.sh: build solutions.
- clear.sh: clear solututions.

### Build manually

Standard CMake build commands can be used to build the software depending on the system you used.


```
   cmake ./source -B build/Release
   cmake --build build/Release --config Release
```

"pc_error" to be generated under ./build/Release/Release/ folder.

## Usage examples

The parameter of the pc_error softare are the following ones:

```
PCC quality measurement software, version 0.14.0

Error: File 1 parameters not correct
Error: File 2 parameters not correct

Usage: pc_error --fileA=infileA --fileB=infileB [options]

Options:
        --help=0            This help text
  -a,   --fileA=""          Input file 1, original version
  -b,   --fileB=""          Input file 2, processed version
  -n,   --inputNorm=""      File name to import the normals of original point
                            cloud, if different from original file 1n
  -s,   --singlePass=0      Force running a single pass, where the loop is
                            over the original point cloud
  -d,   --hausdorff=0       Send the Haursdorff metric as well
  -c,   --color=0           Check color distortion as well
  -l,   --lidar=0           Check lidar reflectance as well
  -r,   --resolution=0      Specify the intrinsic resolution
        --dropdups=2        0(detect), 1(drop), 2(average) subsequent points
                            with same coordinates
        --neighborsProc=1   0(undefined), 1(average), 2(weighted average),
                            3(min), 4(max) neighbors with same geometric
                            distance
        --averageNormals=1  0(undefined), 1(average normal based on neighbors
                            with same geometric distance)
        --mseSpace=1        Colour space used for PSNR calculation
                            0: none (identity) 1: ITU-R BT.709 8: YCgCo-R
        --nbThreads=1       Number of threads used for parallel processing

Example:
   ./test/pc_error \
          --fileA=./loot/loot_vox10_1000.ply \
          --fileB=./S23C2AIR01_loot_dec_1000.ply \
          --inputNorm=./loot/loot_vox10_1000_n.ply \
          --color=1 \
          --resolution=1023
```

The following command line computes the point cloud metrics between two point clouds.

```
./mpeg-pcc-dmetric/build/Release/Release/pc_error.exe \
    -a ./src/loot_vox10_1200.ply \
    -b ./dec/f3c85587_trisoup-raht_lossy-geom-lossy-attrs_loot_vox10_1200_r02.ply \
    -n ./src/loot_vox10_1200_n.ply \
    -c 1 \
    -r 1023
```

## Software manual

More informations could be found in the [user manuel](doc/mpeg-pcc-dmetric-sw-manual.pdf).

this manual could be generate with the following command line:

```
./build.sh --doc
```

## Reference
   MPEG input document M40522, "Updates and Integration of Evaluation Metric Software for PCC"