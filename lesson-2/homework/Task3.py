import pyodbc

con_string = "DRIVER={SQL SERVER};SERVER=WIN-4T5JL30DQFB;DATABASE=DBforhomework;Trusted_Connection=yes;"
con = pyodbc.connect(con_string)

cursor = con.cursor()

cursor.execute("SELECT * FROM photos")
row = cursor.fetchone()
id,image = row

with open('peach.png', 'wb') as f:
    f.write(image)