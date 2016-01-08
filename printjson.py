import json
import sys
import os
import re
import subprocess
import inspect
import requests

jsonFile = sys.argv[1]
if os.path.isfile(jsonFile):
    f = open(jsonFile, 'r+')
    parsed = json.load(f)
    f.seek(0)
    f.truncate()
    print >>f, json.dumps(parsed, indent=4, sort_keys=True)
    f.close()
else:
    sys.exit('Could not find '+jsonFile+', see gitcomments.json.example for instructions')


print json.dumps(parsed, indent=4, sort_keys=True)
