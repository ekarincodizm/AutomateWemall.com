*** Variables ***
${DB_HOSTNAME}    pcmsdb-rw.itruemart-dev.com
#${DB_USERNAME}    pcms_qa
#${DB_PASSWORD}    read1234
${DB_USERNAME}    antman_qa
${DB_PASSWORD}    A4n$t88p

${DB_NAME}        pcms_db_prod
${DB_CHARSET}     utf8
${DB_PORT}        3306

#Redis Cache
${WM_REDIS_HOST}    elasticache-rw.itruemart-dev.com
${WM_REDIS_PORT}    6379
${WM_REDIS_DB}      1


${POINT_DB_HOSTNAME}    point-rw.itruemart-dev.com
${POINT_DB_USERNAME}    root
${POINT_DB_PASSWORD}    Welcome1
${POINT_DB_NAME}    pts_db
${POINT_DB_CHARSET}    utf8
${POINT_DB_PORT}        3306

#Dynamo DB
${WM_DYNAMO_REGION_NAME}          ap-southeast-1
${WM_DYNAMO_ACCESS_KEY_ID}        AKIAIMWEXPPS6ZDJ3P7A
${WM_DYNAMO_SECRET_ACCESS_KEY}    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

