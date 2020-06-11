insert into USER(username, password, role, enabled)
          values('Teacher1', '1234', 'ROLE_ADMIN', TRUE),
                ('Teacher2', '5678', 'ROLE_ADMIN', TRUE),
                ('Student1', '5678', 'ROLE_USER', TRUE);

insert into TASK(task_name, task_description, created_at, user_id)
          values('Task 1. Create Lorem ipsum dolor sit amet.', 'Lorem ipsum dolor sit amet.', '2020-01-01 13:30', 1),
                ('Task 2', 'Lorem ipsum dolor sit amet, consectetur adipisicing elit. Nam natus, aliquid totam commodi minus placeat labore accusantium provident illum atque.', '2020-01-01 13:30', 1),
                ('Task Super', 'Description for Super task', '2020-01-01 13:32', 2);

insert into SUBMISSION(solution, grade, created_at, task_id, user_id)
          values('Lorem ipsum dolor sit amet consectetur adipisicing elit. Assumenda, fuga iste. Ipsa ex temporibus quo quibusdam aliquid animi, sed esse iusto adipisci sunt aliquam, sapiente possimus velit ut vero? Voluptatem.', 5, '2020-01-01 13:30', 1, 3),
                ('My solution Lorem ipsum 2', 3, '2020-01-03 13:30', 1, 3),
                ('My solution 2', 4, '2020-01-03 13:30', 2, 3);