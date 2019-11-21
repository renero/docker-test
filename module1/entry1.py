import pandas as pd

df = pd.read_csv('../data/file.csv', delimiter=',')
# print(df)

df.to_json('../output/saludo.json', orient='split')
print('Module1: Saved json to output')
