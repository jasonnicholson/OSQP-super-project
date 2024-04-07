#!/bin/bash

# Generate source code relationship graph
codeviz.py -o source-code-graph.dot $(cat source-code-list.txt)

# Generate source code relationship graph image
dot -Tsvg -o source-code-graph-twopi.svg -Ktwopi source-code-graph.dot
