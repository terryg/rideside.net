CREATE TABLE comics (
  nid int(10) unsigned NOT NULL default '0',
  strip varchar(25) NOT NULL default '',
  urlname varchar(255) NOT NULL default '',
  imglink varchar(255) NOT NULL default '',
  imgname varchar(25) NOT NULL default '', 
  PRIMARY KEY (nid)
);

