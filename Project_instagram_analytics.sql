use ig_clone;
select* from comments;
select* from follows;
select* from likes;
select* from photo_tags;
select* from photos;
select* from tags;
select* from users;

-- Rewarding the most loyal customer 
SELECT * FROM ig_clone.users 
ORDER BY created_at LIMIT 5;  

-- Inactive users who are needed reminder to start posting
SELECT username FROM ig_clone.users 
LEFT JOIN ig_clone.photos    ON users.id = photos.user_id 
WHERE photos.id IS NULL;

-- Declaring contest winner 
SELECT username, photos.id, photos.image_url,  COUNT(*) AS total 
FROM ig_clone.photos 
INNER JOIN ig_clone.likes  ON likes.photo_id = photos.id 
INNER JOIN ig_clone.users  ON photos.user_id = users.id 
GROUP BY photos.id 
ORDER BY total DESC LIMIT 1;

-- Five most commonly used hashtags
SELECT tags.tag_name, Count(*) AS total 
FROM  ig_clone.photo_tags       
JOIN ig_clone.tags  ON photo_tags.tag_id = tags.id 
GROUP  BY tags.id 
ORDER  BY total DESC LIMIT 5; 

-- Launching day for ad campagin
SELECT   DAYNAME(created_at) AS day, COUNT(*) AS total 
FROM ig_clone.users 
GROUP BY day 
ORDER BY total DESC LIMIT 3;

-- The average number of times users posted on Instagram
SELECT (SELECT Count(*)    FROM   ig_clone.photos) / 
(SELECT Count(*)  FROM ig_clone.users) AS avg; 

-- Bots & fake accounts 
SELECT username, Count(*) AS num_likes 
FROM   ig_clone.users        
INNER JOIN ig_clone.likes  ON users.id = likes.user_id 
GROUP  BY likes.user_id HAVING num_likes = (SELECT Count(*) FROM  ig_clone.photos); 



