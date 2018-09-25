#! /usr/bin/python 

# this script adds the vl_src_header.txt to each .v file

import os

files = [""]

for file in os.listdir("."):
    if file.endswith(".v"):
        concat = open("../../../LICENSE").read()+open(file).read()
        fw = open(file, "w")
        fw.write(concat)
        fw.close()



