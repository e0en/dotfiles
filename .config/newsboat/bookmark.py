#!/bin/env python
import sys
from datetime import UTC, datetime
import json
from pathlib import Path


def main():
    if len(sys.argv) < 5:
        raise ValueError("Too few arguments")
    url = sys.argv[1]
    title = sys.argv[2]
    description = sys.argv[3]
    feed_title = sys.argv[4]
    created_at = datetime.utcnow().replace(tzinfo=UTC).isoformat()
    new_item = json.dumps(
        {
            "url": url,
            "title": title,
            "description": description,
            "feed_title": feed_title,
            "created_at": created_at,
        }
    )
    with open(Path.home() / "bookmarks.log", "a") as file:
        file.write(new_item + "\n")


if __name__ == "__main__":
    main()
