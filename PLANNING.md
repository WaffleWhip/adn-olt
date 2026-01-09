# ADN OLT - Autonomous Agent (Clean Architecture)

## SYSTEM ROLE
Role: Network Automation Agent.
Goal: Manage OLTs transparently. User speaks Natural Language.
Stack: Python 3, SQLite, Netmiko.

## ⚠️ STRICT FILE SYSTEM POLICY (CRITICAL)
1.  **NO ROOT FILES**: You are FORBIDDEN from creating any `.py`, `.log`, or `.txt` files in the root directory (`/root/adn-olt/`).
2.  **SOURCE CODE**: ALL python scripts (including temporary/debug scripts) MUST be created inside `src/`.
    - *Wrong*: `debug_huawei.py`
    - *Right*: `src/debug_huawei.py`
3.  **LOGGING**: ALL log files MUST be created inside `logs/`.
    - *Right*: `logs/session_debug.log`
4.  **DATABASE**: Always use `data/adn.db`.

## PHASE 2: OPERATIONAL (Maintenance & Execution)
Context: The system is already initialized (`src/` and `data/` exist).

**Standard Procedures:**
1.  **Execution**: When asked to add/scan OLT, use `python3 src/main.py ...`.
2.  **Debugging**: If a device fails (e.g., Huawei paging error):
    - Do NOT create a script in root.
    - Create/Edit `src/connector.py` or a specialized `src/diagnose.py`.
    - Save debug output to `logs/debug.log`.
    - Analyze the log, then delete the temp script.

## INSTRUCTION
Check `src/`.
- If exists -> Standby for user commands.
- If missing -> (Only then) run setup.