import pymysql, pymysql.cursors
from dotenv import load_dotenv
load_dotenv()
import os
conn = pymysql.connect(host=os.getenv('DB_HOST'), user=os.getenv('DB_USER'), password=os.getenv('DB_PASSWORD'), db=os.getenv('DB_NAME'), charset='utf8mb4', cursorclass=pymysql.cursors.DictCursor)
cur = conn.cursor()
cur.execute('SHOW TABLES LIKE "%doctor%"')
print('doctor-like tables:', cur.fetchall())
cur.execute('SHOW TABLES LIKE "%staff%"')
print('staff-like tables:', cur.fetchall())
cur.execute('SHOW TABLES LIKE "%user%"')
print('user-like tables:', cur.fetchall())
conn.close()
