#!/usr/bin/env python3
"""Static checks for the source-only AutoLISP project."""
from pathlib import Path
import csv
import re
import sys

ROOT = Path(__file__).resolve().parents[1]
SRC = ROOT / "src"
MODULES = [
    "act-core.lsp",
    "act-coord.lsp",
    "act-export.lsp",
    "act-import.lsp",
    "act-elev.lsp",
    "act-chainage.lsp",
    "act-interp.lsp",
    "act-profile.lsp",
]
FORBIDDEN = [r"https?://", r"startapp", r"wscript\.shell", r"powershell", r"curl", r"wget", r"api[_-]?key", r"password", r"secret", r"token"]
PUBLIC_COMMANDS = {"CTCOORD", "CTEXPORT", "CTIMPORT", "CTELEV", "CTCHAINAGE", "CTINTERP", "CTPROFILE"}

def code_without_comments(text):
    output = []
    for line in text.splitlines():
        clean = []
        in_string = False
        escaped = False
        for char in line:
            if char == '"' and not escaped:
                in_string = not in_string
            if char == ";" and not in_string:
                break
            clean.append(char)
            escaped = char == "\\" and not escaped
            if char != "\\":
                escaped = False
        output.append("".join(clean))
    return "\n".join(output)

def check_parentheses(path, text, failures):
    depth = 0
    in_string = False
    escaped = False
    for char in code_without_comments(text):
        if char == '"' and not escaped:
            in_string = not in_string
        elif not in_string and char == "(":
            depth += 1
        elif not in_string and char == ")":
            depth -= 1
            if depth < 0:
                failures.append(f"{path}: closing parenthesis without opening parenthesis")
                return
        escaped = char == "\\" and not escaped
        if char != "\\":
            escaped = False
    if depth != 0 or in_string:
        failures.append(f"{path}: unbalanced parentheses or string")

def main():
    failures = []
    commands = []
    for path in sorted(SRC.glob("*.lsp")):
        text = path.read_text(encoding="utf-8")
        check_parentheses(path, text, failures)
        for pattern in FORBIDDEN:
            if re.search(pattern, code_without_comments(text), flags=re.IGNORECASE):
                failures.append(f"{path}: forbidden runtime pattern {pattern}")
        commands.extend(re.findall(r"\(defun\s+C:([^\s(/]+)", text, flags=re.IGNORECASE))
    duplicates = sorted({name for name in commands if commands.count(name) > 1})
    if duplicates:
        failures.append("duplicate public commands: " + ", ".join(duplicates))
    if set(commands) != PUBLIC_COMMANDS:
        failures.append("public commands must be exactly: " + ", ".join(sorted(PUBLIC_COMMANDS)))
    loader = (SRC / "act-load.lsp").read_text(encoding="utf-8")
    for module in MODULES:
        if f'"{module}"' not in loader:
            failures.append(f"loader missing module: {module}")
    if 'ACT:version "0.2.0"' not in loader:
        failures.append("loader version must match 0.2.0")
    core = (SRC / "act-core.lsp").read_text(encoding="utf-8")
    for contract in ["trans", "vla-StartUndoMark", "vla-EndUndoMark", "vlax-curve-getDistAtPoint"]:
        if contract not in core:
            failures.append(f"core missing safety contract: {contract}")
    if (ROOT / "VERSION").read_text(encoding="utf-8").strip() != "0.2.0":
        failures.append("VERSION must be 0.2.0")
    for command in PUBLIC_COMMANDS:
        matches = [path.read_text(encoding="utf-8") for path in SRC.glob("*.lsp") if f"(defun C:{command} " in path.read_text(encoding="utf-8")]
        if len(matches) == 1 and ("ACT:undo-start" not in matches[0] or "ACT:undo-end" not in matches[0]):
            failures.append(f"{command}: missing command-level Undo contract")
    fixture = ROOT / "examples" / "import-points.csv"
    with fixture.open(newline="", encoding="utf-8") as stream:
        rows = list(csv.DictReader(stream))
    valid_rows = 0
    for row in rows:
        try:
            tuple(float(row[key]) for key in ("x", "y", "z"))
            valid_rows += 1
        except (TypeError, ValueError):
            pass
    if len(rows) != 5 or valid_rows != 3:
        failures.append("import fixture must contain exactly 3 valid and 2 invalid rows")
    if failures:
        print("FAIL")
        print("\n".join(failures))
        return 1
    print("PASS: source safety, manifest, parentheses, and command uniqueness")
    return 0

if __name__ == "__main__":
    sys.exit(main())
