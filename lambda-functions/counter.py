import boto3

dynamodb = boto3.resource('dynamodb')
table = dynamodb.Table('visit_count')

def handler(event, context):
    response = table.get_item(Key={
        'record_id': '0'
    })
    
    if 'Item' in response:
        record_count = response['Item']['record_count']
    else:
        record_count = 0
    
    record_count += 1
    print(record_count)
    
    table.put_item(Item={
        'record_id': '0',
        'record_count': record_count
    })
    
    return record_count
