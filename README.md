# BossZhipin MCP Server

A [Model Context Protocol (MCP)](https://modelcontextprotocol.io/introduction) server for Boss直聘 recruitment platform.

**Core Features:**
- 🔐 **Auto Login** - QR code scan with automatic security verification
- 💼 **Job Search** - Search by keyword, city, experience, salary
- 👋 **Auto Greeting** - Send greetings to recruiters automatically

---

## Quick Start

### 1. Install

```bash
pip install -r requirements.txt
playwright install chromium
```

### 2. Run

```bash
python mcp_boss.py
```

Server starts at `http://127.0.0.1:8000`

### 3. MCP Client Config

Add to your MCP client (e.g., Cursor):

```json
{
  "mcpServers": {
    "mcp-boss": {
      "command": "python",
      "args": ["/path/to/mcp_boss.py"]
    }
  }
}
```

---

## Usage Examples

### Login
```
User: Login to BossZhipin
LLM:  [Calls login_full_auto]
      QR: http://127.0.0.1:8000/static/qrcode_xxx.png
      Please scan with BossZhipin APP

User: [Scans and confirms]
LLM:  Login successful!
```

### Search Jobs
```python
search_jobs(
    keyword="Python",
    city="上海",
    experience="三到五年",
    salary="20-50k"
)
```

### Send Greeting
```python
send_greeting(
    security_id="xxx",
    job_id="yyy"
)
```

---

## Available Tools

| Tool                        | Description                     |
| --------------------------- | ------------------------------- |
| `login_full_auto()`         | Auto login with QR code         |
| `login_start_interactive()` | Interactive login with guidance |
| `get_login_info()`          | Get login status & cookies      |
| `get_recommend_jobs()`      | Get recommended jobs            |
| `search_jobs()`             | Search jobs by keyword          |
| `send_greeting()`           | Send greeting to HR             |

**Parameters:**
- `experience`: 在校生, 应届生, 不限, 一年以内, 一到三年, 三到五年, 五到十年, 十年以上
- `job_type`: 全职, 兼职
- `salary`: 3k以下, 3-5k, 5-10k, 10-20k, 20-50k, 50以上
- `city`: 北京, 上海, 深圳, 广州, 杭州, 成都, 武汉, 西安, 南京, 苏州

---

## Resources

| URI                 | Description                                 |
| ------------------- | ------------------------------------------- |
| `boss://status`     | Server status                               |
| `boss://config`     | Job search config (experience, salary maps) |
| `boss://login/info` | Login status & cookies                      |

---

## HTTP Endpoints

- `http://127.0.0.1:8000/mcp` - MCP endpoint
- `http://127.0.0.1:8000/static/{file}` - Static files (QR codes)
- `http://127.0.0.1:8000/login/start` - Web login page

---

## How It Works

1. **QR Login** - Generates QR code, monitors scan status in background thread
2. **Security Check** - Uses Playwright headless browser to auto-complete verification
3. **Cookie Management** - Automatically obtains `__zp_stoken__` and valid cookies
4. **Smart Params** - Accepts Chinese parameters, converts to API codes automatically

---

## Project Structure

```
mcp-boss/
├── mcp_boss.py          # Main server
├── requirements.txt     # Dependencies
├── static/              # QR code images
└── README.md
```

---

## Dependencies

- Python 3.12+
- fastmcp >= 0.4.0
- requests >= 2.31.0
- playwright >= 1.40.0
- pycryptodome >= 3.19.0
- starlette >= 0.27.0

---

## Docker

```bash
docker build -t mcp-boss .
docker run -p 8000:8000 mcp-boss
```

---

## Debug Mode

Set `headless=False` in `complete_security_check()` to see browser:

```python
browser = await p.chromium.launch(headless=False)
```

---

## License

[MIT License](LICENSE)
