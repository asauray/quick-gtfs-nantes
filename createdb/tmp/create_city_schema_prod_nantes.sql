REVOKE SELECT ON spatial_ref_sys, geometry_columns FROM nantes;
DROP EXTENSION postgis;
DROP schema nantes cascade;
DROP OWNED BY nantes;
DROP USER nantes;
CREATE USER nantes PASSWORD 'nantes';
CREATE SCHEMA nantes authorization nantes;
CREATE EXTENSION postgis;
GRANT SELECT ON spatial_ref_sys, geometry_columns TO nantes;


DROP TABLE nantes.GTFS_AGENCY;
DROP TABLE nantes.GTFS_ROUTES;
DROP TABLE nantes.GTFS_STOPS;
DROP TABLE nantes.GTFS_TRIPS;

DROP TABLE nantes.GTFS_STOP_TIMES;
DROP TABLE nantes.GTFS_SHAPES;
DROP TABLE nantes.GTFS_CALENDAR;
DROP TABLE nantes.GTFS_CALENDAR_DATES;
DROP TABLE nantes.GTFS_TRANSFERS;

/*
agency_id,agency_name,agency_url,agency_timezone,agency_lang,agency_phone
MTA NYCT,MTA New York City Transit, http://www.mta.info,America/New_York,en,718-330-1234
*/

CREATE TABLE nantes.GTFS_AGENCY
(
agency_id VARCHAR(10),
agency_name VARCHAR(50),
agency_url VARCHAR(100),
agency_timezone VARCHAR(50),
agency_lang VARCHAR(2),
agency_phone VARCHAR(20)
);

/*
routes.txt
route_id,agency_id,route_short_name,route_long_name,route_desc,route_type,route_url,route_color,route_text_color
1,MTA NYCT,1,Broadway - 7 Avenue Local,"Trains operate between 242 St in the Bronx and South Ferry in Manhattan, most times",1,http://www.mta.info/nyct/service/pdf/t1cur.pdf,EE352E,
*/

CREATE TABLE nantes.GTFS_ROUTES
(
route_id NUMERIC(5),
agency_id NUMERIC(3),
route_short_name VARCHAR(10),
route_long_name VARCHAR(100),
route_desc VARCHAR(100),
route_type NUMERIC(3),
route_url VARCHAR(100),
route_color VARCHAR(8),
route_text_color VARCHAR(8)
);
/*
stops.txt
stop_id,stop_code,stop_name,stop_desc,stop_lat,stop_lon,zone_id,stop_url,location_type,parent_station
101,,Van Cortlandt Park - 242 St,,40.889248,-73.898583,,,1,
*/

CREATE TABLE nantes.GTFS_STOPS
( stop_id NUMERIC(10),
stop_code VARCHAR(10),
stop_name VARCHAR(100),
stop_desc VARCHAR(100),
stop_lat NUMERIC(38,8),
stop_lon NUMERIC(38,8),
zone_id NUMERIC(5),
stop_url VARCHAR(100),
location_type NUMERIC(2),
parent_station NUMERIC(38)
);

/*
trips.txt
route_id,service_id,trip_id,trip_headsign,direction_id,block_id,shape_id
1,A20130803WKD,A20130803WKD_000800_1..S03R,SOUTH FERRY,1,,1..S03R
*/
CREATE TABLE nantes.GTFS_TRIPS
(
route_id NUMERIC(10),
service_id VARCHAR(10),
trip_id NUMERIC(10),
trip_headsign VARCHAR(10),
trip_short_name VARCHAR(50),
direction_id NUMERIC(2),
block_id NUMERIC(10),
shape_id NUMERIC(10)
);


/*
stop_times.txt
trip_id,arrival_time,departure_time,stop_id,stop_sequence,stop_headsign,pickup_type,drop_off_type,shape_dist_traveled
A20130803WKD_000800_1..S03R,00:08:00,00:08:00,101S,1,,0,0,
*/

CREATE TABLE nantes.GTFS_STOP_TIMES
(
trip_id NUMERIC(10),
arrival_time TIMESTAMP,
departure_time TIMESTAMP,
stop_id NUMERIC(10),
stop_sequence NUMERIC(10),
stop_headsign VARCHAR(30),
pickup_type VARCHAR(100),
drop_off_type VARCHAR(100)
);

/*
shapes.txt
shape_id,shape_pt_lat,shape_pt_lon,shape_pt_sequence,shape_dist_traveled
4..N06R,40.668897,-73.932942,0,
*/

CREATE TABLE nantes.GTFS_SHAPES
(
shape_id NUMERIC(6),
shape_pt_lat NUMERIC,
shape_pt_lon NUMERIC,
shape_pt_sequence NUMERIC(6),
shape_dist_traveled NUMERIC
);

/*
calendar_dates.txt
service_id,date,exception_type
*/

CREATE TABLE nantes.GTFS_CALENDAR_DATES
(
service_id VARCHAR(10),
exception_date DATE,
exception_type VARCHAR(10)
);

/*
calendar.txt
service_id,monday,tuesday,wednesday,thursday,friday,saturday,sunday,start_date,end_date
A20130803WKD,1,1,1,1,1,0,0,20130803,20141231
*/

CREATE TABLE nantes.GTFS_CALENDAR
(
service_id VARCHAR(10),
monday NUMERIC(1),
tuesday NUMERIC(1),
wednesday NUMERIC(1),
thursday NUMERIC(1),
friday NUMERIC(1),
saturday NUMERIC(1),
sunday NUMERIC(1),
start_date DATE,
end_date DATE
);

/*
transfers.txt
from_stop_id,to_stop_id,transfer_type,min_transfer_time
101,101,2,180
*/

CREATE TABLE nantes.GTFS_TRANSFERS
(
from_stop_id NUMERIC(10),
to_stop_id NUMERIC(10),
transfer_type NUMERIC(3),
min_transfer_time NUMERIC(6)
); 