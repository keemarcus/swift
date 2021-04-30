import dataset

if __name__ == "__main__":
    taskbook_db = dataset.connect('sqlite:///taskbook.db')  
    task_table = taskbook_db.get_table('task')
    if task_table.columns != ['id', 'description', 'date', 'deadline', 'list', 'completed', 'prio', 'order', 'userId']:
        task_table.drop()
        task_table = taskbook_db.create_table('task')
        task_table.insert_many([
            {"description":"Do something useful", "date":"2021-03-03", "deadline":"2021-03-04", "list":"today", "completed":True, "prio":False, "order":0},
            {"description":"Do something fantastic", "date":"2021-03-03", "deadline":"2021-03-04", "list":"today", "completed":False, "prio":False, "order":0},
            {"description":"Do something remarkable", "date":"2021-03-03", "deadline":"2021-03-04", "list":"tomorrow", "completed":False, "prio":False, "order":0},
            {"description":"Do something tomorrow", "date":"2021-03-03", "deadline":"2021-03-04", "list":"tomorrow", "completed":False, "prio":False, "order":0},
            {"description":"Do something later", "date":"2021-03-03", "deadline":"2021-03-04", "list":"later", "completed":False, "prio":False, "order":0},
            {"description":"Do something cool", "date":"2021-03-03", "deadline":"2021-03-04", "list":"later", "completed":True, "prio":False, "order":0},
            {"description":"default user task", "date":"2021-03-03", "deadline":"2021-03-04", "list":"today", "completed":False, "prio":False, "order":0, "userId":1},
            {"description":"admin task", "date":"2021-03-03", "deadline":"2021-03-04", "list":"today", "completed":False, "prio":False, "order":0, "userId":2}
        ])
        print("Created new task table: ") 
        print(task_table.columns)

    user_table = taskbook_db.get_table('user')
    if user_table.columns != ['id', 'username', 'password', 'salt']:
        user_table.drop()
        user_table = taskbook_db.create_table('user')
        user_table.insert_many([
            {"username":"default", "password":"24b5bcf5e8c233d466ad3364afe80195f4e208ea2cda4d31a48fe7e771c8d162", "salt":"d159a141a66560a848c6938d39eb8e4c"},
            {"username":"admin", "password":"8b90f58c40b68752abe64d27e5e3e95c00478cc571c3349fd6dc8c6856fd6454", "salt":"2803dab17326f7adc82355b78d484c53"}
        ])
        print("Created new user table: ") 
        print(user_table.columns)
        
print("done.")
