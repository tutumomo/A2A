# 範例程式碼

此程式碼用於展示隨著規範進展的 A2A 功能。\ 範例分為 3 個子目錄：

* [**Common**](/samples/python/common)  
所有範例代理程式和應用程式用於透過 HTTP 進行 A2A 通訊的通用程式碼。

* [**Agents**](/samples/python/agents/README.md)  
以多種框架編寫的範例代理程式，使用工具執行範例任務。這些都使用通用的 A2AServer。

* [**Hosts**](/samples/python/hosts/README.md)  
使用 A2AClient 的主機應用程式。包含一個展示單一代理程式簡單任務完成的 CLI、一個可以與多個代理程式通訊的 mesop Web 應用程式，以及一個將任務委派給多個遠端 A2A 代理程式之一的協調器代理程式。

## 先決條件

- Python 3.13 或更高版本
- UV

## 執行範例

執行一個（或多個）[代理程式](/samples/python/agents/README.md) A2A 伺服器和一個[主機應用程式](/samples/python/hosts/README.md)。

以下範例將使用 python CLI 主機執行 langgraph 代理程式：

1. 導覽至 samples/python 目錄：
    ```bash
    cd samples/python
    ```
2. 執行一個代理程式：
    ```bash
    uv run agents/langgraph
    ```
3. 執行範例客戶端
    ```
    uv run hosts/cli
    ```
---
**注意：**
這是範例程式碼，並非生產品質的函式庫。
---