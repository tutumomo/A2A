![圖片資訊](images/A2A_banner.png)

**_一個開放的協定，旨在實現不透明代理應用程式之間的通訊和互操作性。_**

<!-- 目錄 -->

- [Agent2Agent 協定 A2A](#agent2agent-協定-a2a)
    - [開始使用](#開始使用)
    - [貢獻](#貢獻)
    - [未來規劃](#未來規劃)
    - [關於](#關於)

<!-- /目錄 -->

企業採用 AI 的最大挑戰之一是讓建立在不同框架和供應商上的代理程式能夠協同工作。這就是我們創建開放式 *Agent2Agent (A2A) 協定* 的原因，這是一種協作方式，旨在幫助不同生態系統中的代理程式相互通訊。Google 正在為業界推動這項開放協定倡議，因為我們相信該協定對於支援多代理程式通訊至關重要，它能為您的代理程式提供一種通用語言——無論它們是基於哪個框架或由哪個供應商建立的。
透過 *A2A*，代理程式可以向彼此展示其能力，並協商如何與使用者互動（透過文字、表單或雙向音訊/視訊）——同時安全地協同工作。

### **觀看 A2A 實際運作**

觀看[此示範影片](https://storage.googleapis.com/gweb-developer-goog-blog-assets/original_videos/A2A_demo_v4.mp4)，了解 A2A 如何實現不同代理程式框架之間的無縫通訊。

### 概念總覽

Agent2Agent (A2A) 協定促進了獨立 AI 代理程式之間的通訊。以下是核心概念：

*   **代理程式卡片 (Agent Card)：** 一個公開的元數據檔案（通常位於 `/.well-known/agent.json`），描述代理程式的能力、技能、端點 URL 和身份驗證要求。客戶端使用它來進行探索。
*   **A2A 伺服器 (A2A Server)：** 一個公開 HTTP 端點的代理程式，該端點實作了 A2A 協定方法（定義在 [json 規範](/specification) 中）。它接收請求並管理任務執行。
*   **A2A 客戶端 (A2A Client)：** 一個使用 A2A 服務的應用程式或其他代理程式。它向 A2A 伺服器的 URL 發送請求（例如 `tasks/send`）。
*   **任務 (Task)：** 工作的核心單位。客戶端透過發送訊息（`tasks/send` 或 `tasks/sendSubscribe`）來啟動任務。任務具有唯一的 ID，並經歷不同的狀態（`submitted`、`working`、`input-required`、`completed`、`failed`、`canceled`）。
*   **訊息 (Message)：** 代表客戶端（`role: "user"`）和代理程式（`role: "agent"`）之間的通訊輪次。訊息包含 `Parts`。
*   **部分 (Part)：** `Message` 或 `Artifact` 中的基本內容單元。可以是 `TextPart`、`FilePart`（帶有內嵌位元組或 URI）或 `DataPart`（用於結構化 JSON，例如表單）。
*   **產出物 (Artifact)：** 代表代理程式在任務期間生成的輸出（例如，生成的文件、最終的結構化數據）。產出物也包含 `Parts`。
*   **串流 (Streaming)：** 對於長時間運行的任務，支援 `streaming` 能力的伺服器可以使用 `tasks/sendSubscribe`。客戶端接收包含 `TaskStatusUpdateEvent` 或 `TaskArtifactUpdateEvent` 訊息的伺服器發送事件 (SSE)，提供即時進度。
*   **推播通知 (Push Notifications)：** 支援 `pushNotifications` 的伺服器可以主動將任務更新發送到客戶端提供的 webhook URL，該 URL 透過 `tasks/pushNotification/set` 進行配置。

**典型流程：**

1.  **探索 (Discovery)：** 客戶端從伺服器的已知 URL 取得代理程式卡片。
2.  **啟動 (Initiation)：** 客戶端發送包含初始使用者訊息和唯一任務 ID 的 `tasks/send` 或 `tasks/sendSubscribe` 請求。
3.  **處理 (Processing)：**
    *   **(串流):** 伺服器在任務進行時發送 SSE 事件（狀態更新、產出物）。
    *   **(非串流):** 伺服器同步處理任務，並在回應中返回最終的 `Task` 物件。
4.  **互動 (Interaction) (可選)：** 如果任務進入 `input-required` 狀態，客戶端使用相同的任務 ID 透過 `tasks/send` 或 `tasks/sendSubscribe` 發送後續訊息。
5.  **完成 (Completion)：** 任務最終達到終止狀態（`completed`、`failed`、`canceled`）。

### **開始使用**

* 📚 閱讀[技術文件](https://google.github.io/A2A/#/documentation)以了解其功能
* 📝 檢閱協定結構的 [json 規範](/specification)
* 🎬 使用我們的[範例](/samples)觀看 A2A 的實際運作
    * 範例 A2A 客戶端/伺服器 ([Python](/samples/python/common), [JS](/samples/js/src))
    * [多代理程式 Web 應用程式](/demo/README.md)
    * CLI ([Python](/samples/python/hosts/cli/README.md), [JS](/samples/js/README.md))
* 🤖 使用我們的[範例代理程式](/samples/python/agents/README.md)了解如何將 A2A 引入代理程式框架
    * [代理程式開發工具包 (ADK)](/samples/python/agents/google_adk/README.md)
    * [CrewAI](/samples/python/agents/crewai/README.md)
    * [LangGraph](/samples/python/agents/langgraph/README.md)
    * [Genkit](/samples/js/src/agents/README.md)
* 📑 檢閱關鍵主題以了解協定細節
    * [A2A 與 MCP](https://google.github.io/A2A/#/topics/a2a_and_mcp.md)
    * [代理程式探索](https://google.github.io/A2A/#/topics/agent_discovery.md)
    * [企業就緒](https://google.github.io/A2A/#/topics/enterprise_ready.md)
    * [推播通知](https://google.github.io/A2A/#/topics/push_notifications.md)

### **貢獻**

我們歡迎貢獻！請參閱我們的[貢獻指南](CONTRIBUTING.md)開始。\
有問題嗎？加入我們在 [GitHub discussions](https://github.com/google/A2A/discussions/) 的社群。\
協助提供協定改進的回饋，請至 [GitHub issues](https://github.com/google/A2A/issues)。\
想發送私人回饋？請使用此 [Google 表單](https://docs.google.com/forms/d/e/1FAIpQLScS23OMSKnVFmYeqS2dP7dxY3eTyT7lmtGLUa8OJZfP4RTijQ/viewform)

### **未來規劃**

未來的計畫包括改進協定本身以及增強範例：

**協定增強：**

*   **代理程式探索：**
    *   將授權方案和可選憑證直接包含在 `AgentCard` 中的做法正式化。
*   **代理程式協作：**
    *   研究 `QuerySkill()` 方法，用於動態檢查不支援或未預期的技能。
*   **任務生命週期與使用者體驗：**
    *   支援在任務*內部*進行動態使用者體驗協商（例如，代理程式在對話中途添加音訊/視訊）。
*   **客戶端方法與傳輸：**
    *   探索將支援擴展到客戶端啟動的方法（超越任務管理）。
    *   改進串流可靠性和推播通知機制。

**範例與文件增強：**

*   簡化 "Hello World" 範例。
*   包含更多與不同框架整合或展示特定 A2A 功能的代理程式範例。
*   為通用客戶端/伺服器函式庫提供更全面的文件。
*   從 JSON Schema 生成人類可讀的 HTML 文件。

### **關於**

A2A 協定是由 Google LLC 運營的一個開源專案，遵循 [授權條款](LICENSE)，並開放給整個社群貢獻。