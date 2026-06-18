#!/usr/bin/env python3
"""Fix screenutil conversion errors."""

import re
from pathlib import Path

ROOT = Path(__file__).resolve().parent.parent / "lib"


def fix(content: str) -> str:
    # Broken decimal conversions
    content = re.sub(r"height:\s*1\.h\.(\d+(?:\.\d+)?)\.h", r"height: 1.\1", content)
    content = re.sub(r"width:\s*0\.w\.5\.w", "width: 0.5.w", content)

    # Remove const before expressions using screenutil extensions
    content = re.sub(
        r"\bconst\s+(EdgeInsets\.[^;(\n]+(?:\.w|\.h|\.r|\.sp)[^;(\n]*)",
        lambda m: m.group(0).replace("const ", "", 1),
        content,
    )
    content = re.sub(
        r"\bconst\s+(Offset\([^)]*(?:\.w|\.h)[^)]*\))",
        r"\1",
        content,
    )
    content = re.sub(
        r"\bconst\s+(BorderRadius\.[^,;\n]+(?:\.r)[^,;\n]*)",
        lambda m: m.group(0).replace("const ", "", 1),
        content,
    )
    content = re.sub(
        r"\bconst\s+(BorderSide\([^)]*(?:\.w)[^)]*\))",
        r"\1",
        content,
    )
    content = re.sub(
        r"\bconst\s+(Radius\.circular\([^)]*\.r\))",
        r"\1",
        content,
    )

    # margin: const EdgeInsets...
    content = re.sub(
        r"(\b(?:padding|margin|insetPadding):\s*)const\s+(EdgeInsets)",
        r"\1\2",
        content,
    )

    return content


def main() -> None:
    for path in ROOT.rglob("*.dart"):
        text = path.read_text(encoding="utf-8")
        new = fix(text)
        if new != text:
            path.write_text(new, encoding="utf-8")
            print(path.relative_to(ROOT.parent))


if __name__ == "__main__":
    main()
