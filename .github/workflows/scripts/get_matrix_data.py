import os
import json
from pathlib import Path


def write_output(var, value):
    if GITHUB_OUTPUT := os.getenv("GITHUB_OUTPUT"):
        with Path(GITHUB_OUTPUT).open("a") as f:
            f.write(f"{var}={value}\n")
    else:
        print(f"::set-output name={var}::{value}")


CHANGED = os.getenv("CHANGED", None)
EVENT_NAME = os.getenv("EVENT_NAME", None)

if EVENT_NAME == "worfklow_dispatch":
    container_files = list(Path().glob("*.Containerfile"))
elif CHANGED:
    container_files = [Path(f) for f in CHANGED.split() if f.endswith(".Containerfile")]
else:
    container_files = []

data = [{"tag": x.stem, "file": x.name} for x in container_files]

write_output("matrix_data", json.dumps(data))

exit(0)
