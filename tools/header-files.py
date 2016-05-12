#!env python
from __future__ import print_function
import os

path = os.path.join(os.path.dirname(os.path.realpath(__file__)), "..", "tex")
files = [os.path.abspath(os.path.join(path, f)) for f in os.listdir(path)]
print(" ".join(files))
