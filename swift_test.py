from selenium import webdriver
from selenium.webdriver.common.keys import Keys
import time
import requests
import dataset

taskbook_db = dataset.connect('sqlite:///taskbook.db')

# testing
def test_database():
    assert taskbook_db.tables != None

def test_database_table():
    assert "task" in taskbook_db.tables

def test_database_columns():
    assert taskbook_db.get_table('task').columns == ['id', 'time', 'description', 'date', 'deadline', 'list', 'completed', 'prio', 'order']


tasks_url = "http://swift-keemarcus.pythonanywhere.com"

def test_has_correct_columns():
    driver = webdriver.Chrome()
    try:
        driver.get(tasks_url)
        header_elements = driver.find_elements_by_tag_name("h1")
        assert len(header_elements) > 0
        column_titles = [e.text for e in header_elements]
        assert column_titles[0] == "Today"
        assert column_titles[1] == "Tomorrow"
        assert column_titles[2] == "Later"
        assert len(column_titles) == 3
    except Exception as e:
        driver.close()
        raise e
    driver.close()

def test_date_not_empty():
    driver = webdriver.Chrome()
    try:
        driver.get(tasks_url)
        date_elements = driver.find_elements_by_class_name("dates")
        for d in date_elements:
            assert len(d.text) != ""
            assert len(d.text) == 40
    except Exception as e:
        driver.close()
        raise e
    driver.close()

if __name__ == "__main__":
    test_date_not_empty()