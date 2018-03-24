import datetime
from ConnectDB import *

def date_by_adding_business_days(from_date, add_days):
    business_days_to_add = add_days
    current_date = from_date
    while business_days_to_add > 0:
        current_date += datetime.timedelta(days=1)
        weekday = current_date.weekday()
        if weekday >= 5: # sunday = 6
            continue
        business_days_to_add -= 1
    return current_date


def adding_date(datetime=None) : 
	if datetime is None : 
		return None 

	
def get_holidays() : 
    mydb = db.connect(host=dbhost, user=dbuser, passwd=dbpass, db=dbname, charset=dbcharset)
    

    query = "SELECT DATE_FORMAT(`started_at`, '%Y-%m-%d') as `started_at`, \
                    DATE_FORMAT(`ended_at`, '%Y-%m-%d') as `ended_at` \
            FROM `holidays` \
          WHERE DATE_FORMAT(`ended_at`, '%Y-%m-%d') >= NOW() "
    cursor = mydb.cursor()
    cursor.execute(query)
    rows =  cursor.fetchall()
    fields = {}
    data_return = []
    for row in rows:
        print row
        fields["started_at"] = row[0]
        fields["ended_at"] = row[1]

        data_return.append(fields)

    return data_return


#demo:
print get_holidays()
print '10 business days from today:'
print date_by_adding_business_days(datetime.date.today(), 10)