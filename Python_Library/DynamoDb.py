import boto3
from robot.libraries.BuiltIn import BuiltIn
from botocore.exceptions import ClientError
import json

class WmDynamo:

    def __init__(self):
            self.region_name = BuiltIn().get_variable_value("${WM_DYNAMO_REGION_NAME}")
            self.aws_access_key_id = BuiltIn().get_variable_value("${WM_DYNAMO_ACCESS_KEY_ID}")
            self.aws_secret_access_key = BuiltIn().get_variable_value("${WM_DYNAMO_SECRET_ACCESS_KEY}")
            print self.region_name
            # Get the service resource.
            self.dynamodb = boto3.resource('dynamodb',region_name=self.region_name,aws_access_key_id=self.aws_access_key_id,aws_secret_access_key=self.aws_secret_access_key)

    def connect(self):
         return self.dynamodb


def convert_string_to_dict(StringJson):

    return  dict(json.loads(StringJson))

def dynamo_put_item(table, Item):

    dictObj = convert_string_to_dict(Item)
    table = WmDynamo().connect().Table(table)
    return table.put_item(
       Item=dictObj
    )

def dynamo_update_item(table,key,attr,value,conditionString,valueJson):
    attrValue = dict({
            ':attr': attr,
            ':value': value
    })
    attrValue = valueJson.update(dict(attrValue))
    table = WmDynamo().connect().Table(table)
    return table.update_item(
        Key=key,
        UpdateExpression='SET :attr = :value',
        ConditionExpression=conditionString,
        ExpressionAttributeValues=attrValue
    )
def dynamo_get_item(table,keyJson):
    dictObj = convert_string_to_dict(keyJson)
    table = WmDynamo().connect().Table(table)
    try:
        response = table.get_item(
            Key=dictObj
        )
    except ClientError as e:
        print(e.response['Error']['Message'])
    else:
        item = response['Item']
        print("GetItem succeeded:")
        return item

def dynamo_delete_item(table,keyJson):

     keyObj = convert_string_to_dict(keyJson)
     table = WmDynamo().connect().Table(table)

     try:
         response = table.delete_item(
            Key=keyObj
         )
     except ClientError as e:
        print(e.response['Error']['Message'])
     return response
