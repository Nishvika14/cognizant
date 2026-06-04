create database cognizant;
use cognizant;
create table Users(user_id INT PRIMARY KEY auto_increment,full_name VARCHAR(100) NOT NULL,email VARCHAR(100) NOT NULL unique,city VARCHAR(100) NOT NULL,registration_date date NOT NULL);
desc Users;
create table Events(event_id INT PRIMARY KEY auto_increment,title VARCHAR(200) not null,description text,city varchar(100) not null,start_date DATETIME not null,end_date datetime not null,status enum('upcoming','completed','cancelled'),organizer_id INT,constraint fk foreign key(organizer_id) references Users(user_id));
create table Sessions(session_id int primary key auto_increment,event_id int,title varchar(200) not null,speaker_name varchar(100) not null,start_time datetime not null,end_time datetime not null,constraint fk1 foreign key(event_id) references Events(event_id));
desc Events;
desc Sessions;
create table Registrations(registration_id int primary key auto_increment,user_id int,event_id int,registration_date date not null,constraint fkuidreg foreign key(user_id) references Users(user_id),constraint fkeidreg foreign key(event_id) references Events(event_id));
desc Registrations;
create table Feedback(feedback_id int primary key auto_increment,user_id int,event_id int,rating int check(rating between 1 and 5),comments text,feedback_date date not null,constraint fkuidfeed foreign key(user_id) references Users(user_id),constraint fkeidfeed foreign key(event_id) references Events(event_id));
desc Feedback;
create table Resources(resource_id int primary key auto_increment,event_id int,resource_type enum('pdf','image','link'),resource_url varchar(225) not null,uploaded_at datetime not null,constraint fkeidresource foreign key(event_id) references Events(event_id));
desc Resources;
insert into Users(full_name,email,city,registration_date) values('Alice Johnson','alice@example.com','New York','2024-12-01'),('Bob Smith','bob@example.com','Los Angeles','2024-12-05'),('Charlie Lee','charlie@example.com','Chicago','2024-12-10'),('Diana King','diana@example.com','New York','2025-01-15'),('Ethan Hunt','ethan@example.com','Los Angeles','2025-02-01');
select * from users;
insert into Events(title,description,city,start_date,end_date,status,organizer_id) values ('Tech Innovators Meetup','A meetup for tech enthusiasts.','New York','2025-06-10 10:00:00','2025-06-10 16:00:00','upcoming',1),('AI & ML Conference','Conference on AI and ML advancements','Chicago','2025-05-15 09:00:00','2025-05-15 17:00:00','completed',3),('Frontend Development Bootcamp','Hands-on training on frontend tech.','Los Angeles','2025-07-01 10:00:00','2025-07-03 16:00:00','upcoming',2);
select * from Events;
insert into Sessions(event_id,title,speaker_name,start_time,end_time) values(1,'Opening Keynote','Dr.Tech','2025-06-10 10:00:00','2025-06-10 11:00:00'),(1,'Future of Web Dev','Alice Johnson','2025-06-10 11:15:00','2025-06-10 12:30:00'),(2,'AI in Healthcare','Charlie Lee','2025-05-15 09:30:00','2025-05-15 11:00:00'),(3,'Intro to HTML5','Bob Smith','2025-07-01 10:00:00','2025-07-01 12:00:00');
select * from Sessions;
insert into Registrations(user_id,event_id,registration_date) values (1,1,'2025-05-01'),(2,1,'2025-05-02'),(3,2,'2025-04-30'),(4,2,'2025-04-28'),(5,3,'2025-06-15');
select * from Registrations;
insert into Feedback(user_id,event_id,rating,comments,feedback_date) values (3,2,4,'Great insights!','2025-05-16'),(4,2,5,'Very informative.','2025-05-16'),(2,1,3,'Could be better.','2025-06-11');
select * from feedback;
insert into Resources(event_id,resource_type,resource_url,uploaded_at) values (1,'pdf','https://portal.com/resources/tech_meetup_agenda.pdf','2025-05-01 10:00:00'),(2,'image','https://portal.com/resources/ai_poster.jpg','2025-04-20 09:00:00'),(3,'link','https://portal.com/resources/html5_docs','2025-06-25 15:00:00');
select * from resources;


select u.full_name,e.title,e.city,e.start_date from users u
join registrations r on u.user_id=r.user_id
join events e on e.event_id=r.event_id
where e.status='upcoming' and u.city=e.city
order by e.start_date;


select e.title,e.event_id,avg(f.rating),count(*) from events e 
join feedback f on e.event_id=f.event_id
group by e.event_id,e.title
having count(*)>=10
order by avg(f.rating) desc;


select * from users
where registration_date<curdate()- interval 90 day;


SELECT e.event_id, e.title,
       COUNT(s.session_id) AS session_count
FROM Events e
LEFT JOIN Sessions s
ON e.event_id = s.event_id
AND TIME(s.start_time) BETWEEN '10:00:00' AND '12:00:00'
GROUP BY e.event_id, e.title;


SELECT u.city,
       COUNT(DISTINCT r.registration_id) AS registrations
FROM Users u
JOIN Registrations r ON u.user_id = r.user_id
GROUP BY u.city
ORDER BY registrations DESC
LIMIT 5;


SELECT e.event_id,
       e.title,
       COUNT(CASE WHEN resource_type='pdf' THEN 1 END) AS pdf_count,
       COUNT(CASE WHEN resource_type='image' THEN 1 END) AS image_count,
       COUNT(CASE WHEN resource_type='link' THEN 1 END) AS link_count
FROM Events e
LEFT JOIN Resources r ON e.event_id = r.event_id
GROUP BY e.event_id, e.title;


SELECT u.full_name,
       e.title,
       f.rating,
       f.comments
FROM Feedback f
JOIN Users u ON f.user_id = u.user_id
JOIN Events e ON f.event_id = e.event_id
WHERE f.rating < 3;


SELECT e.event_id,
       e.title,
       COUNT(s.session_id) AS total_sessions
FROM Events e
LEFT JOIN Sessions s ON e.event_id = s.event_id
WHERE e.status='upcoming'
GROUP BY e.event_id, e.title;


SELECT u.user_id,
       u.full_name,
       e.status,
       COUNT(*) AS event_count
FROM Users u
JOIN Events e ON u.user_id = e.organizer_id
GROUP BY u.user_id, u.full_name, e.status;


SELECT e.event_id,
       e.title
FROM Events e
JOIN Registrations r ON e.event_id = r.event_id
LEFT JOIN Feedback f ON e.event_id = f.event_id
GROUP BY e.event_id, e.title
HAVING COUNT(f.feedback_id) = 0;


SELECT registration_date,
       COUNT(*) AS users_registered
FROM Users
WHERE registration_date >= CURDATE() - INTERVAL 7 DAY
GROUP BY registration_date
ORDER BY registration_date;

SELECT e.event_id, e.title, COUNT(s.session_id) AS total_sessions
FROM Events e
JOIN Sessions s ON e.event_id = s.event_id
GROUP BY e.event_id, e.title
HAVING COUNT(s.session_id) = (
    SELECT MAX(session_count)
    FROM (
        SELECT COUNT(*) AS session_count
        FROM Sessions
        GROUP BY event_id
    ) t
);


SELECT e.city,
       ROUND(AVG(f.rating),2) AS avg_rating
FROM Events e
JOIN Feedback f ON e.event_id = f.event_id
GROUP BY e.city;


SELECT e.event_id,
       e.title,
       COUNT(r.registration_id) AS registrations
FROM Events e
JOIN Registrations r ON e.event_id = r.event_id
GROUP BY e.event_id, e.title
ORDER BY registrations DESC
LIMIT 3;


SELECT s1.event_id,
       s1.title AS session1,
       s2.title AS session2
FROM Sessions s1
JOIN Sessions s2
ON s1.event_id = s2.event_id
AND s1.session_id < s2.session_id
AND s1.start_time < s2.end_time
AND s1.end_time > s2.start_time;


SELECT *
FROM Users u
WHERE u.registration_date >= CURDATE() - INTERVAL 30 DAY
AND NOT EXISTS (
    SELECT 1
    FROM Registrations r
    WHERE r.user_id = u.user_id
);


SELECT speaker_name,
       COUNT(*) AS total_sessions
FROM Sessions
GROUP BY speaker_name
HAVING COUNT(*) > 1;


SELECT e.event_id,
       e.title
FROM Events e
LEFT JOIN Resources r ON e.event_id = r.event_id
WHERE r.resource_id IS NULL;


SELECT e.event_id,
       e.title,
       COUNT(DISTINCT r.registration_id) AS registrations,
       ROUND(AVG(f.rating),2) AS avg_rating
FROM Events e
LEFT JOIN Registrations r ON e.event_id = r.event_id
LEFT JOIN Feedback f ON e.event_id = f.event_id
WHERE e.status = 'completed'
GROUP BY e.event_id, e.title;


SELECT u.user_id,
       u.full_name,
       COUNT(DISTINCT r.event_id) AS events_attended,
       COUNT(DISTINCT f.feedback_id) AS feedback_submitted
FROM Users u
LEFT JOIN Registrations r ON u.user_id = r.user_id
LEFT JOIN Feedback f ON u.user_id = f.user_id
GROUP BY u.user_id, u.full_name;


SELECT u.user_id,
       u.full_name,
       COUNT(f.feedback_id) AS feedback_count
FROM Users u
JOIN Feedback f ON u.user_id = f.user_id
GROUP BY u.user_id, u.full_name
ORDER BY feedback_count DESC
LIMIT 5;


SELECT user_id,
       event_id,
       COUNT(*) AS registration_count
FROM Registrations
GROUP BY user_id, event_id
HAVING COUNT(*) > 1;


SELECT YEAR(registration_date) AS year,
       MONTH(registration_date) AS month,
       COUNT(*) AS registrations
FROM Registrations
WHERE registration_date >= CURDATE() - INTERVAL 12 MONTH
GROUP BY YEAR(registration_date), MONTH(registration_date)
ORDER BY year, month;


SELECT e.event_id,
       e.title,
       ROUND(AVG(
           TIMESTAMPDIFF(MINUTE,
                         s.start_time,
                         s.end_time)
       ),2) AS avg_duration_minutes
FROM Events e
JOIN Sessions s ON e.event_id = s.event_id
GROUP BY e.event_id, e.title;


SELECT e.event_id,
       e.title
FROM Events e
LEFT JOIN Sessions s
ON e.event_id = s.event_id
WHERE s.session_id IS NULL;



