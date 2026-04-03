
from flask import Flask, render_template_string, request
from config.settings import DB_HOST, DB_USER, DB_PASSWORD, DB_NAME
from utils.db_utils import query_database

app = Flask(__name__)

HTML_TEMPLATE = '''
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
        input[type=text], input[type=number] { padding: 6px; }
        input[name=query] { width: 60%; }
        input[type=submit] { padding: 6px 12px; }
        label { margin-right: 10px; }
    </style>
</head>
<body>
    <h1>MySQL Data Viewer</h1>
    <form method="post">
        <label>Query:</label>
        <input type="text" name="query" value="{{ query }}" />
        <label>Limit:</label>
        <input type="number" name="limit" value="{{ limit }}" min="1" max="10000" />
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
            </tr>
        </thead>
        <tbody>
            {% for row in rows %}
            <tr>
                {% for cell in row %}<td>{{ cell }}</td>{% endfor %}
            </tr>
            {% endfor %}
        </tbody>
    </table>
    </div>
    {% endif %}
</body>
</html>
'''


@app.route("/", methods=["GET", "POST"])
def index():
    default_query = "SELECT * FROM opd_treatment"
    query = default_query
    limit = 100
    if request.method == "POST":
        query = request.form.get("query", default_query)
        try:
            limit = int(request.form.get("limit", 100))
        except Exception:
            limit = 100
    results = []
    columns = []
    error = None
    if query:
        try:
            # Add LIMIT to query if not present
            q = query.strip().rstrip(';')
            if not q.lower().endswith(f"limit {limit}"):
                if "limit" not in q.lower():
                    q = f"{q} LIMIT {limit}"
            import pymysql
            conn = pymysql.connect(host=DB_HOST, user=DB_USER, password=DB_PASSWORD, db=DB_NAME)
            try:
                with conn.cursor() as cur:
                    cur.execute(q)
                    results = cur.fetchall()
                    # Get column names from cursor description
                    columns = [desc[0].replace('_', ' ') for desc in cur.description] if cur.description else []
                # Convert binary data to string for display
                def convert_row(row):
                    return [cell.decode('utf-8', errors='replace') if isinstance(cell, (bytes, bytearray)) else cell for cell in row]
                results = [convert_row(row) for row in results]
            finally:
                conn.close()
        except Exception as e:
            error = str(e)
    return render_template_string(HTML_TEMPLATE, columns=columns, rows=results, query=query, limit=limit, error=error)

if __name__ == "__main__":
    app.run(debug=True)
