import dataset

if __name__ == "__main__":
    taskbook_db = dataset.connect('sqlite:///taskbook.db')  
    task_table = taskbook_db.get_table('task')
    task_table.drop()
    task_table = taskbook_db.create_table('task')
    task_table.insert_many([
        {"description":"Do something useful", "date":"2021-03-03", "deadline":"2021-03-4", "list":"today", "completed":True, "prio":False, "order":0},
        {"description":"Do something fantastic", "date":"2021-03-03", "deadline":"2021-03-4", "list":"today", "completed":False, "prio":False, "order":0},
        {"description":"Do something remarkable", "date":"2021-03-03", "deadline":"2021-03-4", "list":"tomorrow", "completed":False, "prio":False, "order":0},
        {"description":"Do something tomorrow", "date":"2021-03-03", "deadline":"2021-03-4", "list":"tomorrow", "completed":False, "prio":False, "order":0},
        {"description":"Do something later", "date":"2021-03-03", "deadline":"2021-03-4", "list":"later", "completed":False, "prio":False, "order":0},
        {"description":"Do something cool", "date":"2021-03-03", "deadline":"2021-03-4", "list":"later", "completed":True, "prio":False, "order":0},
        {"description":"default user task", "date":"2021-03-03", "deadline":"2021-03-4", "list":"today", "completed":False, "prio":False, "order":0, "userId":1},
        {"description":"admin task", "date":"2021-03-03", "deadline":"2021-03-4", "list":"today", "completed":False, "prio":False, "order":0, "userId":2}
    ])

    user_table = taskbook_db.get_table('user')
    user_table.drop()
    user_table = taskbook_db.create_table('user')
    user_table.insert_many([
        {"username":"default", "password":"1234"},
        {"username":"admin", "password":"admin"}
    ])