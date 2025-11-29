import json
import csv
from pathlib import Path
from typing import List, Dict


def load_users(json_path: Path) -> List[Dict]:
    with json_path.open() as f:
        return json.load(f)


def transform_users(users: List[Dict]) -> List[Dict]:
    """
    - Keep only active users
    - Normalize names: trim + lowercase
    """
    result = []
    for u in users:
        if not u.get("active"):
            continue
        cleaned = {
            "id": u["id"],
            "name": u["name"].strip().lower(),
        }
        result.append(cleaned)
    return result


def save_to_csv(users: List[Dict], csv_path: Path) -> None:
    if not users:
        print("No users to write.")
        return

    fieldnames = list(users[0].keys())
    with csv_path.open("w", newline="") as f:
        writer = csv.DictWriter(f, fieldnames=fieldnames)
        writer.writeheader()
        writer.writerows(users)
    print(f"Wrote {len(users)} rows to {csv_path}")


def main():
    base_dir = Path(__file__).parent
    input_path = base_dir / "users_input.json"
    output_path = base_dir / "users_output.csv"

    print(f"Loading users from {input_path}")
    users = load_users(input_path)

    print(f"Transforming {len(users)} users...")
    transformed = transform_users(users)

    print("Saving to CSV...")
    save_to_csv(transformed, output_path)


if __name__ == "__main__":
    main()