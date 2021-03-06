grammar MySQLDMLStatement;

import MySQLKeyword, Keyword, Symbol, MySQLDQLStatement, MySQLBase, BaseRule, DataType;

insert
    : INSERT (LOW_PRIORITY | DELAYED | HIGH_PRIORITY IGNORE)? INTO? tableName partitionClause? (setClause | columnClause) onDuplicateClause?
    ;

columnClause
    : columnNames? (valueClause | select)
    ;

valueClause
    : (VALUES | VALUE) assignmentValueList (COMMA_ assignmentValueList)*
    ;

setClause
    : SET assignmentList
    ;

onDuplicateClause
    : ON DUPLICATE KEY UPDATE assignmentList
    ;

update
    : updateClause setClause whereClause? orderByClause? limitClause?
    ;

updateClause
    : UPDATE LOW_PRIORITY? IGNORE? tableReferences
    ;

delete
    : deleteClause whereClause? orderByClause? limitClause?
    ;

deleteClause
    : DELETE deleteSpec (fromMulti | fromSingle) 
    ;

fromSingle
    : FROM tableName partitionClause?
    ;

fromMulti
    : fromMultiTables FROM tableReferences | FROM fromMultiTables USING tableReferences
    ;

fromMultiTables
    : fromMultiTable (COMMA_ fromMultiTable)*
    ;

fromMultiTable
    : tableName DOT_ASTERISK_?
    ;
    
deleteSpec
    : LOW_PRIORITY? | QUICK? | IGNORE?
    ;
