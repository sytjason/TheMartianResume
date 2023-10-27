#!/bin/bash
docker run -v $(pwd):/data blang/latex:ubuntu pdflatex --output-directory=output resume

