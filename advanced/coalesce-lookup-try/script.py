#!/usr/bin/env python3

import json

def main():
    result = {
        "id": "example-id",
        "description": "example description"
    }
    # Print out as JSON string
    print(json.dumps(result))

if __name__ == "__main__":
    main()