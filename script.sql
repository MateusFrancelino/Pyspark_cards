CREATE TABLESPACE log_space 
   DATAFILE 'log.dbf' 
   SIZE 100m;
  
CREATE TABLE BRONZE.log_table (
	id RAW(16) default SYS_GUID() not NULL,
    status VARCHAR2(1000),
    notebook VARCHAR2(100),
    message CLOB,
    dhlog DATE
) tablespace log_space
  pctfree 10
  initrans 1
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  )
compress for all operations;