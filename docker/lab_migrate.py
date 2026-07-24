import sqlite3
import sys


def column_exists(conn, table, column):
    rows = conn.execute(f"PRAGMA table_info({table})").fetchall()
    return any(row[1] == column for row in rows)


def main(db_path):
    conn = sqlite3.connect(db_path)
    try:
        conn.execute(
            """
            CREATE TABLE IF NOT EXISTS flow_runs (
                id INTEGER PRIMARY KEY AUTOINCREMENT,
                project_id INTEGER NOT NULL,
                status TEXT NOT NULL DEFAULT 'running',
                start_time TEXT DEFAULT CURRENT_TIMESTAMP,
                end_time TEXT,
                duration_ms INTEGER DEFAULT 0,
                roi_impact REAL DEFAULT 0.0,
                nodes_processed INTEGER DEFAULT 0,
                nodes_total INTEGER DEFAULT 0,
                last_node_id TEXT,
                pause_reason TEXT,
                created_at TEXT DEFAULT CURRENT_TIMESTAMP,
                context_json TEXT,
                trigger_data TEXT,
                execution_path TEXT,
                exec_slot INTEGER
            )
            """
        )

        conn.execute(
            """
            CREATE TABLE IF NOT EXISTS alerts (
                id INTEGER PRIMARY KEY AUTOINCREMENT,
                project_id INTEGER,
                type TEXT NOT NULL,
                message TEXT NOT NULL,
                is_active INTEGER DEFAULT 1,
                created_at TEXT DEFAULT CURRENT_TIMESTAMP,
                resolved_at TEXT
            )
            """
        )

        if not column_exists(conn, "flow_runs", "duration_ms"):
            try:
                conn.execute("ALTER TABLE flow_runs ADD COLUMN duration_ms INTEGER DEFAULT 0")
            except sqlite3.OperationalError:
                pass

        conn.commit()
    finally:
        conn.close()


if __name__ == "__main__":
    main(sys.argv[1])
