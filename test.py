

# the `#%%` tells vscode to run this in our jupyter notebook server
import os
import sys
package_path = '/openvdb/build/openvdb/openvdb/python'
sys.path.append(package_path)
# Now you can import modules from the specified PYTHONPATH
import pyopenvdb as vdb

vdb.Axis
