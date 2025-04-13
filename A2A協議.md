# 📘 A2A 協議背景資料（供大語言模型理解與應用）

本文件提供 A2A（Agent-to-Agent）通訊協議的背景知識，作為語言模型參與代理人溝通模組開發之基礎資訊。

---

## 🔍 協議簡介

A2A 協議是由 Google 提出的開放標準，旨在促進多個智能代理人（Agents）之間的溝通與協作。協議設計重點包括：

- 📡 Function Discovery：代理人能揭露可用功能給其他代理人。
- 🧠 Function Call/Response：統一的函式呼叫與回應格式。
- 🔗 Chain of Agents：支持鏈式任務協作與任務分派。
- 🔄 標準化訊息交換格式（使用 JSON Schema 定義）。

---

## 📚 主要文件與資源

| 類型 | 說明 | 連結 |
|------|------|------|
| GitHub 倉庫 | 原始碼與範例 | [google/A2A](https://github.com/google/A2A) |
| 協議規範 | JSON 格式詳細說明 | [A2A 協議規範文件](https://www.a2aprotocol.net/zh/docs/specification) |
| 協議介紹 | 簡介與設計理念 | [A2A 協議介紹](https://www.a2aprotocol.net/zh/docs/introduction) |

---

## 🔧 延伸資料與摘要補充

### ✅ 實作範例與測試資源（精簡摘要）

A2A 專案提供多個實作範例與測試模組，可用於學習與驗證協議實作：

- `samples/simple_agent.py`：提供一個 Python 範例代理人，能根據 A2A 格式處理請求並回應指定的任務。
- 範例中展示如何處理 `tasks/send` 任務、解析使用者的 `message.parts`，並組裝標準回應。
- `tests/test_spec.py`：使用 `pytest` 測試代理人是否正確回應協議格式與任務流程。

---

### ✅ 協議格式與結構（節錄格式）

`specification/json/` 資料夾定義了 A2A 協議的 JSON Schema，描述所有傳輸結構。以下為 `request.json` 精簡結構示意：

```json
{
  "type": "object",
  "properties": {
    "task": {
      "type": "object",
      "properties": {
        "id": { "type": "string" },
        "message": {
          "type": "object",
          "properties": {
            "role": { "type": "string", "enum": ["user", "agent"] },
            "parts": {
              "type": "array",
              "items": {
                "type": "object",
                "oneOf": [
                  { "$ref": "#/definitions/TextPart" },
                  { "$ref": "#/definitions/DataPart" },
                  { "$ref": "#/definitions/FilePart" }
                ]
              }
            }
          },
          "required": ["role", "parts"]
        }
      },
      "required": ["id", "message"]
    }
  },
  "required": ["task"]
}
```

- `TextPart`：純文字訊息  
- `DataPart`：結構化資料（如表單）  
- `FilePart`：檔案或 URI（含 base64）

🔗 [完整 JSON Schema 參考](https://github.com/google/A2A/tree/main/specification/json)

---

### ✅ 支援框架整合情況

目前 A2A 協議尚未與特定框架（如 LangChain、AutoGen）直接整合，但開發者可依據 JSON 格式與 Agent Message 模型，自行設計串接邏輯。

---

### ✅ 協議比較與定位

| 協議 | 特點 | 比較說明 |
|------|------|----------|
| A2A | 標準化 Agent 通訊格式 | 支援語意豐富的多模態交換（如 message.parts） |
| OpenAPI | API 說明文件 | 偏重傳統 REST API 描述，不支援 Agent 對話流程 |
| gRPC | 高效 RPC 通訊協議 | 偏向內部服務通訊，缺乏語意描述與動態適應性 |

---

## 🧩 建議使用方式

- 在 LLM Prompt 或 Plugin 註解中附上這份摘要，提升語言模型對 A2A 結構的理解。
- 可配合 RAG 系統使用此資料作為檢索知識段落來源。
- 若需實作 agent-to-agent 協作流程，可根據 `samples/simple_agent.py` 改寫自定代理模組。