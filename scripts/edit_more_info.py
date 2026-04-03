from flask import Flask, render_template_string, request, redirect, url_for
from config.settings import DB_HOST, DB_USER, DB_PASSWORD, DB_NAME
import pymysql

app = Flask(__name__)

HTML_TEMPLATE = '''
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Queue History - More Info Editor</title>
    <style>
        body { font-family: Arial, sans-serif; }
        .container { max-width: 700px; margin: 40px auto; }
        textarea { width: 100%; height: 300px; font-family: monospace; font-size: 1em; }
        label { font-weight: bold; }
        .row { margin-bottom: 20px; }
        .btn { padding: 8px 18px; font-size: 1em; }
    </style>
</head>
<body>
    <div class="container">
        <h1>Edit More Info (queue_uid={{ queue_uid }})</h1>
        <form method="post">
            <div class="row">
                <label for="more_info">More Info:</label><br>
                <textarea name="more_info" id="more_info">{{ more_info }}</textarea>
            </div>
            <button class="btn" type="submit">Save</button>
            <a href="/queue_history" class="btn">Back to List</a>
        </form>
        {% if message %}<div style="color: green;">{{ message }}</div>{% endif %}
        {% if error %}<div style="color: red;">{{ error }}</div>{% endif %}
    </div>
</body>
</html>
'''

@app.route("/queue_history/edit/<int:queue_uid>", methods=["GET", "POST"])
def edit_more_info(queue_uid):
    message = error = None
    more_info = ""
    conn = pymysql.connect(host=DB_HOST, user=DB_USER, password=DB_PASSWORD, db=DB_NAME)
    try:
        with conn.cursor() as cur:
            if request.method == "POST":
                more_info = request.form.get("more_info", "")
                # Save as bytes
                cur.execute("UPDATE queue_history SET more_info=%s WHERE queue_uid=%s", (more_info.encode('utf-8'), queue_uid))
                conn.commit()
                message = "Saved successfully."
            cur.execute("SELECT more_info FROM queue_history WHERE queue_uid=%s", (queue_uid,))
            row = cur.fetchone()
            if row and row[0]:
                more_info = row[0].decode('utf-8', errors='replace') if isinstance(row[0], (bytes, bytearray)) else str(row[0])
    except Exception as e:
        error = str(e)
    finally:
        conn.close()
    return render_template_string(HTML_TEMPLATE, queue_uid=queue_uid, more_info=more_info, message=message, error=error)

if __name__ == "__main__":
    app.run(debug=True)
