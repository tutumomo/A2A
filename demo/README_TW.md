## 示範網頁應用程式

此示範應用程式展示代理程式(agents)透過A2A協議互相溝通的場景。

![image](/images/a2a_demo_arch.png)

* 前端是一個[mesop](https://github.com/mesop-dev/mesop)網頁應用程式，負責渲染終端使用者與「主控代理程式(Host Agent)」之間的對話內容。此應用程式可渲染文字內容、思考泡泡、網頁表單(代理程式輸入請求)以及圖片等內容類型，未來將持續增加更多內容類型支援

* [主控代理程式](/samples/python/hosts/multiagent/host_agent.py)是一個Google ADK代理程式，負責協調使用者請求並轉發給遠端代理程式

* 每個[遠端代理程式](/samples/python/hosts/multiagent/remote_agent_connection.py)都是一個在Google ADK代理程式中運行的A2AClient。每個遠端代理程式會取得A2AServer的[AgentCard](https://google.github.io/A2A/#documentation?id=agent-card)，然後透過A2A協議代理所有請求

## 功能特色

<需要快速動畫>

### 動態新增代理程式
點擊網頁應用中的機器人圖示即可新增代理程式。輸入遠端代理程式的AgentCard地址，應用程式將取得該卡片並將遠端代理程式加入已知代理程式清單

### 與一個或多個代理程式對話
點擊聊天按鈕開始或繼續現有對話。此對話將傳送至主控代理程式，再由主控代理程式將請求委派給一個或多個遠端代理程式

若代理程式回傳複雜內容(如圖片或網頁表單)，前端將在對話視圖中渲染此內容。遠端代理程式會負責將此內容在A2A與網頁應用原生表示之間進行轉換

### 探索A2A任務
點擊歷史記錄可查看網頁應用與所有代理程式(主控代理程式和遠端代理程式)之間傳送的訊息

點擊任務清單可查看來自遠端代理程式的所有A2A任務更新

## 必要條件

- Python 3.12 或更高版本
- UV
- 支援A2A協議的代理程式伺服器([使用這些範例](/samples/python/agents/README.md))

## 執行範例

1. 導航至demo ui目錄：
    ```bash
    cd demo/ui
    ```

2. 建立包含API金鑰的環境檔案：
   ```bash
   echo "GOOGLE_API_KEY=your_api_key_here" > .env
   ```

3. 執行前端範例：
    ```bash
    uv run main.py
    ```
注意：應用程式預設運行在12000端口