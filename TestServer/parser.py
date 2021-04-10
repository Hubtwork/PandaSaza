from abc import *

import json
from collections import OrderedDict

file = open("univ.txt", "r")
lines = file.readlines()
print([ i.split('=')[0].replace("\"", "").rstrip() for i in lines][:3])

parsed_school = [ i.split('=')[0].replace("”", "").replace("\"", "").rstrip() for i in lines ]
data = OrderedDict()
schools = OrderedDict()
school = OrderedDict()

schools["area"] = "all"
schools["schools"] = [{"sId":idx+1, "name":school} for idx, school in enumerate(parsed_school)]

print(schools)

data["data"] = [schools]
with open('schools.json', 'w', encoding="utf-8") as makeFile:
    json.dump(data, makeFile, ensure_ascii=False, indent='\t')

class JSON_MAKER:
    
    def __init__(self):
        self.reader = None
        self.processor = None
        self.writer = None
    
class FILE_READER:
    def read(self):
        raise NotImplementedError()

class JSON_PROCESSOR:
    def processor(self):
        raise NotImplementedError()

class JSON_WRITER:
    def write(self):
        raise NotImplementedError()