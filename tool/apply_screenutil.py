#!/usr/bin/env python3
"""Convert fixed layout numbers to flutter_screenutil extensions in lib/."""

import re
from pathlib import Path

ROOT = Path(__file__).resolve().parent.parent / "lib"

SKIP_FILES = {
    "app_colors.dart",
    "app_design.dart",
    "app_state.dart",
    "network_guard.dart",
    "app_routes.dart",
    "onboarding_model.dart",
    "app_theme.dart",
    "main.dart",
    "app_text_styles.dart",
}

SKIP_SUFFIXES = (".g.dart",)

IMPORT = "import 'package:flutter_screenutil/flutter_screenutil.dart';\n"

# Already has .w/.h/.r/.sp
HAS_EXT = re.compile(r"\d+(?:\.\d+)?\.(?:w|h|r|sp)\b")

NUM = r"(\d+(?:\.\d+)?)"


def add_import(content: str) -> str:
    if "flutter_screenutil" in content:
        return content
    m = re.match(r"(import .+\n)+", content)
    if m:
        return content[: m.end()] + IMPORT + content[m.end() :]
    return IMPORT + content


def suffix_num(match: re.Match, suffix: str) -> str:
    val = match.group(1)
    if "." in val and val.endswith(("0", "5")) and suffix == "w":
        # border widths like 0.5, 1.5
        pass
    return f"{val}{suffix}"


def convert(content: str) -> str:
    if HAS_EXT.search(content):
        # still process if mixed
        pass

    # fontSize: N -> fontSize: N.sp (avoid double .sp)
    content = re.sub(
        rf"fontSize:\s*{NUM}(?!\.sp)\b",
        lambda m: f"fontSize: {m.group(1)}.sp",
        content,
    )

    # BorderRadius.circular(N) -> .r
    content = re.sub(
        rf"BorderRadius\.circular\({NUM}(?!\.r)\)",
        lambda m: f"BorderRadius.circular({m.group(1)}.r)",
        content,
    )
    content = re.sub(
        rf"Radius\.circular\({NUM}(?!\.r)\)",
        lambda m: f"Radius.circular({m.group(1)}.r)",
        content,
    )

    # SizedBox(height: N) / width: N
    content = re.sub(
        rf"SizedBox\(\s*height:\s*{NUM}(?!\.h)\b",
        lambda m: f"SizedBox(height: {m.group(1)}.h",
        content,
    )
    content = re.sub(
        rf"SizedBox\(\s*width:\s*{NUM}(?!\.w)\b",
        lambda m: f"SizedBox(width: {m.group(1)}.w",
        content,
    )
    content = re.sub(
        rf",\s*height:\s*{NUM}(?!\.h)\b",
        lambda m: f", height: {m.group(1)}.h",
        content,
    )
    content = re.sub(
        rf",\s*width:\s*{NUM}(?!\.w)\b",
        lambda m: f", width: {m.group(1)}.w",
        content,
    )

    # width: N, height: N at start of property lines (Container etc.)
    content = re.sub(
        rf"(?<![\w.])(width:\s*){NUM}(?!\.w)\b",
        lambda m: f"{m.group(1)}{m.group(2)}.w",
        content,
    )
    content = re.sub(
        rf"(?<![\w.])(height:\s*){NUM}(?!\.h)\b",
        lambda m: f"{m.group(1)}{m.group(2)}.h",
        content,
    )

    # size: N (Icon)
    content = re.sub(
        rf"(?<![\w.])(size:\s*){NUM}(?!\.(?:w|sp))\b",
        lambda m: f"{m.group(1)}{m.group(2)}.w",
        content,
    )

    # blurRadius, spreadRadius
    content = re.sub(
        rf"blurRadius:\s*{NUM}(?!\.r)\b",
        lambda m: f"blurRadius: {m.group(1)}.r",
        content,
    )

    # offset: Offset(0, N)
    content = re.sub(
        rf"Offset\(\s*0,\s*{NUM}(?!\.h)\)",
        lambda m: f"Offset(0, {m.group(1)}.h)",
        content,
    )
    content = re.sub(
        rf"Offset\(\s*{NUM}(?!\.w),\s*{NUM}(?!\.h)\)",
        lambda m: f"Offset({m.group(1)}.w, {m.group(2)}.h)",
        content,
    )

    # EdgeInsets helpers
    content = re.sub(
        rf"EdgeInsets\.all\({NUM}(?!\.w)\)",
        lambda m: f"EdgeInsets.all({m.group(1)}.w)",
        content,
    )
    content = re.sub(
        rf"EdgeInsets\.symmetric\(\s*horizontal:\s*{NUM}(?!\.w)\b",
        lambda m: f"EdgeInsets.symmetric(horizontal: {m.group(1)}.w",
        content,
    )
    content = re.sub(
        rf"horizontal:\s*{NUM}(?!\.w)\b,\s*vertical:\s*{NUM}(?!\.h)\b",
        lambda m: f"horizontal: {m.group(1)}.w, vertical: {m.group(2)}.h",
        content,
    )
    content = re.sub(
        rf"EdgeInsets\.symmetric\(\s*vertical:\s*{NUM}(?!\.h)\b",
        lambda m: f"EdgeInsets.symmetric(vertical: {m.group(1)}.h",
        content,
    )
    content = re.sub(
        rf"EdgeInsets\.only\(\s*left:\s*{NUM}(?!\.w)\b",
        lambda m: f"EdgeInsets.only(left: {m.group(1)}.w",
        content,
    )
    content = re.sub(
        rf"EdgeInsets\.only\(\s*right:\s*{NUM}(?!\.w)\b",
        lambda m: f"EdgeInsets.only(right: {m.group(1)}.w",
        content,
    )
    content = re.sub(
        rf"EdgeInsets\.only\(\s*top:\s*{NUM}(?!\.h)\b",
        lambda m: f"EdgeInsets.only(top: {m.group(1)}.h",
        content,
    )
    content = re.sub(
        rf"EdgeInsets\.only\(\s*bottom:\s*{NUM}(?!\.h)\b",
        lambda m: f"EdgeInsets.only(bottom: {m.group(1)}.h",
        content,
    )

    # EdgeInsets.fromLTRB
    def ltrb(m: re.Match) -> str:
        l, t, r, b = m.group(1), m.group(2), m.group(3), m.group(4)
        bs = f", {b}.h" if b != "0" else ", 0"
        return f"EdgeInsets.fromLTRB({l}.w, {t}.h, {r}.w{bs})"

    content = re.sub(
        rf"EdgeInsets\.fromLTRB\(\s*{NUM},\s*{NUM},\s*{NUM},\s*{NUM}\s*\)",
        ltrb,
        content,
    )

    # padding: const EdgeInsets.symmetric(horizontal: N) inside - fix remaining
    content = re.sub(
        rf"(?<=\()(left|right):\s*{NUM}(?!\.w)\b",
        lambda m: f"{m.group(1)}: {m.group(2)}.w",
        content,
    )
    content = re.sub(
        rf"(?<=\()(top|bottom):\s*{NUM}(?!\.h)\b",
        lambda m: f"{m.group(1)}: {m.group(2)}.h",
        content,
    )

    # const SizedBox(height: -> SizedBox(height: (const breaks .h)
    content = content.replace("const SizedBox(height:", "SizedBox(height:")
    content = content.replace("const SizedBox(width:", "SizedBox(width:")

    # BorderSide width
    content = re.sub(
        rf"width:\s*0\.5(?!\.)",
        "width: 0.5.w",
        content,
    )

    return content


def main() -> None:
    changed = []
    for path in sorted(ROOT.rglob("*.dart")):
        if path.name in SKIP_FILES:
            continue
        if any(path.name.endswith(s) for s in SKIP_SUFFIXES):
            continue
        text = path.read_text(encoding="utf-8")
        if not re.search(
            r"\b(SizedBox|EdgeInsets|BorderRadius|fontSize|width:|height:|blurRadius|Offset\()",
            text,
        ):
            continue
        new_text = convert(text)
        if "flutter_screenutil" not in new_text and new_text != text:
            new_text = add_import(new_text)
        if new_text != text:
            path.write_text(new_text, encoding="utf-8")
            changed.append(path.relative_to(ROOT.parent))

    print(f"Updated {len(changed)} files:")
    for p in changed:
        print(f"  - {p}")


if __name__ == "__main__":
    main()
