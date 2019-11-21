import json
import pandas as pd

with open('../models/model1.json') as f:
    data = json.load(f)
    # print(data['name'])

output1 = pd.read_json('../output/saludo.json', orient='split')
print('Module2: ', output1['saludo'].values[0], ', ', data['name'], sep='')
