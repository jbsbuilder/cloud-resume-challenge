import boto3

dynamodb = boto3.resource('dynamodb')
table = dynamodb.Table('visit_count')

def handler(event, context):
    response = table.get_item(Key={
            'record_id':'0'
    })
    record-count = response['Item']['record_count']
    record-count = record_count + 1
    print(record-count)
    response = table.put_item(Item={
            'record_id':'0',
            'record_count': record_count
    })
    
    return record_count
