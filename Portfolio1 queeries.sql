
/*Users */

drop table if exists users CASCADE ;
create table users (
UserID serial primary key, 
name varchar(200),
age int,
USERNAME varchar(200),language varchar(200)

)
;
insert into users(name,age,username,language)
values ('Ali',30,'ali@ruc.dk','[Danish, English]'),
('Bob-Winston',23,'bob@ruc.dk','[Danish, English]'),
( 'Lenka',23,'lenka@ruc.dk','[English, Slovac]'),
('Konstantin',23,'konstantin@ruc.dk','[English, Russian]')
;


/*ACTORS_known_for_titles */

 drop table if exists Actors_known_for_titles;
create table Actors_known_for_titles(
 nconst VARCHAR(55),

 knownfortitles  varchar(800)

 ); 
INSERT INTO Actors_known_for_titles( nconst,knownfortitles)
SELECT distinct(nconst), regexp_split_to_table(knownfortitles,',') from name_basics  ;

 

/*Actors_profession */

drop table if exists Actors_Profession;
create table Actors_Profession(


nconst VARCHAR(55),

 primaryprofession  varchar(800)
  

 ); 
INSERT INTO Actors_Profession( nconst,primaryprofession)
SELECT distinct(nconst), regexp_split_to_table(primaryprofession,',')   from name_basics;

/* bookmarkTitles */

drop table if exists bookmarkTitles;
create table bookmarkTitles(


UserID int,
tconst varchar(200))
;

insert into bookmarkTITLEs (userid)
select userid from users;

UPDATE bookmarkTitles SET tconst = 'tt10850402' WHERE userid > 0 and tconst is null ;

/* bookmarkpersons */

drop table if exists bookmarkPersons;
create table bookmarkPersons(
UserID int,
nconst varchar(200))
;

insert into bookmarkpersons (userid)
select userid from users;

UPDATE bookmarkpersons SET nconst = 'nm0000015' WHERE userid > 0 and nconst is null ;

/* DIRECTORS */

drop table if exists directors;
create table directors(

 
tconst VARCHAR(55),

nconst text

 ); 
INSERT INTO directors( tconst,nconst)

SELECT tconst, regexp_split_to_table(directors,',')  from title_Crew 

 ; 


 /*NAME_basicsNEW */


drop table if exists name_basicsNew cascade;
create table name_basicsNew (

nconst    varchar(800)    ,

primaryname varchar(256),

birthyear bpchar(800),

deathyear bpchar(600),

primary key (nconst)
 
 ); 



INSERT INTO name_basicsNEW(  nconst, primaryname, birthyear, deathyear)
SELECT nconst, primaryname, birthyear, deathyear   
from name_basics ;



/*search_history */

drop table if exists Search_History ;
create table search_history (
UserID int,
search_input varchar(200),
search_Date date
 )
;



/* Title_BASICsNEW */

drop table if exists Title_BasicsNEW cascade ;
create table Title_BasicsNEW(

 
tconst VARCHAR(55),

titletype  varchar(800),
 primaryTitle text,
  originalTitle text,
      isadult bool,
	 startYear varchar(800),
	  endyear varchar(800),
	runtimeminutes varchar(800),
		 poster varchar(200),
		 awards varchar (200), 
		 plot text,
		 averagerating decimal,
		constraint valid_number 
      check (averagerating <= 10), 
		 numvotes int
 
 

 ); 
INSERT INTO title_basicsNEW(tconst,titletype,primarytitle,
  originalTitle,
	 isadult,
	 startYear,
	  endyear,
		runtimeminutes, poster ,
		 awards , plot , averagerating, numvotes
		 
		
		      )
		
		
SELECT distinct title_Basics.tconsT, titleType,primarytitle, 
  originalTitle,
	 isadult,
	 startYear,
	  endyear,
		runtimeminutes , poster, awards, plot, averagerating, numvotes
      from title_basics natural left outer join omdb_data natural left outer join title_ratings 
			 

 ; 
 


/*Title_ Genres */


drop table if exists title_genre;
create table title_genre(

 
tconst VARCHAR(55),
genres  varchar(800)


 ); 
INSERT INTO title_genre( tconst,genres)
SELECT tconst, regexp_split_to_table(genres,',')  from title_basics 

 ; 


 

/*UserNameRate */
drop table if exists user_NameRate;
create table user_NameRate(
UserID int REFERENCES users(userid),
Name_individRating int , constraint valid_number 
      check (Name_individRating <= 10 and Name_individRating > 0),
nconst varchar(200), userNameRate_Date date)
 
;


/*UserTitleRate */

drop table if exists user_TitleRate;
create table user_TitleRate(
UserID int REFERENCES users(userid),
individRating_Title int , 
constraint valid_number 
check (individRating_Title <= 10 and individRating_Title > 0),
			
tconst varchar(200), userTitleRate_Date date )

 
;


drop table if exists writers;
create table writers(

 
tconst VARCHAR(55),

 writers  text
 

 ); 
INSERT INTO writers( tconst,writers)
SELECT tconst, regexp_split_to_table(writers,',')  from title_Crew 

 ; 


/* Set column to foreign key */

ALTER TABLE title_basicsnew  drop CONSTRAINT if exists titlebasicsnew_pkey cascade ;

ALTER TABLE title_basicsnew  ADD CONSTRAINT titlebasicsnew_pkey primary KEY (tconst) ;

alter table bookmarkPERSOns add constraint BOOKperson_fk foreign key (nconst) references name_Basicsnew(nconst );

alter table bookmarkPERSOns add constraint BOOKMARKUSER_fk foreign key (userID) references USERS(USERID );

alter table bookmarkPERSOns drop constraint if exists BOOKMARKUSER_pkey ;

alter table bookmarkPERSOns add constraint BOOKMARKUSER_pkey  PRIMARY key (userID,nconst);
 
 alter table bookmarkTITLES add constraint titlename_fk foreign key (tconst) references title_Basicsnew(tconst );

alter table bookmarkTITLES add constraint user_FK foreign key (userid) REFERENCES users(userid);

alter table bookmarkTitles drop constraint if exists BOOKMARKTitles_pkey;

alter table bookmarkTitles add constraint BOOKMARKTitles_pkey  PRIMARY key (userID,tconst);

ALTER TABLE  actors_known_for_titles drop CONSTRAINT if exists ActorsKnown_pkey; 
 
 ALTER TABLE  actors_known_for_titles ADD CONSTRAINT ActorsKnown_pkey PRIMARY KEY (nconst,knownfortitles) ;
  ALTER TABLE  actors_known_for_titles ADD CONSTRAINT nconst_actor FOREIGN KEY (nconst) REFERENCES name_basicsNEW(nconst) ;
 
 ALTER TABLE  actors_profession drop CONSTRAINT if exists Actorsprofession_pkey;
 
 ALTER TABLE  actors_profession ADD CONSTRAINT Actorsprofession_pkey PRIMARY KEY (nconst,primaryprofession) ;
 


ALTER TABLE  actors_profession ADD CONSTRAINT nconst_prof FOREIGN KEY (nconst) REFERENCES name_basicsnew(nconst) ;

ALTER TABLE  directors ADD CONSTRAINT tconst_director FOREIGN KEY (tconst) REFERENCES title_basicsNEW(tconst) ;

ALTER TABLE  directors drop CONSTRAINT if exists directors_pkey;

ALTER TABLE  directors ADD CONSTRAINT directors_pkey primary KEY (tconst,nconst);

ALTER TABLE  Search_history ADD CONSTRAINT UserID FOREIGN KEY (uSERID) REFERENCES uSERS(uSERID);

alter table title_akas drop constraint if exists titleakas_fkey;

ALTER TABLE  title_akas ADD CONSTRAINT titleakas_fkey FOREIGN KEY (titleid) REFERENCES title_basicsNEW(tconst) ;

Alter table title_akas drop constraint if exists titleakas_pkey;
 
ALTER TABLE title_akas  ADD CONSTRAINT titleakas_pkey primary KEY (titleid,ordering) ;


Alter table title_episode drop constraint if exists titleEpisode_fkey;

Alter table title_episode drop constraint if exists titleEpisode_pkey;
ALTER TABLE title_episode  ADD CONSTRAINT titleEpisode_pkey primary KEY (tconst) ;
		
ALTER TABLE title_episode  ADD CONSTRAINT titleEpisode_fkey FOREIGN KEY (tconst) REFERENCES title_basicsNEW(tconst);
		
ALTER TABLE  title_genre ADD CONSTRAINT tconst FOREIGN KEY (tconst) REFERENCES title_basicsNEW(tconst) ;

Alter table title_genre drop constraint if exists title_genre_pkey ;

ALTER TABLE  title_genre ADD CONSTRAINT title_genre_pkey primary KEY (tconst,genres) ;

Alter table title_ratings drop constraint if exists titleRatings_fkey;

 alter table title_principals drop constraint if exists titleprincipals_fkey;
 
 ALTER TABLE  title_principals ADD CONSTRAINT titleprincipals_fkey FOREIGN KEY (tconst) REFERENCES title_basicsNEW(tconst) ;
 
 Alter table title_principals drop constraint if exists titleprincipals_pkey ;

 ALTER TABLE title_principals ADD CONSTRAINT titleprincipals_pkey primary KEY (tconst,ordering) ;


 
  Alter table user_namerate drop constraint if exists user_nameRate_pkey;
	
	
 Alter table user_NameRate add constraint user_NameRate_pkey primary key (nconst,userid) ;
 
 
  Alter table user_namerate drop constraint if exists user_nameRate_fkey;
	
   Alter table user_namerate drop constraint if exists user_nameRate_fkey2;
 
 Alter table user_NameRate add constraint user_NameRate_fkey foreign key (nconst) references name_Basicsnew (nconst) ;
 
  Alter table user_NameRate add constraint user_NameRate_fkey2 foreign key (userid) references  users (userid) ;
 
  
  Alter table user_titlerate drop constraint if exists user_titleRate_pkey;
	
  Alter table user_TitleRate add constraint user_TitleRate_pkey primary key (Tconst,userid) ;
	
  Alter table user_titlerate drop constraint if exists user_titlerate_fkey;
	  Alter table user_titlerate drop constraint if exists user_titlerate_fkey2;
  Alter table user_TitleRate add constraint userTitleRate_fkey foreign key (tconst) references  title_Basicsnew (tconst) ;
	Alter table user_TitleRate add constraint userTitleRate_fkey2 foreign key (userid) references  users (userid) ;
	
  
		
ALTER TABLE wi drop CONSTRAINT if exists wi_fkey;

alter table wi add constraint wi_fkey foreign key (tconst) references title_basicsnew(tconst);

 ALTER TABLE  writers ADD CONSTRAINT tconst_fkey FOREIGN KEY (tconst) REFERENCES title_basicsNEW(tconst) ;
 
  ALTER TABLE  writers ADD CONSTRAINT Writers_pkey primary KEY (tconst,writers);

/*D- TASKS*/


/* D.2 */


drop function if exists string_Search(userid int, strings varchar(800));

create or replace function string_search(userid int, strings varchar(800))

returns table (
  
  primarytitle text
)    
language sql
as $$

insert into search_history( userid, search_input, search_date) 
VALUES (userid, strings, CURRENT_DATE) ; 

select title_basicsnew.primarytitle 
from title_basicsnew
where plot like '%'||strings||'%' or title_basicsnew.primarytitle like '%'||strings||'%';
 
$$;
 
 select * from  string_search( 1, varchar 'Smart') ;
 
/* Here we used a function that returns a table as a result.  Then we inserted the values into in search_history, therefore we used a concatenation operator which linked titles, plot, characters and Names.  The Natural join was used because  it considers only those pairs of tuples with the same value on those attributes that appear in the schemas of both relations.  As the function needs to be flexible in the sense it doesn’t care about case of letter, we used the ‘lower function’ that converts all letters in the specified stringiest to lowercase. For this purpose we could also use ‘upper function’ which would convert all letters in the specified string to uppercase. At the end we used a select statement of userid, Titles, Plot, Characters and Names and the result was respective tconst and primary title. */


/* D.3 finished*/ 

 drop function if exists rATE(int,int,varchar)  ;

create or replace function  rate(USERID int, tconst varchar(200) ,rate int   ) 

returns table (
  
  tconst_ varchar(200), primarytitle text, numvotes int, averagerating numeric
	)    
AS $$
 
    DECLARE
        UserHasRated boolean;
				declare samerating boolean;
				restore boolean;
    BEGIN
          
		IF  EXISTS (select user_titlerate.tconst, user_titlerate.userid from user_titlerate where rate.userid = user_titlerate.userid and user_titlerate.tconst = rate.tconst)
		       /* if a user already has rated a movie, the UserHasRated boolean returns true */
					then UserHasRated := 'true' ;
				
				else UserHasRated := 'false' ;   
				 
				end if; /* ends if statement*/
				
				IF EXISTS (select  user_titlerate.userid, user_titlerate.tconst, individrating_title 
				from user_titlerate 
				where rate.userid = user_titlerate.userid and user_titlerate.tconst = rate.tconst and rate = individrating_title  ) then
				
				 /* if a user has already rated a movie, and tries to rate the same movie with the same value, 
					samerating boolean returns true and nothing will change in any table */

				  
				samerating := 'true' ; 
				
				else  samerating := 'false' ; 
				
				end if;
			   
				if UserHasRated = 'true' and samerating = 'false' then restore := 'true';
	/* if user has already rated a tconst, and attempts to give it a different rating this time, 
	then update averagerating and the individrating */
	
			  update title_Basicsnew 
			 set averagerating =  round(((title_Basicsnew.averagerating) * (title_Basicsnew.numvotes )
	 -(select individrating_title from user_titlerate where rate.tconst = user_titlerate.tconst and
					 user_titlerate.userid = rate.userid)  +  rate)  / (title_Basicsnew.numvotes),9 )  
	 where title_Basicsnew.tconst = rate.tconst ;
	 
  RETURN QUERY 
   select  title_basicsnew.tconst ,title_basicsnew.primarytitle , title_basicsnew.numvotes  , title_basicsnew.averagerating 
   from title_basicsnew 
   where title_basicsnew.tconst= rate.tconst;
				 else  restore := 'false';
				 
				end if ;
				
				if restore = 'true'
				/* only update the individrating AFTER the average number has been updated,so the function can rollback the averagerating value */
				then 
					 update user_titlerate set individrating_title = rate where rate.tconst = user_titlerate.tconst and
					 user_titlerate.userid = rate.userid; 
					 end if;
					 
				if UserHasRated = 'false' then   
				 /* if the user has never rated the movie, create rows in user_titlerate and update averagerating and numvotes in title_basicsnew */
	  insert into user_titlerate(userID,individrating_title,tconst,usertitlerate_date) 
 
        values  (USERID, rate ,tconst,CURRENT_DATE) 
                                    ;
					 												
		 update title_basicsnew 
		 set  numvotes =    title_basicsnew.numvotes +
 (select count( user_titlerate.tconst ) / count( user_titlerate.tconst )   
 from user_titlerate   
 where  rate.tconst =  user_titlerate.tconst and rate.userid = user_titlerate.userid )  
 where title_Basicsnew.tconst = rate.tconst  ;																
 		 
		 	 update title_Basicsnew 
			 set averagerating =  round((title_Basicsnew.averagerating * (title_Basicsnew.numvotes -1)
	 +  rate) / (title_Basicsnew.numvotes),9 )  
	 where title_Basicsnew.tconst = rate.tconst ;
	 
	 
         RETURN QUERY 
				 select  title_basicsnew.tconst ,title_basicsnew.primarytitle , title_basicsnew.numvotes  , title_basicsnew.averagerating 
				 from title_basicsnew 
				 where title_basicsnew.tconst= rate.tconst
               ;
			 
			   END IF;  
    END;
		 
$$ 
LANGUAGE plpgsql;
  
select * from rate(1, 'tt9910206',7 );
 
select * from Rate(1, 'tt9910206',8);

select * from Rate(1,'tt9910206',7);
 

/*not finished 

drop table if exists rating_history ;
create table rating_history (
Title varchar(200),
rate int

 )
;

 
SELECT *, FLOOR(1 + (random() * 10)) as Ratings FROM title_basicsnew;
UPDATE title_basicsnew SET numvotes = numvotes + ( select  count(individRating_Title) from user_titlerate); */

/* D.4.*/

create or replace function structured_string_search (userid int, Titles varchar(200),Plot text, Characters varchar(200), Names varchar(200))
RETURNS TABLE
(tconst char(10),
primarytitle text
)

language sql as 
$$
insert into search_history(userid, search_input, search_date) 
VALUES (userid, Titles|| ',' ||Plot|| ',' ||CHARACTERS|| ',' ||Names , CURRENT_DATE) ; 


select tconst, primarytitle
FROM title_basics NATURAL JOIN title_principals  natural JOIN name_basicsnew 
WHERE lower(title_basics.primarytitle) like '%'||lower( Titles)||'%' and lower(plot) like '%'||lower(Plot)||'%' and lower(title_principals.CHARACTERS) like '%'||lower( Characters)||'%' and lower( primaryname) like '%'||lower( Names)||'%';
$$;
select * from structured_string_search (2,'','see','','Mads miKKelsen');
	
/* In this exercise we used a function that returns a table as a result.  Then we had to insert the values into only one column in search_history, therefore we used a concatenation operator which linked titles, plot, characters and Names.  The Natural join was used because  it considers only those pairs of tuples with the same value on those attributes that appear in the schemas of both relations.  As the function needs to be flexible in the sense it doesn’t care about case of letter, we used the ‘lower function’ that converts all letters in the specified stringiest to lowercase. For this purpose we could also use ‘upper function’ which would convert all letters in the specified string to uppercase. At the end we used a select statement of userid, Titles, Plot, Characters and Names and the result was respective tconst and primary title. */


/* D.5.*/

create or replace function names_string_search (Titles varchar(200),Plot text,Characters varchar(200) )
RETURNS TABLE
(nconst char(200),
primaryname varchar(800)
)

language sql as 
$$
select nconst, primaryname
FROM title_basicsnew NATURAL JOIN title_principals  natural JOIN name_basicsnew 
WHERE lower(primarytitle) like '%'||lower( Titles)||'%' and lower(plot) like '%'||lower(Plot)||'%' and lower(title_principals.CHARACTERS) like '%'||lower( Characters)||'%' ;
$$;


select * from names_string_search('Auf allen Meeren','', '');

/* The same arguments as in D.4 */ 

/* D.6 */

create or replace view casting as 
select tconst,primarytitle,nconst,primaryname from title_basicsnew natural join title_principals natural join name_basicsnew;

select primaryname,nconst, count(*) from casting  
where primaryname != 'Richard Burton' and tconst in (
select tconst from title_principals natural join name_basicsnew
where primaryname like 'Richard Burton')  
group by casting.primaryname, nconst order by count(*) desc limit 12 ;

 
/* Firstly, a view called casting was created, because it provides abstractions over tables and the fields can be easily removed in a view without modifying the schema. The Natural join was used because it considers only those pairs of tuples with the same value on those attributes that appear in the schemas of both relations. There is also a COUNT function because it was necessary to count the number of non-empty values in the column, on the other hand if we had used SUM function, we would get the sum of all values in the column. */ 



/* D.9 */


/* For this task we could use the tables title_genre and join it  with title_basicsnew in order to get the primary title of the tconst.  If there is given the movie with certain tconst, we can see which genre does it belong to. Based on the same genre, it is possible to find similar movies.  Hence, we would have a function that, given the primary title of the movie, will return the tconst and primarytitle of the movies that have the same genre. */



/* D.10 */ 
/* We will just use the inverted index that’s already in the WI table. */


/* not sure if its correct */ 
drop function if exists Wi_Search(char);

create or replace function Wi_search(strings char(800))

returns table (
 tconst char(200), word text, field char (500), lexeme text)
 
    
language sql
as $$

select tconst, word, field, lexeme
FROM wi where word = strings
 

$$;

select * from wi_search(char 'religious');


/*D.11*/ 

/* 1st solution for D.11 using WI table inverted index */

drop function if exists exact_Search(char,char);

create or replace function exact_search(strings char(800), strings2 char(800))

returns table (
 plot TEXT , primarytitle varchar(800), primaryname varchar(50), characters varchar(50)
 
)    
language sql
as $$


SELECT  plot,primarytitle, primaryname, characters FROM title_basicsnew natural join title_principals natural join name_basicsnew,
(SELECT tconst from wi where word = strings
intersect
SELECT tconst from wi where word = strings2
) AliasName
WHERE title_basicsnew.tconst=AliasName.tconst;

$$;

 select * from exact_search(char 'man', char 'religious');



/* 2ND Solution for D.11 not using inverted index */



drop function if exists exact_Search(char);

create or replace function exact_search(strings char(800))

returns table (
 plot TEXT , primarytitle text
 
)    
language sql
as $$


select PLOT,primarytitle from title_Basicsnew where strpos(plot,strings) > 0 or strpos(primarytitle,strings) > 0

$$;

 select * from exact_search(char 'Morgan Freeman');

/* D.12 */

   drop function if exists bestmatchANY ( text []);
 CREATE OR REPLACE FUNCTION bestmatchANY
(VARIADIC w1  text[])
RETURNS TABLE (tconst char(10), rank_int bigint, title text)
AS $$
select  title_Basicsnew.tconst,  count( distinct(word) ) rank, primarytitle from title_basicsnew natural join wi  where word = any(LOwer( w1::text)::text[]) group by title_Basicsnew.tconst,primarytitle order by count(distinct(word)) desc
$$
LANGUAGE 'sql';
SELECT * FROM bestmatchANY('Apple','mads', 'Mikkelsen','hey','apples','apple')

;

/* D.13 */

drop function if exists WORDweight (text []);
 CREATE OR REPLACE FUNCTION wordweight
(VARIADIC w1 text[])
RETURNS TABLE (tconst char(10), rank_string text, title text)
AS $$
select  title_Basicsnew.tconst,   string_Agg(distinct((word)),' ') rank, primarytitle from title_basicsnew natural join wi  where word = any (w1) group by title_Basicsnew.tconst,primarytitle  order by count(distinct(word )) desc  
$$
LANGUAGE 'sql';
SELECT * FROM wordweight('apple','mads', 'mikkelsen','hey','apples','apple');

;



