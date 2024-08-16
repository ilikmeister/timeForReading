readtest.c: calculates the time taken to read the file with different buffer sizes
you can compile it typing: cc -o readtest readtest.c
you can run it typing: ./readtest fileName bufferSize

read.sh: compiles the readtest.c file and runs it using buffer sizes from 200 to 5000 bytes

makeplot.sh: runs the script read.sh and builds plot.html with a graph as y = time taken in milliseconds, x = buffer size in bytes
