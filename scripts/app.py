from flask import Flask, render_template_string, request, redirect, url_for
from config.settings import DB_HOST, DB_USER, DB_PASSWORD, DB_NAME
import pymysql

app = Flask(__name__)

# Shared HTML templates
TABLE_TEMPLATE = '''
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>MySQL Data Viewer</title>
    <style>
        .table-container { max-height: 400px; overflow: auto; border: 1px solid #ccc; }
        table { border-collapse: collapse; width: 100%; min-width: 600px; }
        th, td { border: 1px solid #ccc; padding: 8px; text-align: left; }
        th { background: #f4f4f4; position: sticky; top: 0; z-index: 2; }
        form { margin-bottom: 20px; }
        input[type=text] { width: 60%; padding: 6px; }
        input[type=submit] { padding: 6px 12px; }
        label { margin-right: 10px; }
        .edit-link { color: #007bff; text-decoration: underline; cursor: pointer; }
    </style>
</head>
<body>
    <h1>MySQL Data Viewer</h1>
    <form method="post">
        <label>Query:</label>
        <input type="text" name="query" value="{{ query }}" />
        <input type="submit" value="Run Query" />
    </form>
    {% if error %}
    <div style="color: red;">{{ error }}</div>
    {% endif %}
    {% if columns %}
    <div class="table-container">
    <table>
        <thead>
            <tr>
                {% for col in columns %}<th>{{ col }}</th>{% endfor %}
                {% if show_edit %}<th>Edit</th>{% endif %}
            </tr>
        </thead>
        <tbody>
            {% for row in rows %}
            <tr>
                {% for cell in row %}<td>{{ cell }}</td>{% endfor %}
                {% if show_edit %}
                <td>
                    <a class="edit-link" href="{{ url_for('edit_more_info', queue_uid=row[0]) }}">Edit More Info</a>
                </td>
                {% endif %}
            </tr>
            {% endfor %}
        </tbody>
    </table>
    </div>
    {% endif %}
</body>
</html>
'''

EDIT_TEMPLATE = '''
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Queue History - More Info Editor</title>
    <script src="https://cdn.tiny.cloud/1/no-api-key/tinymce/6/tinymce.min.js" referrerpolicy="origin"></script>
    <script>
      tinymce.init({
        selector: '#more_info',
        height: 350,
        menubar: false,
        plugins: 'lists link code',
        toolbar: 'undo redo | bold italic underline | forecolor backcolor | alignleft aligncenter alignright alignjustify | bullist numlist outdent indent | link | code',
        content_style: 'body { font-family:Arial,sans-serif; font-size:16px; }'
      });
    </script>
    <style>
        body { font-family: Arial, sans-serif; }
        .container { max-width: 700px; margin: 40px auto; }
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
                <textarea name="more_info" id="more_info">{{ more_info|safe }}</textarea>
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


# Main data viewer page
@app.route("/", methods=["GET", "POST"])
def index():
    default_query = "SELECT * FROM opd_treatment LIMIT 100"
    query = default_query
    if request.method == "POST":
        query = request.form.get("query", default_query)
    results = []
    columns = []
    error = None
    if query:
        try:
            q = query.strip().rstrip(';')
            conn = pymysql.connect(host=DB_HOST, user=DB_USER, password=DB_PASSWORD, db=DB_NAME)
            with conn.cursor() as cur:
                cur.execute(q)
                results = cur.fetchall()
                columns = [desc[0].replace('_', ' ') for desc in cur.description] if cur.description else []
                def convert_row(row):
                    return [cell.decode('utf-8', errors='replace') if isinstance(cell, (bytes, bytearray)) else cell for cell in row]
                results = [convert_row(row) for row in results]
            conn.close()
        except Exception as e:
            error = str(e)
    return render_template_string(TABLE_TEMPLATE, columns=columns, rows=results, query=query, error=error, show_edit=False)

# Dedicated queue_history page with edit links
@app.route("/queue_history", methods=["GET", "POST"])
def queue_history():
    default_query = "SELECT * FROM queue_history ORDER BY queue_uid DESC LIMIT 100"
    query = default_query
    if request.method == "POST":
        query = request.form.get("query", default_query)
    results = []
    columns = []
    error = None
    show_edit = True
    try:
        conn = pymysql.connect(host=DB_HOST, user=DB_USER, password=DB_PASSWORD, db=DB_NAME)
        with conn.cursor() as cur:
            cur.execute(query)
            results = cur.fetchall()
            columns = [desc[0].replace('_', ' ') for desc in cur.description] if cur.description else []
            def convert_row(row):
                return [cell.decode('utf-8', errors='replace') if isinstance(cell, (bytes, bytearray)) else cell for cell in row]
            results = [convert_row(row) for row in results]
        conn.close()
    except Exception as e:
        error = str(e)
    # Add a query form above the table
    query_form = '''<form method="post" style="margin-bottom:20px;">
        <label>Query:</label>
        <input type="text" name="query" value="{}" style="width:60%;padding:6px;" />
        <input type="submit" value="Run Query" style="padding:6px 12px;" />
    </form>'''.format(query.replace('"', '&quot;'))
    table_html = render_template_string(TABLE_TEMPLATE, columns=columns, rows=results, query=query, error=error, show_edit=show_edit)
    return query_form + table_html

@app.route("/queue_history/edit/<int:queue_uid>", methods=["GET", "POST"])
def edit_more_info(queue_uid):
    message = error = None
    more_info = ""
    conn = pymysql.connect(host=DB_HOST, user=DB_USER, password=DB_PASSWORD, db=DB_NAME)
    try:
        with conn.cursor() as cur:
            if request.method == "POST":
                more_info = request.form.get("more_info", "")
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
    return render_template_string(EDIT_TEMPLATE, queue_uid=queue_uid, more_info=more_info, message=message, error=error)

if __name__ == "__main__":
    app.run(debug=True)
