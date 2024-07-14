#Q1. Identify the five oldest users on Instagram from the provided database. 
select * from users order by created_at limit 5; 

#Q2.  Identify users who have never posted a single photo on Instagram. 
select u.id,u.username from users u left join photos p 
       on u.id=p.user_id where p.user_id is null;

#Q3. Identify top 3 photos which got most no of likes.
with no_of_likes as (select count(user_id)as likes,photo_id from likes group by photo_id order by likes desc limit 3)
select n.photo_id, p.user_id,u.username from no_of_likes n join photos p on n.photo_id= p.id
                                              join users u on p.user_id= u.id ;  

#Q4. Identify and suggest the top 5 most commonly used hashtags on the platform
select count(photo_id)as total, tag_id, tag_name from photo_tags p join tags t on p.tag_id=t.id group by tag_id order by tag_id desc limit 5 ;

#Q5. What day of the week do most users register on? Provide insights on when to schedule an ad campaign 
select count(id)as user_count,dayname(created_at)as dayna from users group by dayna order by user_count desc ;


#QQ 1)	Provide how many times does average user posts on Instagram. Also, provide the total number of photos on Instagram/total number of users
with base as( 
select u.id as userid,count(p.id) as photoid from users u left join photos p on 
p.user_id=u.id group by u.id) 
select sum(photoid) as total_photos,count(userid) as total_users, 
sum(photoid)/count(userid) as photo_per_user 
from base;

# 2) Provide data on users (bots) who have liked every single photo on the site (since any normal user would not be able to do this).
with base as (select user_id,count(photo_id)as photo_likes from likes group by user_id order by photo_likes desc)
select user_id from base  where photo_likes = (select count(*) from photos) ;






