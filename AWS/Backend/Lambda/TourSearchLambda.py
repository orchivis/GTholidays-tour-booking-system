import boto3
import json
from decimal import Decimal

def lambda_handler(event, context):
    """
    This function retrieves a list of tour packages from the 'tourpackages' DynamoDB table
    and formats the response for API Gateway.

    Args:
        event (dict): The AWS Lambda event payload (provided by API Gateway).
        context (object): The AWS Lambda context object.

    Returns:
        dict: A dictionary representing the API Gateway response.
            - statusCode (int): The HTTP status code (200 for success, 500 for error).
            - headers (dict):  HTTP headers (Content-Type is set to application/json).
            - body (str):  A JSON string containing the tour packages or an error message.
    """
    # Initialize the DynamoDB client
    dynamodb = boto3.resource('dynamodb')
    table = dynamodb.Table('TourPackages')

    try:
        # Scan the entire table to retrieve all items.
        response = table.scan()
        items = response.get('Items', [])

        # Convert Decimal objects to float for JSON serialization
        def convert_decimal(obj):
            if isinstance(obj, Decimal):
                return float(obj)
            return obj

        items_serializable = [
            {k: convert_decimal(v) for k, v in item.items()} for item in items
        ]

        print(json.dumps(items_serializable, indent=2))

        # Return the data as a JSON string, formatted for API Gateway
        return {
            'statusCode': 200,
            'headers': {
                'Content-Type': 'application/json',
                'Access-Control-Allow-Origin': '*',  # Required for CORS support (if needed)
                'Access-Control-Allow-Methods': 'GET' #Method allowed
            },
            'body': json.dumps(items_serializable, ensure_ascii=False)
        }

    except Exception as e:
        # Handle exceptions
        error_message = f"Error retrieving tour packages: {str(e)}"
        print(error_message)
        return {
            'statusCode': 500,
            'headers': {
                'Content-Type': 'application/json',
                'Access-Control-Allow-Origin': '*',  # Required for CORS support (if needed)
                'Access-Control-Allow-Methods': 'GET' #Method allowed
            },
            'body': json.dumps({'error': error_message})
        }

# Example usage (for local testing)
#if __name__ == "__main__":
    #event = {}
    #context = None
    #result = lambda_handler(event, context)
    #print(json.dumps(result, indent=2))
