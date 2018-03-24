# -*- coding: utf-8 -*-

import datetime
import time

#Get Date Time      weeks,days,hours,minutes,seconds        int
def get_date_time(unit='', value=0):
    now = datetime.datetime.now()
    unit = unit.strip()

    try:
        value = int(value)
    except:
        value = 0

    if unit == 'weeks':
        now += datetime.timedelta( weeks = value)
    if unit == 'days':
        now += datetime.timedelta( days = value)
    if unit == 'hours':
        now += datetime.timedelta( hours = value)
    if unit == 'minutes':
        now += datetime.timedelta( minutes = value)
    if unit == 'seconds':
        now += datetime.timedelta( seconds = value)

    return now.strftime("%d/%m/%Y %H:%M")  # 05/02/2016 00:00

def convert_string_to_time(dateTimeStr, format):
    #2015-06-10T15:52:01+0700

    #dayStr = dateTimeStr[8:2]
    #monthStr = dateTimeStr[5:2]
    #yearStr = dateTimeStr[0:4]
    #hourStr =  dateTimeStr[11:2]
    #minutesStr = dateTimeStr[14:2]
    #newDateTimeStr = dayStr+'/'+monthStr+'/'+yearStr+' '+hourStr+':'+minutesStr
    print "log in convert_string_to_time", dateTimeStr
    print "log in convert_string_to_time", format
    return time.strptime(dateTimeStr, format)

def convert_date_time_to_string(dateTime, format):
    return time.strftime(format, dateTime)

#>>> import datetime
#>>> d = datetime.datetime.strptime('2011-06-09', '%Y-%m-%d')
#>>> d.strftime('%b %d,%Y')
#'Jun 09,2011'