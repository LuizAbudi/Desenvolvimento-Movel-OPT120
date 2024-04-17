INSERT INTO opt120.users (name,email,password) VALUES
	 ('Luiz','teste@teste.com','123456'),
	 ('Luiz2','teste@teste.com','123456'),
	 ('Luiz3','teste@teste.com','123456'),
	 ('Luiz4','teste@teste.com','123456'),
	 ('Luiz5','teste@teste.com','123456'),
	 ('teste','teste@teste.com','123456'),
	 ('Luiz6','teste@teste.com','123456');

INSERT INTO opt120.activities (title,description,due_date) VALUES
	 ('asdads','asdasdasd','2024-04-30 00:00:00'),
	 ('asdasda13123123','dasdasdasd','2024-04-15 00:00:00');

INSERT INTO opt120.user_activities (user_id,activity_id,delivery_date,score) VALUES
	 (1,9,'2024-04-17 00:00:00',9.0),
	 (3,10,'2024-04-17 00:00:00',5.0),
	 (8,10,'2024-04-18 00:00:00',4.0);
