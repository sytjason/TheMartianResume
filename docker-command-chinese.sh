#!/bin/bash
docker run -v $(pwd):/data blang/latex:ubuntu pdflatex resume-chinese
