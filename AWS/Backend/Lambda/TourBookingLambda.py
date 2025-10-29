import json
import uuid
import boto3
from decimal import Decimal

# Initialize DynamoDB client
dynamodb = boto3.resource('dynamodb')
table = dynamodb.Table('TourBookings')

def lambda_handler(event, context):
    try:
        # Parse body
        body = json.loads(event.get('body', '{}'))

        # Generate a unique BookingID
        booking_id = str(uuid.uuid4())

        # Extract and validate fields
        item = {
            'BookingID': booking_id,
            'PackageID': body.get('packageId'),
            'PackageName': body.get('packageName'),
            'Name': body.get('name'),
            'Contact': body.get('contact'),
            'Email': body.get('email'),
            'Adults': int(body.get('adults', 0)),
            'Children': int(body.get('children', 0)),
            'TotalPrice': Decimal(str(body.get('totalPrice', 0)))
        }

        # Insert into DynamoDB
        table.put_item(Item=item)

        return {
            'statusCode': 200,
            'headers': { 'Content-Type': 'application/json' },
            'body': json.dumps({ 'message': 'Booking successful', 'bookingId': booking_id })
        }

    except Exception as e:
        return {
            'statusCode': 500,
            'headers': { 'Content-Type': 'application/json' },
            'body': json.dumps({ 'message': 'Internal server error', 'error': str(e) })
        }
