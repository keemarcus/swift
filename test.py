import requests
import dataset

taskbook_db = dataset.connect('sqlite:///taskbook.db')

# testing
def test_database():
    assert taskbook_db.tables != None

def test_database_table():
    assert "task" in taskbook_db.tables

def test_database_columns():
    assert taskbook_db.get_table('task').columns == ['id', 'time', 'description', 'list', 'completed', 'prio', 'order']

r = requests.get("http://swift-keemarcus.pythonanywhere.com/")
def test_tables_loaded():
    assert '<table id="task-list-today"' in r.text
    assert '<table  id="task-list-tomorrow"' in r.text
    assert '<table id="task-list-later"' in r.text